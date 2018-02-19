unit MapForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SplashFormUnit;

type
  TMap = class(TForm)
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  map: TMap;

implementation

{$R *.dfm}

procedure TMap.FormActivate(Sender: TObject);
begin
  if (SplashForm.stopped = false)then 
    SplashForm.Show;
end;

end.
