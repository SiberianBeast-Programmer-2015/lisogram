unit helpUnit;

interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, strutils;
  
function appPath(): string; 
function getFunction(item: string): string;
function getInfo(item: string):string;
function ScalePercentBmp(bitmp: TBitmap; iPercent: Integer): Boolean;
//----------------------------------------------------------------------------
implementation
function ScalePercentBmp(bitmp: TBitmap; iPercent: Integer): Boolean;
var
TmpBmp: TBitmap;
ARect: TRect;
h, w: Real;
hi, wi: Integer;
begin
Result := False;
try
   TmpBmp := TBitmap.Create;
   try
     h := bitmp.Height * (iPercent / 100);
     w := bitmp.Width * (iPercent / 100);
     hi := StrToInt(FormatFloat('#', h)) + bitmp.Height;
     wi := StrToInt(FormatFloat('#', w)) + bitmp.Width;
     TmpBmp.Width := wi;
     TmpBmp.Height := hi;
     ARect := Rect(0, 0, wi, hi);
     TmpBmp.Canvas.StretchDraw(ARect, Bitmp);
     bitmp.Assign(TmpBmp);
   finally
    TmpBmp.Free;
   end;
   Result := True;
except
   Result := False;
end;
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
    Result := AnsiLowerCase(AnsiLeftStr(item,pos-1));
end;

end.
