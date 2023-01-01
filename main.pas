{
This is part of Vortex Tracker II project
(c)2000-2006 S.V.Bulba
Author Sergey Bulba
E-mail: vorobey@mail.khstu.ru
Support page: http://bulba.at.kz/
}

unit Main;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, AY, WaveOutAPI, trfuncs, grids, ChildWin;

const
 UM_REDRAWTRACKS = WM_USER;
 UM_PLAYINGOFF = WM_USER + 1;
 UM_FINALIZEWO = WM_USER + 2;

 NewTrack_NumberOfLinesDef = 11;

 StdAutoEnvMax = 7;
 StdAutoEnv:array[0..StdAutoEnvMax,0..1] of integer =
 ((1,1),(3,4),(1,2),(1,4),(3,1),(5,2),(2,1),(3,2));

//Version related constants
 VersionString = '1.0';
 IsBeta = ' beta';
 BetaNumber = ' 13';

 FullVersString:string = 'Vortex Tracker II v' + VersionString + IsBeta + BetaNumber;
 HalfVersString:string = 'Version ' + VersionString + IsBeta + BetaNumber;

//Register paths
 MyRegPath1:string = 'SOFTWARE\Sergey Vladimirovich Bulba';
 MyRegPath2:string = 'Vortex Tracker II';
 MyRegPath3:string = VersionString + IsBeta;

type
  ERegistryError = class(Exception);
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ImageList1: TImageList;
    N2: TMenuItem;
    Options1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    Play1: TAction;
    ToolButton14: TToolButton;
    Stop1: TAction;
    Play2: TMenuItem;
    Play4: TMenuItem;
    Stop2: TMenuItem;
    PopupMenu1: TPopupMenu;
    Setloopposition1: TMenuItem;
    Deleteposition1: TMenuItem;
    Insertposition1: TMenuItem;
    SetLoopPos: TAction;
    InsertPosition: TAction;
    DeletePosition: TAction;
    ToolButton15: TToolButton;
    ToggleLooping: TAction;
    Togglelooping1: TMenuItem;
    N3: TMenuItem;
    RFile1: TMenuItem;
    RFile2: TMenuItem;
    RFile3: TMenuItem;
    RFile4: TMenuItem;
    RFile5: TMenuItem;
    RFile6: TMenuItem;
    ToolButton16: TToolButton;
    ToggleChip: TAction;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ToggleChanAlloc: TAction;
    ToolButton17: TToolButton;
    ToggleLoopingAll: TAction;
    ToolButton18: TToolButton;
    PlayFromPos1: TAction;
    Play3: TMenuItem;
    Toggleloopingall1: TMenuItem;
    N4: TMenuItem;
    Tracksmanager1: TMenuItem;
    Globaltransposition1: TMenuItem;
    ToolButton19: TToolButton;
    TrackBar1: TTrackBar;
    PlayPat: TAction;
    PlayPatFromLine: TAction;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    Playpatternfromstart1: TMenuItem;
    Playpatternfromcurrentline1: TMenuItem;
    Exports1: TMenuItem;
    SaveSNDHMenu: TMenuItem;
    SaveDialogSNDH: TSaveDialog;
    SaveforZXMenu: TMenuItem;
    SaveDialogZXAY: TSaveDialog;
    EditCopy1: TAction;
    EditCut1: TAction;
    EditPaste1: TAction;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    Undo: TAction;
    Redo: TAction;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    ToolButton25: TToolButton;
    ComboBox1: TComboBox;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure umredrawtracks(var Msg: TMessage);message UM_REDRAWTRACKS;
    procedure umplayingoff(var Msg: TMessage);message UM_PLAYINGOFF;
    procedure umfinalizewo(var Msg: TMessage);message UM_FINALIZEWO;
    procedure Options1Click(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileSave1Update(Sender: TObject);
    procedure FileSaveAs1Execute(Sender: TObject);
    procedure FileSaveAs1Update(Sender: TObject);
    procedure Play1Update(Sender: TObject);
    procedure Stop1Update(Sender: TObject);
    procedure Play1Execute(Sender: TObject);
    procedure Stop1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetLoopPosExecute(Sender: TObject);
    procedure SetLoopPosUpdate(Sender: TObject);
    procedure InsertPositionExecute(Sender: TObject);
    procedure InsertPositionUpdate(Sender: TObject);
    procedure DeletePositionUpdate(Sender: TObject);
    procedure DeletePositionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToggleLoopingExecute(Sender: TObject);
    procedure AddFileName(FN:string);
    procedure OpenRecent(n:integer);
    procedure RFile1Click(Sender: TObject);
    procedure RFile2Click(Sender: TObject);
    procedure RFile3Click(Sender: TObject);
    procedure RFile4Click(Sender: TObject);
    procedure RFile5Click(Sender: TObject);
    procedure RFile6Click(Sender: TObject);
    procedure RestoreControls;
    procedure ToggleChipExecute(Sender: TObject);
    procedure ToggleChanAllocExecute(Sender: TObject);
    procedure SetChannelsAllocationVis(CA:integer);
    procedure ToggleLoopingAllExecute(Sender: TObject);
    procedure PlayFromPos1Update(Sender: TObject);
    procedure PlayFromPos1Execute(Sender: TObject);
    procedure DisableControls;
    procedure CheckSecondWindow;
    procedure SetIntFreqEx(f:integer);
    procedure SetSampleTemplate(Tmp:integer);
    procedure SetEmulatingChip(ChType:ChTypes);
    procedure AddToSampTemplate(const SamTik:TSampleTick);
    procedure Tracksmanager1Click(Sender: TObject);
    procedure Globaltransposition1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure SaveOptions;
    procedure LoadOptions;
    procedure ResetSampTemplate;
    procedure PlayPatFromLineUpdate(Sender: TObject);
    procedure PlayPatUpdate(Sender: TObject);
    procedure PlayPatExecute(Sender: TObject);
    procedure PlayPatFromLineExecute(Sender: TObject);
    procedure SaveSNDHMenuClick(Sender: TObject);
    procedure SaveforZXMenuClick(Sender: TObject);
    procedure SaveDialogZXAYTypeChange(Sender: TObject);
    procedure SetDialogZXAYExt;
    procedure SaveDialog1TypeChange(Sender: TObject);
    procedure SetPriority(Pr:longword);
    procedure EditCopy1Update(Sender: TObject);
    procedure EditCut1Update(Sender: TObject);
    procedure EditCut1Execute(Sender: TObject);
    procedure EditCopy1Execute(Sender: TObject);
    procedure EditPaste1Update(Sender: TObject);
    procedure EditPaste1Execute(Sender: TObject);
    procedure UndoUpdate(Sender: TObject);
    procedure UndoExecute(Sender: TObject);
    procedure RedoUpdate(Sender: TObject);
    procedure RedoExecute(Sender: TObject);
    procedure CheckCommandLine;
    procedure SavePT3(CW:TMDIChild;FileName:string;AsText:boolean);
    function AllowSave(fn:string):boolean;
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
  public
    { Public declarations }
    NewTrack_NumberOfLines:integer;
    NewTrack_Font:TFont;
    RecentFiles:array[0..5] of string;
    NoteKeys:array[0..255] of shortint;
    ChanAlloc:TChansArray;
    ChanAllocIndex:integer;
    LoopAllAllowed:boolean;
    SampleLineTemplates:array of TSampleTick;
    CurrentSampleLineTemplate:integer;
    GlobalVolume,GlobalVolumeMax,WinCount:integer;
  end;

function IntelWord(a:word):word;

var
  MainForm: TMainForm;
  Priority:dword = NORMAL_PRIORITY_CLASS;
  TrkClBk,TrkClTxt,TrkClHlBk,TrkClSelBk,TrkClSelTxt:integer;

implementation

{$R *.DFM}

uses About, options, TrkMng, GlbTrn, ExportZX;

function IntelWord(a:word):word;
asm
xchg al,ah
end;

procedure CheckRegError(Index:integer);
var
 Strg:PChar;
begin
if Index <> ERROR_SUCCESS then
 begin
  FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ALLOCATE_BUFFER,
                nil,Index,0,@Strg,0,nil);
  try
   raise ERegistryError.Create(Strg);
  finally
   LocalFree(integer(Strg))
  end
 end
end;

procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  Inc(WinCount);
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.WinNumber := WinCount;
  Child.Caption := IntToStr(WinCount) + ': new module';
  ComboBox1.AddItem(Child.Caption,Child);
  if (Name <> '') and FileExists(Name) then
   Child.LoadTrackerModule(Name);
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild('');
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
var
 i:integer;
begin
  if OpenDialog.Execute then
   begin
    OpenDialog.InitialDir := ExtractFilePath(OpenDialog.FileName);
    i := OpenDialog.Files.Count - 1;
    if i > 16 then i := 16;
    for i := i downto 0 do CreateMDIChild(OpenDialog.Files.Strings[i])
   end
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 i:integer;
begin
WinCount := 0;

TrkClBk := GetSysColor(COLOR_WINDOW);
TrkClTxt := GetSysColor(COLOR_WINDOWTEXT);
TrkClHlBk := (TrkClBk xor $101010);
TrkClSelBk := GetSysColor(COLOR_HIGHLIGHT);
TrkClSelTxt := GetSysColor(COLOR_HIGHLIGHTTEXT);

for i := 0 to 5 do RecentFiles[i] := '';
FillChar(NoteKeys,SizeOf(NoteKeys),-3);
NoteKeys[ORD('A')] := -2;
NoteKeys[ORD('K')] := -1;
NoteKeys[ORD('Z')] := 0;
NoteKeys[ORD('S')] := 1;
NoteKeys[ORD('X')] := 2;
NoteKeys[ORD('D')] := 3;
NoteKeys[ORD('C')] := 4;
NoteKeys[ORD('V')] := 5;
NoteKeys[ORD('G')] := 6;
NoteKeys[ORD('B')] := 7;
NoteKeys[ORD('H')] := 8;
NoteKeys[ORD('N')] := 9;
NoteKeys[ORD('J')] := 10;
NoteKeys[ORD('M')] := 11;
NoteKeys[188] := 12;
NoteKeys[ORD('L')] := 13;
NoteKeys[190] := 14;
NoteKeys[186] := 15;
NoteKeys[191] := 16;
NoteKeys[ORD('Q')] := 12;
NoteKeys[ORD('2')] := 13;
NoteKeys[ORD('W')] := 14;
NoteKeys[ORD('3')] := 15;
NoteKeys[ORD('E')] := 16;
NoteKeys[ORD('R')] := 17;
NoteKeys[ORD('5')] := 18;
NoteKeys[ORD('T')] := 19;
NoteKeys[ORD('6')] := 20;
NoteKeys[ORD('Y')] := 21;
NoteKeys[ORD('7')] := 22;
NoteKeys[ORD('U')] := 23;
NoteKeys[ORD('I')] := 24;
NoteKeys[ORD('9')] := 25;
NoteKeys[ORD('O')] := 26;
NoteKeys[ORD('0')] := 27;
NoteKeys[ORD('P')] := 28;
NoteKeys[219] := 29;
NoteKeys[187] := 30;
NoteKeys[221] := 31;
NoteKeys[VK_NUMPAD1] := 33;
NoteKeys[VK_NUMPAD2] := 34;
NoteKeys[VK_NUMPAD3] := 35;
NoteKeys[VK_NUMPAD4] := 36;
NoteKeys[VK_NUMPAD5] := 37;
NoteKeys[VK_NUMPAD6] := 38;
NoteKeys[VK_NUMPAD7] := 39;
NoteKeys[VK_NUMPAD8] := 40;
ChanAlloc[0] := 0;
ChanAlloc[1] := 1;
ChanAlloc[2] := 2;
ChanAllocIndex := 0;
Enabled := True;
FileMode := 0;
OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
NewTrack_NumberOfLines := NewTrack_NumberOfLinesDef;
NewTrack_Font := TFont.Create;
NewTrack_Font.Name := 'Courier';
NewTrack_Font.Size := 12;
LoopAllowed := False;
LoopAllAllowed := False;
GlobalVolume := TrackBar1.Position;
GlobalVolumeMax := TrackBar1.Max;
SetDefault(SampleRate_Def,NumberOfChannels_Def,SampleBit_Def);
ResetMutex := CreateMutex(nil, False, PChar('VTII_Reset' + IntToStr(GetCurrentProcessId)));
Synthesizer := Synthesizer_Stereo16;
ResetSampTemplate;
LoadOptions
end;

procedure TMainForm.umredrawtracks;
var
 pat,ps:integer;
begin
if not IsPlaying then exit;
ps := smallint(Msg.WParam and 65535);
pat := Msg.WParam shr 16;
if ps >= 0 then PlayingWindow[1].SelectPosition2(ps);
if (PlayingWindow[1].Tracks.ShownPattern <> PlayingWindow[1].VTMP.Patterns[pat])
   or (PlayingWindow[1].Tracks.ShownFrom <> Msg.LParam) then
 begin
  PlayingWindow[1].PatNum := pat;
  PlayingWindow[1].UpDown1.Position := pat;
  PlayingWindow[1].Tracks.ShownPattern := PlayingWindow[1].VTMP.Patterns[pat];
  PlayingWindow[1].Tracks.ShownFrom := Msg.LParam;
  PlayingWindow[1].CalculatePos(Msg.LParam);
  if PlayingWindow[1].Tracks.Enabled then HideCaret(PlayingWindow[1].Tracks.Handle);
  PlayingWindow[1].Tracks.CursorY := PlayingWindow[1].Tracks.N1OfLines;
  PlayingWindow[1].Tracks.RemoveSelection(0,True);
  PlayingWindow[1].Tracks.RedrawTracks(0);
  if PlayingWindow[1].Tracks.Enabled then ShowCaret(PlayingWindow[1].Tracks.Handle)
 end
end;

procedure TMainForm.Options1Click(Sender: TObject);
var
 Saved_ChanAllocIndex,
 Saved_AY_Freq,
 Saved_StdChannelsAllocation,
 Saved_Interrupt_Freq,
 Saved_SampleRate,
 Saved_SampleBit,
 Saved_NumberOfChannels,
 Saved_BufLen_ms,
 Saved_NumberOfBuffers,
 Saved_WODevice:integer;
 Saved_ChipType:ChTypes;
 Saved_Optimization,
 Saved_Correct3xxxInterpretation,
 Saved_Detect3xxxInterpretation,
 Saved_VortexModuleHeader,
 Saved_DetectModuleHeader:boolean;
 Saved_IsFilt:boolean;
 Saved_Filt_M:integer;
 Saved_Prior:DWORD;
 i:integer;
begin
Form1.UpDown1.Position := NewTrack_NumberOfLines;
Form1.Edit2.Font := NewTrack_Font;
Form1.Edit2.Text := NewTrack_Font.Name;
Form1.ChipSel.ItemIndex := Ord(Emulating_Chip) - 1;
Saved_ChipType := Emulating_Chip;
Form1.ChanSel.ItemIndex := StdChannelsAllocation;
Saved_StdChannelsAllocation := StdChannelsAllocation;
Form1.ChanVisAlloc.ItemIndex := ChanAllocIndex;
Form1.Label8.Color := TrkClBk;
Form1.Label8.Font.Color := TrkClTxt;
Form1.Label11.Color := TrkClBk;
Form1.Label11.Font.Color := TrkClTxt;
Form1.Label12.Color := TrkClSelBk;
Form1.Label12.Font.Color := TrkClSelTxt;
Form1.Label13.Color := TrkClSelBk;
Form1.Label13.Font.Color := TrkClSelTxt;
Form1.Label14.Color := TrkClHlBk;
Form1.Label14.Font.Color := TrkClTxt;
Saved_ChanAllocIndex := ChanAllocIndex;
Saved_AY_Freq := AY_Freq;
case AY_Freq of
1773400:Form1.ChFreq.ItemIndex := 0;
1750000:Form1.ChFreq.ItemIndex := 1;
2000000:Form1.ChFreq.ItemIndex := 2;
1000000:Form1.ChFreq.ItemIndex := 3;
3500000:Form1.ChFreq.ItemIndex := 4;
else
 begin
  Form1.EdChipFrq.Text := IntToStr(AY_Freq);
  Form1.ChFreq.ItemIndex := 5;
 end;
end;
Saved_Interrupt_Freq := Interrupt_Freq;
case Interrupt_Freq of
50000:Form1.IntSel.ItemIndex := 0;
48828:Form1.IntSel.ItemIndex := 1;
60000:Form1.IntSel.ItemIndex := 2;
100000:Form1.IntSel.ItemIndex := 3;
200000:Form1.IntSel.ItemIndex := 4;
else
 begin
  Form1.EdIntFrq.Text := IntToStr(Interrupt_Freq);
  Form1.IntSel.ItemIndex := 5;
 end;
end;
Form1.Opt.ItemIndex := Ord(not Optimization_For_Quality);
Saved_Optimization := Optimization_For_Quality;
if Detect3xxxInterpretation then
 Form1.RadioGroup1.ItemIndex := 2
else if Correct3xxxInterpretation then
 Form1.RadioGroup1.ItemIndex := 0
else
 Form1.RadioGroup1.ItemIndex := 1;
Saved_Correct3xxxInterpretation := Correct3xxxInterpretation;
Saved_Detect3xxxInterpretation := Detect3xxxInterpretation;
if DetectModuleHeader then
 Form1.SaveHead.ItemIndex := 2
else if VortexModuleHeader then
 Form1.SaveHead.ItemIndex := 0
else
 Form1.SaveHead.ItemIndex := 1;
Saved_VortexModuleHeader := VortexModuleHeader;
Saved_DetectModuleHeader := DetectModuleHeader;
if SampleRate = 11025 then
 Form1.SR.ItemIndex := 0
else if SampleRate = 22050 then
 Form1.SR.ItemIndex := 1
else if SampleRate = 44100 then
 Form1.SR.ItemIndex := 2
else if SampleRate = 48000 then
 Form1.SR.ItemIndex := 3;
Saved_SampleRate := SampleRate;
Form1.BR.ItemIndex := Ord(SampleBit = 16);
Saved_SampleBit := SampleBit;
Form1.NCh.ItemIndex := Ord(NumberOfChannels = 2);
Saved_NumberOfChannels := NumberOfChannels;
Form1.TrackBar1.Position := BufLen_ms;
Saved_BufLen_ms := BufLen_ms;
Form1.TrackBar2.Position := NumberOfBuffers;
Saved_NumberOfBuffers := NumberOfBuffers;
if integer(WODevice) >= 0 then
 if not Form1.ComboBox1.Visible then Form1.Button4Click(Sender);
if Form1.ComboBox1.Visible then
 Form1.ComboBox1.ItemIndex := WODevice + 1;
Saved_WODevice := WODevice;
Saved_IsFilt := IsFilt;
Form1.FiltChk.Checked := IsFilt;
Form1.FiltersGroup.Visible := Optimization_For_Quality;
Saved_Filt_M := Filt_M;
Form1.FiltNK.Position := round(Ln(Filt_M) / Ln(2));
Saved_Prior := Priority;
Form1.PriorGrp.ItemIndex := Ord(Priority <> NORMAL_PRIORITY_CLASS);

if Form1.ShowModal = mrOk then
 begin
  NewTrack_NumberOfLines := Form1.UpDown1.Position;
  NewTrack_Font := Form1.Edit2.Font;
  TrkClBk := Form1.Label8.Color;
  TrkClTxt := Form1.Label11.Font.Color;;
  TrkClHlBk := Form1.Label14.Color;
  TrkClSelBk := Form1.Label12.Color;
  TrkClSelTxt := Form1.Label13.Font.Color;
  for i := 0 to MDIChildCount - 1 do
   TMDIChild(MDIChildren[i]).Tracks.RedrawTracks(0);
 end
else
 begin
  if Saved_ChanAllocIndex <> ChanAllocIndex then
   SetChannelsAllocationVis(Saved_ChanAllocIndex);
  SetEmulatingChip(Saved_ChipType);
  if Saved_AY_Freq <> AY_Freq then
   SetAYFreq(Saved_AY_Freq);
  if Saved_StdChannelsAllocation <> StdChannelsAllocation then
   ToggleChanAlloc.Caption :=  SetStdChannelsAllocation(Saved_StdChannelsAllocation);
  if Saved_Interrupt_Freq <> Interrupt_Freq then
   SetIntFreqEx(Saved_Interrupt_Freq);
  Set_Optimization(Saved_Optimization);
  Correct3xxxInterpretation := Saved_Correct3xxxInterpretation;
  Detect3xxxInterpretation := Saved_Detect3xxxInterpretation;
  VortexModuleHeader := Saved_VortexModuleHeader;
  DetectModuleHeader := Saved_DetectModuleHeader;
  if not WOThreadActive then
   begin
    if Saved_SampleRate <> SampleRate then
     SetSampleRate(Saved_SampleRate);
    if Saved_SampleBit <> SampleBit then
     SetBitRate(Saved_SampleBit);
    if Saved_NumberOfChannels <> NumberOfChannels then
     SetNChans(Saved_NumberOfChannels);
    if (Saved_BufLen_ms <> BufLen_ms) or
       (Saved_NumberOfBuffers <> NumberOfBuffers) then
     SetBuffers(Saved_BufLen_ms,Saved_NumberOfBuffers);
    WODevice := Saved_WODevice
   end;
  SetFilter(Saved_IsFilt,Saved_Filt_M);
  SetPriority(Saved_Prior)
 end
end;

procedure TMainForm.SavePT3(CW:TMDIChild;FileName:string;AsText:boolean);
var
 PT3:TSpeccyModule;
 Size:integer;
 f:file;
begin
if not AsText then
 begin
  if not VTM2PT3(@PT3,CW.VTMP,Size) then
   begin
    Application.MessageBox('Cannot compile module due 65536 size limit for PT3-modules. You can save it in text yet.',PAnsiChar(FileName));
    exit
   end;
  AssignFile(f,FileName);
  Rewrite(f,1);
  BlockWrite(f,PT3,Size);
  CloseFile(f)
 end
else
 VTM2TextFile(FileName,CW.VTMP);
CW.SavedAsText := AsText;
CW.SongChanged := False;
AddFileName(FileName)
end;

procedure TMainForm.FileSave1Execute(Sender: TObject);
begin
TMDIChild(ActiveMDIChild).SaveModule;
end;

procedure TMainForm.FileSaveAs1Execute(Sender: TObject);
begin
TMDIChild(ActiveMDIChild).SaveModuleAs;
end;

procedure TMainForm.FileSave1Update(Sender: TObject);
begin
FileSave1.Enabled := (MDIChildCount <> 0) and
                        TMDIChild(ActiveMDIChild).SongChanged
end;

procedure TMainForm.FileSaveAs1Update(Sender: TObject);
begin
FileSaveAs1.Enabled := MDIChildCount <> 0
end;

procedure TMainForm.SaveDialog1TypeChange(Sender: TObject);
var
 s:string;
begin
if SaveDialog1.FilterIndex = 1 then
 s := 'txt'
else
 s := 'pt3';
SaveDialog1.DefaultExt := s
end;

procedure TMainForm.Play1Update(Sender: TObject);
begin
Play1.Enabled := MDIChildCount <> 0
end;

procedure TMainForm.PlayFromPos1Update(Sender: TObject);
begin
PlayFromPos1.Enabled := MDIChildCount <> 0
end;

procedure TMainForm.PlayPatUpdate(Sender: TObject);
begin
PlayPat.Enabled := MDIChildCount <> 0
end;

procedure TMainForm.PlayPatFromLineUpdate(Sender: TObject);
begin
PlayPatFromLine.Enabled := MDIChildCount <> 0
end;

procedure TMainForm.Stop1Update(Sender: TObject);
begin
Stop1.Enabled := (MDIChildCount <> 0) and IsPlaying
end;

procedure TMainForm.Play1Execute(Sender: TObject);
var
 i:integer;
begin
if MDIChildCount = 0 then exit;
if TMDIChild(ActiveMDIChild).VTMP.Positions.Length <= 0 then exit;
if IsPlaying then
 begin
  StopPlaying;
  RestoreControls
 end;
PlayMode := PMPlayModule;
DisableControls;
CheckSecondWindow;
PlayingWindow[1].Tracks.RemoveSelection(0,False);
for i := 1 to NumberOfSoundChips do
 begin
  Module_SetPointer(PlayingWindow[i].VTMP,i);
  Module_SetDelay(PlayingWindow[i].VTMP.Initial_Delay);
  Module_SetCurrentPosition(0);
 end;
InitForAllTypes(True);
StartWOThread
end;

procedure TMainForm.PlayFromPos1Execute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
if TMDIChild(ActiveMDIChild).VTMP.Positions.Length <= 0 then exit;
if IsPlaying then
 begin
  StopPlaying;
  RestoreControls
 end;
PlayMode := PMPlayModule;
DisableControls;
CheckSecondWindow;
PlayingWindow[1].Tracks.RemoveSelection(0,False);
PlayingWindow[1].RerollToPos(PlayingWindow[1].PositionNumber);
StartWOThread
end;

procedure TMainForm.PlayPatExecute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
if IsPlaying then
 begin
  StopPlaying;
  RestoreControls
 end;
PlayMode := PMPlayPattern;
DisableControls;
PlayingWindow[1].ValidatePattern2(PlayingWindow[1].PatNum);
PlayingWindow[1].Tracks.RemoveSelection(0,False);
Module_SetPointer(PlayingWindow[1].VTMP,1);
Module_SetDelay(PlayingWindow[1].VTMP.Initial_Delay);
PlVars[1].CurrentPosition := 65535;
Module_SetCurrentPattern(PlayingWindow[1].PatNum);
InitForAllTypes(False);
StartWOThread
end;

procedure TMainForm.PlayPatFromLineExecute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
if IsPlaying then
 begin
  StopPlaying;
  RestoreControls
 end;
TMDIChild(ActiveMDIChild).ValidatePattern2(TMDIChild(ActiveMDIChild).PatNum);
TMDIChild(ActiveMDIChild).RestartPlayingPatternLine(False)
end;

procedure TMainForm.Stop1Execute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
StopPlaying;
RestoreControls;
PlayingWindow[1].Tracks.RemoveSelection(0,True);
if (TMDIChild(ActiveMDIChild) = PlayingWindow[1]) and
   (PlayingWindow[1].PageControl1.ActivePageIndex = 0) then
 PlayingWindow[1].Tracks.SetFocus
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
StopPlaying;
SaveOptions
end;

procedure TMainForm.SetLoopPosExecute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
with TMDIChild(ActiveMDIChild) do
 begin
  if (StringGrid1.Selection.Left < VTMP.Positions.Length) and
     (StringGrid1.Selection.Left <> VTMP.Positions.Loop) then
   SetLoopPos(StringGrid1.Selection.Left);
  InputPNumber := 0
 end
end;

procedure TMainForm.SetLoopPosUpdate(Sender: TObject);
begin
SetLoopPos.Enabled := (MDIChildCount <> 0) and
                      TMDIChild(ActiveMDIChild).StringGrid1.Focused and
                      (TMDIChild(ActiveMDIChild).VTMP.Positions.Length >
                       TMDIChild(ActiveMDIChild).StringGrid1.Selection.Left)
end;

procedure TMainForm.InsertPositionExecute(Sender: TObject);
var
 i:integer;
 s:string;
begin
if MDIChildCount = 0 then exit;
if IsPlaying and (PlayMode = PMPlayModule) then exit;
with TMDIChild(ActiveMDIChild) do
 begin
 if (StringGrid1.Selection.Left < VTMP.Positions.Length) and
    (VTMP.Positions.Length < 256) then
  begin
   SongChanged := True;
   AddUndo(CAInsertPosition,0,0);
   ChangeList[ChangeCount - 1].CurrentPosition := StringGrid1.Selection.Left;
   New(ChangeList[ChangeCount - 1].PositionList);
   ChangeList[ChangeCount - 1].PositionList^ := VTMP.Positions;
   i := VTMP.Positions.Length - StringGrid1.Selection.Left;
   Inc(VTMP.Positions.Length);
   if StringGrid1.Selection.Left <= VTMP.Positions.Loop then
    Inc(VTMP.Positions.Loop);
   for i := StringGrid1.Selection.Left + i - 1 downto
                                StringGrid1.Selection.Left do
    VTMP.Positions.Value[i + 1] := VTMP.Positions.Value[i];
   for i := StringGrid1.Selection.Left to VTMP.Positions.Length - 1 do
    begin
     s := IntToStr(VTMP.Positions.Value[i]);
     if i = VTMP.Positions.Loop then
      s := 'L' + s;
     StringGrid1.Cells[i,0] := s
    end;
   CalcTotLen 
  end;
 InputPNumber := 0
 end
end;

procedure TMainForm.InsertPositionUpdate(Sender: TObject);
begin
InsertPosition.Enabled := (MDIChildCount <> 0) and
                      not (IsPlaying and (PlayMode = PMPlayModule)) and
                      TMDIChild(ActiveMDIChild).StringGrid1.Focused and
                      (TMDIChild(ActiveMDIChild).VTMP.Positions.Length >
                       TMDIChild(ActiveMDIChild).StringGrid1.Selection.Left)
end;

procedure TMainForm.DeletePositionExecute(Sender: TObject);
var
 i:integer;
 s:string;
 sel:TGridRect;
begin
if MDIChildCount = 0 then exit;
if IsPlaying and (PlayMode = PMPlayModule) then exit;
with TMDIChild(ActiveMDIChild) do
 begin
 if StringGrid1.Selection.Left < VTMP.Positions.Length then
  begin
   SongChanged := True;
   AddUndo(CADeletePosition,0,0);
   ChangeList[ChangeCount - 1].CurrentPosition := StringGrid1.Selection.Left;
   New(ChangeList[ChangeCount - 1].PositionList);
   ChangeList[ChangeCount - 1].PositionList^ := VTMP.Positions;
   i := VTMP.Positions.Length - StringGrid1.Selection.Left - 1;
   Dec(VTMP.Positions.Length);
   if StringGrid1.Selection.Left < VTMP.Positions.Loop then
    Dec(VTMP.Positions.Loop);
   if i > 0 then
    begin
     for i := StringGrid1.Selection.Left to
                                StringGrid1.Selection.Left + i - 1 do
      VTMP.Positions.Value[i] := VTMP.Positions.Value[i + 1];
     for i := StringGrid1.Selection.Left to VTMP.Positions.Length - 1 do
      begin
       s := IntToStr(VTMP.Positions.Value[i]);
       if i = VTMP.Positions.Loop then
        s := 'L' + s;
       StringGrid1.Cells[i,0] := s
      end
    end
   else
    begin
     if (VTMP.Positions.Loop > 0) and
           (VTMP.Positions.Length = VTMP.Positions.Loop) then
      begin
       Dec(VTMP.Positions.Loop);
       StringGrid1.Cells[VTMP.Positions.Loop,0] := 'L' +
                          IntToStr(VTMP.Positions.Value[VTMP.Positions.Loop])
      end;
     if StringGrid1.Selection.Left > 0 then
      begin
       sel := StringGrid1.Selection;
       Dec(sel.Left);
       Dec(sel.Right);
       StringGrid1.Selection := Sel;
       SelectPosition(sel.Left)
      end
    end;
   CalcTotLen;
   if VTMP.Positions.Length < 256 then
    StringGrid1.Cells[VTMP.Positions.Length,0] := '...'
  end;
 InputPNumber := 0
 end
end;

procedure TMainForm.DeletePositionUpdate(Sender: TObject);
begin
DeletePosition.Enabled := (MDIChildCount <> 0) and
                      not (IsPlaying and (PlayMode = PMPlayModule)) and
                      TMDIChild(ActiveMDIChild).StringGrid1.Focused and
                      (TMDIChild(ActiveMDIChild).VTMP.Positions.Length >
                       TMDIChild(ActiveMDIChild).StringGrid1.Selection.Left)
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
CloseHandle(ResetMutex)
end;

procedure TMainForm.ToggleLoopingExecute(Sender: TObject);
begin
LoopAllowed := not LoopAllowed;
if LoopAllowed then
 begin
  LoopAllAllowed := False;
  ToggleLoopingAll.Checked := False
 end;
ToggleLooping.Checked := LoopAllowed
end;

procedure TMainForm.ToggleLoopingAllExecute(Sender: TObject);
begin
LoopAllAllowed := not LoopAllAllowed;
if LoopAllAllowed then
 begin
  LoopAllowed := False;
  ToggleLooping.Checked := False
 end;
ToggleLoopingAll.Checked := LoopAllAllowed
end;

procedure TMainForm.AddFileName;
var
 i,j:integer;
 FN1:string;
begin
FN1 := AnsiUpperCase(FN);
for i := 0 to 4 do
 if AnsiUpperCase(RecentFiles[i]) = FN1 then
  begin
   for j := i to 4 do
    RecentFiles[j] := RecentFiles[j + 1];
   break
  end;
for i := 4 downto 0 do
 RecentFiles[i + 1] := RecentFiles[i];
RecentFiles[0] := FN;
j := MainMenu1.Items[0].IndexOf(RFile1);
for i :=  0 to 5 do
 if RecentFiles[i] <> '' then
  begin
   MainMenu1.Items[0].Items[j + i].Caption := IntToStr(i + 1) + ' ' +
                                                        RecentFiles[i];
   MainMenu1.Items[0].Items[j + i].Visible := True
  end
 else
  MainMenu1.Items[0].Items[j + i].Visible := False;
MainMenu1.Items[0].Items[j + 6].Visible := MainMenu1.Items[0].Items[j].Visible
end;

procedure TMainForm.OpenRecent;
begin
if (RecentFiles[n] <> '') and FileExists(RecentFiles[n]) then
 begin
  OpenDialog.InitialDir := ExtractFilePath(RecentFiles[n]);
  OpenDialog.FileName := RecentFiles[n];
  CreateMDIChild(RecentFiles[n])
 end
end;

procedure TMainForm.RFile1Click(Sender: TObject);
begin
OpenRecent(0)
end;

procedure TMainForm.RFile2Click(Sender: TObject);
begin
OpenRecent(1)
end;

procedure TMainForm.RFile3Click(Sender: TObject);
begin
OpenRecent(2)
end;

procedure TMainForm.RFile4Click(Sender: TObject);
begin
OpenRecent(3)
end;

procedure TMainForm.RFile5Click(Sender: TObject);
begin
OpenRecent(4)
end;

procedure TMainForm.RFile6Click(Sender: TObject);
begin
OpenRecent(5)
end;

procedure TMainForm.umplayingoff;
begin
RestoreControls
end;

procedure TMainForm.umfinalizewo;
begin
WOThreadFinalization;
RestoreControls;
if LoopAllAllowed and (MDIChildCount > 1) then
 begin
  Next;
  Play1Execute(nil)
 end
end;

procedure TMainForm.ToggleChipExecute(Sender: TObject);
begin
if Emulating_Chip = AY_Chip then
 begin
  Emulating_Chip := YM_Chip;
  ToggleChip.Caption := 'YM'
 end
else
 begin
  Emulating_Chip := AY_Chip;
  ToggleChip.Caption := 'AY'
 end;
if StdChannelsAllocation in [0..6] then
 SetStdChannelsAllocation(StdChannelsAllocation)
else
 Calculate_Level_Tables;
if IsPlaying then PlayingWindow[1].StopAndRestart
end;

procedure TMainForm.ToggleChanAllocExecute(Sender: TObject);
var
 CA:integer;
begin
ToggleChanAlloc.Caption := ToggleChanMode;
CA := StdChannelsAllocation;
if CA > 0 then Dec(CA);
SetChannelsAllocationVis(CA);
if IsPlaying then PlayingWindow[1].StopAndRestart
end;

procedure TMainForm.SetChannelsAllocationVis;
var
 i,c,p,n:integer;
 PrevAlloc:array[0..2]of integer;
begin
Move(ChanAlloc,PrevAlloc,SizeOf(PrevAlloc));
ChanAllocIndex := CA;
case CA of
0:begin ChanAlloc[0] := 0; ChanAlloc[1] := 1; ChanAlloc[2] := 2 end;
1:begin ChanAlloc[0] := 0; ChanAlloc[1] := 2; ChanAlloc[2] := 1 end;
2:begin ChanAlloc[0] := 1; ChanAlloc[1] := 0; ChanAlloc[2] := 2 end;
3:begin ChanAlloc[0] := 1; ChanAlloc[1] := 2; ChanAlloc[2] := 0 end;
4:begin ChanAlloc[0] := 2; ChanAlloc[1] := 0; ChanAlloc[2] := 1 end;
5:begin ChanAlloc[0] := 2; ChanAlloc[1] := 1; ChanAlloc[2] := 0 end
end;
for i := 0 to MDIChildCount - 1 do
 with TMDIChild(MDIChildren[i]) do
 begin
  c := (Tracks.CursorX - 8) div 14;
  if c >= 0 then
   begin
    p := PrevAlloc[c];
    n := 0;
    while (n < 2) and (ChanAlloc[n] <> p) do Inc(n);
    Inc(Tracks.CursorX,(n - c) * 14)
   end;
  ResetChanAlloc
 end
end;

procedure TMainForm.DisableControls;
begin
Form1.PlayStarts;
NumberOfSoundChips := 1;
PlayingWindow[1] := TMDIChild(ActiveMDIChild);
PlayingWindow[1].Edit2.Enabled := False;
PlayingWindow[1].UpDown1.Enabled := False;
PlayingWindow[1].Tracks.Enabled := False;
end;

procedure TMainForm.CheckSecondWindow;
begin
if ComboBox1.ItemIndex > 0 then
 begin
  PlayingWindow[2] := TMDIChild(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
  if PlayingWindow[1] <> PlayingWindow[2] then
   NumberOfSoundChips := 2
 end;
ComboBox1.Enabled := False;
end;

procedure TMainForm.RestoreControls;
begin
Form1.PlayStops;
PlayingWindow[1].Edit2.Enabled := True;
PlayingWindow[1].UpDown1.Enabled := True;
if PlayMode in [PMPlayModule,PMPlayPattern] then
 PlayingWindow[1].Tracks.CursorY := PlayingWindow[1].Tracks.N1OfLines;
PlayingWindow[1].Tracks.Enabled := True;
ComboBox1.Enabled := True;
end;

procedure TMainForm.SetIntFreqEx;
var
 i:integer;
begin
SetIntFreq(f);
for i := 0 to MDIChildCount - 1 do
 with TMDIChild(MDIChildren[i]) do
  ReCalcTimes
end;

procedure TMainForm.SetSampleTemplate;
var
 i:integer;
begin
if CurrentSampleLineTemplate = Tmp then exit;
CurrentSampleLineTemplate := Tmp;
for i := 0 to MDIChildCount - 1 do
 with TMDIChild(MDIChildren[i]) do
  begin
   ListBox1.ItemIndex := Tmp;
   with Samples do
    begin
     if Focused then
      HideCaret(Handle);
     RedrawSamples(0);
     if Focused then
      ShowCaret(Handle)
    end
  end
end;

procedure TMainForm.AddToSampTemplate;
var
 i,l:integer;
begin
l := Length(SampleLineTemplates);
for i := 0 to l - 1 do
 with SampleLineTemplates[i] do
  if (SamTik.Add_to_Ton = Add_to_Ton) and
     (SamTik.Ton_Accumulation = Ton_Accumulation) and
     (SamTik.Amplitude = Amplitude) and
     (SamTik.Envelope_Enabled = Envelope_Enabled) and
     (SamTik.Envelope_or_Noise_Accumulation = Envelope_or_Noise_Accumulation) and
     (SamTik.Add_to_Envelope_or_Noise = Add_to_Envelope_or_Noise) and
     (SamTik.Mixer_Ton = Mixer_Ton) and
     (SamTik.Mixer_Noise = Mixer_Noise) and
     ((not SamTik.Amplitude_Sliding and not Amplitude_Sliding) or
      ((SamTik.Amplitude_Sliding and Amplitude_Sliding) and
       (SamTik.Amplitude_Slide_Up = Amplitude_Slide_Up)
      )
     ) then exit;
SetLength(SampleLineTemplates,l + 1);
SampleLineTemplates[l] := SamTik;
for i := 0 to MDIChildCount - 1 do
 with TMDIChild(MDIChildren[i]) do
  ListBox1.Items.Add(GetSampleString(SamTik,False,True))
end;

procedure TMainForm.ResetSampTemplate;
var
 i:integer;
begin
SetLength(SampleLineTemplates,2);
SampleLineTemplates[0] := EmptySampleTick;
SampleLineTemplates[1] := EmptySampleTick;
SampleLineTemplates[1].Mixer_Ton := True;
SampleLineTemplates[1].Envelope_Enabled := True;
for i := 0 to MDIChildCount - 1 do
 with TMDIChild(MDIChildren[i]) do
  begin
   ListBox1.Clear;
   ListBox1.Items.Add(GetSampleString(EmptySampleTick,False,True));
   ListBox1.Items.Add(GetSampleString(SampleLineTemplates[1],False,True));
  end;
CurrentSampleLineTemplate := -1;
SetSampleTemplate(0)
end;

procedure TMainForm.Tracksmanager1Click(Sender: TObject);
begin
TrMng.ShowModal
end;

procedure TMainForm.Globaltransposition1Click(Sender: TObject);
begin
GlbTrans.ShowModal
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
GlobalVolume := TrackBar1.Position;
Calculate_Level_Tables
end;

procedure TMainForm.SetEmulatingChip;
begin
if Emulating_Chip <> ChType then
 begin
  Emulating_Chip := ChType;
  if Emulating_Chip = AY_Chip then
   ToggleChip.Caption := 'AY'
  else
   ToggleChip.Caption := 'YM';
  Calculate_Level_Tables
 end
end;

procedure TMainForm.SaveOptions;
var
 i:integer;
 MyRegPath:string;
 CreateStatus:longword;
 subKeyHnd1:HKey;

 procedure SaveDW(Nm:PChar; const Vl:integer);
 begin
 CheckRegError(RegSetValueEx(subKeyHnd1,Nm,0,REG_DWORD,@Vl,4))
 end;

 procedure SaveStr(Nm:PChar; const Vl:string);
 begin
 CheckRegError(RegSetValueEx(subKeyHnd1,Nm,0,REG_SZ,PChar(Vl),Length(Vl) + 1))
 end;

begin
SetPriority(0);
MyRegPath := MyRegPath1 + '\' + MyRegPath2 + '\' + MyRegPath3 + #0;
i := 0;
i := RegCreateKeyEx(HKEY_LOCAL_MACHINE,PChar(MyRegPath),0,@i,
     REG_OPTION_NON_VOLATILE,KEY_ALL_ACCESS,nil,subKeyHnd1,@CreateStatus);
CheckRegError(i);
try
 SaveDW('Priority',Priority);
 SaveDW('ChanAllocIndex',ChanAllocIndex);
 SaveDW('AY_Freq',AY_Freq);
 SaveDW('StdChannelsAllocation',StdChannelsAllocation);
 SaveDW('Interrupt_Freq',Interrupt_Freq);
 SaveDW('SampleRate',SampleRate);
 SaveDW('SampleBit',SampleBit);
 SaveDW('NumberOfChannels',NumberOfChannels);
 SaveDW('BufLen_ms',BufLen_ms);
 SaveDW('NumberOfBuffers',NumberOfBuffers);
 SaveDW('WODevice',WODevice);
 SaveDW('ChipType',Ord(Emulating_Chip));
 SaveDW('Optimization',Ord(Optimization_For_Quality));
 SaveDW('Correct3xxxInterpretation',Ord(Correct3xxxInterpretation));
 SaveDW('Detect3xxxInterpretation',Ord(Detect3xxxInterpretation));
 SaveDW('VortexModuleHeader',Ord(VortexModuleHeader));
 SaveDW('DetectModuleHeader',Ord(DetectModuleHeader));
 for i := 0 to 5 do
  SaveStr(PChar('Recent' + IntToStr(i)),RecentFiles[i]);
 i := 0;
 if LoopAllowed then
  i := 1
 else if LoopAllAllowed then
  i := 2;
 SaveDW('LoopMode',i);
 SaveDW('GlobalVolume',GlobalVolume);
 SaveDW('NewTrack_NumberOfLines',NewTrack_NumberOfLines);
 SaveStr('NewTrack_FontName',NewTrack_Font.Name);
 SaveDW('NewTrack_FontSize',NewTrack_Font.Size);
 SaveDW('NewTrack_FontBold',Ord(fsBold in NewTrack_Font.Style));
 SaveDW('NewTrack_FontItalic',Ord(fsItalic in NewTrack_Font.Style));
 SaveDW('NewTrack_FontUnderline',Ord(fsUnderline in NewTrack_Font.Style));
 SaveDW('NewTrack_FontStrikeOut',Ord(fsStrikeOut in NewTrack_Font.Style));
 SaveDW('WindowMaximized',Ord(WindowState = wsMaximized));
 SaveDW('Filtering',Ord(IsFilt));
 SaveDW('FilterQ',Filt_M);
 SaveDW('TrkClBk',TrkClBk);
 SaveDW('TrkClTxt',TrkClTxt);
 SaveDW('TrkClHlBk',TrkClHlBk);
 SaveDW('TrkClSelBk',TrkClSelBk);
 SaveDW('TrkClSelTxt',TrkClSelTxt);
finally
 RegCloseKey(subKeyHnd1)
end
end;

procedure TMainForm.LoadOptions;
var
 MyRegPath,s:string;
 i,v:integer;
 subKeyHnd1:HKey;

 function GetDW(Nm:PChar; var Vl:integer):boolean;
 var
  i:integer;
 begin
 i := 4;
 Result := RegQueryValueEx(subKeyHnd1,Nm,nil,nil,@Vl,@i) = ERROR_SUCCESS
 end;

 function GetStr(Nm:PChar; var Vl:string):boolean;
 var
  i:integer;
 begin
 Result := RegQueryValueEx(subKeyHnd1,Nm,nil,nil,nil,@i) = ERROR_SUCCESS;
 if Result then
  begin
   SetLength(Vl,i + 1);
   Result := RegQueryValueEx(subKeyHnd1,Nm,nil,nil,@Vl[1],@i) = ERROR_SUCCESS;
   if Result then
    Vl := PChar(Vl)
  end;
 end;

begin
if (integer(GetVersion) < 0) then //Win9x or Win32s
 SetPriority(HIGH_PRIORITY_CLASS);
MyRegPath := MyRegPath1 + '\' + MyRegPath2 + '\' + MyRegPath3 + #0;
if RegOpenKeyEx(HKEY_LOCAL_MACHINE,PChar(MyRegPath),0,
   KEY_EXECUTE,subKeyHnd1) = ERROR_SUCCESS then
 begin
  if GetDW('Priority',v) then SetPriority(v);
  if GetDW('ChanAllocIndex',v) then
   if v <> ChanAllocIndex then
    SetChannelsAllocationVis(v);
  if GetDW('AY_Freq',v) then
   if v <> AY_Freq then
    SetAYFreq(v);
  if GetDW('StdChannelsAllocation',v) then
   if v <> StdChannelsAllocation then
    ToggleChanAlloc.Caption :=  SetStdChannelsAllocation(v);
  if GetDW('Interrupt_Freq',v) then
   if v <> Interrupt_Freq then
    SetIntFreqEx(v);
  if GetDW('ChipType',v) then
   if v in [1,2] then
    SetEmulatingChip(ChTypes(v));
  if GetDW('Optimization',v) then
   Set_Optimization(v <> 0);
  if GetDW('Correct3xxxInterpretation',v) then
   Correct3xxxInterpretation := v <> 0;
  if GetDW('Detect3xxxInterpretation',v) then
   Detect3xxxInterpretation := v <> 0;
  if GetDW('VortexModuleHeader',v) then
   VortexModuleHeader := v <> 0;
  if GetDW('DetectModuleHeader',v) then
   DetectModuleHeader := v <> 0;
  if GetDW('SampleRate',v) then
   if v <> SampleRate then
    SetSampleRate(v);
  if GetDW('SampleBit',v) then
   if v <> SampleBit then
    SetBitRate(v);
  if GetDW('NumberOfChannels',v) then
   if v <> NumberOfChannels then
    SetNChans(v);
  if GetDW('BufLen_ms',v) then
   if (v <> BufLen_ms) then
    SetBuffers(v,NumberOfBuffers);
  if GetDW('NumberOfBuffers',v) then
   if (v <> NumberOfBuffers) then
    SetBuffers(BufLen_ms,v);
  if GetDW('WODevice',v) then
   WODevice := v;
  for i := 5 downto 0 do
   if GetStr(PChar('Recent' + IntToStr(i)),s) then
    AddFileName(s);
  if GetDW('LoopMode',v) then
   case v of
   1:ToggleLooping.Execute;
   2:ToggleLoopingAll.Execute
   end;
  if GetDW('GlobalVolume',v) then
   TrackBar1.Position := v;
  if GetDW('NewTrack_NumberOfLines',v) then
   NewTrack_NumberOfLines := v;
  if GetStr('NewTrack_FontName',s) then
   NewTrack_Font.Name := s;
  if GetDW('NewTrack_FontSize',v) then
   NewTrack_Font.Size := v;
  if GetDW('NewTrack_FontBold',v) then
   if v = 0 then
    NewTrack_Font.Style := NewTrack_Font.Style - [fsBold]
   else
    NewTrack_Font.Style := NewTrack_Font.Style + [fsBold];
  if GetDW('NewTrack_FontItalic',v) then
   if v = 0 then
    NewTrack_Font.Style := NewTrack_Font.Style - [fsItalic]
   else
    NewTrack_Font.Style := NewTrack_Font.Style + [fsItalic];
  if GetDW('NewTrack_FontUnderline',v) then
   if v = 0 then
    NewTrack_Font.Style := NewTrack_Font.Style - [fsUnderline]
   else
    NewTrack_Font.Style := NewTrack_Font.Style + [fsUnderline];
  if GetDW('NewTrack_FontStrikeOut',v) then
   if v = 0 then
    NewTrack_Font.Style := NewTrack_Font.Style - [fsStrikeOut]
   else
    NewTrack_Font.Style := NewTrack_Font.Style + [fsStrikeOut];
  if GetDW('WindowMaximized',v) then
   if v <> 0 then
    WindowState := wsMaximized;
  if GetDW('Filtering',v) then
   SetFilter(v <> 0,Filt_M);
  if GetDW('FilterQ',v) then
   SetFilter(IsFilt,v);
  if GetDW('TrkClBk',v) then
   TrkClBk := v;
  if GetDW('TrkClTxt',v) then
   TrkClTxt := v;
  if GetDW('TrkClHlBk',v) then
   TrkClHlBk := v;
  if GetDW('TrkClSelBk',v) then
   TrkClSelBk := v;
  if GetDW('TrkClSelTxt',v) then
   TrkClSelTxt := v;
  RegCloseKey(subKeyHnd1)
 end
end;

procedure TMainForm.SaveSNDHMenuClick(Sender: TObject);
const
 TITL:array[0..3]of char = 'TITL';
 COMM:array[0..3]of char = 'COMM';
 CONV:array[0..3]of char = 'CONV';
 YEAR:array[0..3]of char = 'YEAR';
 TIME:array[0..3]of char = 'TIME';
var
 sndhplsz,sndhhdrsz:integer;
 PT3:TSpeccyModule;
 Size,i,j:integer;
 f:file;
 p:wordptr;
 CurrentWindow:TMDIChild;
 s:string;
begin
if MDIChildCount = 0 then exit;
CurrentWindow := TMDIChild(ActiveMDIChild);
if SaveDialogSNDH.InitialDir = '' then
 SaveDialogSNDH.InitialDir := OpenDialog.InitialDir;

if CurrentWindow.WinFileName = '' then
 MainForm.SaveDialogSNDH.FileName := 'VTIIModule' + IntToStr(CurrentWindow.WinNumber)
else
 MainForm.SaveDialogSNDH.FileName := ChangeFileExt(CurrentWindow.WinFileName,'');

repeat
 if not SaveDialogSNDH.Execute then exit;
 s := LowerCase(ExtractFileExt(SaveDialogSNDH.FileName));
 if s = '.snd' then
  SaveDialogSNDH.FileName := SaveDialogSNDH.FileName + 'h'
 else if s <> '.sndh' then
  SaveDialogSNDH.FileName := SaveDialogSNDH.FileName + '.sndh'
until AllowSave(SaveDialogSNDH.FileName);

SaveDialogSNDH.InitialDir := ExtractFileDir(SaveDialogSNDH.FileName);
i := FindResource(HInstance,'SNDHPLAYER','SNDH');
sndhplsz := SizeofResource(HInstance,i);
p := LockResource(LoadResource(HInstance,i));
if not VTM2PT3(@PT3,CurrentWindow.VTMP,Size) then
 begin
  Application.MessageBox('Cannot compile module due 65536 size limit for PT3-modules. You can save it in text yet.',PAnsiChar(SaveDialogSNDH.FileName));
  exit
 end;
AssignFile(f,SaveDialogSNDH.FileName);
Rewrite(f,1);
BlockWrite(f,p^,16);
sndhhdrsz := 10;
with CurrentWindow do
 begin
  i := Length(VTMP.Title);
  if i <> 0 then
   begin
    inc(sndhhdrsz,4 + i + 1);
    BlockWrite(f,TITL,4);
    BlockWrite(f,VTMP.Title[1],i + 1)
   end;
  i := Length(VTMP.Author);
  if i <> 0 then
   begin
    inc(sndhhdrsz,4 + i + 1);
    BlockWrite(f,COMM,4);
    BlockWrite(f,VTMP.Author[1],i + 1)
   end;
  BlockWrite(f,CONV,4);
  i := Length(FullVersString) + 1; inc(sndhhdrsz,i);
  BlockWrite(f,FullVersString[1],i);
  s := '';
  if InputQuery('SNDHv2 Extra TAG','Year of release (empty if no):',s) then
   begin
    s := Trim(s);
    i := Length(s);
    if i <> 0 then
     begin
      inc(sndhhdrsz,i + 5);
      BlockWrite(f,YEAR,4);
      BlockWrite(f,s[1],i + 1);
     end;
   end;
  j := round(Interrupt_Freq / 1000);
  s := 'TC' + IntToStr(j);
  i := Length(s) + 1; inc(sndhhdrsz,i);
  BlockWrite(f,s[1],i);
  BlockWrite(f,TIME,4);
  i := round(TotInts / j); if i > 65535 then i := 65535;
  i := IntelWord(i);
  BlockWrite(f,i,2);
  if (sndhhdrsz and 1) <> 0 then
   begin
    inc(sndhhdrsz);
    i := 0; BlockWrite(f,i,1);
   end;
  BlockWrite(f,pointer(integer(p) + 16)^,sndhplsz - 16);
  BlockWrite(f,PT3,Size);
 end;
dec(integer(p),2);
for j := 0 to 2 do
 begin
  inc(integer(p),4);
  i := IntelWord(IntelWord(p^) + sndhhdrsz);
  seek(f,2 + j*4); BlockWrite(f,i,2);
 end;
CloseFile(f)
end;

procedure TMainForm.SaveforZXMenuClick(Sender: TObject);
var
 s:string;
 PT3:TSpeccyModule;
 i,t,j,k:integer;
 f:file;
 p:WordPtr;
 pl:array of byte;
 hobetahdr:packed record
  case Boolean of
  False:
   (Name:array[0..7] of char;Typ:char;
    Start,Leng,SectLeng,CheckSum:word);
  True:
   (Ind:array[0..16] of byte);
 end;
 SCLHdr:packed record
  case Boolean of
  False:
   (SCL:array[0..7] of char;
    NBlk:byte;
    Name1:array[0..7] of char;Typ1:char;Start1,Leng1:word;Sect1:byte;
    Name2:array[0..7] of char;Typ2:char;Start2,Leng2:word;Sect2:byte;);
  True:
   (Ind:array[0..36] of byte);
  end;
 TAPHdr:packed record
  case Boolean of
  False:
   (Sz:word;Flag,Typ:byte;
    Name:array[0..9] of char;Leng,Start,Trash:word;Sum:byte);
  True:
   (Ind:array[0..20] of byte);
  end;
 AYFileHeader:TAYFileHeader;
 SongStructure:TSongStructure;
 AYSongData:TSongData;
 AYPoints:TPoints;
 CurrentWindow:TMDIChild;
begin
if MDIChildCount = 0 then exit;
CurrentWindow := TMDIChild(ActiveMDIChild);
if not VTM2PT3(@PT3,CurrentWindow.VTMP,ZXModSize) then
 begin
  Application.MessageBox('Cannot compile module due 65536 size limit for PT3-modules. You can save it in text yet.',PAnsiChar(CurrentWindow.Caption));
  exit
 end;
i := FindResource(HInstance,'ZXAYPLAYER','ZXAY');
p := LockResource(LoadResource(HInstance,i));
Move(p^,zxplsz,2);
Inc(integer(p),2);
Move(p^,zxdtsz,2);
if ExpDlg.ShowModal <> mrOK then exit;
if SaveDialogZXAY.InitialDir = '' then
 SaveDialogZXAY.InitialDir := OpenDialog.InitialDir;
SaveDialogZXAY.FilterIndex := ExpDlg.RadioGroup1.ItemIndex + 1;
SetDialogZXAYExt;

if CurrentWindow.WinFileName = '' then
 MainForm.SaveDialogZXAY.FileName := 'VTIIModule' + IntToStr(CurrentWindow.WinNumber)
else
 MainForm.SaveDialogZXAY.FileName := ChangeFileExt(CurrentWindow.WinFileName,'');

repeat
 if not SaveDialogZXAY.Execute then exit;
 i := SaveDialogZXAY.FilterIndex - 1;
 if not (i in [0..4]) then i := ExpDlg.RadioGroup1.ItemIndex;
 case i of
 0:ChangeFileExt(SaveDialogZXAY.FileName,'$c');
 1:ChangeFileExt(SaveDialogZXAY.FileName,'$m');
 2:ChangeFileExt(SaveDialogZXAY.FileName,'ay');
 3:ChangeFileExt(SaveDialogZXAY.FileName,'scl');
 4:ChangeFileExt(SaveDialogZXAY.FileName,'tap')
 end;
until AllowSave(SaveDialogZXAY.FileName);

SaveDialogZXAY.InitialDir := ExtractFileDir(SaveDialogZXAY.FileName);
if SaveDialogZXAY.FilterIndex in [1..5] then
 ExpDlg.RadioGroup1.ItemIndex := SaveDialogZXAY.FilterIndex - 1;
t := ExpDlg.RadioGroup1.ItemIndex;
if t <> 1 then
 begin
  if ZXModSize + zxplsz + zxdtsz > 65536 then
   begin
    Application.MessageBox('Size of module with player exceeds 65536 RAM size.','Cannot export');
    exit
   end;
  Inc(integer(p),2);
  SetLength(pl,zxplsz);
  Move(p^,pl[0],zxplsz);
  Inc(integer(p),zxplsz);
  while p^ < zxplsz - 1 do
   begin
    Inc(WordPtr(@pl[p^])^,ZXCompAddr);
    Inc(integer(p),2)
   end;
  Inc(integer(p),2);
  while p^ < zxplsz do
   begin
    Inc(BytePtr(@pl[p^])^,ZXCompAddr);
    Inc(integer(p),2)
   end;
  Inc(integer(p),2);
  while p^ < zxplsz do
   begin
    Inc(BytePtr(@pl[p^])^,ZXCompAddr shr 8);
    Inc(integer(p),2)
   end;
  if ExpDlg.LoopChk.Checked then pl[10] := 1
 end;
AssignFile(f,SaveDialogZXAY.FileName);
Rewrite(f,1);
try
i := ZXModSize;
if t = 0 then inc(i,zxplsz + zxdtsz);
case t of
0,1:
 begin
  with hobetahdr do
   begin
    Name := '        ';
    s := ExtractFileName(SaveDialogZXAY.FileName);
    j := Length(s) - 3;
    if j > 8 then j := 8;
    if j > 0 then Move(s[1],Name,j);
    if t = 0 then
     Typ := 'C'
    else
     Typ := 'm';
    Start := ZXCompAddr;
    Leng := i;
    SectLeng := i and $FF00;
    if i and 255 <> 0 then Inc(SectLeng,$100);
    if SectLeng = 0 then
     begin
      Application.MessageBox('Size of hobeta file exceeds 255 sectors.','Cannot export');
      exit
     end;
    k := 0;
    for j := 0 to 14 do
     Inc(k,Ind[j]);
    CheckSum := k * 257 + 105
   end;
  BlockWrite(f,hobetahdr,sizeof(hobetahdr))
 end;
2:
 begin
  with AYFileHeader do
   begin
    FileID := $5941585A;
    TypeID := $4C554D45;
    FileVersion := 0;
    PlayerVersion := 0;
    PSpecialPlayer := 0;
    j := 8 + SizeOf(TSongStructure) + SizeOf(TSongData) + SizeOf(TPoints) +
         Length(CurrentWindow.VTMP.Title) + 1;
    PAuthor := IntelWord(j);
    inc(j,Length(CurrentWindow.VTMP.Author) + 1 - 2);
    PMisc := IntelWord(j);
    NumOfSongs := 0;
    FirstSong := 0;
    PSongsStructure := $200
   end;
  BlockWrite(f,AYFileHeader,SizeOf(TAYFileHeader));
  with SongStructure do
   begin
    PSongName := IntelWord(4 + SizeOf(TSongData) + SizeOf(TPoints));
    PSongData := $200
   end;
  BlockWrite(f,SongStructure,SizeOf(TSongStructure));
  with AYSongData do
   begin
    ChanA := 0;
    ChanB := 1;
    ChanC := 2;
    Noise := 3;
    if CurrentWindow.TotInts > 65535 then
     SongLength := 65535
    else
     SongLength := IntelWord(CurrentWindow.TotInts);
    FadeLength := 0;
    HiReg := 0;
    LoReg := 0;
    PPoints := $400;
    PAddresses := $800
   end;
  BlockWrite(f,AYSongData,SizeOf(TSongData));
  with AYPoints do
   begin
    Stek := IntelWord(ZXCompAddr);
    Init := IntelWord(ZXCompAddr);
    Inter := IntelWord(ZXCompAddr + 5);
    Adr1 := IntelWord(ZXCompAddr);
    Len1 := IntelWord(zxplsz);
    j := 10 + Length(CurrentWindow.VTMP.Title) +
                      Length(CurrentWindow.VTMP.Author) +
                      Length(FullVersString) + 3;
    Offs1 := IntelWord(j);
    Adr2 := IntelWord(ZXCompAddr + zxplsz + zxdtsz);
    Len2 := IntelWord(ZXModSize);
    Offs2 := IntelWord(j - 6 + zxplsz);
    Zero := 0
   end;
  BlockWrite(f,AYPoints,SizeOf(TPoints));
  j := Length(CurrentWindow.VTMP.Title);
  if j <> 0 then
   BlockWrite(f,CurrentWindow.VTMP.Title[1],j + 1)
  else
   BlockWrite(f,j,1);
  j := Length(CurrentWindow.VTMP.Author);
  if j <> 0 then
   BlockWrite(f,CurrentWindow.VTMP.Author[1],j + 1)
  else
   BlockWrite(f,j,1);
  BlockWrite(f,FullVersString[1],Length(FullVersString) + 1)
 end;
3:
 begin
  with SCLHdr do
   begin
    SCL := 'SINCLAIR'; NBlk := 2;
    Name1 := 'vtplayer'; Typ1 := 'C';
    Start1 := ZXCompAddr; Leng1 := zxplsz;
    Sect1 := zxplsz shr 8;
    if zxplsz and 255 <> 0 then Inc(Sect1);
    Name2 := '        ';
    s := ExtractFileName(SaveDialogZXAY.FileName);
    j := Length(s) - 4;
    if j > 8 then j := 8;
    if j > 0 then Move(s[1],Name2,j);
    Typ2 := 'C';
    Start2 := ZXCompAddr + zxplsz + zxdtsz;
    Leng2 := ZXModSize;
    Sect2 := ZXModSize shr 8;
    if ZXModSize and 255 <> 0 then Inc(Sect2);
    k := 0;
    for j := 0 to sizeof(SCLHdr) - 1 do Inc(k,Ind[j]);
   end;
  BlockWrite(f,SCLHdr,sizeof(SCLHdr));
  for j := 0 to zxplsz - 1 do Inc(k,pl[j]);
  for j := 0 to ZXModSize - 1 do Inc(k,PT3.Index[j]);
 end;
4:
 begin
  with TAPHdr do
   begin
    Sz := 19; Flag := 0; Typ := 3; Name := 'vtplayer  ';
    Leng := zxplsz; Start := ZXCompAddr; Trash := 32768;
    k := 0; for j := 2 to 19 do k := k xor Ind[j]; Sum := k;
    BlockWrite(f,TAPHdr,21);
    Sz := 2 + zxplsz; Flag := 255;
   end;
  BlockWrite(f,TAPHdr,3);
 end
end;
if t <> 1 then BlockWrite(f,pl[0],zxplsz);
case t of
4:
 begin
  with TAPHdr do
   begin
    k := 255; for j := 0 to zxplsz - 1 do k := k xor pl[j];
    BlockWrite(f,k,1);
    Sz := 19; Flag := 0; Typ := 3; Name := '          ';
    Leng := ZXModSize; Start := ZXCompAddr + zxplsz + zxdtsz; Trash := 32768;
    s := ExtractFileName(SaveDialogZXAY.FileName);
    j := Length(s) - 4;
    if j > 10 then j := 10;
    if j > 0 then Move(s[1],Name,j);
    k := 0; for j := 2 to 19 do k := k xor Ind[j]; Sum := k;
    BlockWrite(f,TAPHdr,21);
    Sz := 2 + ZXModSize; Flag := 255;
   end;
  BlockWrite(f,TAPHdr,3);
 end;
3:
 begin
  j := zxplsz mod 256;
  if j <> 0 then
   begin
    j := 256 - j;
    FillChar(pl[0],j,0);
    BlockWrite(f,pl[0],j)
   end;
 end;
0:
 begin
  if zxdtsz > zxplsz then SetLength(pl,zxdtsz);
  FillChar(pl[0],zxdtsz,0);
  BlockWrite(f,pl[0],zxdtsz)
 end;
end; 
BlockWrite(f,PT3,ZXModSize);
case t of
4:
 begin
  k := 255; for j := 0 to ZXModSize - 1 do k := k xor PT3.Index[j];
  BlockWrite(f,k,1);
 end;
3:
 begin
  j := ZXModSize mod 256;
  if j <> 0 then
   begin
    j := 256 - j;
    FillChar(pl[0],j,0);
    BlockWrite(f,pl[0],j)
   end;
  BlockWrite(f,k,4);
 end;
0..1:
 with hobetahdr do
  if SectLeng <> i then
   begin
    FillChar(PT3,SectLeng - i,0);
    BlockWrite(f,PT3,SectLeng - i)
   end;
end;
finally
 CloseFile(f)
end
end;

procedure TMainForm.SetDialogZXAYExt;
var
 i:integer;
begin
i := SaveDialogZXAY.FilterIndex - 1;
if not (i in [0..4]) then i := ExpDlg.RadioGroup1.ItemIndex;
case i of
0:SaveDialogZXAY.DefaultExt := '$c';
1:SaveDialogZXAY.DefaultExt := '$m';
2:SaveDialogZXAY.DefaultExt := 'ay';
3:SaveDialogZXAY.DefaultExt := 'scl';
4:SaveDialogZXAY.DefaultExt := 'tap'
end
end;

procedure TMainForm.SaveDialogZXAYTypeChange(Sender: TObject);
begin
SetDialogZXAYExt
end;

procedure TMainForm.SetPriority;
var
 HMyProcess:longword;
begin
if Pr <> 0 then
 Priority := Pr
else
 Pr := NORMAL_PRIORITY_CLASS;
HMyProcess := GetCurrentProcess;
SetPriorityClass(HMyProcess,Pr);
CloseHandle(HMyProcess);
end;

function CanCopy:boolean;
var
 A:TWinControl;
begin
Result := MainForm.MDIChildCount <> 0;
if Result then
 begin
  A := TMDIChild(MainForm.ActiveMDIChild).ActiveControl;
  Result := A is TCustomEdit;
  if Result then
   Result := (A as TCustomEdit).SelLength > 0
  else
   Result := TMDIChild(MainForm.ActiveMDIChild).Tracks = A
 end
end;

procedure TMainForm.EditCopy1Update(Sender: TObject);
begin
EditCopy1.Enabled := CanCopy
end;

procedure TMainForm.EditCut1Update(Sender: TObject);
begin
EditCut1.Enabled := CanCopy
end;

procedure TMainForm.EditPaste1Update(Sender: TObject);
var
 A:TWinControl;
 R:boolean;
begin
R := MainForm.MDIChildCount <> 0;
if R then
 begin
  A := TMDIChild(MainForm.ActiveMDIChild).ActiveControl;
  R := A is TCustomEdit;
  if not R then
   R := TMDIChild(MainForm.ActiveMDIChild).Tracks = A
 end;
EditPaste1.Enabled := R
end;

function GetCopyControl(var CT:integer;var WC:TWinControl):boolean;
begin
Result := MainForm.MDIChildCount <> 0;
if Result then
 begin
  CT := -1;
  WC := TMDIChild(MainForm.ActiveMDIChild).ActiveControl;
  if WC is TCustomEdit then CT := 0;
  if CT < 0 then
   begin
    Result := TMDIChild(MainForm.ActiveMDIChild).Tracks = WC;
    if Result then CT := 1

   end;
 end
end;

procedure TMainForm.EditCut1Execute(Sender: TObject);
var
 CtrlType:integer;
 WC:TWinControl;
begin
if GetCopyControl(CtrlType,WC) then
 case CtrlType of
 0: (WC as TCustomEdit).CutToClipboard;
 1: (WC as TTracks).CutToClipboard;
 end;
end;

procedure TMainForm.EditCopy1Execute(Sender: TObject);
var
 CtrlType:integer;
 WC:TWinControl;
begin
if GetCopyControl(CtrlType,WC) then
 case CtrlType of
 0: (WC as TCustomEdit).CopyToClipboard;
 1: (WC as TTracks).CopyToClipboard;
 end;
end;

procedure TMainForm.EditPaste1Execute(Sender: TObject);
var
 CtrlType:integer;
 WC:TWinControl;
begin
if GetCopyControl(CtrlType,WC) then
 case CtrlType of
 0: (WC as TCustomEdit).PasteFromClipboard;
 1: (WC as TTracks).PasteFromClipboard;
 end;
end;

procedure TMainForm.UndoUpdate(Sender: TObject);
begin
Undo.Enabled := (MDIChildCount <> 0) and
                        (TMDIChild(ActiveMDIChild).ChangeCount > 0)
end;

procedure TMainForm.UndoExecute(Sender: TObject);
begin
if (MDIChildCount = 0) then exit;
TMDIChild(ActiveMDIChild).DoUndo(1,True)
end;

procedure TMainForm.RedoUpdate(Sender: TObject);
begin
Redo.Enabled := (MDIChildCount <> 0) and
                        (TMDIChild(ActiveMDIChild).ChangeCount < TMDIChild(ActiveMDIChild).ChangeTop)
end;

procedure TMainForm.RedoExecute(Sender: TObject);
begin
if (MDIChildCount = 0) then exit;
TMDIChild(ActiveMDIChild).DoUndo(1,False)
end;

procedure TMainForm.CheckCommandLine;
var
 i:integer;
begin
i := ParamCount;
if i = 0 then exit;
for i := i downto 1 do CreateMDIChild(ExpandFileName(ParamStr(i)))
end;

function TMainForm.AllowSave(fn:string):boolean;
begin
Result := not FileExists(fn) or
 (MessageDlg('File ''' + fn + ''' exists. Overwrite?',
        mtConfirmation,[mbYes,mbNo],0) = mrYes)
end;

end.
