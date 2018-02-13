unit helpFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, WMPLib_TLB, ComCtrls,helpUnit,re_bmp;

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
begin
  RichEdit1.Lines.LoadFromFile(appPath + 'data\1.rtf');
  b := TBitmap.Create;
  b.LoadFromFile(apppath + 'data\bgImage.bmp');
  setLine(RichEdit1,2,2);
  InsertBitmapToRE(RichEdit1.Handle,B.Handle);
end;

end.
