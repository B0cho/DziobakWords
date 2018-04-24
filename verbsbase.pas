unit verbsbase;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, strutils, base;
type
  { KLASA CZASOWNIKA }
  Cverb = class sealed(Celement)
    private
      {}
    public
      pl : String; { pl }
      presentSimple1 : String; { present simple 1 os }
      presentSimple3 : String; { present simple 3 os }
      presentContinous : String; { present continous }
      pastSimple : String; { past simple }
      pastPerfect : String; { past perfect }
      constructor init(const new_id : LongInt; const polski_bezokl : String; const present_simple1 : String; const present_simple3 : String; const present_continous : String; const past_simple : String; const past_perfect : String);
      destructor destroy;
  end;
  { KLASA BAZY CZASOWNIKOW }
  Cverbsbase = class sealed(Cbase)
    private
      {}
    public
      constructor init(const PATH : String); reintroduce; { konstruktor }
      destructor destroy; reintroduce; { destruktor }
      function save : Boolean; reintroduce; { zapisuje tablice do pliku }
      function find_verb(const for_word : Celement) : Cverb;
      {}
  end;

implementation

function CverbsBase.find_verb(const for_word : Celement) : Cverb;
var
  i, j : Integer;
begin
 for i := 0 to lista.count-1 do
 begin
      with Cverb(lista.Items[i]) do
      begin
      for j := 0 to relations.count-1 do
      begin
           if(for_word = Celement(relations.items[j])) then
            begin
              find_verb := Cverb(lista.Items[i]);
              break;
              break;
            end;
      end;
      end;
 end;
end;

constructor Cverb.init(const new_id : LongInt; const polski_bezokl : String; const present_simple1 : String; const present_simple3 : String; const present_continous : String; const past_simple : String; const past_perfect : String);
begin
 id := new_id;
 pl := polski_bezokl;
 presentSimple1 := present_simple1;
 presentSimple3 := present_simple3;
 presentContinous := present_continous;
 pastSimple := past_simple;
 pastPerfect := past_perfect;
 rel_as_ptr := true;
 prior := 0;
 dates := Tlist.create;
 relations := Tlist.create;
end;

destructor Cverb.destroy;
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

constructor CverbsBase.init(const PATH : String);
var
  buff : String; { bufor odczytu }
  i : Byte; { iterator }
  new_verb : Cverb; { nowe slowo }
begin
  { inicjalizacja listy }
  lista := Tlist.Create;
  { otwarcie pliku i odczytanie listy, posortowanie }
  try
    assignfile(plik, PATH); { otwarcie pliku - jesli blad, to wyrzuca wyjatek }
    reset(plik); { ustawienie do odczytu i na poczatek pliku }
    while not eof(plik) do
    begin
      new_verb := Cverb.Create; { tworzenie nowego slowa }
      i := 0; { wyzerowanie iteratora}
      readln(plik, buff); { odczyt jednej linijki }
      while(i < 10) do
      begin
        { uzupelnianie pol }
        with new_verb do
        begin
        case i of
             0 : id := strtoint(Copy2SymbDel(buff, ':')); { id }
             1 : prior := strtoint(Copy2SymbDel(buff, ':')); { prior }
             2 : pl := Copy2SymbDel(buff, ':'); { pl }
             3 : presentSimple1 := Copy2SymbDel(buff, ':'); { present simple 1}
             4 : presentSimple3 := Copy2SymbDel(buff, ':'); { present simple 3 }
             5 : presentContinous := Copy2SymbDel(buff, ':'); { present continous }
             6 : pastSimple := Copy2SymbDel(buff, ':'); { past simple }
             7 : pastPerfect := Copy2SymbDel(buff, ':'); { past perfect }
             8 : getRelations(Copy2SymbDel(buff, ':')); { zbieranie relacji }
             9 : getDates(Copy2SymbDel(buff, ':')); { pobieranie i ustawienie dat }
        end;
        end;
        inc(i);
      end;
      { dodanie nowego elementu do listy }
      lista.Add(new_verb);
    end;
    CloseFile(plik);
    { wszystko w porzadku }
    f_opened := true;
  except
    { tu gdy cos poszlo zle, ale to pozniej }
    f_opened := false;
  end;
end;

destructor CverbsBase.destroy;
var
  i : Integer;
begin
  { czyszczenie listy }
  for i := 0 to lista.count - 1 do Cverb(lista[i]).destroy;
  lista.destroy;
end;

function CverbsBase.save : Boolean;
var
  i, j : Integer; { iteratory }
  to_save : String; { string do zapiania }
begin
 if f_opened then
  begin
    try
      rewrite(plik); { ustaw tryb zapisu pliku }
      for i := 0 to lista.Count - 1 do { dla kazdego czasownika z listy }
        begin
        with cverb(lista[i]) do
        begin
          to_save := inttostr(id) + ':' + inttostr(prior) + ':' + pl + ':' + presentSimple1 + ':' + presentSimple3 + ':' + presentContinous + ':' + pastSimple + ':' + pastPerfect + ':';
          { zapisywanie relacji }
          for j := 0 to relations.Count-1 do
            begin
                 to_save := to_save + inttostr(Celement(relations.Items[j]).getId) + '/';
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

end.

