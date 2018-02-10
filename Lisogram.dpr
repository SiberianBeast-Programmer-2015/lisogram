program Lisogram;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  helpUnit in 'helpUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
