unit SplashForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, WMPLib_TLB,helpUnit;

type
  TForm3 = class(TForm)
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  WindowsMediaPlayer1.Width  := Form3.Width;
  WindowsMediaPlayer1.Height := Form3.Height;
  WindowsMediaPlayer1.Left := 0;
  WindowsMediaPlayer1.top := 0;
  WindowsMediaPlayer1.uiMode := 'none';
  
  WindowsMediaPlayer1.URL := appData + 'splash.avi';  
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WindowsMediaPlayer1.controls.stop;
  WindowsMediaPlayer1.Close;
end;

procedure TForm3.FormResize(Sender: TObject);
begin
  WindowsMediaPlayer1.Width := Form3.Width - 10;
  WindowsMediaPlayer1.Height := Form3.Height - 10;
end;

end.
