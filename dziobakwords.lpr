program dziobakwords;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, Unit1, Unit2, wordsbase, base, verbsbase, idiomsbase,
  CtasksBase, task
  { you can add units after this };

{$R *.res}

begin
  { otwieranie baz }
  words := CwordsBase.init(WORDS_PATH);
  verbs := CverbsBase.init(VERBS_PATH);
  idioms := CidiomsBase.init(IDIOMS_PATH);
  { wiazanie slow i czasownikow }
  words.tieRelations(verbs);
  verbs.tieRelations(words);
  { inicjalizacja zadan i harmonogramu }
  tasks := CtaskBase.init(TASKS_PATH, words, verbs, idioms);

  { }
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TMainSettings, MainSettings);
  Application.CreateForm(TTaskForm, TaskForm);
  Application.Run;
end.

