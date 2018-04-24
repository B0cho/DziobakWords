unit idiomsbase;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, strutils, base;
type
  { KLASA IDIOMU }
  Cidiom = class sealed(Celement)
    public
      pl : String; { tlumaczenie polskie }
      ang : String; { tlumaczenie angielskie }
      constructor init(const new_id : LongInt; const polski : String; const angielski : String);
      destructor destroy; reintroduce;
  end;

  { KLASA BAZY IDIOMOW }
  Cidiomsbase = class sealed(Cbase)
    private
      {}
    public
      constructor init(const PATH : String); reintroduce; { konstruktor }
      destructor destroy; reintroduce; { destruktor }
      function save : Boolean; reintroduce; { zapisuje tablice do pliku }
      {}
  end;

implementation

constructor Cidiom.init(const new_id : LongInt; const polski : String; const angielski : String);
begin
  dates := Tlist.Create;
  pl := polski;
  ang := angielski;
  prior := 0;
  id := new_id;
end;

destructor Cidiom.destroy;
var
  i : Integer; { iterator }
begin
  { usuwanie tablicy dat }
  for i := 0 to dates.count - 1 do Cdateans(dates[i]).destroy;
  dates.destroy;
end;

constructor CidiomsBase.init(const PATH : String);
var
  buff : String; { bufor odczytu }
  i : Byte; { iterator }
  new_idiom : Cidiom; { nowe slowo }
begin
  { inicjalizacja listy }
  lista := Tlist.Create;
  { otwarcie pliku i odczytanie listy, posortowanie }
  try
    assignfile(plik, PATH); { otwarcie pliku - jesli blad, to wyrzuca wyjatek }
    reset(plik); { ustawienie do odczytu i na poczatek pliku }
    while not eof(plik) do
    begin
      new_idiom := Cidiom.Create; { tworzenie nowego slowa }
      i := 0; { wyzerowanie iteratora}
      readln(plik, buff); { odczyt jednej linijki }
      while(i < 5) do
      begin
        { uzupelnianie pol }
        with new_idiom do
        begin
        case i of
             0 : id := strtoint(Copy2SymbDel(buff, ':')); { id }
             1 : prior := strtoint(Copy2SymbDel(buff, ':')); { priorytet }
             2 : pl := Copy2SymbDel(buff, ':'); { tlumaczenie polskie }
             3 : ang := Copy2SymbDel(buff, ':'); { tlumaczenie angielskie }
             4 : getDates(Copy2SymbDel(buff, ':')); { pobieranie i ustawienie dat }
        end;
        end;
        inc(i);
      end;
      { dodanie nowego elementu do listy }
      lista.Add(new_idiom);
    end;
    CloseFile(plik);
    { wszystko w porzadku }
    f_opened := true;
  except
    { tu gdy cos poszlo zle, ale to pozniej }
    f_opened := false;
  end;
end;

destructor CidiomsBase.destroy;
var
  i : Integer;
begin
  { czyszczenie listy }
  for i := 0 to lista.count - 1 do Cidiom(lista[i]).destroy;
  lista.destroy;
end;

function CidiomsBase.save : Boolean;
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
        with Cidiom(lista[i]) do
        begin
          to_save := inttostr(id) + ':' + inttostr(prior) + ':' + pl + ':' + ang + ':';
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

