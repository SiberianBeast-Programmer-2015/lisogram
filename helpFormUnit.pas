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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  r: TRxRichEdit;
implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  if FileExists(appData + 'default.rtf') then
    richEdit.Lines.LoadFromFile(appData + 'default.rtf');
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
  r := TRxRichEdit.Create(Form2);
  r.Width := 800;
  r.Height := Form2.Height - 1;
  r.Left := 256;
  r.Top := 0;
  r.Visible := true;

  r.Parent := Form2;
end;

end.
