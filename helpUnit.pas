unit helpUnit;

interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, strutils;
  
function appPath(): string; 
function getFunction(item: string): string;
function getInfo(item: string):string;
function ScalePercentBmp(bitmp: TBitmap; iPercent: Integer): Boolean;
procedure setText(Canva: TCanvas; text: string);
//----------------------------------------------------------------------------
implementation

{Важно! нужно входящий текст разбивать на строки. TextExtent поможет узнать
сколько есть места, по ней будет рассчитываться перенос на новую строку}
// Deprecated
procedure setText(Canva: TCanvas; text: string);
const model = 's';
var
  i,id,line: integer;
  hl,wl, hs,ws: integer;//высота и ширина символа
  width, height: integer;
  max: integer;// сколько всего сможет влезать символов
begin
  text := Trim(text);
  line := 1;
  Canva.Brush.Style := bsSolid;
  Canva.Brush.Color := clRed;
  Canva.Font.Size := 14;

  height := Canva.ClipRect.Bottom;
  width := Canva.ClipRect.Right;
  //ShowMessage(inttostr(width));
  hs := Canva.TextExtent(model).cy;
  ws := Canva.TextExtent(model).cx;
  wl := (Canva.ClipRect.Right) div ws; 
  //max := (Canva.ClipRect.Right div ws) * (Canva.ClipRect.Bottom div hs);
  
  // проверка в цикле - влезет ли строка в строку графическую?
  for i := 1 to Length(text) do
  begin
    if (text[i] = Chr(32)) then
    begin
      //ShowMessage('text wth ' +IntToStr(Canva.TextExtent(AnsiLeftStr(text,i)).cx));
      id := i;
      if (width < Canva.TextExtent(AnsiLeftStr(text,id)).cx) then
      begin
        line := line + 1;
        id := 1;
      end
      else
      begin
        //ShowMessage(inttostr(line*hs));
        Canva.TextOut(0,line*hs,AnsiLeftStr(text,i));
      end;
    end;
  end;
  //ShowMessage('out' + IntToStr(i));
  //Canva.TextOut(0,0,text); // textRect
end;


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
