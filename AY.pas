{
This is part of Vortex Tracker II project
(c)2000-2022 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://bulba.untergrund.net/
}

unit AY;

{$mode objfpc}{$H+}
{$ASMMODE intel}

interface

uses LCLIntf, SysUtils, digsoundcode, Languages;

const
//Amplitude tables of sound chips
{ (c)Hacker KAY }
 Amplitudes_AY:array[0..15]of Word=
    (0, 836, 1212, 1773, 2619, 3875, 5397, 8823, 10392, 16706, 23339,
    29292, 36969, 46421, 55195, 65535);
{ (c)V_Soft
 Amplitudes_AY:array[0..15]of Word=
    (0, 513, 828, 1239, 1923, 3238, 4926, 9110, 10344, 17876, 24682,
    30442, 38844, 47270, 56402, 65535);}
{ (c)Lion17
 Amplitudes_YM:array[0..31]of Word=
    (0,  30,  190,  286, 375, 470, 560, 664, 866, 1130, 1515, 1803, 2253,
    2848, 3351, 3862, 4844, 6058, 7290, 8559, 10474, 12878, 15297, 17787,
    21500, 26172, 30866, 35676, 42664, 50986, 58842, 65535);}
{ (c)Hacker KAY }
 Amplitudes_YM:array[0..31]of Word=
    (0, 0, $F8, $1C2, $29E, $33A, $3F2, $4D7, $610, $77F, $90A, $A42,
    $C3B, $EC2, $1137, $13A7, $1750, $1BF9, $20DF, $2596, $2C9D, $3579,
    $3E55, $4768, $54FF, $6624, $773B, $883F, $A1DA, $C0FC, $E094, $FFFF);

 //Default mixer parameters
  SampleRateDef  = 48000;
  SampleBitDef   = 16;
  AY_FreqDef     = 1773400;
  MaxTStatesDef  = 69888;
  Interrupt_FreqDef = 50000;
  NumOfChanDef   = 2;
  ChanAllocDef    = 1;
  NumberOfBuffersDef = 3;
  BufLen_msDef = 200;

  FiltInfo:string = '';

type

 TRegisterAY = packed record
 case Integer of
  0:(Index:array[0..15]of byte);
  1:(TonA,TonB,TonC: word;
     Noise:byte;
     Mixer:byte;
     AmplitudeA,AmplitudeB,AmplitudeC:byte;
     Envelope:word;
     EnvType:byte);
 end;

//Available soundchips
  ChTypes = (No_Chip, AY_Chip, YM_Chip);

type
 TSoundChip = object
   RegisterAY:TRegisterAY;
   First_Period:boolean;
   Ampl:integer;
   Ton_Counter_A, Ton_Counter_B, Ton_Counter_C, Noise_Counter:packed record
    case integer of
     0:(Lo:word;
        Hi:word);
     1:(Re:longword);
    end;
   Envelope_Counter:packed record
    case integer of
    0:(Lo:dword;
       Hi:dword);
    1:(Re:int64);
    end;
   Ton_A,Ton_B,Ton_C:integer;
   Noise:packed record
    case boolean of
    True: (Seed:longword);
    False:(Low:word;
           Val:dword);
    end;
   Case_EnvType:procedure of object;
   Ton_EnA,Ton_EnB,Ton_EnC,Noise_EnA, Noise_EnB,Noise_EnC:boolean;
   Envelope_EnA,Envelope_EnB,Envelope_EnC:boolean;
   Current_RegisterAY:byte;
   procedure Case_EnvType_0_3__9;
   procedure Case_EnvType_4_7__15;
   procedure Case_EnvType_8;
   procedure Case_EnvType_10;
   procedure Case_EnvType_11;
   procedure Case_EnvType_12;
   procedure Case_EnvType_13;
   procedure Case_EnvType_14;
   procedure Synthesizer_Logic_Q;
   procedure SetMixerRegister(Value:byte);
   procedure SetEnvelopeRegister(Value:byte);
   procedure SetAmplA(Value:byte);
   procedure SetAmplB(Value:byte);
   procedure SetAmplC(Value:byte);
   procedure SetAYRegister(Num:integer;Value:byte);
   procedure SetAYRegisterFast(Num:integer;Value:byte);
   procedure Synthesizer_Mixer_Q;
   procedure Synthesizer_Mixer_Q_Mono;
  end;
 TFilt_K = array of integer;

var
 NOfTicks:DWORD;
 PlayingGrid:array of record
  M:array[0..1] of integer;
 end;
 MkVisPos,VisPosMax,VisPoint,VisStep,VisTickMax:DWORD;

 FilterWant:boolean = True;
 Filt_M:integer;
 IsFilt:integer = 1;
 Filt_K,Filt_XL,Filt_XR:TFilt_K;
 Filt_I:integer;
 IntFlag:boolean;
 RegNumNext,DatNext:integer;
 Delay_in_tiks:DWORD;
 AY_Freq:integer;
 Previous_Tact:integer;

 NumberOfSoundChips:integer;
 Real_End:array[0..1] of boolean;
 Real_End_All,LoopAllowed:boolean;
 LineReady:boolean;

 SoundChip:array[0..1] of TSoundChip;

 Tik:packed record
 case integer of
 0:(Lo:word;
    Hi:word);
 1:(Re:integer);
 end;
 Synthesizer:procedure(Buf:pointer);
 Current_Tik:longword;
 Number_Of_Tiks:packed record
 case boolean of
  False:(lo:longword;
         hi:longword);
  True: (re:int64);
 end;
 Flg:smallint;
 Index_AL,Index_AR,Index_BL,Index_BR,Index_CL,Index_CR:byte;
 ChType:ChTypes = YM_Chip;
 AY_Tiks_In_Interrupt:longword;

procedure Synthesizer_Stereo16(Buf:pointer);
procedure Synthesizer_Stereo8(Buf:pointer);
procedure Synthesizer_Mono16(Buf:pointer);
procedure Synthesizer_Mono8(Buf:pointer);
procedure ResetAYChipEmulation(chip:integer;zeroregs:boolean);

procedure SynthesizerZX50(Buf:pointer);

procedure MakeBufferTracker(Buf:pointer);
procedure SetBuffers(len,num:integer);
procedure Set_Sample_Rate(SR:integer);
procedure Set_Sample_Bit(SB:integer);
procedure Set_Stereo(St:integer);
procedure Set_Chip_Frq(Fr:integer);
procedure Set_Player_Frq(Fr:integer);
procedure SetFilter(Filt:boolean);

procedure Calculate_Level_Tables;
function ToggleChanMode:string;

implementation

uses
  ChildWin, Main, trfuncs;

var
  Level_AR,Level_AL,
  Level_BR,Level_BL,
  Level_CR,Level_CL:array[0..31]of Integer;
  PrevLeft,PrevRight:integer;
  LevelL,LevelR,Left_Chan,Right_Chan:integer;
  Left_Chan1,Right_Chan1:integer;
  Tick_Counter:packed record
  case integer of
  0:(Lo:word;
     Hi:word);
  1:(Re:integer);
  end;

type
 TS16 = packed array[0..0] of record
  Left:smallint;
  Right:smallint;
 end;
 PS16 = ^TS16;
 TS8 = packed array[0..0] of record
  Left:byte;
  Right:byte;
 end;
 PS8 = ^TS8;
 TM16 = packed array[0..0] of smallint;
 PM16 = ^TM16;
 TM8 = packed array[0..0] of byte;
 PM8 = ^TM8;

procedure TSoundChip.Case_EnvType_0_3__9;
begin
if First_Period then
 begin
  dec(Ampl);
  if Ampl = 0 then First_Period := False
 end
end;

procedure TSoundChip.Case_EnvType_4_7__15;
begin
if First_Period then
 begin
  Inc(Ampl);
  if Ampl = 32 then
   begin
    First_Period := False;
    Ampl := 0
   end
 end
end;

procedure TSoundChip.Case_EnvType_8;
begin
Ampl := (Ampl - 1) and 31
end;

procedure TSoundChip.Case_EnvType_10;
begin
if First_Period then
 begin
  dec(Ampl);
  if Ampl < 0 then
   begin
    First_Period := False;
    Ampl := 0
   end
 end
else
 begin
  inc(Ampl);
  if Ampl = 32 then
   begin
    First_Period := True;
    Ampl := 31
   end
 end
end;

procedure TSoundChip.Case_EnvType_11;
begin
if First_Period then
 begin
  dec(Ampl);
  if Ampl < 0 then
   begin
    First_Period := False;
    Ampl := 31
   end
 end
end;

procedure TSoundChip.Case_EnvType_12;
begin
Ampl := (Ampl + 1) and 31
end;

procedure TSoundChip.Case_EnvType_13;
begin
if First_Period then
 begin
  inc(Ampl);
  if Ampl = 32 then
   begin
    First_Period := False;
    Ampl := 31
   end
 end
end;

procedure TSoundChip.Case_EnvType_14;
begin
if not First_Period then
 begin
  dec(Ampl);
  if Ampl < 0 then
   begin
    First_Period := True;
    Ampl := 0
   end
 end
else
 begin
  inc(Ampl);
  if Ampl = 32 then
   begin
    First_Period := False;
    Ampl := 31
   end
 end
end;

function NoiseGenerator(Seed:integer):integer;
begin
{$ifdef cpu32}
asm
 shld edx,eax,16
 shld ecx,eax,19
 xor ecx,edx
 and ecx,1
 add eax,eax
 and eax,$1ffff
 inc eax
 xor eax,ecx
end;
{$else}
Result := (((Seed shl 1) or 1) xor ((Seed shr 16) xor (Seed shr 13) and 1)) and $1ffff;
{$endif}
end;

procedure TSoundChip.Synthesizer_Logic_Q;
begin
inc(Ton_Counter_A.Hi);
if Ton_Counter_A.Hi >= RegisterAY.TonA then
 begin
  Ton_Counter_A.Hi := 0;
  Ton_A := Ton_A xor 1
 end;
inc(Ton_Counter_B.Hi);
if Ton_Counter_B.Hi >= RegisterAY.TonB then
 begin
  Ton_Counter_B.Hi := 0;
  Ton_B := Ton_B xor 1
 end;
inc(Ton_Counter_C.Hi);
if Ton_Counter_C.Hi >= RegisterAY.TonC then
 begin
  Ton_Counter_C.Hi := 0;
  Ton_C := Ton_C xor 1
 end;
inc(Noise_Counter.Hi);
if (Noise_Counter.Hi and 1 = 0) and
   (Noise_Counter.Hi >= RegisterAY.Noise shl 1) then
 begin
  Noise_Counter.Hi := 0;
  Noise.Seed := NoiseGenerator(Noise.Seed);
 end;
if Envelope_Counter.Hi = 0 then Case_EnvType;
inc(Envelope_Counter.Hi);
if Envelope_Counter.Hi >= RegisterAY.Envelope then
 Envelope_Counter.Hi := 0;
end;

procedure TSoundChip.SetMixerRegister(Value:byte);
begin
RegisterAY.Mixer := Value;
Ton_EnA := (Value and 1) = 0;
Noise_EnA := (Value and 8) = 0;
Ton_EnB := (Value and 2) = 0;
Noise_EnB := (Value and 16) = 0;
Ton_EnC := (Value and 4) = 0;
Noise_EnC := (Value and 32) = 0;
end;

procedure TSoundChip.SetEnvelopeRegister(Value:byte);
begin
Envelope_Counter.Hi := 0;
First_Period := True;
if (Value and 4) = 0 then
 ampl := 32
else
 ampl := -1;
RegisterAY.EnvType := Value;
Case Value of
0..3,9: Case_EnvType := @Case_EnvType_0_3__9;
4..7,15:Case_EnvType := @Case_EnvType_4_7__15;
8:      Case_EnvType := @Case_EnvType_8;
10:     Case_EnvType := @Case_EnvType_10;
11:     Case_EnvType := @Case_EnvType_11;
12:     Case_EnvType := @Case_EnvType_12;
13:     Case_EnvType := @Case_EnvType_13;
14:     Case_EnvType := @Case_EnvType_14;
end;
end;

procedure TSoundChip.SetAmplA(Value:byte);
begin
RegisterAY.AmplitudeA := Value;
Envelope_EnA := (Value and 16) = 0;
end;

procedure TSoundChip.SetAmplB(Value:byte);
begin
RegisterAY.AmplitudeB := Value;
Envelope_EnB := (Value and 16) = 0;
end;

procedure TSoundChip.SetAmplC(Value:byte);
begin
RegisterAY.AmplitudeC := Value;
Envelope_EnC := (Value and 16) = 0;
end;

procedure TSoundChip.SetAYRegister(Num:integer;Value:byte);
begin
case Num of
13:
 SetEnvelopeRegister(Value and 15);
1,3,5:
 RegisterAY.Index[Num] := Value and 15;
6:
 RegisterAY.Noise := Value and 31;
7: SetMixerRegister(Value and 63);
8: SetAmplA(Value and 31);
9: SetAmplB(Value and 31);
10:SetAmplC(Value and 31);
0,2,4,11,12:
 RegisterAY.Index[Num] := Value;
end
end;

procedure TSoundChip.SetAYRegisterFast(Num:integer;Value:byte);
begin
case Num of
13:
 SetEnvelopeRegister(Value);
1,3,5:
 RegisterAY.Index[Num] := Value;
6:
 RegisterAY.Noise := Value;
7: SetMixerRegister(Value);
8: SetAmplA(Value);
9: SetAmplB(Value);
10:SetAmplC(Value);
0,2,4,11,12:
 RegisterAY.Index[Num] := Value;
end;
end;

//sorry for assembler, I can't make effective qword procedure on pascal...
function ApplyFilter(Lev:integer;var Filt_X:TFilt_K):integer;
{$ifdef cpu32}
begin
asm
        push    ebx
        push    esi
        push    edi
        add     esp,-8
        mov     ecx,Filt_M
        mov     edi,Filt_K
//        lea     esi,edi+ecx*4
        lea     esi,edi[ecx*4] //FPC
        mov     ebx,[edx]
        mov     ecx,Filt_I
        mov     [ebx+ecx*4],eax
        imul    dword ptr [edi]
        mov     [esp],eax
        mov     [esp+4],edx
@lp:    dec     ecx
        jns     @gz
        mov     ecx,Filt_M
//        sets    al
//        dec     eax


@gz:    mov     eax,[ebx+ecx*4]
        add     edi,4
        imul    dword ptr [edi]
        add     [esp],eax
        adc     [esp+4],edx
        cmp     edi,esi
        jnz     @lp
        mov     Filt_I,ecx
        pop     eax
        pop     edx
        pop     edi
        pop     esi
        pop     ebx
        test    edx,edx
        jns     @nm
        add     eax,0FFFFFFh
        adc     edx,0
@nm:    shrd    eax,edx,24
end;
{$else}
var
 Res:int64;
 j:integer;
begin
Filt_X[Filt_I] := Lev;
Res := Lev*Filt_K[0];
for j := 1 to Filt_M do
 begin
  if Filt_I > 0 then
   Dec(Filt_I)
  else
   Filt_I := Filt_M;
  Inc(Res,Filt_X[Filt_I]*Filt_K[j]);
 end;
Result := Res div $1000000;
{$endif}
end;

procedure TSoundChip.Synthesizer_Mixer_Q;
var
 LevL,LevR,k:integer;
begin
LevL := 0;
LevR := LevL;

k := 1;
if Ton_EnA then k := Ton_A;
if Noise_EnA then k := k and Noise.Val;
if k <> 0 then
 begin
  if Envelope_EnA then
   begin
    inc(LevL,Level_AL[RegisterAY.AmplitudeA * 2 + 1]);
    inc(LevR,Level_AR[RegisterAY.AmplitudeA * 2 + 1])
   end
  else
   begin
    inc(LevL,Level_AL[Ampl]);
    inc(LevR,Level_AR[Ampl])
   end
 end;

k := 1;
if Ton_EnB then k := Ton_B;
if Noise_EnB then k := k and Noise.Val;
if k <> 0 then
 if Envelope_EnB then
  begin
   inc(LevL,Level_BL[RegisterAY.AmplitudeB * 2 + 1]);
   inc(LevR,Level_BR[RegisterAY.AmplitudeB * 2 + 1])
  end
 else
  begin
   inc(LevL,Level_BL[Ampl]);
   inc(LevR,Level_BR[Ampl])
  end;

k := 1;
if Ton_EnC then k := Ton_C;
if Noise_EnC then k := k and Noise.Val;
if k <> 0 then
 if Envelope_EnC then
  begin
   inc(LevL,Level_CL[RegisterAY.AmplitudeC * 2 + 1]);
   inc(LevR,Level_CR[RegisterAY.AmplitudeC * 2 + 1])
  end
 else
  begin
   inc(LevL,Level_CL[Ampl]);
   inc(LevR,Level_CR[Ampl])
  end;

inc(LevelL,LevL);
inc(LevelR,LevR);
end;

procedure FillVis;
var
 i:integer;
begin
for i := 0 to NumberOfSoundChips-1 do
 PlayingGrid[MkVisPos].M[i] := (PlVars[i].CurrentPosition and $1FF) +
                             (PlVars[i].CurrentPattern shl 9) +
                             (PlVars[i].CurrentLine shl 17);
Inc(MkVisPos);
if MkVisPos >= VisPosMax then MkVisPos := 0;
Inc(VisPoint,VisStep);
end;

function Interpolator16(l1,l0,ofs:integer):integer;
begin
Result := (l1 - l0) * ofs div 65536 + l0;
if Result > 32767 then
 Result := 32767
else if Result < -32768 then
 Result := -32768;
end;

function Interpolator8(l1,l0,ofs:integer):integer;
begin
Result := (l1 - l0) * ofs div 65536 + l0 + 128;
if Result > 255 then
 Result := 255
else if Result < 0 then
 Result := 0;
end;

function Averager16(l:integer):integer;
begin
Result := l div Tick_Counter.Hi;
if Result > 32767 then
 Result := 32767
else if Result < -32768 then
 Result := -32768;
end;

function Averager8(l:integer):integer;
begin
Result := 128 + l div Tick_Counter.Hi;
if Result > 255 then
 Result := 255
else if Result < 0 then
 Result := 0;
end;

procedure Synthesizer_Stereo16(Buf:pointer);
var
 Tmp,i:integer;
begin
repeat
Tmp := 0; LevelL := Tmp; LevelR := Tmp;
if Tick_Counter.Re >= Tik.Re then
 begin
  repeat
   if IsFilt > 0 then
    begin
     Tmp := Tik.Re - Tick_Counter.Re + 65536;
     PS16(Buf)^[BuffLen].Left := Interpolator16(Left_Chan,PrevLeft,Tmp);
     PS16(Buf)^[BuffLen].Right := Interpolator16(Right_Chan,PrevRight,Tmp);
    end
   else
    begin
     PS16(Buf)^[BuffLen].Left := Averager16(Left_Chan1);
     PS16(Buf)^[BuffLen].Right := Averager16(Right_Chan1);
    end;
   inc(Tik.Re,integer(Delay_In_Tiks));
   if NOfTicks = VisPoint then FillVis;
   Inc(NOfTicks);
   Inc(BuffLen);
   if BuffLen = BufferLength then
    begin
     if Current_Tik < Number_Of_Tiks.Hi then
      IntFlag := True;
     exit
    end
  until Tick_Counter.Re < Tik.Re; //simple upsampler
  dec(Tik.Re,Tick_Counter.Re);
  Tmp := 0; Left_Chan1 := Tmp; Right_Chan1 := Tmp; Tick_Counter.Re := Tmp;
 end;
for i := 0 to NumberOfSoundChips-1 do
 begin
  SoundChip[i].Synthesizer_Logic_Q;
  SoundChip[i].Synthesizer_Mixer_Q;
 end;
if IsFilt >= 0 then
 begin
  Tmp := Filt_I;
  LevelL := ApplyFilter(LevelL,Filt_XL);
  Filt_I := Tmp;
  LevelR := ApplyFilter(LevelR,Filt_XR)
 end;
PrevLeft := Left_Chan;
Left_Chan := LevelL;
inc(Left_Chan1,LevelL);
PrevRight := Right_Chan;
Right_Chan := LevelR;
inc(Right_Chan1,LevelR);

inc(Current_Tik);
Inc(Tick_Counter.Hi);
until Current_Tik >= Number_Of_Tiks.Hi;
Tmp := 0; Number_Of_Tiks.Hi := Tmp; Current_Tik := Tmp
end;

procedure Synthesizer_Stereo8(Buf:pointer);
var
 Tmp,i:integer;
begin
repeat
Tmp := 0; LevelL := Tmp; LevelR := Tmp;
if Tick_Counter.Re >= Tik.Re then
 begin
  repeat
   if IsFilt > 0 then
    begin
     Tmp := Tik.Re - Tick_Counter.Re + 65536;
     PS8(Buf)^[BuffLen].Left := Interpolator8(Left_Chan,PrevLeft,Tmp);
     PS8(Buf)^[BuffLen].Right := Interpolator8(Right_Chan,PrevRight,Tmp);
    end
   else
    begin
     PS8(Buf)^[BuffLen].Left := Averager8(Left_Chan1);
     PS8(Buf)^[BuffLen].Right := Averager8(Right_Chan1);
    end;
   inc(Tik.Re,integer(Delay_In_Tiks));
   if NOfTicks = VisPoint then FillVis;
   Inc(NOfTicks);
   Inc(BuffLen);
   if BuffLen = BufferLength then
    begin
     if Current_Tik < Number_Of_Tiks.Hi then
      IntFlag := True;
     exit
    end
  until Tick_Counter.Re < Tik.Re; //simple upsampler
  dec(Tik.Re,Tick_Counter.Re);
  Tmp := 0; Left_Chan1 := Tmp; Right_Chan1 := Tmp; Tick_Counter.Re := Tmp;
 end;
for i := 0 to NumberOfSoundChips-1 do
 begin
  SoundChip[i].Synthesizer_Logic_Q;
  SoundChip[i].Synthesizer_Mixer_Q;
 end;
if IsFilt >= 0 then
 begin
  Tmp := Filt_I;
  LevelL := ApplyFilter(LevelL,Filt_XL);
  Filt_I := Tmp;
  LevelR := ApplyFilter(LevelR,Filt_XR)
 end;
PrevLeft := Left_Chan;
Left_Chan := LevelL;
inc(Left_Chan1,LevelL);
PrevRight := Right_Chan;
Right_Chan := LevelR;
inc(Right_Chan1,LevelR);

Inc(Current_Tik);
Inc(Tick_Counter.Hi);
until Current_Tik >= Number_Of_Tiks.Hi;
Tmp := 0; Number_Of_Tiks.hi := Tmp; Current_Tik := Tmp;
end;

procedure TSoundChip.Synthesizer_Mixer_Q_Mono;
var
 Lev,k:integer;
begin
Lev := 0;

k := 1;
if Ton_EnA then k := Ton_A;
if Noise_EnA then k := k and Noise.Val;
if k <> 0 then
 if Envelope_EnA then
  inc(Lev,Level_AL[RegisterAY.AmplitudeA * 2 + 1])
 else
  inc(Lev,Level_AL[Ampl]);

k := 1;
if Ton_EnB then k := Ton_B;
if Noise_EnB then k := k and Noise.Val;
if k <> 0 then
 if Envelope_EnB then
  inc(Lev,Level_BL[RegisterAY.AmplitudeB * 2 + 1])
 else
  inc(Lev,Level_BL[Ampl]);

k := 1;
if Ton_EnC then k := Ton_C;
if Noise_EnC then k := k and Noise.Val;
if k <> 0 then
 if Envelope_EnC then
  inc(Lev,Level_CL[RegisterAY.AmplitudeC * 2 + 1])
 else
  inc(Lev,Level_CL[Ampl]);

inc(LevelL,Lev);
end;

procedure Synthesizer_Mono16(Buf:pointer);
var
 Tmp,i:integer;
begin
repeat
LevelL := 0;
if Tick_Counter.Re >= Tik.Re then
 begin
  repeat
   if IsFilt > 0 then
    PM16(Buf)^[BuffLen] := Interpolator16(Left_Chan,PrevLeft,Tik.Re - Tick_Counter.Re + 65536)
   else
    PM16(Buf)^[BuffLen] := Averager16(Left_Chan1);
   inc(Tik.Re,integer(Delay_In_Tiks));
   if NOfTicks = VisPoint then FillVis;
   Inc(NOfTicks);
   Inc(BuffLen);
   if BuffLen = BufferLength then
    begin
     if Current_Tik < Number_Of_Tiks.Hi then
      IntFlag := True;
     exit
    end
  until Tick_Counter.Re < Tik.Re; //simple upsampler
  dec(Tik.Re,Tick_Counter.Re);
  Tmp := 0; Left_Chan1 := Tmp; Tick_Counter.Re := Tmp;
 end;
for i := 0 to NumberOfSoundChips-1 do
 begin
  SoundChip[i].Synthesizer_Logic_Q;
  SoundChip[i].Synthesizer_Mixer_Q_Mono;
 end;
if IsFilt >= 0 then
 LevelL := ApplyFilter(LevelL,Filt_XL);

PrevLeft := Left_Chan;
Left_Chan := LevelL;
inc(Left_Chan1,LevelL);

Inc(Current_Tik);
Inc(Tick_Counter.Hi);
until Current_Tik >= Number_Of_Tiks.Hi;
Tmp := 0; Number_Of_Tiks.hi := Tmp; Current_Tik := Tmp;
end;

procedure Synthesizer_Mono8(Buf:pointer);
var
 Tmp,i:integer;
begin
repeat
LevelL := 0;
if Tick_Counter.Re >= Tik.Re then
 begin
  repeat
   if IsFilt > 0 then
    PM8(Buf)^[BuffLen] := Interpolator8(Left_Chan,PrevLeft,Tik.Re - Tick_Counter.Re + 65536)
   else
    PM8(Buf)^[BuffLen] := Averager8(Left_Chan1);
   inc(Tik.Re,integer(Delay_In_Tiks));
   if NOfTicks = VisPoint then FillVis;
   Inc(NOfTicks);
   Inc(BuffLen);
   if BuffLen = BufferLength then
    begin
     if Current_Tik < Number_Of_Tiks.Hi then
      IntFlag := True;
     exit
    end
  until Tick_Counter.Re < Tik.Re; //simple upsampler
  dec(Tik.Re,Tick_Counter.Re);
  Tmp := 0; Left_Chan1 := Tmp; Tick_Counter.Re := Tmp;
 end;
for i := 0 to NumberOfSoundChips-1 do
 begin
  SoundChip[i].Synthesizer_Logic_Q;
  SoundChip[i].Synthesizer_Mixer_Q_Mono;
 end;
if IsFilt >= 0 then
 LevelL := ApplyFilter(LevelL,Filt_XL);

PrevLeft := Left_Chan;
Left_Chan := LevelL;
inc(Left_Chan1,LevelL);

Inc(Current_Tik);
Inc(Tick_Counter.Hi);
until Current_Tik >= Number_Of_Tiks.Hi;
Tmp := 0; Number_Of_Tiks.Hi := Tmp; Current_Tik := Tmp;
end;

procedure ResetAYChipEmulation(chip:integer;zeroregs:boolean);
begin
 with SoundChip[chip] do
  begin
    if zeroregs then
     begin
      FillChar(RegisterAY,14,0);
      SetEnvelopeRegister(0);
      SetMixerRegister(0);
      SetAmplA(0);
      SetAmplB(0);
      SetAmplC(0);
      Current_RegisterAY := 0;
     end;
    First_Period := False;
    Ampl := 0;
    Number_Of_Tiks.Re := 0;
    Current_Tik := 0;
    Envelope_Counter.Re := 0;
    Ton_Counter_A.Re := 0;
    Ton_Counter_B.Re := 0;
    Ton_Counter_C.Re := 0;
    Noise_Counter.Re := 0;
    Ton_A := 0;
    Ton_B := 0;
    Ton_C := 0;
    Noise.Seed := $ffff;
    Noise.Val := 0;
  end;
 PrevLeft := 0; PrevRight := 0;
 Left_Chan := 0; Right_Chan := 0;
 Left_Chan1 := 0; Right_Chan1 := 0;
 Tick_Counter.Re := 0;
 Tik.Re := Delay_In_Tiks;
 Flg := 0;
 IntFlag := False;
end;

procedure Calculate_Level_Tables;
var
 i,b,l,r:integer;
 Index_A,Index_B,Index_C:integer;
 k:real;
begin
if NumberOfChannels = 2 then
 begin
  Index_A := Index_AL; Index_B := Index_BL; Index_C := Index_CL;
  l := (Index_AL + Index_BL + Index_CL) * 2;
  r := (Index_AR + Index_BR + Index_CR) * 2;
  if l < r then
   l := r;
 end
else
 begin
  Index_A := Index_AL + Index_AR; Index_B := Index_BL + Index_BR; Index_C := Index_CL + Index_CR;
  l := (Index_A + Index_B + Index_C) * 2;
 end;
if l = 0 then
 inc(l);
if SampleBit = 8 then
 r := 127
else
 r := 32767;
k := exp(MainForm.GlobalVolume * ln(2) / MainForm.GlobalVolumeMax) - 1;
case ChType of
AY_Chip:
 for i := 0 to 15 do
  begin
   b := trunc(Index_A/l*Amplitudes_AY[i]/65535*r*k+0.5);
   Level_AL[i*2] := b; Level_AL[i*2 + 1] := b;
   b := trunc(Index_AR/l*Amplitudes_AY[i]/65535*r*k+0.5);
   Level_AR[i*2] := b; Level_AR[i*2 + 1] := b;
   b := trunc(Index_B/l*Amplitudes_AY[i]/65535*r*k+0.5);
   Level_BL[i*2] := b; Level_BL[i*2 + 1] := b;
   b := trunc(Index_BR/l*Amplitudes_AY[i]/65535*r*k+0.5);
   Level_BR[i*2] := b; Level_BR[i*2 + 1] := b;
   b := trunc(Index_C/l*Amplitudes_AY[i]/65535*r*k+0.5);
   Level_CL[i*2] := b; Level_CL[i*2 + 1] := b;
   b := trunc(Index_CR/l*Amplitudes_AY[i]/65535*r*k+0.5);
   Level_CR[i*2] := b; Level_CR[i*2 + 1] := b;
  end;
YM_Chip:
 for i := 0 to 31 do
  begin
   Level_AL[i] := trunc(Index_A/l*Amplitudes_YM[i]/65535*r*k+0.5);
   Level_AR[i] := trunc(Index_AR/l*Amplitudes_YM[i]/65535*r*k+0.5);
   Level_BL[i] := trunc(Index_B/l*Amplitudes_YM[i]/65535*r*k+0.5);
   Level_BR[i] := trunc(Index_BR/l*Amplitudes_YM[i]/65535*r*k+0.5);
   Level_CL[i] := trunc(Index_C/l*Amplitudes_YM[i]/65535*r*k+0.5);
   Level_CR[i] := trunc(Index_CR/l*Amplitudes_YM[i]/65535*r*k+0.5);
  end;
end;
end;

function ToggleChanMode:string;
begin
Inc(StdChannelsAllocation);
if StdChannelsAllocation > 3 then
 StdChannelsAllocation := 0;
Result := SetStdChannelsAllocation(StdChannelsAllocation);
end;

procedure SynthesizerZX50(Buf:pointer);
begin
if not IntFlag then
 Number_Of_Tiks.hi := AY_Tiks_In_Interrupt
else
 IntFlag := False;
Synthesizer(Buf);
end;

procedure Get_Registers;
begin
if Real_End[CurChip] then
 begin
  SoundChip[CurChip].SetAmplA(0);
  SoundChip[CurChip].SetAmplB(0);
  SoundChip[CurChip].SetAmplC(0);
  exit
 end;
case PlayMode of
PMPlayModule:
 begin
  if Module_PlayCurrentLine = 3 then
   if not LoopAllowed and
     (not MainForm.LoopAllAllowed or (MainForm.MDIChildCount <> 1))  then
    begin
     Real_End[CurChip] := True;
     SoundChip[CurChip].SetAmplA(0);
     SoundChip[CurChip].SetAmplB(0);
     SoundChip[CurChip].SetAmplC(0);
    end;
 end;
PMPlayPattern:
 begin
  if Pattern_PlayCurrentLine = 2 then
   if not LoopAllowed and not MainForm.LoopAllAllowed then
    begin
     Real_End[CurChip] := True;
     SoundChip[CurChip].SetAmplA(0);
     SoundChip[CurChip].SetAmplB(0);
     SoundChip[CurChip].SetAmplC(0);
    end
   else
    begin
     Pattern_SetCurrentLine(0);
     Pattern_PlayCurrentLine;
    end;
 end;
PMPlayLine:
 Pattern_PlayOnlyCurrentLine;
end;
end;

procedure MakeBufferTracker(Buf:pointer);
var
 i:integer;
begin
BuffLen := 0;
if IntFlag then SynthesizerZX50(Buf);
if IntFlag then exit;
if LineReady then
 begin
  LineReady := False;
  SynthesizerZX50(Buf);
 end;
while not Real_End_All and (BuffLen < BufferLength) do
 begin
  Real_End_All := True;
  for i := 0 to NumberOfSoundChips-1 do
   begin
    Module_SetPointer(PlayingWindow[i].VTMP,i);
    Get_Registers;
    Real_End_All := Real_End_All and Real_End[i];
   end;
  if not Real_End_All then SynthesizerZX50(Buf);
 end;
end;

procedure SetBuffers(len,num:integer);
begin
if digsoundthread_active then exit;
if (num < 2) or (num > 10) then exit;
if (len < 5) or (len > 2000) then exit;
BufLen_ms := len;
NumberOfBuffers := num;
BufferLength := round(BufLen_ms * SampleRate / 1000);
VisPosMax := round(BufferLength * NumberOfBuffers / VisStep) + 1;
VisTickMax := VisStep * VisPosMax;
SetLength(PlayingGrid,VisPosMax);
end;

procedure Set_Sample_Rate(SR:integer);
begin
if IsPlaying then exit;
if not ((SR >= 8000) and (SR < 300000)) then exit;
SampleRate := SR;
VisStep := round(SampleRate/100);
BufferLength := round(BufLen_ms * SampleRate / 1000);
VisPosMax := round(BufferLength * NumberOfBuffers / VisStep) + 1;
VisTickMax := VisStep * VisPosMax;
SetLength(PlayingGrid,VisPosMax);
Delay_In_Tiks := round(8192/SampleRate*AY_Freq);
SetFilter(FilterWant);
end;

procedure SetSynthesizer;
begin
if NumberOfChannels = 2 then
 begin
  if SampleBit = 8 then
   Synthesizer := @Synthesizer_Stereo8
  else
   Synthesizer := @Synthesizer_Stereo16;
 end
else if SampleBit = 8 then
 Synthesizer := @Synthesizer_Mono8
else
 Synthesizer := @Synthesizer_Mono16;
Calculate_Level_Tables;
end;

procedure Set_Sample_Bit(SB:integer);
begin
if IsPlaying then exit;
SampleBit := SB;
SetSynthesizer;
end;

procedure Set_Stereo(St:integer);
begin
if IsPlaying then exit;
NumberOfChannels := St;
SetSynthesizer;
end;

procedure Set_Chip_Frq(Fr:integer);
begin
if (Fr >= 1000000) and (Fr <= 3546800) then
 begin
  digsoundloop_catch;
  try
    AY_Freq := Fr;
    Delay_In_Tiks := round(8192/SampleRate * AY_Freq);
    Tik.Re := Delay_In_Tiks;
    AY_Tiks_In_Interrupt := round(AY_Freq/(Interrupt_Freq/1000 * 8));
    SetFilter(FilterWant);
  finally
    digsoundloop_release;
  end;
 end;
end;

procedure Set_Player_Frq(Fr:integer);
begin
if (Fr >= 1000) and (Fr <= 2000000) and (Interrupt_Freq <> Fr) then
 begin
  digsoundloop_catch;
  try
    Interrupt_Freq := Fr;
    AY_Tiks_In_Interrupt := trunc(AY_Freq/(Interrupt_Freq/1000*8)+0.5);
  finally
    digsoundloop_release;
  end;
 end;
end;

procedure CalcFiltKoefs;
const
 MaxF = 9200;
var
 i:integer;
 K,F,C,i2,Filt_M2:double;
 FKt:array of double;
begin
//Work range [0..MaxF)
//Range [MaxF..SampleRate / 2) is easy cut-off from 0 to -53 dB
//Cut-off range is [SampleRate / 2.. AY_Freq div 8 / 2] (-53 dB)
//for Ay_Freq = 1773400 Hz:
(*
Полезная область - 0..11083,75 Гц (10)
221675->44100 - 67 (коэффициентов)
221675->48000 - 57
221675->96000 - 20
221675->110000 - 17

Полезная область - 0..10076,14 (11)
221675->22050 - 771

Полезная область - 0..9236,46 (12)
221675->22050 - 409

Полезная область - 0..8525,96 (13)
221675->22050 - 293
*)
IsFilt := 0;
C := 22050; if SampleRate >= 44100 then
 begin
  C := SampleRate / 2;
  inc(IsFilt);
 end;
Filt_M := round(3.3/(C - MaxF) * (AY_Freq div 8));
if AY_Freq * Filt_M > 3500000 * 50 then //90% of usage for my Celeron 850 MHz
 begin
  Filt_M := round(3500000 * 50 / AY_Freq);
  IsFilt := 0;
 end;
C := Pi * (MaxF + C) / (AY_Freq div 8);
SetLength(FKt,Filt_M);
Filt_M2 := (Filt_M - 1) / 2;
K := 0;
for i := 0 to Filt_M - 1 do
 begin
  i2 := i - Filt_M2;
  if i2 = 0 then
   F := C
  else
   F := sin(C * i2) / i2 * (0.54 + 0.46 * cos(2 * Pi / Filt_M * i2));
  FKt[i] := F;
  K := K + F;
 end;
SetLength(Filt_K,Filt_M);
for i := 0 to Filt_M - 1 do
 Filt_K[i] := round(FKt[i] / K * $1000000);
FiltInfo := Mes_FIR + ' (' + IntToStr(Filt_M) + ' '+Mes_PTS+')';
if IsFilt = 0 then FiltInfo := FiltInfo + ' + ' + LowerCase(Mes_Averager);
dec(Filt_M);
end;

procedure SetFilter(Filt:boolean);
begin
digsoundloop_catch;
try
  FilterWant := Filt;
  if not Filt or (SampleRate >= AY_Freq div 8) then
   begin
    IsFilt := -1;
    Filt_K := nil;
    Filt_XL := nil;
    Filt_XR := nil;
    FiltInfo := Mes_Averager;
    Exit;
   end;
  CalcFiltKoefs;
  SetLength(Filt_XL,Filt_M + 1);
  SetLength(Filt_XR,Filt_M + 1);
  FillChar(Filt_XL[0],(Filt_M + 1) * 4,0);
  FillChar(Filt_XR[0],(Filt_M + 1) * 4,0);
  Filt_I := 0;
finally
  digsoundloop_release;
end;
end;

end.
