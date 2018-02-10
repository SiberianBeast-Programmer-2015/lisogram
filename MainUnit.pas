unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, strutils, helpUnit, jpeg, ExtCtrls, ComCtrls;

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
    Button1: TButton;
    ThemeLabel: TLabel;
    Button2: TButton;
    QueryLabel: TLabel;
    Animate1: TAnimate;
    Image1: TImage;
    Button3: TButton;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const testName = 'data\test.txt';
var
  Form1: TForm1;
  list: TStringList;
  zadania: array [1..20] of TStringList;
  answer: string;   themeName: string;
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
procedure testOne(list: TStringList);
var i: integer; var func,element: string;
begin
with form1 do 
begin
  for i := 0 to list.Count - 1 do
  begin
    // iterate for every line
    func := getFunction(list[i]);
    element := getInfo(list[i]);
    if  func = 'тема' then
      ThemeLabel.Caption := '“ема: ' + element;
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
    if func = 'правильныйвариантномер' then     
      answer := element;
  end;
end;
end;
procedure readTest(testFile: string); // разделим на прочтение вопросов циклично
var i,n: integer; {// iter}var func,element: string;
begin
With Form1 do begin 
  list := TStringList.Create;
  list.LoadFromFile(testFile);

  themeName := getInfo(list[0]);
  ThemeLabel.Caption := themeName;

  n := 1;
  zadania[n] := TStringList.Create;
  for i := 2 to list.count - 1 do
  begin
    element := Trim(list[i]);
    if element = '---' then
    begin
      Inc(n);
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  readTest(appPath + testName);
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

procedure TForm1.Button1Click(Sender: TObject);
begin
   if Trim(getUserAnswerString) = Trim(answer) then
    ShowMessage('¬ерно!')
   else
    SHowMessage('Ќеверно! посмотрите справку!');
end;

procedure TForm1.Button3Click(Sender: TObject);
var cx,cy,h,w: integer;
begin
  cx := Image1.Width div 2;
  cy := Image1.Height div 2;  
  
  Image1.Canvas.Brush.Style := bsSolid;
  Image1.Canvas.Brush.Color := clRed;
  Image1.Canvas.Font.Size := 14;
  cy := cy + Image1.Canvas.TextExtent('s').cy;
  cx := cx - Image1.Canvas.TextExtent('s').cx;
  h := Image1.Canvas.TextExtent('s').cy;
  w := Image1.Canvas.TextExtent('s').cx;
  //cx := cx div 4;
  //cy := cy div 4;
  ShowMessage(IntToStr(Image1.width div w));
  Image1.Canvas.TextOut(cx,cy,'я нерпа-нерпа и уже не кос€к'); // textRect
  Image1.Canvas.TextOut(cx,cy+h,'я нерпа-нерпа и уже не кос€к'); // textRect
  
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ShowMessage('«дес€ была справка');
end;

end.

