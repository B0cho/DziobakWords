unit task;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, CtasksBase, base, idiomsbase, unit2, wordsbase, verbsbase;

type

  { TTaskForm }

  TTaskForm = class(TForm)
    AnsLabel1: TStaticText;
    AnsLabel2: TStaticText;
    AnsIdiomLabel2: TStaticText;
    VerbAns3: TStaticText;
    CheckVerb3: TButton;
    CloseVerb3: TButton;
    VerbAnsLabel2: TStaticText;
    CheckVerb2: TSpeedButton;
    CloseVerb2: TSpeedButton;
    MeansLabel4: TStaticText;
    PlVerbLabel2: TStaticText;
    VerbAnsLabel1: TStaticText;
    CheckWord3: TButton;
    CheckWord1: TSpeedButton;
    CheckWord2: TSpeedButton;
    CheckIdiom2: TSpeedButton;
    CheckVerb1: TSpeedButton;
    CloseWord3: TButton;
    CloseIdiom1: TSpeedButton;
    CloseWord1: TSpeedButton;
    CloseWord2: TSpeedButton;
    CloseIdiom2: TSpeedButton;
    CloseVerb1: TSpeedButton;
    MeansLabel3: TStaticText;
    VerbOptions1: TComboBox;
    PlVerbLabel1: TStaticText;
    VerbLvl1: TPage;
    VerbLvl2: TPage;
    VerbLvl3: TPage;
    VerbNotebook: TNotebook;
    VerbLevel1: TGroupBox;
    VerbEdit2: TEdit;
    VerbLevel2: TGroupBox;
    VerbLevel3: TGroupBox;
    VerbLvl31: TStaticText;
    VerbLvl32: TStaticText;
    VerbLvl33: TStaticText;
    wordoptions3: TComboBox;
    Wordlvl31: TStaticText;
    WordLvl33: TStaticText;
    AnsWord3: TStaticText;
    WordLvl32: TStaticText;
    WordLevel3: TGroupBox;
    IdiomNotebook: TNotebook;
    IdiomLvl1: TPage;
    IdiomLvl2: TPage;
    MeansIdiomLabel2: TStaticText;
    Level3: TPage;
    PlLabel2: TStaticText;
    VerbOptions3: TComboBox;
    WordPolecenie3: TStaticText;
    WordEdit2: TEdit;
    MeansLabel1: TStaticText;
    MeansLabel2: TStaticText;
    OptionsWord1: TComboBox;
    PlWordLabel1: TStaticText;
    PlWordLabel2: TStaticText;
    IdiomEdit2: TEdit;
    WordLevel1: TGroupBox;
    Level1: TPage;
    Level2: TPage;
    WordLevel2: TGroupBox;
    IdiomPageLvl2: TGroupBox;
    WordNotebook: TNotebook;
    IdiomOptions: TComboBox;
    IdiomPagelvl1: TGroupBox;
    CheckIdiom1: TSpeedButton;
    plLabel1: TStaticText;
    MeansLabel0: TStaticText;
    AnsIdiomLabel1: TStaticText;
    TaskNotebook: TNotebook;
    WordPage: TPage;
    VerbPage: TPage;
    IdiomPage: TPage;
    VerbPolecenie3: TStaticText;
    procedure CheckIdiom2Click(Sender: TObject);
    procedure CheckVerb1Click(Sender: TObject);
    procedure CheckVerb2Click(Sender: TObject);
    procedure CheckVerb3Click(Sender: TObject);
    procedure CheckWord1Click(Sender: TObject);
    procedure CheckWord2Click(Sender: TObject);
    procedure CheckWord3Click(Sender: TObject);
    procedure CloseIdiom1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckIdiom1Click(Sender: TObject);
    procedure IdiomEdit2Change(Sender: TObject);
    procedure WordEdit2Change(Sender: TObject);
    procedure WordLevel1Click(Sender: TObject);
  private
    { private declarations }
  public
    current_task : Ctask;
    { public declarations }
  end;

var
  TaskForm: TTaskForm;

implementation

{$R *.lfm}

{ TTaskForm }

procedure TTaskForm.FormCreate(Sender: TObject);
begin

end;

procedure TTaskForm.CloseIdiom1Click(Sender: TObject);
begin
  words.has_changed := true;
  close;
end;

procedure TTaskForm.CheckWord1Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(OptionsWord1.Items.Objects[optionsWord1.ItemIndex] = Cword(current_task.elem)) then
  begin
    current_task.answer(now, true);
    ansLabel1.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    ansLabel1.Font.Color := clred;
  end;
  ansLabel1.Visible := true;
  CheckWord1.Visible := false;
  CloseWord1.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.CheckIdiom2Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(lowercase(Cidiom(current_task.elem).ang) = lowercase(IdiomEdit2.Caption)) then
  begin
    current_task.answer(now, true);
    ansIdiomLabel2.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    ansIdiomLabel2.Font.Color := clred;
  end;
  ansIdiomLabel2.Visible := true;
  CheckIdiom2.Visible := false;
  CloseIdiom2.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.CheckVerb1Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(VerbOptions1.Items.Objects[VerbOptions1.ItemIndex] = Cverb(current_task.elem)) then
  begin
    current_task.answer(now, true);
    VerbAnsLabel1.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    verbAnsLabel1.Font.Color := clred;
  end;
  VerbAnsLabel1.Visible := true;
  CheckVerb1.Visible := false;
  CloseVerb1.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.CheckVerb2Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(lowercase(Cverb(current_task.elem).presentSimple1) = lowercase(VerbEdit2.Caption)) then
  begin
    current_task.answer(now, true);
    VerbAnsLabel2.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    VerbAnsLabel2.Font.Color := clred;
  end;
  VerbAnsLabel2.Visible := true;
  CheckVerb2.Visible := false;
  CloseVerb2.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.CheckVerb3Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(VerbOptions3.Items.Objects[VerbOptions3.ItemIndex] = Cverb(current_task.elem)) then
  begin
    current_task.answer(now, true);
    VerbAns3.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    VerbAns3.Font.Color := clred;
  end;
  VerbAns3.Visible := true;
  CheckVerb3.Visible := false;
  CloseVerb3.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.CheckWord2Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(lowercase(Cword(current_task.elem).ang_poj) = lowercase(WordEdit2.Caption)) then
  begin
    current_task.answer(now, true);
    ansLabel2.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    ansLabel2.Font.Color := clred;
  end;
  ansLabel2.Visible := true;
  CheckWord2.Visible := false;
  CloseWord2.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.CheckWord3Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(WordOptions3.Items.Objects[WordOptions3.ItemIndex] = Cword(current_task.elem)) then
  begin
    current_task.answer(now, true);
    AnsWord3.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    ansWord3.Font.Color := clred;
  end;
  ansWord3.Visible := true;
  CheckWord3.Visible := false;
  CloseWord3.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if current_task <> nil then current_task.answer(now, false);
end;

procedure TTaskForm.FormShow(Sender: TObject);
var
  other_opts : Tlist;
  i : Byte;
  option : Byte;
  verb : Cverb;
  word : Cword;
begin
  case current_task.typ of
       pword:
         begin
           TaskNotebook.PageIndex := 0;
           with Cword(current_task.elem) do
           begin
             { level 1}
             if(avrg <= 0.4) then
             begin
               WordNotebook.PageIndex := 0;
               OptionsWord1.Clear;
               CloseWord1.Visible := false;
               CheckWord1.Visible := true;
               with Cword(current_task.elem) do
               begin
                PlWordLabel1.Caption := pl_poj;
                AnsLabel1.Caption := ang_poj;
               end;
               AnsLabel1.Visible := false;
               other_opts := words.get_rand(current_task.elem);
               i := random(other_opts.count);
               other_opts.Insert(i, current_task.elem);
               for i := 0 to other_opts.Count-1 do
               begin
                 OptionsWord1.AddItem(Cword(other_opts.Items[i]).ang_poj, Cword(other_opts.items[i]));
               end;
               OptionsWord1.ItemIndex := 0;
               other_opts.destroy;
             end else
             { level 2 }
             if(avrg <= 0.8) then
             begin
                  WordNotebook.PageIndex := 1;
                  CloseWord2.Visible := false;
                  CheckWord2.Visible := true;
                  WordEdit2.Clear;
                  with Cword(current_task.elem) do
                   begin
                    PlWordLabel2.Caption := pl_poj;
                    AnsLabel2.Caption := ang_poj;
                   end;
                  AnsLabel2.Visible := false;
             end else
             { level 3 }
             begin
               WordNotebook.PageIndex := 2;
               AnsWord3.Visible := false;
               CloseWord3.visible := false;
               CheckWord3.Visible := true;
               wordoptions3.Clear;
               other_opts := words.get_rand(current_task.elem as Cword);
               { znajdź czasownik, które jest w relacji ze slowem }
               verb := verbs.find_verb(Cword(current_task.elem));
                       wordlvl31.Caption := 'I ' + lowercase(verb.presentSimple1);
                       wordlvl32.caption := '(' + lowercase(Cword(current_task.elem).pl_poj) + ')';
                       wordlvl33.caption := '';
                       other_opts := words.get_rand(Cword(current_task.elem));
                       wordoptions3.AddItem(lowercase(Cword(current_task.elem).ang_poj), Cword(current_task.elem));
                       for i := 0 to other_opts.Count-1 do wordoptions3.AddItem(lowercase(Cword(other_opts.items[i]).ang_poj), Cword(other_opts.items[i]));
                       AnsWord3.caption := 'I ' + lowercase(verb.presentSimple1) + ' ' + lowercase(Cword(current_task.elem).ang_poj);
               end;
             end;
         end;
       pverb:
         begin
           TaskNotebook.PageIndex := 1;
           with cverb(current_task.elem) do
            begin
              if avrg <= 0.4 then { level 1 }
              begin
                VerbNotebook.PageIndex := 0;
               VerbOptions1.Clear;
               CloseVerb1.Visible := false;
               CheckVerb1.Visible := true;
                PlVerbLabel1.Caption := pl;
                VerbAnsLabel1.Caption := presentSimple1;
               VerbAnsLabel1.Visible := false;
               other_opts := verbs.get_rand(current_task.elem);
               i := random(other_opts.count);
               other_opts.Insert(i, current_task.elem);
               for i := 0 to other_opts.Count-1 do
               begin
                 VerbOptions1.AddItem(Cverb(other_opts.Items[i]).presentSimple1, Cverb(other_opts.items[i]));
               end;
               VerbOptions1.ItemIndex := 0;
               other_opts.destroy;
              end else
              { lvl 2 }
              if avrg <= 0.75 then
               begin
                  VerbNotebook.PageIndex := 1;
                  CloseVerb2.Visible := false;
                  CheckVerb2.Visible := true;
                  VerbEdit2.Clear;
                  with Cverb(current_task.elem) do
                   begin
                    PlVerbLabel2.Caption := pl;
                    VerbAnsLabel2.Caption := presentsimple1;
                   end;
                  VerbAnsLabel2.Visible := false;
             end else { lvl 3 }
             begin
               VerbNotebook.PageIndex := 2;
               VerbAns3.Visible := false;
               CloseVerb3.visible := false;
               CheckVerb3.Visible := true;
               VerbOptions3.Clear;
               other_opts := verbs.get_rand(current_task.elem as Cverb);
               { znajdź czasownik, które jest w relacji ze slowem }
               word := words.find_word(Cverb(current_task.elem));
               option := random(5);
               if (option = 2) and (Cverb(current_task.elem).presentContinous = '') then option := 0;
               case option of
                    0 : { I do }
                      begin
                       VerbLvl31.Caption := 'You ';
                       VerbLvl33.caption := '(' + lowercase(Cverb(current_task.elem).pl) + ' 1 os. l. poj)';
                       verblvl32.caption :=  lowercase(word.ang_poj);
                       other_opts := verbs.get_rand(Cverb(current_task.elem));
                       VerbOptions3.AddItem(lowercase(Cverb(current_task.elem).presentSimple1), Cverb(current_task.elem));
                       for i := 0 to other_opts.Count-1 do verboptions3.AddItem(lowercase(Cverb(other_opts.items[i]).presentSimple1), Cverb(other_opts.items[i]));
                       VerbAns3.caption := 'You ' + lowercase(Cverb(current_task.elem).presentSimple1) + ' ' + lowercase(word.ang_poj);
                      end;
                    1 : { He does}
                      begin
                       VerbLvl31.Caption := 'He ';
                       VerbLvl33.caption := '(' + lowercase(Cverb(current_task.elem).pl) + ' 3 os. l. poj)';
                       verblvl32.caption :=  lowercase(word.ang_poj);
                       other_opts := verbs.get_rand(Cverb(current_task.elem));
                       VerbOptions3.AddItem(lowercase(Cverb(current_task.elem).presentSimple3), Cverb(current_task.elem));
                       for i := 0 to other_opts.Count-1 do verboptions3.AddItem(lowercase(Cverb(other_opts.items[i]).presentSimple3), Cverb(other_opts.items[i]));
                       VerbAns3.caption := 'He ' + lowercase(Cverb(current_task.elem).presentSimple3) + ' ' + lowercase(word.ang_poj);
                      end;
                    2 : { I'm doing }
                      begin
                       VerbLvl31.Caption := 'I m ';
                       VerbLvl33.caption := '(' + lowercase(Cverb(current_task.elem).pl) + ')';
                       verblvl32.caption :=  lowercase(word.ang_poj);
                       other_opts := verbs.get_rand(Cverb(current_task.elem));
                       VerbOptions3.AddItem(lowercase(Cverb(current_task.elem).presentContinous), Cverb(current_task.elem));
                       for i := 0 to other_opts.Count-1 do
                       begin
                        if (Cverb(other_opts.items[i]).presentContinous <> '') then verboptions3.AddItem(lowercase(Cverb(other_opts.items[i]).presentContinous), Cverb(other_opts.items[i]));
                       end;
                       VerbAns3.caption := 'I m ' + lowercase(Cverb(current_task.elem).presentContinous) + ' ' + lowercase(word.ang_poj);
                      end;
                    3 : { I did }
                      begin
                       VerbLvl31.Caption := 'We ';
                       VerbLvl33.caption := '(' + lowercase(Cverb(current_task.elem).pl) + '- Past S.)';
                       verblvl32.caption :=  lowercase(word.ang_poj);
                       other_opts := verbs.get_rand(Cverb(current_task.elem));
                       VerbOptions3.AddItem(lowercase(Cverb(current_task.elem).pastSimple), Cverb(current_task.elem));
                       for i := 0 to other_opts.Count-1 do verboptions3.AddItem(lowercase(Cverb(other_opts.items[i]).pastSimple), Cverb(other_opts.items[i]));
                       VerbAns3.caption := 'We ' + lowercase(Cverb(current_task.elem).pastSimple) + ' ' + lowercase(word.ang_poj);
                      end;
                    4 : { She has }
                      begin
                       VerbLvl31.Caption := 'She has ';
                       VerbLvl33.caption := '(' + lowercase(Cverb(current_task.elem).pl) + '- Past P.)';
                       verblvl32.caption :=  lowercase(word.ang_poj);
                       other_opts := verbs.get_rand(Cverb(current_task.elem));
                       VerbOptions3.AddItem(lowercase(Cverb(current_task.elem).pastPerfect), Cverb(current_task.elem));
                       for i := 0 to other_opts.Count-1 do verboptions3.AddItem(lowercase(Cverb(other_opts.items[i]).pastPerfect), Cverb(other_opts.items[i]));
                       VerbAns3.caption := 'She has ' + lowercase(Cverb(current_task.elem).pastPerfect) + ' ' + lowercase(word.ang_poj);
                      end;
               end;
               end;
         end;
         end;
       { idiom }
       pidiom:
         { lvl1 }
         begin
           TaskNotebook.PageIndex := 2;
           if(current_task.elem.avrg <= 0.75) then
           begin
           IdiomNotebook.PageIndex := 0;
           IdiomOptions.Clear;
           CloseIdiom1.Visible := false;
           CheckIdiom1.Visible := true;
           TaskNotebook.PageIndex := 2;
           with Cidiom(current_task.elem) do
           begin
                plLabel1.Caption := pl;
                AnsIdiomLabel1.Caption := ang;
           end;
           AnsIdiomLabel1.Visible := false;
           other_opts := idioms.get_rand(current_task.elem);
           i := random(other_opts.count);
           other_opts.Insert(i, current_task.elem);
           for i := 0 to other_opts.Count-1 do
           begin
             IdiomOptions.AddItem(Cidiom(other_opts.Items[i]).ang, Cidiom(other_opts.items[i]));
           end;
           IdiomOptions.ItemIndex := 0;
           other_opts.destroy;
           end else
           { level 2 }
           begin
             IdiomNotebook.PageIndex := 1;
             CloseIdiom2.Visible := false;
             CheckIdiom2.Visible := true;
             IdiomEdit2.Clear;
             with Cidiom(current_task.elem) do
             begin
                plLabel2.Caption := pl;
                AnsIdiomLabel2.Caption := ang;
             end;
             AnsIdiomLabel2.Visible := false;
           end;
         end;
end;
end;

procedure TTaskForm.CheckIdiom1Click(Sender: TObject);
var
  ans : Cdateans;
begin
  ans := Cdateans.create;
  if(IdiomOptions.Items.Objects[IdiomOptions.ItemIndex] = Cidiom(current_task.elem)) then
  begin
    current_task.answer(now, true);
    AnsIdiomLabel1.Font.Color := clgreen;
  end else
  begin
    current_task.answer(now, false);
    AnsIdiomLabel1.Font.Color := clred;
  end;
  AnsIdiomLabel1.Visible := true;
  CheckIdiom1.Visible := false;
  CloseIdiom1.Visible := true;
  current_task := nil;
end;

procedure TTaskForm.IdiomEdit2Change(Sender: TObject);
begin
  if(IdiomEdit2.Caption <> '') then CheckIdiom2.Enabled:= true
  else CheckIdiom2.enabled := false;
end;

procedure TTaskForm.WordEdit2Change(Sender: TObject);
begin
  if(WordEdit2.Caption <> '') then CheckWord2.Enabled:= true
  else CheckWord2.enabled := false;
end;

procedure TTaskForm.WordLevel1Click(Sender: TObject);
begin

end;

end.

