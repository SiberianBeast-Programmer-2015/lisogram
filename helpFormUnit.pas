unit helpFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, WMPLib_TLB, ComCtrls,helpUnit,RxRichEd,
  ExtCtrls, PicShow;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    r: TRichEdit;
    Timer1: TTimer;
    PicShow1: TPicShow;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    themeName: string;
    procedure swapRichEdit();
    procedure loadHelp(themeNm: string);
  public
    procedure setThemeName(strThemeName: string);
  end;
var
  Form2: TForm2;
  richEdit: TRxRichEdit;
  i: integer;
implementation

{$R *.dfm}

procedure TForm2.swapRichEdit();
begin
  try
    with r do
    begin
      richEdit := TRxRichEdit.Create(Form2); // form is owner
      richEdit.Width := Width;
      richEdit.Height := Height;
      richEdit.Left := Left;
      richEdit.Top := Top;
      richEdit.Visible := Visible;
      richEdit.Font.Charset := RUSSIAN_CHARSET;

      richEdit.Parent := Parent;
    end;
    r.Free;
    r := nil;
  except
    showmessage('Не удается создать расширенный RichEdit!');
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  swapRichEdit(); // destroyes default, creates RxRichEdit
end;

procedure TForm2.setThemeName(strThemeName: string);
begin
  themeName := Trim(strThemeName);
  loadHelp(appData + 'Materials\' + themeName + '.rtf');
end;

procedure TForm2.loadHelp(themeNm: string);
begin
  if Not FileExists(themeNm) then
  begin
    ShowMessage('Нет такого файла! ' + themeNm);
    Exit;
  end;
  try
    richEdit.Lines.LoadFromFile(themeNm);
  except 
    on E:Exception do ShowMessage('ошибка при загрузке справки: ' + e.Message);
  end;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
  try
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
  except 
    Timer1.Enabled := false;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  try Timer1.Enabled := true; except end;
end;

procedure TForm2.FormHide(Sender: TObject);
begin
  try  Timer1.Enabled := false; except end;
end;

end.
