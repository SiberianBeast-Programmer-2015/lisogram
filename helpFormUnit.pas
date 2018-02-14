unit helpFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, WMPLib_TLB, ComCtrls,helpUnit,re_bmp,RxRichEd;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    r: TRichEdit;
    WindowsMediaPlayer2: TWindowsMediaPlayer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    themeName: string;
    procedure swapRichEdit();
    procedure loadHelp(themeNm: string);
  public
    procedure setThemeName(strThemeName: string);
  end;
const string_file_not_found = 'file not found';
var
  Form2: TForm2;
  richEdit: TRxRichEdit;
implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  if FileExists(appData + 'default.rtf') then
    richEdit.Lines.LoadFromFile(appData + 'default.rtf');
end;

procedure TForm2.swapRichEdit();
begin
  with r do
  begin
    richEdit := TRxRichEdit.Create(Form2); // form is owner
    richEdit.Width := Width;
    richEdit.Height := Height;
    richEdit.Left := Left;
    richEdit.Top := Top;
    richEdit.Visible := Visible;

    richEdit.Parent := Parent;
  end;
  r.Free;
  r := nil;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  swapRichEdit(); // destroyes default, creates RxRichEdit
end;

procedure TForm2.setThemeName(strThemeName: string);
begin
  themeName := Trim(strThemeName);
  loadHelp(appData + themeName + '.rtf');
end;

procedure TForm2.loadHelp(themeNm: string);
begin
  if Not FileExists(themeNm) then
  begin
    ShowMessage('no such file!');
    richedit.Lines.Add(string_file_not_found + ' at ' + themeNm);
    Exit;
  end;

  richEdit.Lines.LoadFromFile(themeNm);
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    // some paranoia :)
  try
    try
      try
        WindowsMediaPlayer2.controls.stop; // avoid exceptions
        WindowsMediaPlayer2.Close;
        WindowsMediaPlayer2.Free;
      except
      end;
    except
    end;
  except
  end;
end;

end.
