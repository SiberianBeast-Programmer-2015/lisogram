unit helpFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, WMPLib_TLB, ComCtrls,helpUnit,re_bmp,RxRichEd;

type
  TForm2 = class(TForm)
    RichEdit1: TRichEdit;
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
Procedure setline(WhichEdit:TRichedit;Linepos,charpos:integer);
Begin
with WhichEdit do
begin
selstart:=perform(EM_LineIndex,Linepos,0)+charpos;
perform(EM_ScrollCaret,0,0);
end;

end;

procedure TForm2.Button1Click(Sender: TObject);
var b:TBitmap;
var r: TRxRichEdit;
begin
  RichEdit1.Lines.LoadFromFile(appPath + 'data\1.rtf');
  b := TBitmap.Create;
  b.LoadFromFile(apppath + 'data\bgImage.bmp');
  setLine(RichEdit1,2,2);
  InsertBitmapToRE(RichEdit1.Handle,B.Handle);

  r := TRxRichEdit.Create(Form2);
  r.Width := 1100;
  r.Height := 500;
  r.Left := 50;
  r.Top := 0;
  r.Visible := true;

  r.Parent := Form2;
  r.Lines.LoadFromFile (appPath + 'data\1.rtf');
 
end;


end.
