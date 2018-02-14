program Lisogram;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  helpUnit in 'helpUnit.pas',
  WMPLib_TLB in 'WMPLib_TLB.pas',
  helpFormUnit in 'helpFormUnit.pas' {Form2},
  re_bmp in 're_bmp.pas',
  RxRichEd in 'RxRichEd.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
