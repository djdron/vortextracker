{
ZX Spectrum Pro Tracker 3.0x - 3.6x modules player
Designed to compile for Atari ST with MC68000 processor
Used in Vortex Tracker II in PT3 to SNDH converter
To work on other MC68K based systems simply replace 'ROut' procedure
Based on Ay_Emul sources

(c)2003 S.V.Bulba

http://bulba.at.kz is
 - Micro ST (Win32 SNDH player)
 - AY Emulator (Win32 AY-3-8910/12 and YM2149F emulator/player/converter/ripper
 - Vortex Tracker II (Win32 AY/YM music editor)
 - and many other AY/YM soundchips related

Author Sergey Bulba <vorobey@mail.khstu.ru>
}
program MC68KPT3;

type

 BytePtr = ^byte;

 TModTypes = packed record
 case Integer of
 0: (Index:array[0..65535] of byte);
 6: (PT3_MusicName:array[0..$62]of char;
     PT3_TonTableId:byte;
     PT3_Delay:byte;
     PT3_NumberOfPositions:byte;
     PT3_LoopPosition:byte;
     PT3_PatternsPointer:word;
     PT3_SamplesPointers:array[0..31]of word;
     PT3_OrnamentsPointers:array[0..15]of word;
     PT3_PositionList:array[0..65535-201]of byte);
 end;

 TRegisterAY = packed record
 case Integer of
  0:(Index:array[0..13] of byte);
  1:(TonA,TonB,TonC: word;
     Noise:byte;
     Mixer:byte;
     AmplitudeA,AmplitudeB,AmplitudeC:byte;
     EnvelopeL:byte;
     EnvelopeH:byte;
     EnvType:byte);
 end;

 PT3_Channel_Parameters = record
  Address_In_Pattern,
  OrnamentPointer,
  SamplePointer,
  Ton:word;
  Loop_Ornament_Position,
  Ornament_Length,
  Position_In_Ornament,
  Loop_Sample_Position,
  Sample_Length,
  Position_In_Sample,
  Volume,
  Number_Of_Notes_To_Skip,
  Note,
  Slide_To_Note,
  Amplitude:byte;
  Envelope_Enabled,
  Enabled,
  SimpleGliss:boolean;
  Current_Amplitude_Sliding,
  Current_Noise_Sliding,
  Current_Envelope_Sliding,
  Ton_Slide_Count,
  Current_OnOff,
  OnOff_Delay,
  OffOn_Delay,
  Ton_Slide_Delay,
  Current_Ton_Sliding,
  Ton_Accumulator,
  Ton_Slide_Step,
  Ton_Delta:integer;
  Note_Skip_Counter:shortint;
  Dump:byte;
 end;

 PT3_Parameters = record
  PT3_Version:integer;
  Env_Base:word;
  Cur_Env_Slide,
  Env_Slide_Add:integer;
  Cur_Env_Delay,
  Env_Delay:shortint;
  Noise_Base,
  Delay,
  AddToNoise,
  DelayCounter,
  CurrentPosition:byte;
  PatPtr:word;
 end;

 PT3ToneTable = array[0..95] of word;
 PT3VolTable = array[0..15,0..15] of byte;

 TTbls = record
  T1,T2,T3,T4,T5,T6,T7:PT3ToneTable;
  V1,V2:PT3VolTable;
 end;

 TPlVars = record
  Tb:TTbls;
  RegAY:TRegisterAY;
  PT3:PT3_Parameters;PT3_A,PT3_B,PT3_C:PT3_Channel_Parameters;
  RAM:TModTypes;
 end;

const 

{Table #0 of Pro Tracker 3.3x - 3.4r}
 T033:PT3ToneTable = (
  $0C21,$0B73,$0ACE,$0A33,$09A0,$0916,$0893,$0818,$07A4,$0736,$06CE,$066D,
  $0610,$05B9,$0567,$0519,$04D0,$048B,$0449,$040C,$03D2,$039B,$0367,$0336,
  $0308,$02DC,$02B3,$028C,$0268,$0245,$0224,$0206,$01E9,$01CD,$01B3,$019B,
  $0184,$016E,$0159,$0146,$0134,$0122,$0112,$0103,$00F4,$00E6,$00D9,$00CD,
  $00C2,$00B7,$00AC,$00A3,$009A,$0091,$0089,$0081,$007A,$0073,$006C,$0066,
  $0061,$005B,$0056,$0051,$004D,$0048,$0044,$0040,$003D,$0039,$0036,$0033,
  $0030,$002D,$002B,$0028,$0026,$0024,$0022,$0020,$001E,$001C,$001B,$0019,
  $0018,$0016,$0015,$0014,$0013,$0012,$0011,$0010,$000F,$000E,$000D,$000C);

{Table #0 of Pro Tracker 3.4x - 3.5x}
 T035:PT3ToneTable = (
  $0C22,$0B73,$0ACF,$0A33,$09A1,$0917,$0894,$0819,$07A4,$0737,$06CF,$066D,
  $0611,$05BA,$0567,$051A,$04D0,$048B,$044A,$040C,$03D2,$039B,$0367,$0337,
  $0308,$02DD,$02B4,$028D,$0268,$0246,$0225,$0206,$01E9,$01CE,$01B4,$019B,
  $0184,$016E,$015A,$0146,$0134,$0123,$0112,$0103,$00F5,$00E7,$00DA,$00CE,
  $00C2,$00B7,$00AD,$00A3,$009A,$0091,$0089,$0082,$007A,$0073,$006D,$0067,
  $0061,$005C,$0056,$0052,$004D,$0049,$0045,$0041,$003D,$003A,$0036,$0033,
  $0031,$002E,$002B,$0029,$0027,$0024,$0022,$0020,$001F,$001D,$001B,$001A,
  $0018,$0017,$0016,$0014,$0013,$0012,$0011,$0010,$000F,$000E,$000D,$000C);

{Table #1 of Pro Tracker 3.3x - 3.5x)}
 T1ST:PT3ToneTable = (
  $0EF8,$0E10,$0D60,$0C80,$0BD8,$0B28,$0A88,$09F0,$0960,$08E0,$0858,$07E0,
  $077C,$0708,$06B0,$0640,$05EC,$0594,$0544,$04F8,$04B0,$0470,$042C,$03FD,
  $03BE,$0384,$0358,$0320,$02F6,$02CA,$02A2,$027C,$0258,$0238,$0216,$01F8,
  $01DF,$01C2,$01AC,$0190,$017B,$0165,$0151,$013E,$012C,$011C,$010A,$00FC,
  $00EF,$00E1,$00D6,$00C8,$00BD,$00B2,$00A8,$009F,$0096,$008E,$0085,$007E,
  $0077,$0070,$006B,$0064,$005E,$0059,$0054,$004F,$004B,$0047,$0042,$003F,
  $003B,$0038,$0035,$0032,$002F,$002C,$002A,$0027,$0025,$0023,$0021,$001F,
  $001D,$001C,$001A,$0019,$0017,$0016,$0015,$0013,$0012,$0011,$0010,$000F);

{Table #2 of Pro Tracker 3.4r}
 T233:PT3ToneTable = (
  $0D3E,$0C80,$0BCC,$0B22,$0A82,$09EC,$095C,$08D6,$0858,$07E0,$076E,$0704,
  $069F,$0640,$05E6,$0591,$0541,$04F6,$04AE,$046B,$042C,$03F0,$03B7,$0382,
  $034F,$0320,$02F3,$02C8,$02A1,$027B,$0257,$0236,$0216,$01F8,$01DC,$01C1,
  $01A8,$0190,$0179,$0164,$0150,$013D,$012C,$011B,$010B,$00FC,$00EE,$00E0,
  $00D4,$00C8,$00BD,$00B2,$00A8,$009F,$0096,$008D,$0085,$007E,$0077,$0070,
  $006A,$0064,$005E,$0059,$0054,$0050,$004B,$0047,$0043,$003F,$003C,$0038,
  $0035,$0032,$002F,$002D,$002A,$0028,$0026,$0024,$0022,$0020,$001E,$001D,
  $001B,$001A,$0019,$0018,$0015,$0014,$0013,$0012,$0011,$0010,$000F,$000E);

{Table #2 of Pro Tracker 3.4x - 3.5x}
 T235:PT3ToneTable = (
  $0D10,$0C55,$0BA4,$0AFC,$0A5F,$09CA,$093D,$08B8,$083B,$07C5,$0755,$06EC,
  $0688,$062A,$05D2,$057E,$052F,$04E5,$049E,$045C,$041D,$03E2,$03AB,$0376,
  $0344,$0315,$02E9,$02BF,$0298,$0272,$024F,$022E,$020F,$01F1,$01D5,$01BB,
  $01A2,$018B,$0174,$0160,$014C,$0139,$0128,$0117,$0107,$00F9,$00EB,$00DD,
  $00D1,$00C5,$00BA,$00B0,$00A6,$009D,$0094,$008C,$0084,$007C,$0075,$006F,
  $0069,$0063,$005D,$0058,$0053,$004E,$004A,$0046,$0042,$003E,$003B,$0037,
  $0034,$0031,$002F,$002C,$0029,$0027,$0025,$0023,$0021,$001F,$001D,$001C,
  $001A,$0019,$0017,$0016,$0015,$0014,$0012,$0011,$0010,$000F,$000E,$000D);

{Table #3 of Pro Tracker 3.4r}
 T333:PT3ToneTable = (
  $0CDA,$0C22,$0B73,$0ACF,$0A33,$09A1,$0917,$0894,$0819,$07A4,$0737,$06CF,
  $066D,$0611,$05BA,$0567,$051A,$04D0,$048B,$044A,$040C,$03D2,$039B,$0367,
  $0337,$0308,$02DD,$02B4,$028D,$0268,$0246,$0225,$0206,$01E9,$01CE,$01B4,
  $019B,$0184,$016E,$015A,$0146,$0134,$0123,$0113,$0103,$00F5,$00E7,$00DA,
  $00CE,$00C2,$00B7,$00AD,$00A3,$009A,$0091,$0089,$0082,$007A,$0073,$006D,
  $0067,$0061,$005C,$0056,$0052,$004D,$0049,$0045,$0041,$003D,$003A,$0036,
  $0033,$0031,$002E,$002B,$0029,$0027,$0024,$0022,$0020,$001F,$001D,$001B,
  $001A,$0018,$0017,$0016,$0014,$0013,$0012,$0011,$0010,$000F,$000E,$000D);

{Table #3 of Pro Tracker 3.4x - 3.5x}
 T335:PT3ToneTable = (
  $0CDA,$0C22,$0B73,$0ACF,$0A33,$09A1,$0917,$0894,$0819,$07A4,$0737,$06CF,
  $066D,$0611,$05BA,$0567,$051A,$04D0,$048B,$044A,$040C,$03D2,$039B,$0367,
  $0337,$0308,$02DD,$02B4,$028D,$0268,$0246,$0225,$0206,$01E9,$01CE,$01B4,
  $019B,$0184,$016E,$015A,$0146,$0134,$0123,$0112,$0103,$00F5,$00E7,$00DA,
  $00CE,$00C2,$00B7,$00AD,$00A3,$009A,$0091,$0089,$0082,$007A,$0073,$006D,
  $0067,$0061,$005C,$0056,$0052,$004D,$0049,$0045,$0041,$003D,$003A,$0036,
  $0033,$0031,$002E,$002B,$0029,$0027,$0024,$0022,$0020,$001F,$001D,$001B,
  $001A,$0018,$0017,$0016,$0014,$0013,$0012,$0011,$0010,$000F,$000E,$000D);

{Volume table of Pro Tracker 3.3x - 3.4x}
 V34:PT3VolTable = (
  ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),
  ($00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01),
  ($00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02),
  ($00,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03),
  ($00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04),
  ($00,$00,$00,$01,$01,$01,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05),
  ($00,$00,$00,$01,$01,$02,$02,$03,$03,$03,$04,$04,$05,$05,$06,$06),
  ($00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07),
  ($00,$00,$01,$01,$02,$02,$03,$03,$04,$05,$05,$06,$06,$07,$07,$08),
  ($00,$00,$01,$01,$02,$03,$03,$04,$05,$05,$06,$06,$07,$08,$08,$09),
  ($00,$00,$01,$02,$02,$03,$04,$04,$05,$06,$06,$07,$08,$08,$09,$0A),
  ($00,$00,$01,$02,$03,$03,$04,$05,$06,$06,$07,$08,$09,$09,$0A,$0B),
  ($00,$00,$01,$02,$03,$04,$04,$05,$06,$07,$08,$08,$09,$0A,$0B,$0C),
  ($00,$00,$01,$02,$03,$04,$05,$06,$07,$07,$08,$09,$0A,$0B,$0C,$0D),
  ($00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E),
  ($00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F));

{Volume table of Pro Tracker 3.5x}
 V35:PT3VolTable = (
  ($00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00),
  ($00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01),
  ($00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02),
  ($00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03),
  ($00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03,$04,$04),
  ($00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05),
  ($00,$00,$01,$01,$02,$02,$02,$03,$03,$04,$04,$04,$05,$05,$06,$06),
  ($00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07),
  ($00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,$08),
  ($00,$01,$01,$02,$02,$03,$04,$04,$05,$05,$06,$07,$07,$08,$08,$09),
  ($00,$01,$01,$02,$03,$03,$04,$05,$05,$06,$07,$07,$08,$09,$09,$0A),
  ($00,$01,$01,$02,$03,$04,$04,$05,$06,$07,$07,$08,$09,$0A,$0A,$0B),
  ($00,$01,$02,$02,$03,$04,$05,$06,$06,$07,$08,$09,$0A,$0A,$0B,$0C),
  ($00,$01,$02,$03,$03,$04,$05,$06,$07,$08,$09,$0A,$0A,$0B,$0C,$0D),
  ($00,$01,$02,$03,$04,$05,$06,$07,$07,$08,$09,$0A,$0B,$0C,$0D,$0E),
  ($00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F));

var
 PVars:^TPlVars;

procedure ROut;
var
 i:integer;
begin
with PVars^ do
 begin
  for i := 0 to 12 do
   begin
    BytePtr($FF8800)^ := i;
    BytePtr($FF8802)^ := RegAY.Index[i]
   end;
  if shortint(RegAY.EnvType) <> -1 then
   begin
    BytePtr($FF8800)^ := 13;
    BytePtr($FF8802)^ := RegAY.EnvType
   end
 end
end;

function MW(L,H:byte):word;
begin
MW := L + (word(H) shl 8)
end;

function IW(W:word):word;
begin
IW := (W shl 8) or (W shr 8)
end;

procedure PT3Init;
var
 i:integer;
 wp:word;
begin
with PVars^ do
 begin
   with PT3,RAM do
    begin
     PT3_Version := 6;
     if (Index[13] >= $30) and (Index[13] <= $39) then
      PT3_Version := Index[13] - $30;
     DelayCounter := 1;
     Delay := PT3_Delay;
     CurrentPosition := 0;
     Noise_Base := 0;
     AddToNoise := 0;
     Env_Base := 0;
     PatPtr := MW(Index[103],Index[104]);
     wp := PatPtr + PT3_PositionList[0] * 2;
     PT3_A.Address_In_Pattern := MW(Index[wp + 0],Index[wp + 1]);
     PT3_B.Address_In_Pattern := MW(Index[wp + 2],Index[wp + 3]);
     PT3_C.Address_In_Pattern := MW(Index[wp + 4],Index[wp + 5])
    end;

   with PT3_A,RAM do
    begin
     OrnamentPointer := MW(Index[169],Index[170]);
     Loop_Ornament_Position := Index[OrnamentPointer];
     inc(OrnamentPointer);
     Ornament_Length := Index[OrnamentPointer];
     inc(OrnamentPointer);
     SamplePointer := MW(Index[107],Index[108]);
     Loop_Sample_Position := Index[SamplePointer];
     inc(SamplePointer);
     Sample_Length := Index[SamplePointer];
     inc(SamplePointer);
     Volume := 15;
     Current_Ton_Sliding := 0;
     Note_Skip_Counter := 1;
     Enabled := False;
     Envelope_Enabled := False;
     Note := 0;
     Ton := 0
    end;

   with PT3_B do
    begin
     OrnamentPointer := PT3_A.OrnamentPointer;
     Loop_Ornament_Position := PT3_A.Loop_Ornament_Position;
     Ornament_Length := PT3_A.Ornament_Length;
     SamplePointer := PT3_A.SamplePointer;
     Loop_Sample_Position := PT3_A.Loop_Sample_Position;
     Sample_Length := PT3_A.Sample_Length;
     Volume := 15;
     Current_Ton_Sliding := 0;
     Note_Skip_Counter := 1;
     Enabled := False;
     Envelope_Enabled := False;
     Note := 0;
     Ton := 0
    end;

   with PT3_C do
    begin
     OrnamentPointer := PT3_A.OrnamentPointer;
     Loop_Ornament_Position := PT3_A.Loop_Ornament_Position;
     Ornament_Length := PT3_A.Ornament_Length;
     SamplePointer := PT3_A.SamplePointer;
     Loop_Sample_Position := PT3_A.Loop_Sample_Position;
     Sample_Length := PT3_A.Sample_Length;
     Volume := 15;
     Current_Ton_Sliding := 0;
     Note_Skip_Counter := 1;
     Enabled := False;
     Envelope_Enabled := False;
     Note := 0;
     Ton := 0
    end;

   for i := 0 to 13 do RegAY.Index[i] := 0

 end;

ROut

end;

procedure Pl;

 function Nt(j:integer):integer;
 begin
  with PVars^ do
   case RAM.PT3_TonTableId of
   0:if PT3.PT3_Version <= 3 then
      Result := Tb.T1[j]
     else
      Result := Tb.T2[j];
   1:Result := Tb.T3[j];
   2:if PT3.PT3_Version <= 3 then
      Result := Tb.T4[j]
     else
      Result := Tb.T5[j];
   else if PT3.PT3_Version <= 3 then
         Result := Tb.T6[j]
        else
         Result := Tb.T7[j]
   end
 end;

 procedure P(var Chan:PT3_Channel_Parameters);
 var
  quit:boolean;
  Flag9,Flag8,Flag5,Flag4,
  Flag3,Flag2,Flag1:byte;
  counter:byte;
  PrNote,PrSliding:integer;
  wp:word;
 begin
  PrNote := Chan.Note;
  PrSliding := Chan.Current_Ton_Sliding;
  quit := False;
  counter := 0;
  Flag9 := 0; Flag8 := 0; Flag5 := 0; Flag4 := 0;
  Flag3 := 0; Flag2 := 0; Flag1 := 0;
  with PVars^ do
  with Chan,RAM do
   begin
    repeat
     case Index[Address_In_Pattern] of
     $f0..$ff:
       begin
        wp := 169 + (Index[Address_In_Pattern] - $f0) * 2;
        OrnamentPointer := MW(Index[wp],Index[wp + 1]);
        Loop_Ornament_Position := Index[OrnamentPointer];
        Inc(OrnamentPointer);
        Ornament_Length := Index[OrnamentPointer];
        Inc(OrnamentPointer);
        Inc(Address_In_Pattern);
        wp := 105 + Index[Address_In_Pattern];
        SamplePointer := MW(Index[wp],Index[wp + 1]);
        Loop_Sample_Position := Index[SamplePointer];
        Inc(SamplePointer);
        Sample_Length := Index[SamplePointer];
        Inc(SamplePointer);
        Envelope_Enabled := False;
        Position_In_Ornament := 0
       end;
     $d1..$ef:
       begin
        wp := 105 + (Index[Address_In_Pattern] - $d0) * 2;
        SamplePointer := MW(Index[wp],Index[wp + 1]);
        Loop_Sample_Position := Index[SamplePointer];
        Inc(SamplePointer);
        Sample_Length := Index[SamplePointer];
        Inc(SamplePointer)
       end;
     $d0:
       quit := true;
     $c1..$cf:
       Volume := Index[Address_In_Pattern] - $c0;
     $c0:
       begin
        Position_In_Sample := 0;
        Current_Amplitude_Sliding := 0;
        Current_Noise_Sliding := 0;
        Current_Envelope_Sliding := 0;
        Position_In_Ornament := 0;
        Ton_Slide_Count := 0;
        Current_Ton_Sliding := 0;
        Ton_Accumulator := 0;
        Current_OnOff := 0;
        Enabled := False;
        quit := True
       end;
     $b2..$bf:
       begin
        Envelope_Enabled := True;
        RegAY.EnvType := Index[Address_In_Pattern] - $b1;
        Inc(Address_In_Pattern);
        with PT3 do
         begin
          {not big-endian}
          Env_Base := MW(Index[Address_In_Pattern + 1],Index[Address_In_Pattern]);
          Inc(Address_In_Pattern);
          Position_In_Ornament := 0;
          Cur_Env_Slide := 0;
          Cur_Env_Delay := 0
         end
       end;
     $b1:
       begin
        inc(Address_In_Pattern);
        Number_Of_Notes_To_Skip := Index[Address_In_Pattern]
       end;
     $b0:
       begin
        Envelope_Enabled := False;
        Position_In_Ornament := 0
       end;
     $50..$af:
       begin
        Note := Index[Address_In_Pattern] - $50;
        Position_In_Sample := 0;
        Current_Amplitude_Sliding := 0;
        Current_Noise_Sliding := 0;
        Current_Envelope_Sliding := 0;
        Position_In_Ornament := 0;
        Ton_Slide_Count := 0;
        Current_Ton_Sliding := 0;
        Ton_Accumulator := 0;
        Current_OnOff := 0;
        Enabled := True;
        quit := True
       end;
     $40..$4f:
       begin
        wp := 169 + (Index[Address_In_Pattern] - $40) * 2;
        OrnamentPointer := MW(Index[wp],Index[wp + 1]);
        Loop_Ornament_Position := Index[Chan.OrnamentPointer];
        Inc(OrnamentPointer);
        Ornament_Length := Index[OrnamentPointer];
        Inc(OrnamentPointer);
        Position_In_Ornament := 0
       end;
     $20..$3f:
       PT3.Noise_Base := Index[Address_In_Pattern] - $20;
     $10..$1f:
       begin
        if Index[Address_In_Pattern] = $10 then
         Envelope_Enabled := False
        else
         begin
          RegAY.EnvType := Index[Address_In_Pattern] - $10;
          Inc(Address_In_Pattern);
          with PT3 do
           begin
            {not big-endian}
            Env_Base := MW(Index[Address_In_Pattern + 1],Index[Address_In_Pattern]);
            Inc(Address_In_Pattern);
            Envelope_Enabled := True;
            Cur_Env_Slide := 0;
            Cur_Env_Delay := 0
           end
         end;
        Inc(Address_In_Pattern);
        wp := 105 + Index[Address_In_Pattern];
        SamplePointer := MW(Index[wp],Index[wp + 1]);
        Loop_Sample_Position := Index[SamplePointer];
        Inc(SamplePointer);
        Sample_Length := Index[SamplePointer];
        Inc(SamplePointer);
        Position_In_Ornament := 0
       end;
     $9:
       begin
        Inc(counter);
        Flag9 := counter
       end;
     $8:
       begin
        Inc(counter);
        Flag8 := counter
       end;
     $5:
       begin
        Inc(counter);
        Flag5 := counter
       end;
     $4:
       begin
        Inc(counter);
        Flag4 := counter
       end;
     $3:
       begin
        Inc(counter);
        Flag3 := counter
       end;
     $2:
       begin
        Inc(counter);
        Flag2 := counter
       end;
     $1:
       begin
        Inc(counter);
        Flag1 := counter
       end
     end;
     inc(Address_In_Pattern)
    until quit;
    while counter > 0 do
     begin
      if (counter = Flag1) then
       begin
        Ton_Slide_Delay := Index[Address_In_Pattern];
        Ton_Slide_Count := Ton_Slide_Delay;
        Inc(Address_In_Pattern);
        Ton_Slide_Step := MW(Index[Address_In_Pattern],Index[Address_In_Pattern + 1]);
        Inc(Address_In_Pattern,2);
        SimpleGliss := True;
        Current_OnOff := 0
       end
      else if (counter = Flag2) then
       begin
        SimpleGliss := False;
        Current_OnOff := 0;
        Ton_Slide_Delay := Index[Address_In_Pattern];
        Ton_Slide_Count := Ton_Slide_Delay;
        Inc(Address_In_Pattern,3);
        Ton_Slide_Step := Abs(integer(MW(Index[Address_In_Pattern],Index[Address_In_Pattern + 1])));
        Inc(Address_In_Pattern,2);
        Ton_Delta := Nt(Note) - Nt(PrNote);
        Slide_To_Note := Note;
        Note := PrNote;
        if PT3.PT3_Version >= 6 then
         Current_Ton_Sliding := PrSliding;
        if Ton_Delta - Current_Ton_Sliding < 0 then
         Ton_Slide_Step := -Ton_Slide_Step
       end
      else if counter = Flag3 then
       begin
        Position_in_Sample := Index[Address_In_Pattern];
        Inc(Address_In_Pattern)
       end
      else if counter = Flag4 then
       begin
        Position_in_Ornament := Index[Address_In_Pattern];
        inc(Address_In_Pattern)
       end
      else if counter = Flag5 then
       begin
        OnOff_Delay := Index[Address_In_Pattern];
        Inc(Address_In_Pattern);
        OffOn_Delay := Index[Address_In_Pattern];
        Current_OnOff := OnOff_Delay;
        Inc(Address_In_Pattern);
        Ton_Slide_Count := 0;
        Current_Ton_Sliding := 0
       end
      else if counter = Flag8 then
       begin
        with PT3 do
         begin
          Env_Delay := Index[Address_In_Pattern];
          Cur_Env_Delay := Env_Delay;
          Inc(Address_In_Pattern);
          Env_Slide_Add := MW(Index[Address_In_Pattern],Index[Address_In_Pattern + 1]);
         end;
        Inc(Address_In_Pattern,2)
       end
      else if counter = Flag9 then
       begin
        PT3.Delay := Index[Address_In_Pattern];
        Inc(Address_In_Pattern)
       end;
      Dec(counter)
     end;
    Note_Skip_Counter := Number_Of_Notes_To_Skip
   end
 end;

var
 TempMixer:byte;
 AddToEnv:shortint;

 procedure C(var Chan:PT3_Channel_Parameters);
 var
  j,b1,b0:byte;
  w,wp:word;
 begin
  with PVars^ do
  with Chan,RAM do
   begin
    if Enabled then
     begin
      wp := SamplePointer + Position_In_Sample * 4;
      Ton := MW(Index[wp + 2],Index[wp + 3]);
      Inc(Ton,Ton_Accumulator);
      b0 := Index[wp];
      b1 := Index[wp + 1];
      if b1 and $40 <> 0 then
       Ton_Accumulator := Ton;
      j := Note + Index[OrnamentPointer + Position_In_Ornament];
      if shortint(j) < 0 then j := 0
      else if j > 95 then j := 95;
      w := Nt(j);
      Ton := (Ton + Current_Ton_Sliding + w) and $fff;
      if Ton_Slide_Count > 0 then
       begin
        Dec(Ton_Slide_Count);
        if Ton_Slide_Count = 0 then
         begin
          Inc(Current_Ton_Sliding,Ton_Slide_Step);
          Ton_Slide_Count := Ton_Slide_Delay;
          if not SimpleGliss then
           if ((Ton_Slide_Step < 0) and (Current_Ton_Sliding <= Ton_Delta)) or
              ((Ton_Slide_Step >= 0) and (Current_Ton_Sliding >= Ton_Delta)) then
            begin
             Note := Slide_To_Note;
             Ton_Slide_Count := 0;
             Current_Ton_Sliding := 0
            end
         end
       end;
      Amplitude := b1 and $f;
      if b0 and $80 <> 0 then
      if b0 and $40 <> 0 then
       begin
        if Current_Amplitude_Sliding < 15 then
         inc(Current_Amplitude_Sliding)
       end
      else if Current_Amplitude_Sliding > -15 then
       dec(Current_Amplitude_Sliding);
      inc(Amplitude,Current_Amplitude_Sliding);
      if shortint(Amplitude) < 0 then Amplitude := 0
      else if Amplitude > 15 then Amplitude := 15;
      if PT3.PT3_Version <= 4 then
       Amplitude := Tb.V1[Volume,Amplitude]
      else
       Amplitude := Tb.V2[Volume,Amplitude];
      if (b0 and 1 = 0) and Envelope_Enabled then
       Amplitude := Amplitude or 16;
      if b1 and $80 <> 0 then
       begin
        if b0 and $20 <> 0 then
         j := (b0 shr 1) or $F0 + Current_Envelope_Sliding
        else
         j := (b0 shr 1) and $F + Current_Envelope_Sliding;
        if b1 and $20 <> 0 then Current_Envelope_Sliding := j;
        Inc(AddToEnv,j)
       end
      else
       begin
        PT3.AddToNoise := b0 shr 1 + Current_Noise_Sliding;
        if b1 and $20 <> 0 then
         Current_Noise_Sliding := PT3.AddToNoise
       end;
      TempMixer := b1 shr 1 and $48 or TempMixer;
      Inc(Position_In_Sample);
      if Position_In_Sample >= Sample_Length then
       Position_In_Sample := Loop_Sample_Position;
      Inc(Position_In_Ornament);
      if Position_In_Ornament >= Ornament_Length then
       Position_In_Ornament := Loop_Ornament_Position
     end
    else
     Amplitude := 0;
    TempMixer := TempMixer shr 1;
    if Current_OnOff > 0 then
     begin
      dec(Current_OnOff);
      if Current_OnOff = 0 then
       begin
        Enabled := not Enabled;
        if Enabled then Current_OnOff := OnOff_Delay
        else Current_OnOff := OffOn_Delay
       end;
     end
   end
 end;

var
 wp:word;
begin

with PVars^ do
begin

shortint(RegAY.EnvType) := -1;
with PT3 do
 begin
  Dec(DelayCounter);
  if DelayCounter = 0 then
   begin
    with PT3_A do
     begin
      Dec(Note_Skip_Counter);
      if Note_Skip_Counter = 0 then
       with RAM do
        begin
         if (Index[Address_In_Pattern] = 0) then
          begin
           inc(CurrentPosition);
           if CurrentPosition = PT3_NumberOfPositions then
            CurrentPosition := PT3_LoopPosition;
           wp := PatPtr + PT3_PositionList[CurrentPosition] * 2;
           Address_In_Pattern := MW(Index[wp + 0],Index[wp + 1]);
           PT3_B.Address_In_Pattern := MW(Index[wp + 2],Index[wp + 3]);
           PT3_C.Address_In_Pattern := MW(Index[wp + 4],Index[wp + 5]);
           Noise_Base := 0
          end;
         P(PT3_A)
        end
     end;
    with PT3_B do
     begin
      Dec(Note_Skip_Counter);
      if Note_Skip_Counter = 0 then
       P(PT3_B)
     end;
    with PT3_C do
     begin
      Dec(Note_Skip_Counter);
      if Note_Skip_Counter = 0 then
       P(PT3_C)
     end;
    DelayCounter := Delay
   end;

  AddToEnv := 0;
  TempMixer := 0;
  C(PT3_A);
  C(PT3_B);
  C(PT3_C);

  RegAY.Mixer := TempMixer;

  RegAY.TonA := IW(PT3_A.Ton);
  RegAY.TonB := IW(PT3_B.Ton);
  RegAY.TonC := IW(PT3_C.Ton);

  RegAY.AmplitudeA := PT3_A.Amplitude;
  RegAY.AmplitudeB := PT3_B.Amplitude;
  RegAY.AmplitudeC := PT3_C.Amplitude;

  RegAY.Noise := (Noise_Base + AddToNoise) and 31;

  wp := Env_Base + AddToEnv + Cur_Env_Slide;
  RegAY.EnvelopeL := wp;
  RegAY.EnvelopeH := wp shr 8;

  if Cur_Env_Delay > 0 then
   begin
    Dec(Cur_Env_Delay);
    if Cur_Env_Delay = 0 then
     begin
      Cur_Env_Delay := Env_Delay;
      Inc(Cur_Env_Slide,Env_Slide_Add)
     end
   end
 end

end;

ROut

end;

begin
end.