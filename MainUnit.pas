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
    Memo1: TMemo;
    variant5: TEdit;
    CheckBox5: TCheckBox;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCheckClick(Sender: TObject);
    procedure buttonHelpClick(Sender: TObject);
    procedure WindowsMediaPlayer1EndOfStream(ASender: TObject;
      Result: Integer);
    procedure WindowsMediaPlayer1MediaChange(ASender: TObject;
      const Item: IDispatch);
    procedure WindowsMediaPlayer1PlayStateChange(ASender: TObject;
      NewState: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
{�� ������ ����� ����������������� ������ �������}
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
  bm.LoadFromFile(appPath + 'data\bgImage.bmp');
with form1 do
begin
    Image1.Proportional := false;
    Image1.Stretch := true;
    Image1.Picture.Assign(bm);
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  WindowsMediaPlayer1.uiMode := 'none';
  QueryBgImageLoad();
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
  showMessage('��������� �������� �� ��������� �����');
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
  ShowMessage('����� ���� �������');
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
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  WindowsMediaPlayer1.controls.stop;
  WindowsMediaPlayer1.close;
end;

end.

