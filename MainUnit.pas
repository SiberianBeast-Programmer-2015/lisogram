unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, strutils, helpUnit, jpeg, ExtCtrls, ComCtrls, MPlayer,
  OleCtrls, WMPLib_TLB,helpFormUnit, PicShow;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ButtonCheck: TButton;
    ThemeLabel: TLabel;
    buttonHelp: TButton;
    QueryLabel: TLabel;
    Image1: TImage;
    CheckBox5: TCheckBox;
    Timer1: TTimer;
    PicShow1: TPicShow;
    TaskNumberLabel: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo5: TMemo;
    ContinueLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCheckClick(Sender: TObject);
    procedure buttonHelpClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    currTask: integer;
    myThemeName: string;
    procedure setTheme(themeName: string);
    procedure readTest(testFile: string);
    procedure loadTest(number: integer);
    function getUserAnswerString(): string;
    procedure testIsFinished();
    procedure doIfRightAnswer();
    procedure doIfFalseAnswer();
    procedure cleanFields();
    procedure setQueryToCenter();
  end;
const testName = 'test.txt';
var
  Form1: TForm1;
  Form2: TForm2;
  
  list: TStringList;
  tasks: array of TStringList;
  
  answer: string;
  startLeft,startTop: integer; // WMP unknown behavior  
  i: integer;
implementation

{$R *.dfm}
{В каждом тесте сначала тема идет, потом === потом структурно. вот так:
тема
===
вопрос:
варианты
правильныйответ
---
вопрос:
варианты
ответ
}

procedure TForm1.readTest(testFile: string); // разделим на прочтение вопросов циклично
var i,n: integer; element: string;
begin
  With Form1 do begin 
    list := TStringList.Create;
    list.LoadFromFile(testFile);

    myThemeName := getInfo(list[0]);
    ThemeLabel.Caption := myThemeName;

    n := 1;
    SetLength(tasks,n+1);
    tasks[n] := TStringList.Create;
    for i := 2 to list.count - 1 do
    begin
      element := Trim(list[i]);
      if element = '---' then  // delimiter
      begin
        Inc(n);
        SetLength(tasks,n+1);
        tasks[n] := TStringList.Create;
      end
      else
        tasks[n].Add(element);
    end; 
    list.Free;
    list := nil;
  end; //end with
{на выходе имеем структурированный массив заданий}
end;

procedure TForm1.loadTest(number: integer);
var i: integer; 
    func,element: string;
begin
  ThemeLabel.Caption := 'Тема: ' + myThemeName;
  for i := 0 to tasks[number].Count - 1 do
  begin
    func := getFunction(tasks[number][i]);
    element := getInfo(tasks[number][i]);
    if  func = 'тема' then
    begin
      ThemeLabel.Caption := 'Тема: ' + element;
      myThemeName := element;
    end;
    if func = 'продолжение' then
      ContinueLabel.Caption := ContinueLabel.Caption + #10#13 + element;
    if func = 'вопрос' then
    begin      
      QueryLabel.Caption := element;
      QueryLabel.Top := 72; // default value from the form's designer
      TaskNumberLabel.Caption := 'Вопрос № ' + IntToStr(Form1.currTask);
    end;
    if func = 'вариант1' then 
    begin 
      Memo1.Lines.Add(element);
      Memo1.Enabled := true;
      CheckBox1.Enabled := true;
    end;
    if func = 'вариант2' then 
    begin 
      Memo2.Lines.Add(element);
      Memo2.Enabled := true;
      CheckBox2.Enabled := true;
    end;
    if func = 'вариант3' then 
    begin 
      Memo3.Lines.Add(element);
      Memo3.Enabled := true;
      CheckBox3.Enabled := true;
    end;
    if func = 'вариант4' then 
    begin 
      Memo4.Lines.Add(element);
      Memo4.Enabled := true;
      CheckBox4.Enabled := true;
    end;
    if func = 'вариант5' then 
    begin 
      Memo5.Lines.Add(element);
      Memo5.Enabled := true;
      CheckBox5.Enabled := true;
    end;
    if func = 'правильныйвариантномер' then
      answer := element;
  end;
  if ContinueLabel.Caption = '' then 
    setQueryToCenter();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  cleanFields;
  buttonHelp.Visible := false;
end;

function TForm1.getUserAnswerString(): string;
var 
  s: string;
begin
  s := '';
  if CheckBox1.Checked = true then
    s := s + '1';
  if CheckBox2.Checked = true then
    s := s + '2';
  if CheckBox3.Checked = true then
    s := s + '3';
  if CheckBox4.Checked = true then
    s := s + '4';
  Result := s;
end;

procedure TForm1.testIsFinished();
begin
  form1.ButtonCheck.Enabled := false;
  ShowMessage('Тест пройден. Возвращаемся к карте');
  Application.MainForm.Show;
  form1.Close;
end;

procedure TForm1.doIfRightAnswer();
begin
  form1.buttonHelp.Visible := false;
  if currTask = Length(tasks) - 1 then
  begin
    testIsFinished();
    exit;
  end
  else
    Inc(currTask);
  cleanFields;
  loadTest(currTask);
end;

procedure TForm1.doIfFalseAnswer();
begin
  Form1.buttonHelp.Visible := true;
  ShowMessage('Ответ неверен, обратитесь к справке');
end;

procedure TForm1.ButtonCheckClick(Sender: TObject);
begin
   if Trim(getUserAnswerString) = Trim(answer) then
    doIfRightAnswer()
   else
    doIfFalseAnswer();
end;

procedure TForm1.buttonHelpClick(Sender: TObject);
begin
  if FileExists(appData + 'Materials\' + Trim(myThemeName) + '.rtf') then
  begin
    Application.CreateForm(TForm2,Form2);
    Form2.Show;
    Form2.setThemeName(myThemeName);
  end
  else
    ShowMessage('нет такого файла справки! ' + #10#13 + 
    appData + 'Materials\' + Trim(myThemeName) + '.rtf');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  try
    Inc(i);
    if (i mod 2 = 0) then
    begin
      PicShow1.BgPicture.LoadFromFile(appdata + 'lis\lis3.bmp');
    end;
    if (i mod 3 = 0) then 
      PicShow1.BgPicture.LoadFromFile(appData + 'lis\lis2.bmp');
    if (i mod 4 = 0) then
      PicShow1.BgPicture.LoadFromFile(appdata + 'lis\lis1.bmp');
    if (i mod 5 = 0) then
      i := 1;
  except
    Timer1.Enabled := false;
    ShowMessage('Отсутствуют файлы анимации лиса!');
  end;
end;

procedure TForm1.cleanFields;
begin
  QueryLabel.Caption := '';
  ContinueLabel.Caption := '';
  ThemeLabel.Caption := '';
  
  Memo1.Lines.Clear; Memo1.Enabled := false;
  Memo2.Lines.Clear; Memo2.Enabled := false;
  Memo3.Lines.Clear; Memo3.Enabled := false;
  Memo4.Lines.Clear; Memo4.Enabled := false;
  Memo5.Lines.Clear; Memo5.Enabled := false;
    
  CheckBox1.Checked := false;  CheckBox1.Enabled := false;
  CheckBox2.Checked := false;  CheckBox2.Enabled := false;
  CheckBox3.Checked := false;  CheckBox3.Enabled := false;
  CheckBox4.Checked := false;  CheckBox4.Enabled := false;
  CheckBox5.Checked := false;  CheckBox5.Enabled := false;
end;

procedure TForm1.FormHide(Sender: TObject);
begin
  Timer1.Enabled := false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
  Self.Top := 0;
end;

procedure TForm1.setTheme(themeName: string);
begin
  myThemeName := themeName;
  currTask := 1;
  readTest(appData + 'Materials\' + themeName + '.txt'); // whole test to read
  loadTest(currTask); // show the first test
end;

procedure TForm1.setQueryToCenter;
const 
  queryLabelHeight = 36;
var 
  imageMediana, labelMediana: integer;
begin
  imageMediana := (image1.Height div 2) + image1.Top;
  labelMediana := (imageMediana + queryLabelHeight div 2) - (QueryLabel.Height div 2);

  QueryLabel.Top := labelMediana;
end;

end.

