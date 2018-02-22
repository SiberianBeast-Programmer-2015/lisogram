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
    procedure QueryBgImageLoad();
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
{¬ каждом тесте сначала тема идет, потом === потом структурно. вот так:
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
var i: integer; var func,element: string;
begin
  with form1 do 
  begin
    ThemeLabel.Caption := '“ема: ' + myThemeName;
    for i := 0 to tasks[number].Count - 1 do
    begin
      func := getFunction(tasks[number][i]);
      element := getInfo(tasks[number][i]);
      if  func = 'тема' then
      begin
        ThemeLabel.Caption := '“ема: ' + element;
        myThemeName := element;
      end;
      if func = 'продолжение' then
      begin
        ContinueLabel.Caption := ContinueLabel.Caption + #10#13 + element;
      end;
      if func = 'вопрос' then
      begin      
        QueryLabel.Caption := element;
        QueryLabel.Top := 72; // default from form in designer
        TaskNumberLabel.Caption := '¬опрос є ' + IntToStr(Form1.currTask);
        
      end;
      if func = 'вариант1' then
        Memo1.Lines.Add(element);
      if func = 'вариант2' then
        Memo2.Lines.Add(element);
      if func = 'вариант3' then
        Memo3.Lines.Add(element);
      if func = 'вариант4' then
        Memo4.Lines.Add(element);
      if func = 'вариант5' then
        Memo5.Lines.Add(element);
      if func = 'правильныйвариантномер' then
        answer := element;
    end;
  end;
  if ContinueLabel.Caption = '' then 
    setQueryToCenter();
end;

procedure TForm1.QueryBgImageLoad();
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  QueryBgImageLoad(); // query area background image
  cleanFields;
  buttonHelp.Visible := false;
end;

function TForm1.getUserAnswerString(): string;
var s: string;
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
  ShowMessage('“ест пройден. ¬озвращаемс€ к карте');
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
  ShowMessage('ќтвет неверен, обратитесь к справке');
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
  Application.CreateForm(TForm2,Form2);
  Form2.Show;
  Form2.setThemeName(myThemeName);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Inc(i);
  if (i mod 1 = 0) then
  begin
    PicShow1.BgPicture.LoadFromFile(appdata + 'lis\lis1.bmp');
    PicShow1.Picture.LoadFromFile(appData + 'lis\lis2.bmp');
  end;
  if (i mod 2 = 0) then 
    PicShow1.BgPicture.LoadFromFile(appdata + 'lis\lis3.bmp');
 
  if (i mod 3 = 0) then
    i := 0;
end;

procedure TForm1.cleanFields;
begin
  QueryLabel.Caption := '';
  ContinueLabel.Caption := '';
  ThemeLabel.Caption := '';
  
  Memo1.Lines.Clear;
  Memo2.Lines.Clear;
  Memo3.Lines.Clear;
  Memo4.Lines.Clear;
  Memo5.Lines.Clear;
    
  CheckBox1.Checked := false;
  CheckBox2.Checked := false;
  CheckBox3.Checked := false;
  CheckBox4.Checked := false;
  CheckBox5.Checked := false;
end;

procedure TForm1.FormHide(Sender: TObject);
begin
  Timer1.Enabled := false;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TForm1.setTheme(themeName: string);
begin
  myThemeName := themeName;
  currTask := 1;
  readTest(appData + 'Materials\' + themeName + '.txt'); // whole test to read
  loadTest(currTask); // show the first test
end;

procedure TForm1.setQueryToCenter;
var imageMediana, labelMediana: integer;
begin
  imageMediana := (image1.Height div 2) + image1.Top;
  labelMediana := (imageMediana + (36 div 2)) - (QueryLabel.Height div 2);

  QueryLabel.Top := labelMediana;
  // image height median
end;

end.

