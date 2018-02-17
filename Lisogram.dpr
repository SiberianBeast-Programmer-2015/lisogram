program Lisogram;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  helpUnit in 'helpUnit.pas',
  WMPLib_TLB in 'WMPLib_TLB.pas',
  helpFormUnit in 'helpFormUnit.pas' {Form2},
  RxRichEd in 'RxRichEd.pas',
  SplashForm in 'SplashForm.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  //Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
