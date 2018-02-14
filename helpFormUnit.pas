unit helpFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, WMPLib_TLB, ComCtrls,helpUnit,re_bmp,RxRichEd;

type
  TForm2 = class(TForm)
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    Button1: TButton;
    Label1: TLabel;
    r: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure swapRichEdit();
  public
  end;

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

end.
