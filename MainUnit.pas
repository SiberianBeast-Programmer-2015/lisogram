unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, strutils, helpUnit, jpeg, ExtCtrls, ComCtrls, MPlayer,
  OleCtrls, WMPLib_TLB,helpFormUnit, PicShow;

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
    Timer1: TTimer;
    PicShow1: TPicShow;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCheckClick(Sender: TObject);
    procedure buttonHelpClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const testName = 'test.txt';
var
  Form1: TForm1;
  Form2: TForm2;
  
  list: TStringList;
  tasks: array of TStringList;
  
  answer: string;   themeName: string;
  startLeft,startTop: integer; // WMP unknown behavior  
  i: integer;
implementation

{$R *.dfm}
{� ������ ����� ������� ���� ����, ����� === ����� ����������. ��� ���:
����
===
������:
��������
���������������
---
������:
��������
�����
}

procedure readTest(testFile: string); // �������� �� ��������� �������� ��������
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
{�� ������ ����� ����������������� ������ �������}
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
      if  func = '����' then
        ThemeLabel.Caption := '����: ' + element;
      if func = '������' then
        QueryLabel.Caption := element;
      if func = '�������1' then
        Variant1.Text := element;
      if func = '�������2' then
        Variant2.Text := element;
      if func = '�������3' then
        Variant3.Text := element;
      if func = '�������4' then
        Variant4.Text := element;
      if func = '�������5' then
        Variant5.Text := element;
      if func = '����������������������' then     
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  QueryBgImageLoad(); // query area background image
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
  showMessage('��������� �������� �� ��������� �����');
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
  ShowMessage('����� �������, ���������� � �������');
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
  Form2 := TForm2.Create(Application);
  Form2.Show;
  Form2.setThemeName(themeName);
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

begin
end;

end.

