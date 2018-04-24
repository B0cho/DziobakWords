unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dateutils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Menus, ColorBox, DbCtrls, ValEdit,
  ActnList, Buttons, unit2, wordsbase, verbsbase, idiomsbase, strutils, LCLType,
  Grids, PopupNotifier, CheckLst, EditBtn, Calendar, Spin, base, task, ctasksbase;

type

  { TMainSettings }

  TMainSettings = class(TForm)
    HarmAdd: TButton;
    HarmDelete: TButton;
    HarmCalendar: TCalendar;
    HarmNotebook: TNotebook;
    Image1: TImage;
    Image2: TImage;
    LabelHarmPage: TPage;
    HarmPage: TPage;
    MainNotebook: TNotebook;
    MainPage: TPage;
    LockPage: TPage;
    PriorBox: TGroupBox;
    HarmBox: TGroupBox;
    HarmList: TListBox;
    RelationsWords: TCheckListBox;
    RelationsVerbs: TListBox;
    RelationsLabel2: TStaticText;
    RelationLabel: TStaticText;
    PriorBar: TTrackBar;
    s3Picture1: TImage;
    MinsEdit: TSpinEdit;
    PytajLabel: TStaticText;
    MinutLabel: TStaticText;
    LockLabel: TStaticText;
    Timer1: TTimer;
    VerbCheck: TCheckBox;
    Label1: TLabel;
    WordPrefix: TComboBox;
    DictNotebook: TNotebook;
    WordAngSng: TEdit;
    IdiomPl: TLabeledEdit;
    IdiomAng: TLabeledEdit;
    s2Picture: TImage;
    s3Picture: TImage;
    SlownikNotebook: TNotebook;
    LabelSlownikPage: TPage;
    SlownikPage: TPage;
    WybierzStatsLabel1: TStaticText;
    ZakladkaRelacje: TTabSheet;
    ZakladkaHarm: TTabSheet;
    WybierzSlownikLabel: TStaticText;
    TabelaPoprawnosc: TDrawGrid;
    GroupBox1: TGroupBox;
    IdiomPage: TPage;
    QueryLabel: TLabel;
    CorrectLabel: TLabel;
    ProgressLabel: TLabel;
    LabelStatsPage: TPage;
    ProgressBar: TProgressBar;
    Correct: TStaticText;
    Query: TStaticText;
    Progress: TStaticText;
    PoprawnoscLabel: TStaticText;
    StaticText3: TStaticText;
    StatsPage: TPage;
    StatsNotebook: TNotebook;
    SlownikButtonNotebook: TNotebook;
    SlownikButtonNotebookNormal: TPage;
    SlownikButtonNotebookAdd: TPage;
    SlownikZapisz: TButton;
    SlownikAnuluj: TButton;
    StatusBar: TStatusBar;
    WordAngInputPlr: TLabeledEdit;
    WordPlSng: TLabeledEdit;
    VerbAng1: TLabeledEdit;
    VerbAng2: TLabeledEdit;
    VerbAng3: TLabeledEdit;
    VerbAng4: TLabeledEdit;
    VerbAng5: TLabeledEdit;
    VerbPl: TLabeledEdit;
    WordPage: TPage;
    VerbPage: TPage;
    WordPlCheck: TCheckBox;
    WordPlInputPlr: TEdit;
    WordBox: TGroupBox;
    VerbBox: TGroupBox;
    IdiomBox: TGroupBox;
    WordPl: TLabel;
    WordAng: TLabel;
    WordButton: TRadioButton;
    VerbButton: TRadioButton;
    IdiomButton: TRadioButton;
    FormRadio: TRadioGroup;
    SlownikDodaj: TButton;
    SlownikUsun: TButton;
    SlownikSzukaj: TEdit;
    SlownikLista: TListBox;
    WybierzStatsLabel: TStaticText;
    ZakladkaSlownik: TTabSheet;
    ZakladkaStats: TTabSheet;
    zakladkiUstawienia: TPageControl;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HarmAddClick(Sender: TObject);
    procedure HarmCalendarDayChanged(Sender: TObject);
    procedure HarmDeleteClick(Sender: TObject);
    procedure HarmListSelectionChange(Sender: TObject; User: boolean);
    procedure IdiomBoxExit(Sender: TObject);
    procedure IdiomPlChange(Sender: TObject);
    procedure PriorBarChange(Sender: TObject);
    procedure RelationsVerbsSelectionChange(Sender: TObject; User: boolean);
    procedure RelationsWordsClickCheck(Sender: TObject);
    procedure SlownikAnulujClick(Sender: TObject);
    procedure SlownikListaSelectionChange(Sender: TObject; User: boolean);
    procedure SlownikSzukajClick(Sender: TObject);
    procedure SlownikSzukajKeyPress(Sender: TObject; var Key: char);
    procedure SlownikZapiszClick(Sender: TObject);
    procedure MinsEditEditingDone(Sender: TObject);
    procedure TabelaPoprawnoscDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure VerbBoxExit(Sender: TObject);
    procedure VerbCheckChange(Sender: TObject);
    procedure VerbPlEditingDone(Sender: TObject);
    procedure WordBoxExit(Sender: TObject);
    procedure WordButtonClick(Sender: TObject);
    procedure VerbButtonClick(Sender: TObject);
    procedure IdiomButtonClick(Sender: TObject);
    procedure SlownikDodajClick(Sender: TObject);
    procedure SlownikUsunClick(Sender: TObject);
    procedure WordPlCheckClick(Sender: TObject);
    procedure WordPlSngEditingDone(Sender: TObject);
    procedure ZakladkaRelacjeHide(Sender: TObject);
    procedure ZakladkaRelacjeShow(Sender: TObject);
    procedure ZakladkaSlownikHide(Sender: TObject);
  private
    { private declarations }
    { filtruje liste elementow na podstawie tekstu pola }
    procedure filtr(var lista : TlistBox; const pole : Tedit; const key : Char);
    { wypelnia liste slow tylko tymi elementami, ktore zawieraja wzorzec, jesli jest on pusty, to wszystkimi }
    procedure filllist(var lista : TlistBox; pattern : String = ''; InclWords : Boolean = true; InclVerbs : Boolean = true; InclIdioms : Boolean = true);
    { wypelnia liste harmonogramu }
    procedure fillharmlist(var lista : TlistBox; const lista_slownika : TlistBox; const tasks_list : CTaskBase);
    { czysci wszystkie pola }
    procedure clearfields;
    { blokuje wszystkie pola strony slow }
    procedure disablefields;
    { zwraca indeks wybranego elementu na liscie, -1 jesli nie zaznaczono }
    function getSelected(const ctrl : TlistBox) : Integer;
    { WARUNKI ZAPISANIA }
    { slowa }
    function condWord : Boolean;
    { czasowniki }
    function condVerb : Boolean;
    { idiomy }
    function condIdiom : Boolean;
  public
    { public declarations }
  end;

var
  MainSettings: TMainSettings;

implementation

{$R *.lfm}

{ TMainSettings }

procedure TmainSettings.fillharmlist(var lista : TlistBox; const lista_slownika : TlistBox; const tasks_list : CTaskBase);
type
  lptr = ^LongInt;
var
  selected : Celement;
  index_ls : Integer;
  found_task : Ctask;
  i : Integer;
begin
  lista.clear;
  lista.clearselection;
  HarmCalendar.DateTime := dateof(now);
  HarmDelete.Enabled := false;
  index_ls := getSelected(lista_slownika);
  if index_ls <> -1 then
  begin
    selected := element(lista_slownika.Items.objects[index_ls]).content as Celement;
    found_task := tasks.find(selected.getId);
    for i := 0 to found_task.terms.Count-1 do
    begin
      lista.AddItem(FormatDateTime('dd.mm.yyyy', FileDateToDateTime(lptr(found_task.terms.Items[i])^)), Tobject(found_task.terms.Items[i]));
    end;
  end;
end;

{ WARUNKI ZAPISANIA }
    { slowa }
function TmainSettings.condWord : Boolean;
begin
  if
  is_alpha(WordPlSng.Caption) and
  is_alpha(WordAngSng.caption) and
  ((WordPlCheck.Checked = false) or (is_alpha(WordPlInputPlr.Caption) and is_alpha(WordAngInputPlr.Caption) and (WordPrefix.ItemIndex <> -1)))
  then condWord := true else condWord := false;
end;
    { czasowniki }
function TmainSettings.condVerb : Boolean;
begin
  if
  is_alpha(VerbPl.Caption) and
  is_alpha(VerbAng1.caption) and
  is_alpha(VerbAng2.caption) and
  (verbCheck.Checked or is_alpha(VerbAng3.caption)) and
  is_alpha(VerbAng4.caption) and
  is_alpha(VerbAng5.caption)
  then condVerb := true else condVerb := false;
end;
    { idiomy }
function TmainSettings.condIdiom : Boolean;
begin
  if
  is_alphaIdiom(IdiomPL.Text) and
  is_alphaIdiom(IdiomAng.Text)
  then condIdiom := true else condIdiom := false;
end;

procedure TmainSettings.filtr(var lista : TlistBox; const pole : Tedit; const key : Char);
var
  pattern : String; { ciag, ktory bedzie poszukiwany w kazdym elemencie }
begin
  pattern := pole.Text; { kopiowanie dotychczasowego tekstu kontrolki }
  { dodawanie znaku ze wzgledu na dodanie znaku dopiero po puszczeniu }
  if(ord(key) > 31) and (ord(key) < 127) then pattern := pattern + key
  else if(ord(key) = 8) and (length(pattern) <> 0) then setLength(pattern, length(pattern)-1);
  filllist(lista, pattern); { wypelnienie tablicy wg wzorca }
end;

{ przy wyjsciu z okna }
procedure TMainSettings.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  {zatrzymanie timera }
  timer1.Enabled := false;
  { komunikat przy wyjsciu z aplikacji }
  if(MessageDlg('DziobakWords', 'Czy na pewno chcesz zamknac DziobakWords?', mtConfirmation, [mbYes, mbNo], 0)) <> mrYes then Canclose := false
  else timer1.enabled := true;
  { komunikat o zapisie }
  if canclose and (words.changes or verbs.changes or idioms.changes or tasks.changes) and (confirmsave = false or (MessageDlg('Zapytanie', 'Zapisac zmiany do plikow?', mtConfirmation, [mbyes, mbno], 0) = mryes)) then
     if words.save = false or verbs.save = false or idioms.save = false or tasks.save = false then showmessage('Blad zapisu');
end;

procedure TMainSettings.filllist(var lista : TlistBox; pattern : String; InclWords : Boolean; InclVerbs : Boolean; InclIdioms : Boolean);
var
  i : Integer; { iterator }
  new_item : element; { para : wskaznik i typ wskaznika }
begin
  { czyszczenie listy }
  lista.Clear;
  { tworzenie listy ze slow }
  if words.is_file_opened and InclWords then
  begin
    for i := 0 to words.lista.Count - 1 do
    begin
      { jesli wzorzec zawiera sie w kluczu(wielkosc liter bez znaczenia) }
      if(pos(lowercase(pattern), lowercase(Cword(words.lista[i]).pl_poj)) <> 0) or (length(pattern) = 0) then
      begin
        new_item := element.create; { zaalokoj nowy element }
        new_item.content := Cword(words.lista[i]); { przypisanie slowa }
        new_item.typ := pword; { przypisz typ wskaznika }
        lista.AddItem(Cword(new_item.content).pl_poj + ' (' + Cword(new_item.content).ang_poj + ')', new_item); { dodaj element }
        end;
    end;
  end;
  { tworzenie listy z czasownikow }
  if verbs.is_file_opened and InclVerbs then
  begin
    for i := 0 to verbs.lista.Count - 1 do
    begin
      { jesli wzorzec zawiera sie w kluczu(wielkosc liter bez znaczenia) }
      if(pos(lowercase(pattern), lowercase(Cverb(verbs.lista[i]).pl)) <> 0) or isemptystr(pattern, [' ']) then
      begin
        new_item := element.create; { zaalokoj nowy element }
        new_item.content := Cverb(verbs.lista[i]); { przypisanie slowa }
        new_item.typ := pverb; { przypisz typ wskaznika }
        lista.AddItem(Cverb(new_item.content).pl + ' (' + Cverb(new_item.content).presentSimple1 + ')', new_item); { dodaj element }
        end;
    end;
  end;
  { tworzenie listy z idiomow }
  if idioms.is_file_opened and InclIdioms then
  begin
    for i := 0 to idioms.lista.Count - 1 do
    begin
      { jesli wzorzec zawiera sie w kluczu(wielkosc liter bez znaczenia) }
      if(pos(lowercase(pattern), lowercase(Cidiom(idioms.lista[i]).pl)) <> 0) or isemptystr(pattern, [' ']) then
      begin
        new_item := element.create; { zaalokoj nowy element }
        new_item.content := Cidiom(idioms.lista[i]); { przypisanie slowa }
        new_item.typ := pidiom; { przypisz typ wskaznika }
        lista.AddItem(Cidiom(new_item.content).pl, new_item); { dodaj element }
        end;
    end;
  end;
end;

procedure TMainSettings.clearfields;
begin
  { panel slow }
  WordPlSng.Clear; { czyszczenie l. poj pl }
  WordPlInputPlr.Clear; { czyszczenie l. mn pl }
  WordAngSng.Clear; { czyszczenie l. poj ang }
  WordAngInputPlr.Clear; { czyszczenie l. mn ang }
  WordAngInputPlr.Enabled := true; { odblokowanie l. mn ang }
  WordPlCheck.Checked := true; { zaznaczenie pola l. mn }
  WordPlSng.Enabled := true; { odblokowanie pol l. pj pl }
  WordPrefix.ClearSelection; { wyczyszczenie przedrostka }
  { panel czasownika }
  VerbPl.Clear;
  VerbAng1.Clear;
  VerbAng2.Clear;
  VerbAng3.Clear;
  VerbAng4.Clear;
  VerbAng5.Clear;
  { panel idiomu }
  IdiomPl.Clear;
  IdiomAng.Clear;
end;

procedure TmainSettings.disablefields;
begin
  { panel slow }
  WordBox.Enabled := false; { zablokowanie ramki slowa }
  WordPlCheck.Checked := false; { odhaczenie liczby mnogiej }
  { panel czasownikow }
  VerbBox.Enabled := false; { zablokowanie ramki czasownika }
  { panel idiomow }
  IdiomBox.Enabled := false; { zablokowanie ramki idiomu }
end;

{ tworzenie glownego okna }
procedure TMainSettings.FormCreate(Sender: TObject);
begin
  { ustawienie zakladki na slowa }
  {WordButtonClick(Sender);}
  SlownikNotebook.PageIndex := 0;
  { komunikat o bledzie przy otwieraniu slow }
  if words.is_file_opened = false then MessageDlg('Blad odczytu', 'Nie udalo sie otworzyc pliku slow- slowa nie beda obslugiwane w tej instancji.', mtError, [mbok], 'Help');
  if verbs.is_file_opened = false then MessageDlg('Blad odczytu', 'Nie udalo sie otworzyc pliku czasownikow- czasowniki nie beda obslugiwane w tej instancji.', mtError, [mbok], 'Help');
  if idioms.is_file_opened = false then MessageDlg('Blad odczytu', 'Nie udalo sie otworzyc pliku idiomow- idiomy i frazesy nie beda obslugiwane w tej instancji.', mtError, [mbok], 'Help');

  { wypelnienie listy }
  filllist(SlownikLista);
  MinsEdit.Value := tasks.time_break / 60000;
  { wczytywanie obrazkow }

end;

{ puszczenie klawisza w glownym oknie }
procedure TMainSettings.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  { nacisniecie delete przy wlaczonym panelu slownika }
  if(getselected(SlownikLista) <> -1) and (key = vk_delete) and (SlownikLista.Focused) then SlownikUsunClick(Sender);
end;

procedure TMainSettings.HarmAddClick(Sender: TObject);
var
  s : String;
begin
  tasks.add_term(HarmCalendar.DateTime, element(SlownikLista.Items.Objects[getSelected(slownikLista)]).content as Celement);
  fillharmlist(HarmList, SlownikLista, tasks);
end;

procedure TMainSettings.HarmCalendarDayChanged(Sender: TObject);
begin
  if(dateof(HarmCalendar.DateTime) >= dateof(now)) then HarmAdd.Enabled := true
  else HarmAdd.enabled := false;
end;

procedure TMainSettings.HarmDeleteClick(Sender: TObject);
type
  lptr = ^LongInt;
begin
  tasks.delete_term(lptr(HarmList.items.objects[getSelected(HarmList)]), element(SlownikLista.Items.Objects[getSelected(slownikLista)]).content as Celement);
  fillharmlist(HarmList, SlownikLista, tasks);
end;

procedure TMainSettings.HarmListSelectionChange(Sender: TObject; User: boolean);
begin
  if getSelected(HarmList) <> -1 then HarmDelete.enabled := true
  else HarmDelete.enabled := false;
end;

{ wyjscie z ramki idiomu }
procedure TMainSettings.IdiomBoxExit(Sender: TObject);
var
  ptr : Cidiom; { modyfikowane slowo }
begin
  if (SlownikButtonNotebook.PageIndex <> 1) and condIdiom then { jesli nie jest dodawany nowy element }
  begin
    ptr := element(SlownikLista.Items.Objects[getSelected(SlownikLista)]).content as Cidiom; { pobranie zaznaczanego slowa }
   { nadpisywanie }
    with ptr do
    begin
         pl := IdiomPl.Text;
         Ang := IdiomAng.Text;
    end;
    filllist(SlownikLista, slownikszukaj.Text); { ponowne zapelnienie kontrlki listy }
    Idioms.has_changed := true; { zaznaczenie zmian }
    Statusbar.Panels.Items[1].Text := 'Zmodyfikowano Idiom'; { w tym na pasku }
   end else Statusbar.Panels.Items[1].Text := 'Nie zapisano zmian- niedozwolone znaki'; { w tym na pasku }
end;

procedure TMainSettings.IdiomPlChange(Sender: TObject);
begin
  if condIdiom
  {is_alphaIdiom(IdiomPl.Caption) and
  is_alphaIdiom(IdiomAng.caption)}
  then SlownikZapisz.Enabled := true
  else SlownikZapisz.Enabled := false;
end;

procedure TMainSettings.PriorBarChange(Sender: TObject);
begin
  if (getSelected(SlownikLista) <> -1) and PriorBar.enabled = true then
  begin
    Celement(element(SlownikLista.Items.Objects[getSelected(SlownikLista)]).content).prior := PriorBar.Position;
    words.has_changed := true;
    statusbar.panels.Items[1].Text := 'Zmieniono priorytet';
  end;
end;

procedure TMainSettings.RelationsVerbsSelectionChange(Sender: TObject;
  User: boolean);
var
  selectedVerb : Cverb;
  i : Integer;
begin
  if getSelected(relationsVerbs) <> -1 then
  begin
    RelationsWords.ClearSelection;
    RelationsWords.CheckAll(cbUnchecked);
    RelationsWords.Enabled := true;
    selectedVerb := relationsVerbs.items.objects[getSelected(relationsVerbs)] as Cverb;
    for i := 0 to relationsWords.items.Count - 1 do
    begin
      if include(selectedVerb.relations, relationsWords.items.objects[i]) then relationsWords.Checked[i] := true;
    end;
  end else
  begin
    RelationsWords.Enabled := false;
  end;
end;

procedure TMainSettings.RelationsWordsClickCheck(Sender: TObject);
var
  current_verb : Cverb;
  i : Integer;
  index : Integer;
begin
  current_verb := Cverb(RelationsVerbs.Items.Objects[getSelected(RelationsVerbs)]);
  { zmiany w slowach- odhaczenie }
  for i := 0 to current_verb.relations.Count-1 do
  begin
    { indeks slowa na kontrolce slow relacji}
    index := RelationsWords.Items.IndexOfObject(Tobject(current_verb.relations.Items[i]));
    { jesli dane slowo zostalo odchaczone, to wywal je z listy relacji odhaczonego slowa }
    if not RelationsWords.Checked[index] then Cword(RelationsWords.Items.Objects[index]).relations.remove(current_verb);
  end;
  { ponowne zapisanie listy relacji czasownika }
  current_verb.relations.Clear;
  for i := 0 to RelationsWords.Items.Count-1 do
  begin
    if RelationsWords.Checked[i] then
    begin
      current_verb.relations.add(RelationsWords.Items.Objects[i]);
      if(Cword(relationsWords.Items.Objects[i]).relations.IndexOf(current_verb) = -1) then Cword(relationsWords.Items.Objects[i]).relations.Add(current_verb);
    end;
  end;
  { zaznaczenie zmian }
  verbs.has_changed := true;
  words.has_changed := true;
  statusbar.panels.Items[1].Text := 'Zmieniono relację';
end;

{ klikniecie anuluj }
procedure TMainSettings.SlownikAnulujClick(Sender: TObject);
begin
  { zablokowanie pol }
  clearfields;
  {disablefields;}
  SlownikNotebook.PageIndex := 0;
  formradio.Enabled := false;
  { odblokowanie pol }
  SlownikLista.Enabled := true;
  SlownikSzukaj.Enabled := true;
  { przelaczenie przyciskow anuluj i zapisz na dodaj i usun }
  SlownikButtonNotebook.PageIndex := 0;
end;

{ zmiana zaznaczenia na liscie }
procedure TMainSettings.SlownikListaSelectionChange(Sender: TObject;
  User: boolean);
var
  item : element; { przechwytywany element listy }
  current_word : Cword; { obslugiwany element jako slowo }
  current_verb : Cverb; { obslugiwany element jako czasownik }
  current_idiom : Cidiom; { obslugiwany element jako idiom }
  current : Celement; { obslugiwany element }
  index : Integer; { indeks }
  queries : Integer; { ilosc zapytan }
  corr : Integer = 0; { ilosc poprawnych }
  progr : Double = 0; { wskaznik postepu }
  i : Integer; { iterator }
begin
  index := getSelected(SlownikLista); { zwraca indeks zaznaczonego elementu }
  if index <> -1 then { jesli jakikolwiek jest zaznaczony }
  begin
    item := SlownikLista.items.Objects[index] as element; { przechwyc element i skastuj }
    { ustawienie slowa }
    SlownikNotebook.PageIndex := 1;
    case item.typ of { ustaw pola }
         { slowo }
         pword :
         begin
           current_word := item.content as Cword; { rzutowanie }
           DictNotebook.PageIndex := 1; {przelaczenie notebooka na slowo }
           WordButton.Checked := true; { zaznaczenie radio }
           WordBox.Enabled := true; { odblokowanie pol slow }
           SlownikUsun.Enabled := true;{ odblokowanie przycisku usun }
           { uzupelnianie pol }
           WordPlSng.Text := current_word.pl_poj; { pol- l. poj }
           WordAngSng.Text := current_word.ang_poj; { ang- l poj }
           WordPlInputPlr.Text := current_word.pl_mn; { pol- l mn }
           WordAngInputPlr.Text := current_word.ang_mn; { ang - l mn }
           WordPrefix.ItemIndex := LongInt(current_word.prefix) - 1; { ustawienie przedimka }
           if length(current_word.pl_mn) <> 0 then WordPlCheck.Checked := true { jesli nie ma liczby mn, zablokuj pl mn}
           else WordPlCheck.Checked := false;
           WordPlCheckClick(Sender);
         end;
         { czasownik }
         pverb :
         begin
           current_verb := item.content as Cverb; { rzutowanie }
           VerbButton.Checked := true; { zaznaczenie radio }
           DictNotebook.PageIndex := 2; { przelaczenie notebooka na czasownik }
           VerbBox.Enabled := true; { odblokowanie kontrolek }
           SlownikUsun.Enabled := true; { zablokowanie przycisku usun }
           if length(current_verb.presentContinous) = 0 then
           begin
             VerbCheck.Checked := true;
             VerbCheckChange(Sender);
           end;
           { uzupelnianie pol }
           with current_verb do
           begin
             VerbPl.Text := pl;
             VerbAng1.Text := presentSimple1;
             VerbAng2.Text := presentSimple3;
             VerbAng3.Text := presentContinous;
             VerbAng4.Text := pastSimple;
             VerbAng5.Text := pastPerfect;
           end;
         end;
         { idiom }
         pidiom :
         begin
           current_idiom := item.content as Cidiom; { rzutowanie }
           IdiomButton.Checked := true; { zaznaczenie radio }
           DictNotebook.PageIndex := 0; { przelaczenie notebooka na idiom }
           IdiomBox.Enabled := true; { odblokowanie kontrolek }
           SlownikUsun.Enabled := true; { zablokowanie przycisku usun }
           { uzupelnianie pol }
           with current_idiom do
           begin
             IdiomPl.Text := pl;
             IdiomAng.Text := ang;
             {}
           end;


           {}
         end;
    end;
  { ustawienie statystyk }
  current := item.content as Celement;
  StatsNotebook.PageIndex := 1; { przelaczenie strony statystyk na pokazywanie danych }
  queries := current.dates.Count; { obliczenie ilosci zapytan }
  TabelaPoprawnosc.RowCount := queries + 1; { ustawienie ilosci wierszy }
  for i := 0 to queries-1 do if Cdateans(current.dates[i]).ans = true then inc(corr); { obliczanie ilosci poprawnych odpowiedzi }
  progr := corr / (queries + 1); { obliczanie progresu }
  ProgressBar.Position:= Round(ProgressBar.Min + progr * (ProgressBar.Max - ProgressBar.Min)); { ustawienie paska progresu }
  query.Caption := inttostr(queries); { ustawienie ilosci zapytan }
  correct.Caption := inttostr(corr); { ustawienie ilosci poprawnych odpowiedzi }
  progress.Caption:= inttostr(round(100 * progr)) + '%'; { ustawienie progresu }
  { ustawienie harmonogramu }
  PriorBar.Enabled := false;
  PriorBar.Position := current.prior;
  PriorBar.Enabled := true;
  HarmAdd.Enabled := false;
  HarmNotebook.PageIndex := 1;
  { wypelnij liste zadaniami }
  fillharmlist(HarmList, SlownikLista, tasks);


  end else { jesli nie zostal zaznaczony zadny }
  begin
    SlownikNotebook.PageIndex := 0; { przelaczenie strony slownika }
    StatsNotebook.PageIndex := 0; { przelaczenie strony statystyk }
    SlownikUsun.Enabled := false; { zablokowanie przycisku usuwania }
    PriorBar.Position := 0; { wyczyszczenie paska priorytetu }
    HarmList.Clear; { wyczyszczenie listy dat }
    HarmNotebook.PageIndex := 0;
    {}

  end;

end;

{ klikniecie slownik szukaj }
procedure TMainSettings.SlownikSzukajClick(Sender: TObject);
begin
  SlownikLista.ClearSelection; { wyczysc zaznaczenie }
  SlownikUsun.Enabled := false; { zablokuj przycisk usuwania }
end;

{ nacisniecie klawisza dla przycisku szukaj }
procedure TMainSettings.SlownikSzukajKeyPress(Sender: TObject; var Key: char);
begin
  filtr(SlownikLista, SlownikSzukaj, key); { przefiltrowanie listy wg tekstu w polu }
end;

{ klikniecie zapisz }
procedure TMainSettings.SlownikZapiszClick(Sender: TObject);
var
  new_pair : element; { zmienna nowego elementu- zawartosci + wskaznik }
begin
  { inicjalizacja nowego elementu }
  new_pair := element.Create;
  { dla slowa }
  if WordButton.Checked then
  begin
   new_pair.typ := pword; { ustawienie typu }
   new_pair.content := cword.init(DateTimeToFileDate(Now), WordPlSng.Text, '', WordAngSng.Text, ''); { wstepne uzupelnienie }
   cword(new_pair.content).prefix := CWordPrefix(WordPrefix.ItemIndex + 1); { zapisanie prefixu }
   if WordPlCheck.Checked then
   begin
    cword(new_pair.content).pl_mn := WordPlInputPlr.Text; { wstawienie liczby mnogiej }
    cword(new_pair.content).ang_mn := WordAngInputPlr.Text;
   end;
   words.lista.Add(new_pair.content); { dodawanie do listy slow }
   filllist(SlownikLista);
   Statusbar.Panels.Items[1].Text := 'Dodano slowo'; { zmiana statusu }
   words.has_changed := true;
   tasks.add_task(Ctask.create(new_pair.content as Celement, pword));
  end
  else
  { dla czasownika }
  if VerbButton.Checked then
  begin
   new_pair.typ := pverb;
   new_pair.content := cverb.init(DateTimeToFileDate(Now), VerbPl.Text, VerbAng1.Text, VerbAng2.Text, VerbAng3.Text, VerbAng4.Text, VerbAng5.Text);
   verbs.lista.add(new_pair.content); { dodawanie do listy czasownikow }
   filllist(SlownikLista);
   Statusbar.Panels.Items[1].Text := 'Dodano czasownik'; { zmiana statusu }
   verbs.has_changed := true;
   tasks.add_task(Ctask.create(new_pair.content as Celement, pverb));
  end
  else
  { dla idiomu }
  if IdiomButton.Checked then
  begin
   new_pair.typ := pIdiom;
   new_pair.content := Cidiom.init(DateTimeToFileDate(Now), IdiomPL.Text, IdiomAng.Text);
   idioms.lista.add(new_pair.content); { dodawanie do listy czasownikow }
   {SlownikLista.AddItem(Cidiom(new_pair.content).pl, new_pair); { dodawanie do kontrolki listy }}
   filllist(SlownikLista);
   Statusbar.Panels.Items[1].Text := 'Dodano idiom'; { zmiana statusu }
   idioms.has_changed := true;
   tasks.add_task(Ctask.create(new_pair.content as Celement, pidiom));
  {}
  end;
  SlownikAnulujClick(Sender); { powrot do poprzedniego widoku }
end;

procedure TMainSettings.MinsEditEditingDone(Sender: TObject);
begin
  tasks.time_break := MinsEdit.Value;
  words.has_changed := true;
end;

{ rysowanie tabelki poprawnosci }
procedure TMainSettings.TabelaPoprawnoscDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  ptr : Celement; { wskaznik na zaznaczone na liscie slowo }
begin
  { jesli rysuje wiersz nie bedacy naglowkiem i jesli zaznaczono jakikolwiek element }
  if (getSelected(SlownikLista) <> -1) and (arow <> 0) then
  begin
   ptr := element(SlownikLista.Items.Objects[getSelected(SlownikLista)]).content as Celement; { sprowadzenie zaznaczonego slowa }
   case acol of
       0: { w kolumnie dat }
       begin
         TabelaPoprawnosc.Canvas.Font.Color := clBlack; { ustawienie koloru czcionki na czarny }
         TabelaPoprawnosc.Canvas.TextRect(arect, arect.Left, arect.Top, FormatDateTime('hh:nn:ss DD.MM.YYYY' ,Cdateans(ptr.dates[arow-1]).time)); { wpisanie daty }
       end;
       1: { w kolumnie poprawnosci }
       begin
         if Cdateans(ptr.dates[arow-1]).ans = true then TabelaPoprawnosc.Canvas.Brush.color := clGreen { jesli odpowiedz dobra, to ustaw pedzel na zielony }
         else TabelaPoprawnosc.Canvas.Brush.color := clRed; { jesli zla, to na czerwony }
         TabelaPoprawnosc.Canvas.Ellipse(arect.TopLeft.x + 3, arect.TopLeft.y + 3, arect.TopLeft.x + 25, arect.TopLeft.y + 25); { narysuj kolo o ustawionym kolorze }

       end;
   end;
  end;
end;

procedure TMainSettings.Timer1Timer(Sender: TObject);
begin
  dec(tasks.time, Timer1.Interval);
  if(tasks.time <= 0) and (tasks.is_task) then
  begin
       timer1.Enabled:= false;
       MainNotebook.PageIndex := 1;
       TaskForm.current_task := tasks.getTask;
       TaskForm.ShowModal;
       MainNotebook.PageIndex := 0;
       timer1.Enabled:= true;
       tasks.generate_task;
  end;

end;

{ przy wyjsciu z opakowania czasownika }
procedure TMainSettings.VerbBoxExit(Sender: TObject);
var
  ptr : Cverb; { modyfikowane slowo }
begin
  if (SlownikButtonNotebook.PageIndex <> 1) and condVerb then { jesli nie jest dodawany nowy element }
  begin
    ptr := element(SlownikLista.Items.Objects[getSelected(SlownikLista)]).content as Cverb; { pobranie zaznaczanego slowa }
   { nadpisywanie }
    with ptr do
    begin
         pl := VerbPL.Text;
         presentSimple1 := VerbAng1.Text;
         presentSimple3 := VerbAng2.Text;
         presentContinous := VerbAng3.Text;
         pastSimple := VerbAng4.Text;
         pastPerfect := VerbAng5.Text;
    end;
    filllist(SlownikLista, slownikszukaj.Text); { ponowne zapelnienie kontrlki listy }
    verbs.has_changed := true; { zaznaczenie zmian }
    Statusbar.Panels.Items[1].Text := 'Zmieniono czasownik'; { w tym na pasku }
   end else Statusbar.Panels.Items[1].Text := 'Nie zapisano zmian- niedozwolone znaki';
end;

{ zaznaczenie lub odznaczenie checka czasownika statycnzego }
procedure TMainSettings.VerbCheckChange(Sender: TObject);
begin
  if(VerbCheck.Checked) then VerbAng3.Enabled := false
  else VerbAng3.enabled := true;
  VerbAng3.Clear;
  VerbPlEditingDone(Sender);
end;

{ na zakonczenie edycji pol czasownika }
procedure TMainSettings.VerbPlEditingDone(Sender: TObject);
begin
  if condVerb then SlownikZapisz.Enabled := true
  else SlownikZapisz.Enabled := false;
end;

{ wyjscie poza ramke slowa }
procedure TMainSettings.WordBoxExit(Sender: TObject);
var
  ptr : cword; { modyfikowane slowo }
begin
  if (SlownikButtonNotebook.PageIndex <> 1) then { jesli nie jest dodawany nowy element }
  begin
    if condWord then
    begin
      ptr := element(SlownikLista.Items.Objects[getSelected(SlownikLista)]).content as cword; { pobranie zaznaczanego slowa }
     { nadpisywanie }
      ptr.pl_poj := WordPlSng.Text;
      ptr.ang_poj := WordAngSng.Text;
      { jesli zaznaczono l mn }
      if WordPlCheck.checked then
      begin
        ptr.pl_mn := WordPlInputPlr.Text;
        ptr.ang_mn := WordAngInputPlr.Text;
        {ptr.prefix := CWordPrefix(WordPrefix.ItemIndex + 1);}
      end else
      begin
        ptr.ang_mn := '';
        ptr.pl_mn := '';
        {ptr.prefix := none;}
      end;
      ptr.prefix := CWordPrefix(WordPrefix.ItemIndex + 1);
      filllist(SlownikLista, slownikszukaj.Text); { ponowne zapelnienie kontrlki listy }
      words.has_changed := true; { zaznaczenie zmian }
      Statusbar.Panels.Items[1].Text := 'Zmieniono slowo'; { w tym na pasku }
    end else Statusbar.Panels.Items[1].Text := 'Nie zapisano zmian- niedozwolone znaki'; { w tym na pasku }            ;
  end;
end;

{ nacisniecie na radio slowa }
procedure TMainSettings.WordButtonClick(Sender: TObject);
begin
  DictNotebook.PageIndex := 1;
  clearfields;
  SlownikZapisz.Enabled := false;
end;

{ nacisniecie na radio czasownika }
procedure TMainSettings.VerbButtonClick(Sender: TObject);
begin
  DictNotebook.PageIndex := 2;
  clearfields;
  SlownikZapisz.Enabled := false;
end;

{ nacisniecie na radio czasownika }
procedure TMainSettings.IdiomButtonClick(Sender: TObject);
begin
  DictNotebook.PageIndex := 0;
  clearfields;
  SlownikZapisz.Enabled := false;
end;

{ nacisniecie na przycisk dodaj }
procedure TMainSettings.SlownikDodajClick(Sender: TObject);
begin
  SlownikLista.ClearSelection; { wyczysc zaznaczenie na liscie }
  ZakladkiUstawienia.PageIndex := 0; { ustawienie zakladki na slownik }
  SlownikNotebook.PageIndex := 1; { ustawienie zakladki slownika na slowo }
  WordButton.Checked := true;
  WordButtonClick(Sender);
  StatusBar.Panels.Items[1].Text := ''; { wyczyszczenie paska }
  SlownikButtonNotebook.PageIndex := 1; { przestawienie przyciskow na zapisz i anuluj }
  { odblokowywanie pol }
  FormRadio.Enabled := true;
  WordBox.Enabled := true;
  VerbBox.Enabled := true;
  IdiomBox.Enabled := true;
  { blokowanie pol }
  SlownikLista.Enabled := false;
  SlownikSzukaj.Enabled := false;
  SlownikZapisz.Enabled := false;

  {}


end;

{ nacisniecie na przycisk usun }
procedure TMainSettings.SlownikUsunClick(Sender: TObject);
var
  index : Integer; { indeks elementu do usuniecia na kontrolce }
  to_del : element; { wskaznik na pare do usuniecia }
  i : Integer; { iterator }
begin
  index := getSelected(SlownikLista); { zwrocenie indeksu zaznaczonego elementu }
  { jesli na kontrolce jest zaznaczony jakikolwiek elementu i jesli potwierdzono usuniecie }
  if (index <> -1) and ((confirmDelete = false) or (MessageDlg('Zapytanie', 'Czy na pewno chcesz usunac ten element?', mtConfirmation, [mbyes, mbno], 0) = mryes)) then
  begin
    to_del := SlownikLista.Items.Objects[index] as element; { wskaznik do elementu do usuniecia }
    case to_del.typ of
         { w przypadku slowa }
         PWORD:
         begin
           words.lista.Remove(to_del.content); { usuwanie z listy slow }
           to_del.destroy; { niszczenie zawartosci wskaznika }
           SlownikLista.items.Delete(index); { usuwanie z kontrolki }
           words.has_changed := true; { zaznaczenie zmiany }
           { usuwanie slowa z relacji z czasownikami }
           verbs.dropRelation(to_del.content as Celement);

           {}

         end;
         { czasownik }
         PVERB:
         begin
           verbs.lista.Remove(to_del.content); { usuwanie z listy czasownika }
           to_del.destroy;
           SlownikLista.items.Delete(index);
           verbs.has_changed := true; { zaznaczenie zmiany }
           { usuwanie czasownika z relacji ze slowami }
           words.dropRelation(to_del.content as Celement);

           {}

         end;
         { idiom }
         PIDIOM:
         begin
           idioms.lista.Remove(to_del.content); { usuwanie z listy czasownika }
           to_del.destroy;
           SlownikLista.items.Delete(index);
           idioms.has_changed := true; { zaznaczenie zmiany }

           {}

         end;
    end;
    { wywalenie zadania }
    tasks.delete(to_del.content as Celement);
    clearfields; { wyczyszczenie pol }
    disablefields; { zablokowanie pol }
    SlownikUsun.Enabled := false; { zablokowanie przycisku usun }
    SlownikNotebook.PageIndex := 0;
    StatsNotebook.PageIndex := 0;
    HarmNotebook.PageIndex := 0;
    StatusBar.Panels.Items[1].Text := 'Usunieto'; { zaznaczenie zmiany na pasku }
  end;
end;

{ zaznaczenie liczby mnogiej }
procedure TMainSettings.WordPlCheckClick(Sender: TObject);
begin
  { jesli pole jest zaznaczone, to odblokuj, inaczej zablokuj }
  if WordPlCheck.Checked then
  begin
   WordPlInputPlr.Enabled := true;
   WordAngInputPlr.Enabled := true;
   WordPrefix.Enabled := true;
   {WordPrefix.ItemIndex := 0;}
  end else
  begin
    WordPlInputPlr.Enabled := false;
    WordAngInputPlr.Enabled := false;
    WordPrefix.Enabled := false;
    WordPlInputPlr.Clear;
    WordAngInputPlr.Clear;
    WordPrefix.ClearSelection;
  end;
  WordPlSngEditingDone(Sender);
end;

{ na zakonczenie edycji pol slowa }
procedure TMainSettings.WordPlSngEditingDone(Sender: TObject);
begin
  if condWord then SlownikZapisz.Enabled := true
  else SlownikZapisz.Enabled := false;
end;

{ chowanie zakladaki relacji }
procedure TMainSettings.ZakladkaRelacjeHide(Sender: TObject);
begin
  { odblokowanie kontrolek }
  SlownikSzukaj.Enabled := true;
  SlownikLista.Enabled := true;
end;

{ pokazywanie zakladki relacji }
procedure TMainSettings.ZakladkaRelacjeShow(Sender: TObject);
var
  i : Integer;
  copy : element;
begin
  { blokowanie kontrolek }
  SlownikSzukaj.Enabled := false;
  SlownikLista.Enabled := false;
  RelationsWords.ClearSelection;
  RelationsVerbs.ClearSelection;
  RelationsWords.Enabled := false;
  { ladowanie kontrolek }
  { czyszczenie kontrolek }
  RelationsWords.Clear;
  RelationsVerbs.Clear;
  { kopiowanie elementow listy glownej do listy czasownikow i slow }
  if words.is_file_opened and verbs.is_file_opened then
  begin
    for i := 0 to SlownikLista.Items.Count - 1 do
    begin
        copy := SlownikLista.Items.Objects[i] as element; { pobierz wskaznik do elementu listy }
        { dodanie do slow }
        if copy.typ = pword then RelationsWords.AddItem(Cword(copy.content).pl_poj + ' (' + Cword(copy.content).ang_poj + ')', copy.content);
        { dodanie do czasownikow }
        if copy.typ = pverb then RelationsVerbs.AddItem(Cverb(copy.content).pl + ' (' + Cverb(copy.content).presentSimple1 + ')', copy.content);
    end;
  end;
end;

{ zasuniecie zakladki slownika }
procedure TMainSettings.ZakladkaSlownikHide(Sender: TObject);
begin
  { wtrybie dodawanie nowego slowa }
  if SlownikButtonNotebook.PageIndex = 1 then SlownikAnulujClick(Sender);
  {
  { po zmianach- zapisanie }
  if words.changes and (confirmsave = false or (MessageDlg('Zapytanie', 'Zapisac zmiany do plikow?', mtConfirmation, [mbyes, mbno], 0) = mryes)) then
  begin
   with StatusBar.Panels.Items[1] do
        if words.save then Text := 'Zapisano'
        else Text := 'Wystapil blad przy zapisie!';
  end else words.has_changed:= false;
  }
end;


{ przy zamykaniu }
procedure TMainSettings.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  words.destroy;
  verbs.destroy;

end;

{ zwraca indeks zaznaczonego elementu na liscie }
function TmainSettings.getSelected(const ctrl : TlistBox) : Integer;
var
  index : Integer;
begin
  getSelected := - 1; { zaloz, ze zaden nie jest zaznaczony }
  for index := 0 to ctrl.Count - 1 do
  begin
    if ctrl.Selected[index] then { jesli ten jest zaznaczony, to zapisz indeks }
    begin
      getSelected := index;
      break;
    end;
  end;
end;

end.

