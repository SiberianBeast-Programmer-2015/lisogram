unit SplashFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, WMPLib_TLB,helpUnit;

type
  TSplashForm = class(TForm)
    WindowsMediaPlayer1: TWindowsMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WindowsMediaPlayer1PlayStateChange(ASender: TObject;
      NewState: Integer);
  private
  public
    stopped: boolean;

    procedure videoStopped();
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.dfm}

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  try
    stopped := false;
    SplashForm.Width := Screen.Width;
    SplashForm.Height := Screen.Height;
  
    WindowsMediaPlayer1.Width  := SplashForm.Width;
    WindowsMediaPlayer1.Height := SplashForm.Height;
    WindowsMediaPlayer1.Left := 0;
    WindowsMediaPlayer1.top := 0;
    WindowsMediaPlayer1.uiMode := 'none';
  
    try
      WindowsMediaPlayer1.URL := appData + splashVideoName;
    except
      ShowMessage('Такой файл не найден: ' + appData + splashVideoName);
      videoStopped;
      exit;
    end;
  except
    showMessage('Не удалось запустить форму!');
  end;
end; // proc

procedure TSplashForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    WindowsMediaPlayer1.controls.stop;
    WindowsMediaPlayer1.Close;
    
    videoStopped;
  except
  end;
end; // proc

procedure TSplashForm.WindowsMediaPlayer1PlayStateChange(ASender: TObject;
  NewState: Integer);
begin
  try
    WindowsMediaPlayer1.Left := 0;
    WindowsMediaPlayer1.Top := 0;
    
    WindowsMediaPlayer1.Width  := SplashForm.Width;
    WindowsMediaPlayer1.Height := SplashForm.Height;
    
    if (newstate = 1) then
      videoStopped(); 
  except
  end;
end;

procedure TSplashForm.videoStopped;
begin
  stopped := true;
  
  try
    SplashForm.Width := 1;
    SplashForm.Height := 1;
  except 
  end;
  
end;

end.
