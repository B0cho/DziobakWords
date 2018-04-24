unit wordsbase;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, strutils, base;
type

  CwordPrefix = (none = 0, a = 1, an = 2); { przedrostki }

  { struktura slowa }
  Cword = class sealed(Celement)
    public
      pl_poj : String; { polski l. poj }
      pl_mn : String; { polski l. mn }
      ang_poj : String; { angielski l. poj }
      ang_mn : String; { angielski l. mn }
      prefix : CwordPrefix; { przedimek }
      constructor init(const nowe_id : LongInt; const polski_l_poj : String; const polski_l_mnoga : String; const angielski_l_poj : String; const angielski_l_mnoga : String);
      destructor destroy;
  end;

  { KLASA BAZY SLOW }
  CwordsBase = class sealed(Cbase)
    public
      constructor init(const PATH : String); reintroduce; { konstruktor }
      destructor destroy; reintroduce; { destruktor }
      function save : Boolean; reintroduce; { zapisuje tablice slow do pliku }
      function find_word(const for_verb : Celement) : Cword; { zwraca slowo zwiazane relacją z podanym czasownikiem }
  end;

implementation

function CwordsBase.find_word(const for_verb : Celement) : Cword;
var
  i, j : Integer;
begin
 for i := 0 to lista.count-1 do
 begin
      with Cword(lista.Items[i]) do
      begin
      for j := 0 to relations.count-1 do
      begin
           if(for_verb = Celement(relations.items[j])) then
            begin
              find_word := Cword(lista.Items[i]);
              break;
              break;
            end;
      end;
      end;
 end;
end;

destructor Cword.destroy;
var
  i : Integer; { iterator }
type
  lptr = ^LongInt;
begin
  { usuwanie tablicy dat }
  for i := 0 to dates.count - 1 do Cdateans(dates[i]).destroy;
  dates.destroy;
  { niszczenie tablicy relacji }
  if not rel_as_ptr then for i := 0 to relations.count - 1 do dispose(lptr(relations[i]));
  relations.destroy;
end;

constructor cword.init(const nowe_id : LongInt; const polski_l_poj : String; const polski_l_mnoga : String; const angielski_l_poj : String; const angielski_l_mnoga : String);
begin
  id := nowe_id;
  pl_poj := polski_l_poj;
  pl_mn := polski_l_mnoga;
  ang_poj := angielski_l_poj;
  ang_mn := angielski_l_mnoga;
  prefix := none;
  rel_as_ptr := true;
  prior := 0;
  dates := Tlist.create;
  relations := Tlist.create;
end;

function Cwordsbase.save : Boolean;
var
  i, j : Integer; { iteratory }
  to_save : String; { string do zapiania }
begin
 { zaloz, ze zapis sie nie udal }
 if f_opened then
  begin
    try
      rewrite(plik); { ustaw tryb zapisu pliku }
      for i := 0 to lista.Count - 1 do { dla kazdego slowa z listy }
        begin
        with cword(lista[i]) do
        begin
          to_save := inttostr(id) + ':' + inttostr(prior) + ':' + pl_poj + ':' + pl_mn + ':' + inttostr(LongInt(prefix)) + '-' + ang_poj + ':' + ang_mn + ':';
          { zapisywanie relacji }
          for j := 0 to relations.Count-1 do
            begin
                 to_save := to_save + inttostr(Celement(relations.items[j]).getId) + '/';
            end;
          to_save := to_save + ':'; { dodawanie separatora miedzy relacjami a datami }
          { zapisywanie dat }
          for j := 0 to dates.count-1 do
            begin
              to_save := to_save + inttostr(DateTimeToFileDate(Cdateans(dates[j]).time)) + '-' + IntToStr(Integer(Cdateans(dates[j]).ans)) + '/';
            end;
         end;
        writeln(plik, to_save); { zapisanie }
        end;
      Closefile(plik);
      save := true; { zwroc prawde, jesli sie udalo }
    except
      save := false; { zwroc falsz, jesli blad }
    end;
  end;
 change := false; { zaznacz, ze zmiana zostala zapisana }
end;

constructor CwordsBase.init(const PATH : String);
var
  buff, buff2 : String; { bufor odczytu }
  i : Byte; { iterator }
  new_word : Cword; { nowe slowo }
begin
  { inicjalizacja listy }
  lista := Tlist.Create;
  { otwarcie pliku i odczytanie listy, posortowanie }
  try
    assignfile(plik, PATH); { otwarcie pliku - jesli blad, to wyrzuca wyjatek }
    reset(plik); { ustawienie do odczytu i na poczatek pliku }
    while not eof(plik) do
    begin
      new_word := Cword.Create; { tworzenie nowego slowa }
      i := 0; { wyzerowanie iteratora}
      readln(plik, buff); { odczyt jednej linijki }
      while(i < 8) do
      begin
        { uzupelnianie pol }
        case i of
             0 : new_word.id := strtoint(Copy2SymbDel(buff, ':')); { id }
             1 : new_word.prior := strtoint(Copy2SymbDel(buff, ':')); { prior }
             2 : new_word.pl_poj := Copy2SymbDel(buff, ':'); { pl poj }
             3 : new_word.pl_mn := Copy2SymbDel(buff, ':'); { pl mn }
             4 :
               begin
                buff2 := Copy2SymbDel(buff, ':');
                with new_word do
                begin
                    prefix := CWordPrefix(StrToInt(Copy2SymbDel(buff2, '-'))); { ustawienie przedimka }
                    new_word.ang_poj := buff2; { ang poj }
                end;
               end;
             5 : new_word.ang_mn := Copy2SymbDel(buff, ':'); { ang mn }
             6 : new_word.getRelations(Copy2SymbDel(buff, ':')); { zbieranie relacji }
             7 : new_word.getDates(Copy2SymbDel(buff, ':')); { pobieranie i ustawienie dat }
        end;
        inc(i);
      end;
      { dodanie nowego elementu do listy }
      lista.Add(new_word);
    end;
    CloseFile(plik);
    { wszystko w porzadku }
    f_opened := true;
  except
    { tu gdy cos poszlo zle, ale to pozniej }
    f_opened := false;
  end;
end;

destructor CwordsBase.destroy;
var
  i : Integer;
begin
  { czyszczenie listy }
  for i := 0 to lista.count - 1 do Cword(lista[i]).destroy;
  lista.destroy;
end;

end.

