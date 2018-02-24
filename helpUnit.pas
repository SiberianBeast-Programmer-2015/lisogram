unit helpUnit;

interface
 uses
   SysUtils, Forms, strUtils;
  
function appPath(): string; 
function getFunction(item: string): string;
function getInfo(item: string):string;
function appData(): string;
//Procedure setline(WhichEdit:TRichedit;Linepos,charpos:integer);
//----------------------------------------------------------------------------
implementation
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
    if AnsiLowerCase(AnsiLeftStr(item,6)) = 'вопрос'  then
    begin
      Result :=  'вопрос';
      Exit;
    end;
    Result := AnsiLowerCase(AnsiLeftStr(item,pos-1));
end;

end.
