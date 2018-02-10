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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const testName = 'data\test.txt';
var
  Form1: TForm1;
  list: TStringList;
  answer: string;
  

implementation

{$R *.dfm}
function appPath(): string;
begin
  Result := ExtractFileDir(Application.ExeName)+ '\';
end;

function getFunction(item: string): string;
var
pos: integer;
begin
    if AnsiLeftStr(item,1) = '-' then
    begin
      Result := 'delimiter'; // delim
      exit;
    end;
    pos := AnsiPos(':',item); 
    if (pos = 0) then 
    begin
      Result := '';
      exit;
    end;
    Result := AnsiLowerCase(AnsiLeftStr(item,pos-1));
end;

function getInfo(item: string):string;
var pos: integer;
begin
  pos := AnsiPos(':',item);
  if (pos = 0) then 
  begin
    Result := '';
    exit;
  end
  else
  begin
    //
    Result := AnsiRightStr(item,StrLen(PChar(item))-pos);
  end;
     
  //Result := '';
end;

procedure readTest();
var i: integer; // iter
var func,element: string;
begin
With Form1 do begin
  list := TStringList.Create;
  list.LoadFromFile(appPath + testName);

  for i := 0 to list.Count - 1 do
  begin
    // iterate for every line
    func := getFunction(list[i]);
    element := getInfo(list[i]);
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
    if func = 'правильныйвариантномер' then
      answer := element;
  end;
  
  list.Free;
  list := nil;
end; //end with
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  readTest();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  readTest();
end;

end.
