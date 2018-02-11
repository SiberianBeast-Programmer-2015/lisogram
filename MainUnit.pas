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
    Button3: TButton;
    Memo1: TMemo;
    variant5: TEdit;
    CheckBox5: TCheckBox;
    Button1: TButton;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    Button2: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCheckClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure buttonHelpClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure WindowsMediaPlayer1EndOfStream(ASender: TObject;
      Result: Integer);
    procedure WindowsMediaPlayer1MediaChange(ASender: TObject;
      const Item: IDispatch);
    procedure WindowsMediaPlayer1PlayStateChange(ASender: TObject;
      NewState: Integer);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const testName = 'data\test.txt';
var
  Form1: TForm1;
  list: TStringList;
  zadania: array of TStringList;
  currZadanie: integer;
  answer: string;   themeName: string;
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
var i,n: integer; func,element: string;
begin
  With Form1 do begin 
    list := TStringList.Create;
    list.LoadFromFile(testFile);

    themeName := getInfo(list[0]);
    ThemeLabel.Caption := themeName;

    n := 1;
    SetLength(zadania,n+1);
    zadania[n] := TStringList.Create;
    for i := 2 to list.count - 1 do
    begin
      element := Trim(list[i]);
      if element = '---' then
      begin
        Inc(n);
        SetLength(zadania,n+1);
        zadania[n] := TStringList.Create;
      end
      else
      begin
        zadania[n].Add(element);
        Memo1.Lines.Add(IntToStr(n) + ' = ' + element);
      end;
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
    for i := 0 to zadania[number].Count - 1 do
    begin
      func := getFunction(zadania[number][i]);
      element := getInfo(zadania[number][i]);
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  WindowsMediaPlayer1.uiMode := 'none';

  buttonHelp.Visible := false;
  currZadanie := 1;
  readTest(appPath + testName); // whole test to read
  loadTest(currZadanie); // fill first
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
  // ++ curr zadanie if right
  if currZadanie = Length(zadania) - 1 then
  begin
    testIsFinished();
    exit;
  end
  else
    Inc(currZadanie);
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
  loadTest(currZadanie);
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

procedure setText(Canva: TCanvas; text: string);
var
  cx,cy: integer;
begin
  Canva.Brush.Style := bsSolid;
  Canva.Brush.Color := clRed;
  Canva.Font.Size := 14;
  cy := cy + Canva.TextExtent('s').cy;
  cx := cx - Canva.TextExtent('s').cx;
  
  Canva.TextOut(0,0,text); // textRect
end;

procedure TForm1.Button3Click(Sender: TObject);
const scale = false;
var h,w: integer;
bm: TBitmap;
begin
  bm := TBitmap.Create();
  bm.LoadFromFile(appPath + 'data\bgImage.bmp');
  if scale then 
  begin
    h := image1.Height*100 div bm.Height;
    w := image1.Width *100 div bm.Width;
    h := (h+w) div 2;
    ScalePercentBmp(bm,-h);
    Image1.Picture.Assign(bm);
  end
  else
    Image1.Picture.Assign(bm); 
  setText(Image1.Canvas,'i am');
end;

procedure TForm1.buttonHelpClick(Sender: TObject);
begin
  ShowMessage('Здеся была справка');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  WindowsMediaPlayer1.uiMode := 'none';
  memo1.lines.add('start loading');
  WindowsMediaPlayer1.URL := appPath + 'data\1.avi';  
end;

procedure TForm1.WindowsMediaPlayer1EndOfStream(ASender: TObject;
  Result: Integer);
begin
  showmessage('stop!');
end;

procedure TForm1.WindowsMediaPlayer1MediaChange(ASender: TObject;
  const Item: IDispatch);
begin
  //showmessage('media changed');
end;

procedure TForm1.WindowsMediaPlayer1PlayStateChange(ASender: TObject;
  NewState: Integer);
begin
    try
      if (newstate = 1) then
        WindowsMediaPlayer1.controls.play; 
      memo1.Lines.add('state changed - ' + inttostr(newState));
    except
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
WindowsMediaPlayer1.controls.stop;
WindowsMediaPlayer1.close;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  WindowsMediaPlayer1.controls.stop;
  WindowsMediaPlayer1.close;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
WindowsMediaPlayer1.controls.play
end;

end.

