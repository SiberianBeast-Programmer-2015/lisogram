unit MapForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SplashFormUnit, Buttons,helpUnit, jpeg, ExtCtrls, MainUnit;

type
  TMap = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure dispatchTest(Sender: TObject);
  end;

var
  map: TMap;
  created: boolean;

implementation

{$R *.dfm}

procedure TMap.FormActivate(Sender: TObject);
begin
  try
    if (SplashForm.stopped = false)then 
      SplashForm.Show;
  except 
  end;
end;

procedure TMap.FormCreate(Sender: TObject);
begin
  created := false;
  if IsAllFilesExists() = false then
  begin
    ShowMessage('Не все файлы присутствуют, приложение будет закрыто.');
    Application.Terminate;
  end;
end;

procedure TMap.dispatchTest(Sender: TObject);
var 
  fl: string;
begin

  if Created = false then
  begin
    if (Sender is TBitBtn) then  // our button is pressed
    begin
      fl := appData + 'Materials\' + (Sender as TBitBtn).Caption + '.txt';

      if FileExists(fl) then
      begin
        Application.CreateForm(TForm1,Form1);
        Form1.Show;
      end
      else
      begin
        ShowMessage('Не найден такой файл!');
        exit;
      end;
      
      try 
        Form1.Show; 
      except 
        showmessage('Не могу отобразить форму');
        exit;
      end; // try
      try
        Form1.setTheme((Sender as TBitBtn).Caption);
      except
        showMessage('Такого файла справки не найдено!');
      end; //try
    
    end; // if (Sender is TBitBtn) then  // our button is pressed
  end; // if Created = false then 
  
end; // proc

procedure TMap.BitBtn1Click(Sender: TObject);
begin
  dispatchTest(Sender);
end;

procedure TMap.BitBtn2Click(Sender: TObject);
begin
  dispatchTest(Sender);
end;

procedure TMap.BitBtn3Click(Sender: TObject);
begin
  dispatchTest(Sender);
end;

procedure TMap.BitBtn4Click(Sender: TObject);
begin
  dispatchTest(Sender);
end;

procedure TMap.BitBtn5Click(Sender: TObject);
begin
  dispatchTest(Sender);
end;

procedure TMap.BitBtn6Click(Sender: TObject);
begin
  dispatchTest(Sender);
end;

procedure TMap.BitBtn7Click(Sender: TObject);
begin
  dispatchTest(Sender);
end;

end.

