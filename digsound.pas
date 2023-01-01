{
This is part of Vortex Tracker II project
(c)2000-2022 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://bulba.untergrund.net/
}

unit digsound;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, {$ifdef Windows}MMSystem, Windows{$else}asoundlib{, cmem}, BaseUnix{$endif};

type
  digsound_retcodes = (
   digsound_rc_playing = -1,
   digsound_rc_done = 0,
   digsound_rc_error_driver,
   digsound_rc_first_nodriver,
   digsound_rc_already_opened = digsound_rc_first_nodriver{%H-},
   digsound_rc_no_memory,
   digsound_rc_samplerate_not_supported,
   digsound_rc_bad_parameter,
   digsound_rc_no_buffer,
   digsound_rc_buffer_some_data_lost,
   digsound_rc_device_in_bad_state,
   digsound_rc_unknown_error,
   digsound_rc_last_nodriver = digsound_rc_unknown_error
  );

  function digsound_geterrortext(ErrorNumber:integer):string;
  procedure digsound_getdevices(devices:TStrings);
  function digsound_open(Device,Channels,SampleRate,Bits,NumberOfBuffers,OneBufferLength_ms:integer;BufferDoneEvent:boolean):integer;
  function digsound_close:integer;
  function digsound_getbuffer(var BufferAddress:pointer;var BufferSampleLength:integer):integer;
  function digsound_push(NumberOfSamples:integer):integer;
  function digsound_reset:integer;
  function digsound_pause:integer;
  function digsound_continue:integer;
  function digsound_getposition(out Position:int64):integer;
  function digsound_check:integer;
  function digsound_waitforevent:integer;
  function digsound_setevent:integer;

implementation

{const
 EBADFD = 77;
 EPIPE = 32;
 ESTRPIPE = 86;}

var
  LastCallResult:{$ifdef Windows}integer{$else}cint{$endif};

  {$ifdef Windows}
  {nDevice,}nChannels,{nSampleRate,}nBits:integer;
  hwo:HWAVEOUT;
  whs:array of WAVEHDR;
  buffer_size:longword;
  buffer_number:integer;
  buffer_size_ms:longword;
  digsound_event:PRTLEvent;
  {$else}
  handle:Psnd_pcm_t = nil;
  buffer_size:snd_pcm_sframes_t;
  period_size:snd_pcm_sframes_t;
  writen_size:int64{snd_pcm_sframes_t};
  period_size_ms:clong;
  ufds:Ppollfd;
  count:cint;
  samples:pointer = nil;
  device_list:array of string = nil;
  {$endif}

{$ifdef Windows}
function WOChecked(Res:MMRESULT):boolean;
begin
LastCallResult := Res;
Result := Res = MMSYSERR_NOERROR;
end;
{$else}
function ASChecked(Res:cint):boolean;
begin
LastCallResult := Res;
Result := Res >= 0;
end;
{$endif}

function digsound_geterrortext(ErrorNumber:integer):string;
{$ifdef Windows}
var
  WS:WideString;
{$endif}
const
 digsound_errors:array[Ord(digsound_rc_first_nodriver)..Ord(digsound_rc_last_nodriver)] of string =
   (
   {digsound_rc_already_opened}
   'Device already opened',
   {digsound_rc_no_memory}
   'Can''t allocate memory (GetMem)',
   {digsound_rc_samplerate_not_supported}
   'Specified SampleRate is not supported by device',
   {digsound_rc_bad_parameter}
   'Invalid parameter',
   {digsound_rc_no_buffer}
   'No buffer',
   {digsound_rc_buffer_some_data_lost}
   'Some buffer data was not sent to device',
   {digsound_rc_device_in_bad_state}
   'Device is in bad state',
   {digsound_rc_unknown_error}
   'Unhandled error'
   );
begin
 if ErrorNumber <= 0 then
  Result := 'No error'
 else if ErrorNumber = Ord(digsound_rc_error_driver) then
  begin
   {$ifdef Windows}
   SetLength(WS,256); //???
   if waveOutGetErrorTextW(LastCallResult,PWideChar(WS),Length(WS)) = MMSYSERR_NOERROR then
    Result := UTF8Encode(WideString(PWideChar(WS)))
   else
    Result := 'WaveOut error # ' + IntToStr(LastCallResult);
   {$else}
    Result := snd_strerror(LastCallResult);
   {$endif}
  end
 else if ErrorNumber in [Ord(digsound_rc_first_nodriver)..Ord(digsound_rc_last_nodriver)] then
  Result := digsound_errors[ErrorNumber]
 else
  Result := 'Unknown error';
end;

procedure digsound_getdevices(devices:TStrings);
var
{$ifdef Windows}
 outcaps:WAVEOUTCAPSW;
{$endif}
 i:integer;
begin
{$ifdef Windows}
devices.Add('Wave Mapper');
for i := 0 to integer(waveOutGetNumDevs) - 1 do
 if waveOutGetDevCapsW(i, @outcaps, sizeof(outcaps)) = MMSYSERR_NOERROR then
  devices.Add({AnsiTo}UTF8Encode(WideString(outcaps.szPname)))
 else
  devices.Add('Unknown WaveOut device #' + IntToStr(i));
{$else}
for i := 0 to Length(device_list)-1 do
 devices.Add(device_list[i]);
{$endif}
end;

procedure ClearBuffers;
{$ifdef Windows}
var
  i:integer;
{$endif}
begin
{$ifdef Windows}
for i := 0 to Length(whs)-1 do
 begin
  if hwo <> 0 then
   if whs[i].dwFlags and WHDR_PREPARED <> 0 then
    waveOutUnprepareHeader(hwo,@whs[i],sizeof(WAVEHDR));
  FreeMem(whs[i].lpData);
 end;
whs := nil;
buffer_number := -1;
buffer_size := 0;
{$else}
if samples = nil then exit;
FreeMem(samples);
samples := nil;
period_size := 0;
{$endif}
end;

{$ifndef Windows}
function wait_for_poll:integer;
var
 revents:cushort;
 err:cint;
begin
Result := 0;
while True do
 begin
  err := fppoll(ufds, count, period_size_ms);
  if err = 0 then //timeout
   exit;
  if err < 0 then
   begin
    Result := -errno;
    exit;
   end;
  snd_pcm_poll_descriptors_revents(handle, ufds, count, @revents);
  if (revents and POLLERR) <> 0 then
   begin
    Result := -ESysEIO;
    exit;
   end;
  if (revents and POLLOUT) <> 0 then
   exit;
 end;
end;

function prepare_poll:boolean;
begin
Result := False;
count := snd_pcm_poll_descriptors_count(handle);
if (count <= 0) then exit;{
	printf("Invalid poll descriptors count\n");
	return count;
}

ufds := GetMem(sizeof(pollfd) * count);
if (ufds = nil) then exit; {
	printf("No enough memory\n");
	return -ENOMEM;
}
if not ASChecked(snd_pcm_poll_descriptors(handle, ufds, count)) then exit;
Result := True;
end;
{$endif}

function digsound_open(Device,Channels,SampleRate,Bits,NumberOfBuffers,OneBufferLength_ms:integer;BufferDoneEvent:boolean):integer;
var
{$ifdef Windows}
  pwfx:PCMWAVEFORMAT;
  i:integer;
{$else}
 hwparams:Psnd_pcm_hw_params_t;
 swparams:Psnd_pcm_sw_params_t;
 dwtemp:cuint;
 size:snd_pcm_uframes_t;
// sz:Psnd_pcm_sframes_t;
 dir:cint;
{$endif}

begin
Result := 0;
ClearBuffers;
{$ifdef Windows}
//nDevice := Device;
nChannels := Channels;
//nSampleRate := SampleRate;
nBits := Bits;
pwfx.wf.wFormatTag := 1;
pwfx.wf.nChannels := Channels;
pwfx.wf.nSamplesPerSec := SampleRate;
pwfx.wf.nBlockAlign := Channels*(Bits div 8);
pwfx.wf.nAvgBytesPerSec := SampleRate*Channels*(Bits div 8);
pwfx.wBitsPerSample := Bits;
if BufferDoneEvent then
 i := CALLBACK_EVENT
else
 i := CALLBACK_NULL;
if not WOChecked(waveOutOpen(@hwo,device-1,@pwfx,{%H-}DWORD_PTR(digsound_event),0,i)) then
 Result := Ord(digsound_rc_error_driver);
{$else}
if handle <> nil then
 begin
  Result := Ord(digsound_rc_already_opened);
  exit;
 end;
if (Device < 0) or (Device >= Length(device_list)) then
 begin
  Result := Ord(digsound_rc_bad_parameter);
  exit;
 end;
if not ASChecked(snd_pcm_open(@handle, PChar(device_list[Device]), SND_PCM_STREAM_PLAYBACK, 0)) then
 begin
  Result := Ord(digsound_rc_error_driver);
  exit;
 end;

try
 hwparams := GetMem(snd_pcm_hw_params_sizeof); //ReturnNilIfGrowHeapFails = False
except
 hwparams := nil;
end;
if hwparams = nil then
 begin
  snd_pcm_close(handle);
  handle := nil;
  Result := Ord(digsound_rc_no_memory);
  exit;
 end;

try
 //* choose all parameters */
 if ASChecked(snd_pcm_hw_params_any(handle, hwparams)) then
  //* set hardware resampling */
  if ASChecked(snd_pcm_hw_params_set_rate_resample(handle, hwparams, 0)) then
   //* set the interleaved read/write format */
   if ASChecked(snd_pcm_hw_params_set_access(handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED)) then
    //* set the sample format */
    if ASChecked(snd_pcm_hw_params_set_format(handle,hwparams, snd_pcm_build_linear_format(Bits,Bits,Ord(Bits=8),0){SND_PCM_FORMAT_S16})) then
     //* set the count of channels */
     if ASChecked(snd_pcm_hw_params_set_channels(handle, hwparams, Channels)) then
      begin
        //* set the stream rate */
        dwtemp := SampleRate;
        if ASChecked(snd_pcm_hw_params_set_rate_near(handle, hwparams, @dwtemp, nil)) then
         if (dwtemp <> cuint(SampleRate)) then
          Result := Ord(digsound_rc_samplerate_not_supported)
         else
          begin
           dwtemp := OneBufferLength_ms * 1000 * NumberOfBuffers;
           //* set the buffer time */
           if ASChecked(snd_pcm_hw_params_set_buffer_time_near(handle, hwparams, @dwtemp, @dir)) then
            if ASChecked(snd_pcm_hw_params_get_buffer_size(hwparams, @size)) then
             begin
              buffer_size := size;
              dwtemp := dwtemp div longword(NumberOfBuffers);
              //* set the period time */
              if ASChecked(snd_pcm_hw_params_set_period_time_near(handle, hwparams, @dwtemp, @dir)) then
               if ASChecked(snd_pcm_hw_params_get_period_size(hwparams, @size, @dir)) then
                begin
                 period_size := size;
                 period_size_ms := dwtemp div 1000;
                 //* write the parameters to device */
                 if ASChecked(snd_pcm_hw_params(handle, hwparams)) then
                  begin
                   try
                    swparams := GetMem(snd_pcm_sw_params_sizeof);
                   except
                    swparams := nil;
                   end;
                   if swparams = nil then
                    begin
                     snd_pcm_close(handle);
                     handle := nil;
                     Result := Ord(digsound_rc_no_memory);
                     exit;
                    end;
                   try
                    //* get the current swparams */
                    if ASChecked(snd_pcm_sw_params_current(handle, swparams)) then
                     //* start the transfer when the buffer is almost full: */
                     //* (buffer_size / avail_min) * avail_min */
                     if ASChecked(snd_pcm_sw_params_set_start_threshold(handle, swparams, (buffer_size div period_size) * period_size)) then
                      begin
                       //* allow the transfer when at least period_size samples can be processed */
                       //* or disable this mechanism when period event is enabled (aka interrupt like style processing) */
//                       if period_event = 0 then sz := @buffer_size else sz := @period_size;
                       if ASChecked(snd_pcm_sw_params_set_avail_min(handle, swparams, period_size)) then
                        //* enable period events when requested */
                        if not BufferDoneEvent or
                           ASChecked(snd_pcm_sw_params_set_period_event(handle, swparams, 1)) then
                         //* write the parameters to the playback device */
                         ASChecked(snd_pcm_sw_params(handle, swparams));
                      end;
                   finally
                    FreeMem(swparams);
                   end;
                  end;
                end;
             end;
          end;
      end;

if not prepare_poll then //todo
 Result := Ord(digsound_rc_error_driver);

if LastCallResult < 0 then
 Result := Ord(digsound_rc_error_driver);
if Result <> 0 then
 begin
  snd_pcm_close(handle);
  handle := nil;
  exit;
 end;
finally
 FreeMem(hwparams);
end;

try
 samples := GetMem(period_size * Channels * (Bits div 8));
except
 samples := nil;
end;
if samples = nil then
 begin
  snd_pcm_close(handle);
  handle := nil;
  Result := Ord(digsound_rc_no_memory);
  exit;
 end;
writen_size := 0;
{$endif}

//creating/preparing buffer(s)
{$ifdef Windows}
buffer_size := OneBufferLength_ms*SampleRate div 1000;
buffer_size_ms := OneBufferLength_ms;
SetLength(whs,NumberOfBuffers);
for i := 0 to NumberOfBuffers - 1 do
 begin
  whs[i].dwFlags := 0;
  whs[i].dwLoops := 0;
  whs[i].dwBufferLength := buffer_size*longword(Channels)*(longword(Bits) div 8);
  try
   whs[i].lpdata := GetMem(whs[i].dwBufferLength);
  except
   whs[i].lpdata := nil;
  end;
  if whs[i].lpdata = nil then
   begin
    Result := Ord(digsound_rc_no_memory);
    digsound_close;
    exit;
   end;

  if not WOChecked(waveOutPrepareHeader(hwo,@whs[i],SizeOf(WAVEHDR))) then
   begin
    Result := Ord(digsound_rc_error_driver);
    digsound_close;
    exit;
   end;

  whs[i].dwFlags := whs[i].dwFlags or WHDR_DONE; //todo для режима без digsound_close нужно устанавливать этот флажок в какой-то другой процедре, т.е. dsopen будет вызываться один раз
 end;
{$endif}
end;

function digsound_close:integer;
begin
Result := 0;
{$ifdef Windows}
if not WOChecked(waveOutReset(hwo)) then
 begin
  Result := Ord(digsound_rc_error_driver);
//  exit;
  //anyway try to close
 end;
ClearBuffers;
if not WOChecked(waveOutClose(hwo)) then
 Result := Ord(digsound_rc_error_driver);
hwo := 0;
{$else}
snd_pcm_close(handle);
handle := nil;
FreeMem(ufds);
ClearBuffers;
{$endif}
end;

function digsound_getbuffer(var BufferAddress:pointer;var BufferSampleLength:integer):integer;
var
{$ifdef Windows}
 i:integer;
{$else}
 avail:snd_pcm_sframes_t;
{$endif}
begin
Result := Ord(digsound_rc_no_buffer);
{$ifdef Windows}
for i := 0 to Length(whs)-1 do
 if whs[i].dwFlags and WHDR_DONE <> 0 then
  begin
   Result := 0;
   buffer_number := i;
   BufferAddress := whs[i].lpData;
   BufferSampleLength := buffer_size;
   exit;
  end;
{$else}
avail := snd_pcm_avail_update(handle);
if avail < 0 then
 begin
  avail := snd_pcm_recover(handle, avail, 0);
  if avail = 0 then
   avail := snd_pcm_avail_update(handle);
 end;
if avail >= period_size then
 begin
  Result := 0;
  BufferAddress := samples;
  BufferSampleLength := period_size;
 end
else if avail < 0 then
 begin
  Result := Ord(digsound_rc_error_driver);
  LastCallResult := avail;
 end;
{$endif}
end;

function digsound_push(NumberOfSamples:integer):integer;
{$ifndef Windows}
var
  state:snd_pcm_state_t;
  frames:snd_pcm_sframes_t;
{$endif}
begin
Result := 0;
{$ifdef Windows}
if buffer_number = -1 then
 begin
  Result := Ord(digsound_rc_no_buffer);
  exit;
 end;
if longword(NumberOfSamples) > buffer_size then
 begin
  Result := Ord(digsound_rc_bad_parameter);
  exit;
 end;
whs[buffer_number].dwBufferLength := NumberOfSamples*nChannels*(nBits div 8);
whs[buffer_number].dwFlags := whs[buffer_number].dwFlags and not WHDR_DONE;
if not WOChecked(waveOutWrite(hwo,@whs[buffer_number],SizeOf(WAVEHDR))) then
 Result := Ord(digsound_rc_error_driver);
{$else}
if snd_pcm_state(handle) = SND_PCM_STATE_SETUP then
 if not ASChecked(snd_pcm_prepare(handle)) then
  begin
   Result := Ord(digsound_rc_error_driver);
   exit;
  end;
state := snd_pcm_state(handle);
if not (state in [SND_PCM_STATE_PREPARED,SND_PCM_STATE_RUNNING,
   SND_PCM_STATE_XRUN,SND_PCM_STATE_DRAINING,SND_PCM_STATE_PAUSED]) then
 begin
  Result := Ord(digsound_rc_device_in_bad_state);
  exit;
 end;
frames := snd_pcm_writei(handle, samples, NumberOfSamples);
if (frames < 0) then
 begin
  frames := snd_pcm_recover(handle, frames, 0);
  if frames = 0 then
   frames := snd_pcm_writei(handle, samples, NumberOfSamples);
  if (frames < 0) then
   begin
    LastCallResult := frames;
    Result := Ord(digsound_rc_error_driver);
    exit;
   end;
 end;
inc(writen_size,frames);
if (frames > 0) and (frames < NumberOfSamples) then
 Result := Ord(digsound_rc_buffer_some_data_lost);
{$endif}
end;

function digsound_reset:integer;
begin
Result := 0;
{$ifdef Windows}
if not WOChecked(waveOutReset(hwo)) then
 Result := Ord(digsound_rc_error_driver);
{$else}
if not ASChecked(snd_pcm_drop(handle)) then
 Result := Ord(digsound_rc_error_driver)
else
 begin
  writen_size := 0;
  if not ASChecked(snd_pcm_prepare(handle)) then
   Result := Ord(digsound_rc_error_driver);
 end;
{$endif}
end;

function digsound_pause:integer;
begin
Result := 0;
{$ifdef Windows}
if not WOChecked(waveOutPause(hwo)) then
{$else}
if not ASChecked(snd_pcm_pause(handle,1)) then
{$endif}
 Result := Ord(digsound_rc_error_driver);
end;

function digsound_continue:integer;
begin
Result := 0;
{$ifdef Windows}
if not WOChecked(waveOutRestart(hwo)) then
{$else}
if not ASChecked(snd_pcm_pause(handle,0)) then
{$endif}
 Result := Ord(digsound_rc_error_driver);
end;

function digsound_getposition(out Position:int64):integer;
var
{$ifdef Windows}
  MMTIME1:MMTIME;
{$else}
 delay:snd_pcm_sframes_t;
{$endif}
begin
Result := 0;
{$ifdef Windows}
MMTIME1.wType := TIME_SAMPLES;
if WOChecked(waveOutGetPosition(hwo,@MMTIME1,sizeof(MMTIME))) then
 Position := MMTIME1.sample
else
 Result := Ord(digsound_rc_error_driver);
{$else}
 if not ASChecked(snd_pcm_delay(handle,@delay)) then
  begin
   Result := Ord(digsound_rc_error_driver);
   exit;
  end;
 if delay >= 0 then
  Position := writen_size-delay
 else
  Result := Ord(digsound_rc_unknown_error);
{$endif}
end;

function digsound_check:integer;
var
{$ifdef Windows}
 i:integer;
{$else}
 delay:snd_pcm_sframes_t;
{$endif}
begin
{$ifdef Windows}
Result := Ord(digsound_rc_playing);
for i := 0 to Length(whs)-1 do
 if whs[i].dwFlags and WHDR_DONE = 0 then exit;
{$else}
if snd_pcm_state(handle) <> SND_PCM_STATE_RUNNING then
 begin
  Result := Ord(digsound_rc_done);
  exit;
 end;
if not ASChecked(snd_pcm_delay(handle,@delay)) then
 begin
  Result := Ord(digsound_rc_error_driver);
  exit;
 end;
if delay > 0 then
  Result := Ord(digsound_rc_playing)
 else
{$endif}
Result := Ord(digsound_rc_done);
end;

function digsound_waitforevent:integer;
begin
Result := 0;
{$ifdef Windows}
RtlEventWaitFor(digsound_event,buffer_size_ms);
{$else}
wait_for_poll;
{$endif}
end;

function digsound_setevent:integer;
begin
Result := 0;
{$ifdef Windows}
RtlEventSetEvent(digsound_event);
{$else}
//todo break poll events in wait_for_poll
if count <= 0 then exit;
//ufds^.revents := ufds^.revents or POLLOUT;
//fpwrite(ufds^.fd,ufds,0);
//putmsg(
//pthread_kill(
//pipe
Result := digsound_reset; //temporary
{$endif}
end;

{$ifndef Windows}
procedure prepare_device_list;

  procedure add_device(const dev:string);
  var
   l:integer;
  begin
   l := Length(device_list);
   SetLength(device_list,l+1);
   device_list[l] := dev;
  end;

var
 hints,n:PPointer;
 name:PChar;
begin
//* Enumerate sound devices */
if (snd_device_name_hint(-1, 'pcm', @hints) <> 0) then
 begin
  add_device('default');
  exit; //Error! Just return
 end;

n := hints;
while (n^ <> nil) do
 begin
    name := snd_device_name_get_hint(n^, 'NAME');

    if (name <> nil) and  (name <> 'null') then
     begin
        //Copy name to another buffer and then free it
        add_device(name);
//        free(name); //todo чем освободить? freemem не годится :( cmem глючит...
     end;
    inc(n);
 end; //End of while

//Free hint buffer too
snd_device_name_free_hint(hints);
end;
{$endif}

initialization

{$ifdef Windows}
digsound_event := RTLEventCreate;
{$else}
prepare_device_list;
{$endif}

finalization

{$ifdef Windows}
RTLeventdestroy(digsound_event);
{$endif}

end.

