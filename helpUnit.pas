unit helpUnit;

interface
 uses
   SysUtils, Forms, strUtils, Dialogs;
  
function appPath(): string; 
function getFunction(item: string): string;
function getInfo(item: string):string;
function appData(): string;
function IsAllFilesExists(): boolean;

const splashVideoName = 'splash.avi';
//----------------------------------------------------------------------------
implementation

function isMaterialExists(material: string): boolean;
var r1, r2: boolean;
begin
  if FileExists(appData + 'Materials\' + material + '.txt') then 
    r1 := true
  else
  begin
    r1 := false;
    ShowMessage('��� �����: ' + material + '.txt!');
  end;
  
  if FileExists(appData + 'Materials\' + material + '.rtf') then 
    r2 := true
  else
  begin
    r2 := false;
    ShowMessage('��� �����: ' + material + '.rtf!');
  end;

  Result := r1 AND r2;
end;

function IsAllFilesExists(): boolean;
var 
  r1,r2,r3,r4,r5,r6,r7,r8: boolean;
begin
  r1 := isMaterialExists('����������');
  r2 := isMaterialExists('������� �����������'); 
  r3 := isMaterialExists('�������� �����������');
  r4 := isMaterialExists('����������� �����');    
  r5 := isMaterialExists('������������ �-��');   
  r6 := isMaterialExists('���');               
  r7 := isMaterialExists('��������');         

  if FileExists(appData + splashVideoName) then 
    r8 := true
  else
  begin
      r8 := false;
      ShowMessage('��� ����� ����� �����������!');
  end;
  Result := r1 And r2 and r3 and r4 and r5 and r6 and r7 and r8;
end;

function appData(): string;
begin
  Result := appPath + 'data\';
end;

function getInfo(item: string):string;
var pos: integer;
begin
  pos := AnsiPos(':',item);
  if (pos = 0) then 
  begin
    Result := '';
    exit;
  end
  else
  begin
    Result := AnsiRightStr(item,StrLen(PChar(item))-pos);
  end;
end;

function appPath(): string;
begin
  Result := ExtractFileDir(Application.ExeName)+ '\';
end;

function getFunction(item: string): string;
var
pos: integer;
begin
    if AnsiLeftStr(item,1) = '-' then
    begin
      Result := 'delimiter'; // delim
      exit;
    end;
    pos := AnsiPos(':',item); 
    if (pos = 0) then 
    begin
      Result := '';
      exit;
    end;
    if AnsiLowerCase(AnsiLeftStr(item,6)) = '������'  then
    begin
      Result :=  '������';
      Exit;
    end;
    Result := AnsiLowerCase(AnsiLeftStr(item,pos-1));
end;

end.
