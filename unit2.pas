{
FORMAR SLOWA:
_id_:_prior_:_PLlpoj_:_PLlmn_:_prefix_-_ANGlpoj_:_ANGlmn_:_rel1_/_rel2_/_rel3_/:_data1-punkty_/_data2-punkty_/data3-punkty3
FORMAT CZASOWNIKA:
_id_:_prior_:_PLbez_:_ANGpresentsimple1_:_ANGpresentsimple3_:_ANGpresenttcontinous_:_ANGpastsimple2_:_ANGpastperfect_:_rel1_/_rel2_/_rel3_/:_data1-punkty_/_data2-punkty_/data3-punkty3
FORMAT IDIOMU:
_id_:_prior_:_PL_:_ANG_:_data1-punkty_/_data2-punkty_/data3-punkty3
FORMAT TASK:
_id_:_data1_/_data2_/
}
unit Unit2;
{$mode objfpc}{$H+}
{ ZMIENNE WAZNE DLA PROGRAMU }
interface
uses
  Classes, SysUtils, wordsbase, verbsbase, idiomsbase, CtasksBase;

const
  WORDS_PATH = 'files/words.txt'; { sciezka do pliku ze slowami }
  VERBS_PATH = 'files/verbs.txt';  { sciezka do pliku z czasownikami }
  IDIOMS_PATH = 'files/idioms.txt'; { sciezka do pliku z idiomami }
  TASKS_PATH = 'files/tasks.txt';
var
  words : CwordsBase; { slownik slow }
  verbs : CVerbsbase; { baza czasownikow }
  idioms : CIdiomsBase; { baza idiomow }
  tasks : CtaskBase; { zadania do obsluzenia w dzialajacej sesji + harmonogram }
  confirmDelete : Boolean = true; { zmienna okreslajaca upewnienie sie przed usunieciem }
  confirmSave : Boolean = true; { zmienna potwierdzajaca zapis }

{ sprawdza, czy podany string zawiera tylko litery }
function is_alpha(const str : String) : Boolean;
{ sprawdza, czy idiom zawiera poprawne znaki }
function is_alphaIdiom(const str : String) : Boolean;
{ sprawdza, czy podany obiekt zawarty jest w liscie }
function include(const list : Tlist; const elem : Tobject) : Boolean;

implementation

function include(const list : Tlist; const elem : Tobject) : Boolean;
var
  i : Integer;
begin
  include := false;
  for i := 0 to list.count-1 do
  begin
    if list.IndexOf(elem) <> -1 then
      begin
        include := true;
        break;
      end;
  end;
end;

function is_alpha(const str : String) : Boolean;
var
  i : Integer; { iterator }
begin
  is_alpha := true;
  for i := 1 to length(str) do
  begin
      if not(str[i] in ['A'..'Z', 'a'..'z', ' ']) then
      begin
        is_alpha := false;
        break;
      end;
  end;
  if length(str) = 0 then is_alpha := false;
end;

function is_alphaIdiom(const str : String) : Boolean;
var
  i : Integer; { iterator }
begin
  is_alphaIdiom := true;
  for i := 1 to length(str) do
  begin
      if not(str[i] in ['A'..'Z', 'a'..'z', ' '..')', ',']) then
      begin
        is_alphaIdiom := false;
        break;
      end;
  end;
  if length(str) = 0 then is_alphaIdiom := false;
end;

end.
