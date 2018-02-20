program Lisogram;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  helpUnit in 'helpUnit.pas',
  WMPLib_TLB in 'WMPLib_TLB.pas',
  helpFormUnit in 'helpFormUnit.pas' {Form2},
  RxRichEd in 'RxRichEd.pas',
  SplashFormUnit in 'SplashFormUnit.pas' {SplashForm},
  MapForm in 'MapForm.pas' {Map};

{$R *.res}

begin
  Application.Initialize;
  
  Application.CreateForm(TMap, Map);
  Application.CreateForm(TSplashForm, SplashForm); 
 
 // Application.CreateForm(TMap, Map);
  //Application.CreateForm(TForm2, Form2); // help form
  Application.Run;
end.
