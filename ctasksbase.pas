unit CtasksBase;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, strutils, dateutils, wordsbase, idiomsbase, verbsbase, base;
type
  lptr = ^LongInt;

  Ctask = class
    public
           elem : Celement; { element }
           typ : ptr_type; { typ elementu }
           terms : Tlist; { lista terminow harmonogramu }
           constructor create(const added_elem : Celement; const type_of_element : ptr_type);
           destructor destroy;
           procedure answer(const czas : TdateTime; const poprawnosc : Boolean); { dodaje odpowiedz na zadanie do statystyk }
  end;

  CtaskBase = class
    private
      f_opened : Boolean; { czy udalo sie otworzyc harmonogram }
      change : Boolean; { czy dokonano zmian w harmonogramie }
      plik : TextFile; { plik harmonogramu }
      ptrWords : CWordsBase; { wskaznik do listy slow }
      ptrVerbs : CVerbsBase; { wskaznik do listy czasownikow }
      ptrIdioms : CIdiomsBase; { wskaznik do listy idiomow }
      next_task : Ctask; { nastepne zadanie do przedstawienia }
      tasks_list : Tlist; { lista zadan }
     public
       time_break : cardinal;{ przerwa czasowa miedzy zadaniami }
       time : cardinal; { pozostaly czas do wyswietlenia zadania }
       constructor init(const PATH : String; const slowa : CwordsBase; const czasowniki : CverbsBase; const idiomy : CidiomsBase);
       destructor destroy; { destruktor }
       procedure generate_task; { generuje nowe zadanie na podstawie listy slow, czasownikow, idiomow, harmonogramu i statystyki }
       function is_task : Boolean; { zwraca prawdę, gdy ustawiono zadanie }
       function save : Boolean; { zapisuje zadania }
       function find(const id : LongInt) : Ctask; { szuka zadania na podstawie id elementu }
       property changes : Boolean read change; { zwraca true jesli zaszly zmiany w liscie }
       property getTask : Ctask read next_task;
       procedure add_task(const new_task : Ctask); { dodaje nowe zadania }
       procedure delete(ptr : Celement);  { usuwa zadanie }
       procedure add_term(const when : TdateTime; const elem : Celement); { dodaje termin do harmonogramu }
       procedure delete_term(date : lptr; elem : Celement); { usuwa termin z harmonogramu }
  end;

implementation

procedure Ctask.answer(const czas : TdateTime; const poprawnosc : Boolean);
var
  i : Integer;
type
  lptr = ^LongInt;
begin
 elem.dates.Add(CdateAns.init(czas, poprawnosc));
 { wywalenie harmonogramu }
 for i := 0 to terms.Count-1 do
 begin
     if(dateof(czas) = dateof(FileDateToDateTime(lptr(terms.Items[i])^))) then
     begin
       terms.Delete(i);
       break;
     end;
 end;
end;

procedure CtaskBase.delete_term(date : lptr; elem : Celement);
var
  task : Ctask;
begin
 task := find(elem.getId);
 task.terms.Remove(date);
 change := true;
 generate_task;
end;

procedure CtaskBase.add_term(const when : TdateTime; const elem : Celement);
var
  task : Ctask;
  new_term : lptr;
begin
 task := find(elem.getid);
 new(new_term);
 new_term^ := LongInt(DateTimeToFileDate(now));
 task.terms.Add(new_term);
 change := true;
 generate_task;
end;

procedure CtaskBase.delete(ptr : Celement);
var
  to_del : Ctask;
begin
 to_del := find(ptr.getId);
 tasks_list.Remove(to_del);
 generate_task;
end;

procedure CtaskBase.add_task(const new_task : Ctask);
begin
 tasks_list.Add(new_task);
 generate_task;
end;

constructor Ctask.create(const added_elem : Celement; const type_of_element : ptr_type);
begin
  elem := added_elem;
  typ := type_of_element;
  terms := Tlist.create;
end;

destructor Ctask.destroy;
var
  i : Integer;
type
  lptr = ^LongInt;
begin
  for i := 0 to terms.count - 1 do dispose(lptr(terms.items[i]));
  terms.destroy;
end;

constructor CtaskBase.init(const PATH : String; const slowa : CwordsBase; const czasowniki : CverbsBase; const idiomy : CidiomsBase);
var
  modified : Ctask;
  id : LongInt;
  i : Integer;
  buff : String;
  new_term : ^LongInt;
  t : Boolean;
begin
  ptrWords := slowa;
  ptrVerbs := czasowniki;
  ptrIdioms := idiomy;
  { tworzenie listy zadan }
  tasks_list := Tlist.create;
  for i := 0 to ptrWords.lista.count-1 do tasks_list.Add(Ctask.create(Cword(ptrWords.lista.Items[i]), pword));
  for i := 0 to ptrVerbs.lista.count-1 do tasks_list.Add(Ctask.create(Cverb(ptrVerbs.lista.Items[i]), pverb));
  for i := 0 to ptrIdioms.lista.count-1 do tasks_list.Add(Ctask.create(Cidiom(ptrIdioms.lista.Items[i]), pidiom));
  { otwieranie listy harmonogramu }
  try
    assignfile(plik, PATH); { otwarcie pliku - jesli blad, to wyrzuca wyjatek }
    reset(plik); { ustawienie do odczytu i na poczatek pliku }
    t := true;
    while not eof(plik) do
    begin
        readln(plik, buff); { odczyt jednej linijki }
        if t then
        begin
          time_break := strtoint(buff) * 60000;
          t := false;
          continue;
        end;
        id := strtoint(Copy2SymbDel(buff, ':')); { ustalanie id dla elementu ktorego dotyczy harmonogram }
        modified := find(id); { szukanie elementu }
        while(length(buff) > 0) do
        begin
            { dodawaj terminy dla danego elementu }
            new(new_term);
            new_term^ := strtoint(Copy2SymbDel(buff, '/'));
            { jesli termin elementu jest przeterminowany, to przenies na dzis i nakaz zapis }
            if(dayof(now) > dayof(FileDateToDateTime(new_term^))) then
            begin
              new_term^ := DateTimeToFileDate(now);
              change := true;
            end;
            modified.terms.add(new_term);
        end;
    end;
    CloseFile(plik);
    { wszystko w porzadku }
    f_opened := true;
  except
    { tu gdy cos poszlo zle, ale to pozniej }
    f_opened := false;
  end;
  generate_task;
end;

destructor CtaskBase.destroy;
var
  i : Integer;
begin
  for i := 0 to tasks_list.count - 1 do Ctask(tasks_list.items[i]).destroy;
  tasks_list.destroy;
end;

procedure CtaskBase.generate_task;
type
  lptr = ^LongInt;
var
  i, j : integer;
  highest_rank : Double;
  checked_rank : Double;
  checked_task : Ctask;
  day : LongInt;
begin
  highest_rank := 0;
  next_task := nil;
  for i := 0 to tasks_list.Count-1 do
  begin
      checked_task := Ctask(tasks_list.Items[i]);
      checked_rank := checked_task.elem.prior - 4 * checked_task.elem.avrg;
      for j := 0 to checked_task.terms.count-1 do
      begin
          if(dayof(now) = dayof(lptr(checked_task.terms.Items[j])^)) then checked_rank := checked_rank + 5;
      end;
      if(checked_rank >= highest_rank) then
      begin
        highest_rank := checked_rank;
        next_task := checked_task;
      end;
  end;
  time := time_break;
end;

function CtaskBase.is_task : Boolean;
begin
  if next_task <> nil then is_task := true
  else is_task := false;
end;

function CtaskBase.save : Boolean;
type
  lptr = ^LongInt;
var
  i, j : Integer;
  terms : Tlist;
  to_save : String;
begin
 if f_opened then
  begin
    try
      rewrite(plik); { ustaw tryb zapisu pliku }
      writeln(plik, inttostr(time_break div 60000)); { zapisanie przerwy czasowej }
      for i := 0 to tasks_list.Count-1 do
      begin
          terms := Ctask(tasks_list.Items[i]).terms;
          if(terms.count > 0) then
           begin
             to_save := inttoStr(Ctask(tasks_list.Items[i]).elem.getId) + ':';
             for j := 0 to terms.count-1 do
             begin
                 to_save := to_save + IntToStr(lptr(terms.items[j])^) + '/';
             end;
             writeln(plik, to_save);
           end;
      end;
      Closefile(plik);
      save := true; { zwroc prawde, jesli sie udalo }
    except
      save := false; { zwroc falsz, jesli blad }
    end;
  end;
 change := false; { zaznacz, ze zmiana zostala zapisana }
end;

function CtaskBase.find(const id : LongInt) : Ctask;
var
  i : Integer;
  task : Ctask;
begin
  find := nil;
  for i := 0 to tasks_list.Count-1 do
  begin
      task := Ctask(tasks_list.Items[i]);
      if(id = task.elem.getId) then
      begin
        find := task;
        break;
      end;
  end;
end;

end.

