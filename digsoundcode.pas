{
This is part of Vortex Tracker II project
(c)2000-2022 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://bulba.untergrund.net/
}

unit digsoundcode;

{$mode objfpc}{$H+}

interface

uses
  Classes, LCLIntf, LCLType, digsound, SysUtils, Forms;

type
 EMultiMediaError = class(Exception);
 TPlayModes = (PMPlayModule,PMPlayPattern,PMPlayLine);

const
 digsoundDeviceDef = 0;
 digsoundDeviceNameDef = 'Wave Mapper';

var
 digsoundDevice:integer = digsoundDeviceDef;
 digsoundDeviceName:string = digsoundDeviceNameDef;
 digsoundNotify:HWND = 0; //notify handle for PostMessage if playing stopped due end of data
 UM_DIGSOUNDNOTIFY:Cardinal; //message ID for digsoundNotify

 //moved from WaveOutAPI
 IsPlaying:boolean = False;
 NumberOfBuffers,BufferLength,BuffLen,BufLen_ms:integer;
 Interrupt_Freq,NumberOfChannels,SampleRate,SampleBit:integer;
 PlayMode:TPlayModes;

procedure digsoundthread_start;
procedure digsoundthread_stop;
procedure digsoundthread_free;
function digsoundthread_active:boolean;
procedure digsoundloop_catch;
procedure digsoundloop_release(Force:boolean=False);
function digsound_gotposition(out position:int64):boolean;

procedure Set_WODevice(WOD:integer;NM:string);

implementation

uses
  AY;

type
 TThread1 = class(TThread)
     protected
       procedure Execute; override;
     end;

var
 digsound_thread:TThread1 = nil;
 digsoundloop_break:integer;
 digsoundloop_csection:TCriticalSection;
 digsoundcall_csection:TCriticalSection;

procedure DSCheck(Res:integer);
var
 ErrMsg:string;
begin
if Res > 0 then
 begin
  EnterCriticalSection(digsoundcall_csection);
  try
   ErrMsg := digsound_geterrortext(Res);
  finally
   LeaveCriticalSection(digsoundcall_csection);
  end;
  raise EMultiMediaError.Create(ErrMsg);
 end;
end;

function digsound_gotposition(out position:int64):boolean;
begin
if not digsoundthread_active then exit;
EnterCriticalSection(digsoundcall_csection);
try
 Result := digsound_getposition(position) = 0;
finally
 LeaveCriticalSection(digsoundcall_csection);
end;
end;

procedure digsoundthread_stop;
begin
if digsoundthread_active then
 begin
  digsound_thread.Terminate;
  digsoundloop_release(True);
  IsPlaying := False;
  EnterCriticalSection(digsoundcall_csection);
  try
   digsound_setevent;
  finally
   LeaveCriticalSection(digsoundcall_csection);
  end;
  digsoundthread_free;
 end;
end;

function FillBuffers:boolean;
var
 i,Res:integer;
 PBuffer:pointer;
begin
Result := False;
for i := 0 to NumberOfBuffers - 1 do
 begin
  if not IsPlaying then exit;
  if digsoundloop_break > 0 then exit;
  EnterCriticalSection(digsoundcall_csection);
  try
   Res := digsound_getbuffer(PBuffer,BufferLength);
  finally
   LeaveCriticalSection(digsoundcall_csection);
  end;
  if Res = Ord(digsound_rc_no_buffer) then exit;
  if Res = 0 then
   begin
    MakeBufferTracker(PBuffer);
    if not IsPlaying then exit;
    if BuffLen = 0 then
     break //todo StopPlaying
    else
     begin
      EnterCriticalSection(digsoundcall_csection);
      try
       Res := digsound_push(BuffLen);
      finally
       LeaveCriticalSection(digsoundcall_csection);
      end;
      DSCheck(Res);
     end;
    Result := True;
    if Real_End_All then exit;
   end
  else
   DSCheck(Res);
 end;
end;

procedure TThread1.Execute;
begin
repeat
 EnterCriticalSection(digsoundloop_csection);
 try
  if Real_End_All and (digsoundloop_break = 0) then
   begin
    EnterCriticalSection(digsoundcall_csection);
    try
     //is all buffers finished playing?
     if digsound_check = Ord(digsound_rc_done) then
      begin
       //yes, any playing was finished
       IsPlaying := False;
       if not Terminated and (digsoundNotify <> 0) then
        PostMessage(digsoundNotify,UM_DIGSOUNDNOTIFY,0,0);
       break;
      end;
    finally
     LeaveCriticalSection(digsoundcall_csection);
    end;
   end
  else
   FillBuffers;
 finally
  LeaveCriticalSection(digsoundloop_csection);
 end;
 if Terminated {or not IsPlaying} then break;
 digsound_waitforevent;
until Terminated { or not IsPlaying};
end;

procedure digsoundthread_start;
begin
if digsoundthread_active then
 Exit;
DSCheck(digsound_open(digsoundDevice,NumberOfChannels,SampleRate,SampleBit,NumberOfBuffers,BufLen_ms,True));
//todo может загнать всё это в thread?
try
 try
  IsPlaying := True;
  digsoundloop_break := 0;
  if FillBuffers then
   begin
    digsound_thread := TThread1.Create(False);
    digsound_thread.Priority := tpHigher;
   end
  else
   IsPlaying := False;
 except
  IsPlaying := False;
  raise;
 end;
finally
 if not IsPlaying then
  DSCheck(digsound_close);
end;
end;

procedure digsoundthread_free;
begin
digsoundloop_release(True);
digsound_thread.Terminate;
digsound_thread.WaitFor;
digsound_thread.Free;
digsound_thread := nil;
//todo не закрывать без нужды
DSCheck(digsound_close);
IsPlaying := False;
end;

function digsoundthread_active:boolean;
begin
Result := digsound_thread <> nil;
end;

procedure digsoundloop_catch;
begin
if not IsPlaying then exit;
inc(digsoundloop_break);
if digsoundloop_break > 1 then exit;
EnterCriticalSection(digsoundloop_csection);
end;

procedure digsoundloop_release(Force:boolean=False);
begin
if (not IsPlaying) or (digsoundloop_break = 0) then
 Exit;
if Force then
 digsoundloop_break := 0
else
 dec(digsoundloop_break);
if digsoundloop_break = 0 then
 LeaveCriticalSection(digsoundloop_csection);
end;

procedure Set_WODevice(WOD:integer;NM:string);
var
 l,j:integer;
 s:TStringList;
begin
if digsoundthread_active or (WOD < 0) then
 Exit;
s := TStringList.Create;
try
 digsound_getdevices(s);
 l := s.Count; if WOD >= l then exit;
 if (NM <> '') and (s.Strings[WOD] <> NM) then
  begin
   j := 1;
   while (j < l) and (s.Strings[j] <> NM) do inc(j);
   if j < l then
    WOD := j
   else
    WOD := 0;
  end;
 digsoundDevice := WOD;
 digsoundDeviceName := NM;
finally
 s.Free;
end;
end;

initialization

InitializeCriticalSection(digsoundcall_csection);
InitializeCriticalSection(digsoundloop_csection);

finalization

DeleteCriticalSection(digsoundloop_csection);
DeleteCriticalSection(digsoundcall_csection);

end.
