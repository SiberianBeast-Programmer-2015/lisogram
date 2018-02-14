unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, strutils, helpUnit, jpeg, ExtCtrls, ComCtrls, MPlayer,
  OleCtrls, WMPLib_TLB;

type
  TForm1 = class(TForm)
    Variant1: TEdit;
    CheckBox1: TCheckBox;
    Variant2: TEdit;
    CheckBox2: TCheckBox;
    Variant3: TEdit;
    CheckBox3: TCheckBox;
    Variant4: TEdit;
    CheckBox4: TCheckBox;
    ButtonCheck: TButton;
    ThemeLabel: TLabel;
    buttonHelp: TButton;
    QueryLabel: TLabel;
    Image1: TImage;
    variant5: TEdit;
    CheckBox5: TCheckBox;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCheckClick(Sender: TObject);
    procedure buttonHelpClick(Sender: TObject);
    procedure WindowsMediaPlayer1PlayStateChange(ASender: TObject;
      NewState: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WindowsMediaPlayer1OpenStateChange(ASender: TObject;
      NewState: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const testName = 'test.txt';
var
  Form1: TForm1;
  list: TStringList;
  tasks: array of TStringList;
  currTask: integer;
  answer: string;   themeName: string;
  startLeft,startTop: integer; // WMP unknown behavior
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

procedure readTest(testFile: string); // разделим на прочтение вопросов циклично
var i,n: integer; element: string;
begin
  With Form1 do begin 
    list := TStringList.Create;
    list.LoadFromFile(testFile);

    themeName := getInfo(list[0]);
    ThemeLabel.Caption := themeName;

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

procedure loadTest(number: integer);
var i: integer; var func,element: string;
begin
  with form1 do 
  begin
    for i := 0 to tasks[number].Count - 1 do
    begin
      func := getFunction(tasks[number][i]);
      element := getInfo(tasks[number][i]);
      if  func = 'тема' then
        ThemeLabel.Caption := 'Тема: ' + element;
      if func = 'вопрос' then
        QueryLabel.Caption := element;
      if func = 'вариант1' then
        Variant1.Text := element;
      if func = 'вариант2' then
        Variant2.Text := element;
      if func = 'вариант3' then
        Variant3.Text := element;
      if func = 'вариант4' then
        Variant4.Text := element;
      if func = 'вариант5' then
        Variant5.Text := element;
      if func = 'правильныйвариантномер' then     
        answer := element;
    end;
  end;
end;

procedure QueryBgImageLoad();
var bm: TBitmap;
begin
  bm := TBitmap.Create();
  bm.LoadFromFile(appData + 'bgImage.bmp');
  with form1 do
  begin
    Image1.Proportional := false;
    Image1.Stretch := true;
    Image1.Picture.Assign(bm);
  end;
end;

procedure loadVideo();
begin
  with Form1 do
  begin
    WindowsMediaPlayer1.uiMode := 'none';
    WindowsMediaPlayer1.settings.volume := 100;
    WindowsMediaPlayer1.URL := appData + '1.avi'; 
  end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  startLeft := WindowsMediaPlayer1.Left;
  startTop := WindowsMediaPlayer1.Top;
  QueryBgImageLoad(); // query area background image
  
  loadVideo;
  
  buttonHelp.Visible := false;
  currTask := 1;
  readTest(appData + testName); // whole test to read
  loadTest(currTask); // show the first test
end;

function getUserAnswerString(): string;
var s: string;
begin
  s := '';
  if Form1.CheckBox1.Checked = true then
    s := s + '1';
  if Form1.CheckBox2.Checked = true then
    s := s + '2';
  if Form1.CheckBox3.Checked = true then
    s := s + '3';
  if Form1.CheckBox4.Checked = true then
    s := s + '4';
  Result := s;
end;

procedure testIsFinished();
begin
  form1.ButtonCheck.Enabled := false;
  showMessage('Выполните действие по окончании теста');
end;

procedure doIfRightAnswer();
begin
  form1.buttonHelp.Visible := false;
  if currTask = Length(tasks) - 1 then
  begin
    testIsFinished();
    exit;
  end
  else
    Inc(currTask);
  with form1 do
  begin
    variant1.Text := '';
    variant2.Text := '';
    variant3.Text := '';
    variant4.Text := '';
    variant5.Text := '';
    
    CheckBox1.Checked := false;
    CheckBox2.Checked := false;
    CheckBox3.Checked := false;
    CheckBox4.Checked := false;
    CheckBox5.Checked := false;
  end;
  loadTest(currTask);
end;

procedure doIfFalseAnswer();
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
  ShowMessage('Здесь была справка');
end;

procedure TForm1.WindowsMediaPlayer1PlayStateChange(ASender: TObject;
  NewState: Integer);
begin
  try
    WindowsMediaPlayer1.Left := startLeft;
    WindowsMediaPlayer1.Top := startTop;
    if (newstate = 1) then
      WindowsMediaPlayer1.controls.play; 
  except
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  WindowsMediaPlayer1.controls.stop; // avoid exceptions
  WindowsMediaPlayer1.close;
end;

procedure TForm1.WindowsMediaPlayer1OpenStateChange(ASender: TObject;
  NewState: Integer);
begin
  WindowsMediaPlayer1.Left := startLeft;
  WindowsMediaPlayer1.Top := startTop;
end;

end.

