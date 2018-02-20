unit re_bmp;

interface

uses Windows;

procedure InsertBitmapToRE(Wnd:HWND; Bmp:HBITMAP);


implementation
uses Activex, RichEdit;
const
IID_IDataObject: TGUID = (
  D1:$0000010E;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));
IID_IOleObject: TGUID = (
   D1:$00000112;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));
 
REO_CP_SELECTION    = ULONG(-1);
REO_IOB_SELECTION   = ULONG(-1);
REO_GETOBJ_POLEOBJ  =  $00000001;
 
type
TReobject = record
   cbStruct: DWORD;
   cp: ULONG;
   clsid: TCLSID;
   poleobj: IOleObject;
   pstg: IStorage;
   polesite: IOleClientSite;
   sizel: TSize;
   dvAspect: Longint;
   dwFlags: DWORD;
   dwUser: DWORD;
end;
 
type
IRichEditOle = interface(IUnknown)
   ['{00020d00-0000-0000-c000-000000000046}']
   function GetClientSite(out clientSite: IOleClientSite): HResult; stdcall;
   function GetObjectCount: HResult; stdcall;
   function GetLinkCount: HResult; stdcall;
   function GetObject(iob: Longint; out reobject: TReObject;
     dwFlags: DWORD): HResult; stdcall;
   function InsertObject(var reobject: TReObject): HResult; stdcall;
   function ConvertObject(iob: Longint; rclsidNew: TIID;
     lpstrUserTypeNew: LPCSTR): HResult; stdcall;
   function ActivateAs(rclsid: TIID; rclsidAs: TIID): HResult; stdcall;
   function SetHostNames(lpstrContainerApp: LPCSTR;
     lpstrContainerObj: LPCSTR): HResult; stdcall;
   function SetLinkAvailable(iob: Longint; fAvailable: BOOL): HResult; stdcall;
   function SetDvaspect(iob: Longint; dvaspect: DWORD): HResult; stdcall;
   function HandsOffStorage(iob: Longint): HResult; stdcall;
   function SaveCompleted(iob: Longint; const stg: IStorage): HResult; stdcall;
   function InPlaceDeactivate: HResult; stdcall;
   function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
   function GetClipboardData(var chrg: TCharRange; reco: DWORD;
     out dataobj: IDataObject): HResult; stdcall;
   function ImportDataObject(dataobj: IDataObject; cf: TClipFormat;
     hMetaPict: HGLOBAL): HResult; stdcall;
end;
 
TImageDataObject=class(TInterfacedObject,IDataObject)
private
  FBmp:HBITMAP;
  FMedium:TStgMedium;
  FFormatEtc: TFormatEtc;
  procedure SetBitmap(bmp:HBITMAP);
  function GetOleObject(OleClientSite:IOleClientSite; Storage:IStorage):IOleObject;
  destructor Destroy;override;
 
  // IDataObject
   function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
   function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
   function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
   function GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult; stdcall;
   function SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult; stdcall;
   function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
   function DAdvise(const formatetc: TFormatEtc; advf: Longint; 
                    const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
   function DUnadvise(dwConnection: Longint): HResult; stdcall;
   function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
public
  procedure InsertBitmap(wnd:HWND; Bitmap:HBITMAP);
end;
 
 
{ TImageDataObject }
 
function TImageDataObject.DAdvise(const formatetc: TFormatEtc; advf: Integer;
const advSink: IAdviseSink; out dwConnection: Integer): HResult;
begin
Result:=E_NOTIMPL;
end;
 
function TImageDataObject.DUnadvise(dwConnection: Integer): HResult;
begin
Result:=E_NOTIMPL;
end;
 
function TImageDataObject.EnumDAdvise(out enumAdvise: IEnumStatData): HResult;
begin
Result:=E_NOTIMPL;
end;
 
function TImageDataObject.EnumFormatEtc(dwDirection: Integer; out enumFormatEtc: IEnumFormatEtc): HResult;
begin
Result:=E_NOTIMPL;
end;
 
function TImageDataObject.GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult;
begin
Result:=E_NOTIMPL;
end;
 
function TImageDataObject.GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult;
begin
Result:=E_NOTIMPL;
end;
 
function TImageDataObject.QueryGetData(const formatetc: TFormatEtc): HResult;

begin

Result:=E_NOTIMPL;

end;

 

destructor TImageDataObject.Destroy;

begin

ReleaseStgMedium(FMedium);

end;

 

function TImageDataObject.GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult;

begin

medium.tymed := TYMED_GDI;

medium.hBitmap :=  FMedium.hBitmap;

medium.unkForRelease := nil;

Result:=S_OK;

end;

 

function TImageDataObject.SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult;

begin

FFormatEtc := formatetc;

FMedium := medium;

Result:= S_OK;

end;

 

procedure TImageDataObject.SetBitmap(bmp: HBITMAP);

var

stgm: TStgMedium;

fm:TFormatEtc;

begin

stgm.tymed := TYMED_GDI;

stgm.hBitmap := bmp;

stgm.UnkForRelease := nil;

 

fm.cfFormat := CF_BITMAP;

fm.ptd := nil;

fm.dwAspect := DVASPECT_CONTENT;

fm.lindex := -1;

fm.tymed := TYMED_GDI;

SetData(fm, stgm, FALSE);

end;

 

function TImageDataObject.GetOleObject(OleClientSite: IOleClientSite; Storage: IStorage):IOleObject;

begin

if (Fmedium.hBitmap=0) then Result:=nil else

OleCreateStaticFromData(self, IID_IOleObject, OLERENDER_FORMAT, @FFormatEtc, OleClientSite, Storage, Result);

end;

 

procedure TImageDataObject.InsertBitmap(wnd:HWND; Bitmap: HBITMAP);
var
OleClientSite:IOleClientSite;
RichEditOLE:IRichEditOLE;
Storage:IStorage;
LockBytes:ILockBytes;
OleObject:IOleObject;
reobject:TReobject;
clsid:TGUID;
begin
if (SendMessage(wnd, EM_GETOLEINTERFACE, 0, cardinal(@RichEditOle))=0) then exit;
FBmp:=CopyImage(Bitmap,IMAGE_BITMAP,0,0,0);
if FBmp=0 then exit;
try
  SetBitmap(Fbmp);
  RichEditOle.GetClientSite(OleClientSite);
  if (OleClientSite=nil) then exit;
  CreateILockBytesOnHGlobal(0, TRUE,LockBytes);
  if (LockBytes = nil) then exit;
  if (StgCreateDocfileOnILockBytes(LockBytes, STGM_SHARE_EXCLUSIVE or STGM_CREATE or STGM_READWRITE, 0,Storage)<> S_OK) then
  begin
     LockBytes._Release;
     exit
   end;

  if (Storage = nil) then exit;
  OleObject:=GetOleObject(OleClientSite, Storage);
  if (OleObject = nil) then exit;
  OleSetContainedObject(OleObject, TRUE);

  ZeroMemory(@reobject, sizeof(TReobject));
  reobject.cbStruct := sizeof(TReobject);
  OleObject.GetUserClassID(clsid);
  reobject.clsid := clsid;
  reobject.cp := REO_CP_SELECTION;
  reobject.dvaspect := DVASPECT_CONTENT;
  reobject.poleobj := OleObject;
  reobject.polesite := OleClientSite;
  reobject.pstg := Storage;
  RichEditOle.InsertObject(reobject);
finally
  DeleteObject(FBmp)
end

end;

 

 

procedure InsertBitmapToRE(Wnd:HWND; bmp:HBITMAP);

begin

with TImageDataObject.Create do

try

InsertBitmap(Wnd,Bmp);

finally

Free

end

end;

 

end.

