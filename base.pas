unit base;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils, strutils;
type

  { KLASA BAZOWA DLA SLOWA/CZASOWNIKA/IDIOMU }
  Celement = class abstract
    protected
      rel_as_ptr : Boolean; { okresla, czy relacje sa zapisane jako wskazniki(true) czy jako liczby(false) }
      id : LongInt; { id- czas utworzenia slowa }
      procedure getDates(str : String); { pobiera string zakodowanych dat i zapisuje daty do slow }
      procedure getRelations(str : String); { pobiera string zakodowanych relacji i zapisuje je do elementu }
    public
      dates : Tlist; { lista dat odpowiedzi, potrzebne do statystyki }
      relations : Tlist; { LongInt, lista elementow, z ktorymi moze byc tworzone zadanie }
      prior : Byte; { okresla priorytet 0-5 }
      property getId : LongInt read id; { zwraca id elementu }
      function avrg : Double; { prawdopodobienstwo nastepnej poprawnej odpowiedzi }
  end;

  { KLASA BAZOWA DLA BAZY SLOW/CZASOWNIKOW/IDIOMOW }
  Cbase = class abstract
    protected
      f_opened : Boolean; { czy udalo sie otworzyc slowa }
      change : Boolean; { czy dokonano zmian w liscie }
      plik : TextFile; { plik }
    public
      lista : Tlist; { lista slow/czasownikow/idiomow }
      constructor init(const PATH : String); virtual; abstract; { konstruktor }
      destructor destroy; virtual; abstract; { destruktor }
      function save : Boolean; virtual; abstract; { zapisuje tablice slow do pliku }
      procedure tieRelations(const with_base : Cbase); { konwertuje relacje elementow bazy z liczb na wskazniki do elementow podanej bazy }
      function dropRelation(const to_remove : Celement) : Boolean; { usuwa podany element z wszystkich list relacji elementow bazy }
      property has_changed : Boolean write change; { ustawienie zmian w liscie }
      property changes : Boolean read change; { zwraca true jesli zaszly zmiany w liscie }
      property is_file_opened : Boolean read f_opened; { zwraca rezultat otwarcia pliku }
      function find(const id : LongInt) : Celement; { szuka w bazie elementu o podanym id i go zwraca, jak nie znajdzie- nil }
      function get_rand(const excpt : Celement; elems : Byte = 3) : Tlist; { zwraca liste losowych elementow z bazy roznych od podanego- do tworzenia blednych odpowiedzi }
  end;

  { typ wskaznika w parze- przydatne do uzupelniania listy }
  ptr_type = (
  pword, { slowo }
  pverb, { czasownik }
  pidiom  { idiom }
  );

  { typ elementu }
  element = class sealed
    typ : ptr_type; { typ wskaznika }
    content : Tobject; { zawartosc }
  end;

  { typ daty i odpowiedzi }
  Cdateans = class sealed
    ans : Boolean; { odpowiedz: poprawna lub nie }
    time : TDateTime; { czas odpowiedzi }
    constructor init(const _time : TdateTime; const answer : Boolean);
  end;

implementation

constructor Cdateans.init(const _time : TdateTime; const answer : Boolean);
begin
  ans := answer;
  time := _time;
end;

function Celement.avrg : Double;
var
  i : Integer;
begin
  avrg := 0;
  for i := 0 to dates.Count-1 do
  begin
    avrg := avrg + Integer(CDateAns(dates.Items[i]).ans);
  end;
  if(dates.count <> 0) then avrg := avrg / (1 + dates.count);
end;

function Cbase.get_rand(const excpt : Celement; elems : Byte = 3) : Tlist;
var
  i, j : Integer;
  elem : Celement;
begin
  get_rand := Tlist.create;
  if elems > lista.count then elems := lista.count-1;
  i := 0;
  randomize;
  while i < elems do
  begin
    j := random(lista.count);
    elem := Celement(lista.items[j]);
    if (excpt.id <> elem.id) and (get_rand.IndexOf(lista.items[j]) = -1) then
    begin
      get_rand.add(elem);
      inc(i);
    end;
  end;
end;

function Cbase.find(const id : LongInt) : Celement;
var
  i : Integer;
begin
  find := nil;
  for i := 0 to lista.Count-1 do
  begin
    if(id = Celement(lista.Items[i]).id) then
    begin
      find := Celement(lista.Items[i]);
      break;
    end;
  end;
end;

function Cbase.dropRelation(const to_remove : Celement) : Boolean;
var
  i : Integer; { iterator }
begin
  dropRelation := false;
  for i := 0 to lista.Count-1 do
  begin
    if Celement(lista.Items[i]).relations.remove(to_remove) <> -1 then dropRelation := true;
  end;
end;

procedure Cbase.tieRelations(const with_base : Cbase);
type
  lptr = ^LongInt;
var
  i, j, k : Integer; { iteratory }
  elem : Celement;
begin
  for i := 0 to lista.Count - 1 do
  begin
    elem := Celement(lista[i]);
    for j := 0 to elem.relations.count - 1 do
    begin
      for k := 0 to with_base.lista.count - 1 do
      begin
        if lptr(elem.relations.items[j])^ = Celement(with_base.lista.Items[k]).id then
        begin
          dispose(lptr(elem.relations.items[j]));
          elem.relations.items[j] := Celement(with_base.lista.items[k]);
          break;
        end;
      end;
    end;
    elem.rel_as_ptr := true;
  end;
end;

procedure Celement.getDates(str : String);
var
  new_date : Cdateans;
  substr : String;
begin
  dates := Tlist.Create;
  while length(str) > 0 do
  begin
    substr := Copy2SymbDel(str, '/');
    new_date := Cdateans.create;
    new_date.time := FileDateToDateTime(strtoint(Copy2SymbDel(substr, '-')));
    new_date.ans := Boolean(strtoint(substr));
    dates.Add(new_date);
  end;
end;

procedure Celement.getRelations(str : String);
var
  ptr : ^LongInt;
begin
  relations := Tlist.create;
  while length(str) > 0 do
  begin
    new(ptr);
    ptr^ := strtoint64(Copy2SymbDel(str, '/'));
    relations.Add(ptr);
  end;
  rel_as_ptr := false;
end;

end.

