{
This is part of Vortex Tracker II project
(c)2000-2022 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://bulba.untergrund.net/
}

//bug of LCL - fsMDIChild always with sizable border, so to mask sizing errors
//all MDI childs windows created with bsNone temporary

unit Main;

{$mode objfpc}{$H+}

interface

uses LCLIntf, LCLType,
  {$IFDEF Windows}
  Windows,
  {$ENDIF Windows}
  SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, {StdActns,}
  ActnList, ImgList, AY, digsoundcode, digsound, trfuncs, grids, ChildWin,
  lazutf8, LMessages, Config, Languages;

const
 UM_FINALIZEDS = WM_USER + 2;

 NewTrack_NumberOfLinesDef = 11;
 StdChannelsAllocationDef = 1;

 StdAutoEnvMax = 7;
 StdAutoEnv:array[0..StdAutoEnvMax,0..1] of integer =
 ((1,1),(3,4),(1,2),(1,4),(3,1),(5,2),(2,1),(3,2));

//Version related constants
 VersionString = '1.0';
 IsBeta = ' beta';
 BetaNumber = ' 20';

 FullVersString:string = 'Vortex Tracker II v' + VersionString + IsBeta + BetaNumber;
 HalfVersString:string = 'Version ' + VersionString + IsBeta + BetaNumber;

type
  // to avoid conflicts with Delphi Code :
  TWindowClose          = TAction;
  TWindowCascade        = TAction;
  TWindowTileHorizontal = TAction;
  TWindowArrange        = TAction;
  TWindowMinimizeAll    = TAction;
  TWindowTileVertical   = TAction;

  TChansArrayBool = array [0..2] of boolean;
  ERegistryError = class(Exception);

  { TMainForm }

  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    VisTimer: TTimer;
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
    TransposeUp1: TAction;
    TransposeDown1: TAction;
    TransposeUp12: TAction;
    TransposeDown12: TAction;
    PopupMenu2: TPopupMenu;
    ranspose11: TMenuItem;
    ranspose12: TMenuItem;
    ranspose121: TMenuItem;
    ranspose122: TMenuItem;
    N5: TMenuItem;
    Undo2: TMenuItem;
    Redo2: TMenuItem;
    N6: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    N7: TMenuItem;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    PopupMenu3: TPopupMenu;
    File2: TMenuItem;
    Clipboard1: TMenuItem;
    UndoRedo1: TMenuItem;
    Window2: TMenuItem;
    Play5: TMenuItem;
    rack1: TMenuItem;
    N8: TMenuItem;
    Togglesamples1: TMenuItem;
    ToolButton25: TToolButton;
    N9: TMenuItem;
    ExpandTwice1: TMenuItem;
    Compresspattern1: TMenuItem;
    Merge1: TMenuItem;
    procedure AddWindowListItem(Child:TMDIChild);
    procedure DeleteWindowListItem(Child:TMDIChild);
    procedure FileClose1Execute(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure digsoundfinalize(var Msg: TMessage);message UM_FINALIZEDS;
    procedure Options1Click(Sender: TObject);
    procedure CommonActionUpdate(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileSave1Update(Sender: TObject);
    procedure FileSaveAs1Execute(Sender: TObject);
    procedure Stop1Update(Sender: TObject);
    procedure Play1Execute(Sender: TObject);
    procedure Stop1Execute(Sender: TObject);
    procedure SetLoopPosExecute(Sender: TObject);
    procedure SetLoopPosUpdate(Sender: TObject);
    procedure InsertPositionExecute(Sender: TObject);
    procedure InsertPositionUpdate(Sender: TObject);
    procedure DeletePositionUpdate(Sender: TObject);
    procedure DeletePositionExecute(Sender: TObject);
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
    procedure PlayPatExecute(Sender: TObject);
    procedure PlayPatFromLineExecute(Sender: TObject);
    procedure SaveSNDHMenuClick(Sender: TObject);
    procedure SaveforZXMenuClick(Sender: TObject);
    procedure SaveDialogZXAYTypeChange(Sender: TObject);
    procedure SetDialogZXAYExt;
    procedure SaveDialog1TypeChange(Sender: TObject);
    {$IFDEF Windows}
    procedure SetPriority(Pr:longword);
    {$ENDIF Windows}
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
    procedure RedrawPlWindow(PW:TMDIChild;ps,pat,line:integer);
    procedure TransposeChannel(WorkWin:TMDIChild;Pat,Chn,i,Semitones:integer);
    procedure TransposeColumns(WorkWin:TMDIChild;Pat:integer;Env:boolean;Chans:TChansArrayBool;LFrom,LTo,Semitones:integer;MakeUndo:boolean);
    procedure TransposeSelection(Semitones:integer);
    procedure TransposeUp1Update(Sender: TObject);
    procedure TransposeDown1Update(Sender: TObject);
    procedure TransposeUp12Update(Sender: TObject);
    procedure TransposeDown12Update(Sender: TObject);
    procedure TransposeUp1Execute(Sender: TObject);
    procedure TransposeDown1Execute(Sender: TObject);
    procedure TransposeUp12Execute(Sender: TObject);
    procedure TransposeDown12Execute(Sender: TObject);
    procedure PopupMenu3Click(Sender: TObject);
    procedure SetBar(BarNum:integer;Value:boolean);
    procedure Togglesamples1Click(Sender: TObject);
    procedure ExpandTwice1Click(Sender: TObject);
    procedure Compresspattern1Click(Sender: TObject);
    procedure Merge1Click(Sender: TObject);
    procedure VisTimerTimer(Sender: TObject);
    procedure WindowArrangeAll1Execute(Sender: TObject);
    procedure WindowCascade1Execute(Sender: TObject);
    procedure WindowMinimizeAll1Execute(Sender: TObject);
    procedure WindowTileHorizontal1Execute(Sender: TObject);
    procedure WindowTileVertical1Execute(Sender: TObject);
  protected
    procedure WndProc(var TheMessage : TLMessage); override;
  private
    { Private declarations }
    procedure CreateMDIChild(const aFileName: string);
  public
    { Public declarations }
    NewTrack_NumberOfLines:integer;
    NewTrack_Font,NewSample_Font:TFont;
    RecentFiles:array[0..5] of string;
    NoteKeys:array[0..255] of shortint;
    ChanAlloc:TChansArray;
    ChanAllocIndex:integer;
    LoopAllAllowed:boolean;
    SampleLineTemplates:array of TSampleTick;
    CurrentSampleLineTemplate:integer;
    GlobalVolume,GlobalVolumeMax,WinCount:integer;
  end;

function SwapW(a:word):word; inline;

//All=False - иницилизировать только проигрыватель (т.е. переменные плеера не инициализировать)
procedure InitForAllTypes(All:boolean);

function SetStdChannelsAllocation(CA:integer):string;
procedure SetDefault;
procedure ResetPlaying;
procedure CatchAndResetPlaying;

var
  MainForm: TMainForm;
  {$IFDEF Windows}
  Priority:dword = NORMAL_PRIORITY_CLASS;
  {$ENDIF Windows}
  TrkClBk,TrkClTxt,TrkClHlBk,TrkClSelBk,TrkClSelTxt:integer;
  StdChannelsAllocation:integer;

implementation

{$R *.lfm}

uses About, options, TrkMng, GlbTrn, ExportZX, selectts, TglSams;

type
 TStr4 = array[0..3] of char;
 
const
 TSData:packed record
  Type1:TStr4; Size1:word;
  Type2:TStr4; Size2:word;
  TSID:TStr4;
 end = (Type1:'PT3!';Size1:0;Type2:'PT3!';Size2:0;TSID:'02TS');

function SwapW(a:word):word;
begin
Result := Swap(a);
end;

procedure InitForAllTypes(All:boolean);
var
  i:integer;
begin
for i := NumberOfSoundChips-1 downto 0 do
 begin
  Module_SetPointer(PlayingWindow[i].VTMP,i);
  InitTrackerParameters(All);
  Real_End[i] := False;
 end;
Real_End_All := False;
//if All then
 //begin
if IsFilt >= 0 then
 begin
  FillChar(Filt_XL[0],(Filt_M + 1) * 4,0);
  FillChar(Filt_XR[0],(Filt_M + 1) * 4,0);
  Filt_I := 0;
 end;
MkVisPos := 0;
VisPoint := 0;
NOfTicks := 0;
for i := 0 to NumberOfSoundChips-1 do
 ResetAYChipEmulation(i,True);
 //end;
end;

procedure TMainForm.DeleteWindowListItem(Child:TMDIChild);
var
 i,j:integer;
begin
LineReady := False;
for i := 1 to TSSel.ListBox1.Items.Count - 1 do
 if TSSel.ListBox1.Items.Objects[i] = Child then
  begin
   TSSel.ListBox1.Items.Delete(i);
   for j := 0 to MDIChildCount - 1 do
    if (MDIChildren[j] <> Child) and (TMDIChild(MDIChildren[j]).TSWindow = Child) then
     begin
      TMDIChild(MDIChildren[j]).TSWindow := nil;
      TMDIChild(MDIChildren[j]).TSBut.Caption := TMDIChild(MDIChildren[j]).PrepareTSString(TMDIChild(MDIChildren[j]).TSBut,TSSel.ListBox1.Items[0]);
     end;
   break;
  end;
end;

procedure TMainForm.FileClose1Execute(Sender: TObject);
begin
TMDIChild(ActiveMDIChild).Close;
end;

procedure TMainForm.AddWindowListItem(Child:TMDIChild);
begin
TSSel.ListBox1.AddItem(Child.Caption,Child);
end;

procedure TMainForm.CreateMDIChild(const aFileName: string);
var
  Child: TMDIChild;
  Ok:boolean;
  VTMP2:PModule;
  i:integer;
begin
VTMP2 := nil;
for i := 0 to 1 do
  begin
   Inc(WinCount);
   Child := TMDIChild.Create(Application);
   Child.WinNumber := WinCount;
   Child.Caption := IntToStr(WinCount) + ': new module';
   AddWindowListItem(Child);
   Ok := True;
   if (aFileName <> '') and FileExists(aFileName) then
    Ok := Child.LoadTrackerModule(aFileName,VTMP2);
   if Ok then Caption := Child.Caption + ' - Vortex Tracker II';
   if not Ok or (VTMP2 = nil) then break;
  end;
if Ok and (VTMP2 <> nil) then
 begin
  Child.TSBut.Caption := Child.PrepareTSString(Child.TSBut,TSSel.ListBox1.Items[MDIChildCount - 1]);
  Child.TSWindow := TMDIChild(TSSel.ListBox1.Items.Objects[MDIChildCount - 1]);
  Child.TSWindow.TSBut.Caption := Child.TSWindow.PrepareTSString(Child.TSWindow.TSBut,TSSel.ListBox1.Items[MDIChildCount]);
  Child.TSWindow.TSWindow := TMDIChild(TSSel.ListBox1.Items.Objects[MDIChildCount]);
  if Child.Width*2 <= ClientWidth then
   if MDIChildCount = 2 then
    //only one TS - move to top left
    begin
     Child.Top:=0;
     Child.Left:=0;
     Child.TSWindow.Top:=0;
     Child.TSWindow.Left:=Child.Width;
    end
   else
    //new TS but some other opened before
    begin
     //to mask LCL bug MDI childs with bsNone border,
     //and -16 and -48 is temporary constants till LCL bug will be fixed
     Child.Left:=Child.TSWindow.Left-16;
     Child.Top:=Child.TSWindow.Top-48;
     Child.TSWindow.Top:=Child.TSWindow.Top-48; //mask LCL bug
     Child.TSWindow.Left:=Child.Left+Child.Width;
    end;
 end;
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild('');
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
var
 i:integer;
begin
  OpenDialog.FileName := ExtractFileName(OpenDialog.FileName);
  if OpenDialog.Execute then
   begin
    OpenDialog.InitialDir := ExtractFilePath(OpenDialog.FileName);
    i := OpenDialog.Files.Count - 1;
    if i > 16 then i := 16;
    for i := i downto 0 do CreateMDIChild(OpenDialog.Files.Strings[i])
   end
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
digsoundthread_stop;
SaveOptions;
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
FillChar(NoteKeys,SizeOf(NoteKeys),byte(-3));
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
NewSample_Font := TFont.Create;
NewSample_Font.Name := 'Courier';
NewSample_Font.Size := 10;
LoopAllowed := False;
LoopAllAllowed := False;
GlobalVolume := TrackBar1.Position;
GlobalVolumeMax := TrackBar1.Max;
digsoundNotify:=Handle;
UM_DIGSOUNDNOTIFY:=UM_FINALIZEDS;
SetDefault;
Synthesizer := @Synthesizer_Stereo16;
ResetSampTemplate;
LoadOptions;
end;

procedure TMainForm.RedrawPlWindow(PW:TMDIChild;ps,pat,line:integer);
begin
if ps < 256 then
 PW.ShowPosition(ps);
if (PW.PatNum <> pat) or (PW.Tracks.ShownFrom <> line) then
 begin
  PW.ChangePattern(pat,line);
  PW.CalculatePos(line);
 end;
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
 Saved_digsoundDevice:integer;
 Saved_ChipType:ChTypes;
 Saved_Resampler:integer;
 Saved_FeaturesLevel:integer;
 Saved_DetectFeaturesLevel,
 Saved_VortexModuleHeader,
 Saved_DetectModuleHeader:boolean;
 {$IFDEF Windows}
 Saved_Prior:DWORD;
 {$ENDIF Windows}
 i:integer;
begin
Form1.UpDown1.Position := NewTrack_NumberOfLines;
Form1.Edit2.Font := NewTrack_Font;
Form1.Edit2.Text := NewTrack_Font.Name;
Form1.ChipSel.ItemIndex := Ord(ChType) - 1;
Saved_ChipType := ChType;
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
Saved_Resampler := Ord(FilterWant);
Form1.Resamp.ItemIndex := Ord(FilterWant);
Form1.Label9.Caption:=FiltInfo;
if DetectFeaturesLevel then
 Form1.RadioGroup1.ItemIndex := 3
else
 Form1.RadioGroup1.ItemIndex := FeaturesLevel;
Saved_FeaturesLevel := FeaturesLevel;
Saved_DetectFeaturesLevel := DetectFeaturesLevel;
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
 Form1.SR.ItemIndex := 3
else if SampleRate = 96000 then
 Form1.SR.ItemIndex := 4
else if SampleRate = 192000 then
 Form1.SR.ItemIndex := 5;
Saved_SampleRate := SampleRate;
Form1.BR.ItemIndex := Ord(SampleBit = 16);
Saved_SampleBit := SampleBit;
Form1.NCh.ItemIndex := Ord(NumberOfChannels = 2);
Saved_NumberOfChannels := NumberOfChannels;
Form1.TrackBar1.Position := BufLen_ms;
Saved_BufLen_ms := BufLen_ms;
Form1.TrackBar2.Position := NumberOfBuffers;
Saved_NumberOfBuffers := NumberOfBuffers;
Saved_digsoundDevice := digsoundDevice;
digsound_getdevices(Form1.ComboBox1.Items);
if digsoundDevice < Form1.ComboBox1.Items.Count then
 Form1.ComboBox1.ItemIndex := digsoundDevice;
{$IFDEF Windows}
Saved_Prior := Priority;
Form1.PriorGrp.ItemIndex := Ord(Priority <> NORMAL_PRIORITY_CLASS);
{$ENDIF Windows}

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
   TMDIChild(MDIChildren[i]).Tracks.RedrawTracks;
 end
else
 begin
  if Saved_ChanAllocIndex <> ChanAllocIndex then
   SetChannelsAllocationVis(Saved_ChanAllocIndex);
  SetEmulatingChip(Saved_ChipType);
  if Saved_AY_Freq <> AY_Freq then
   Set_Chip_Frq(Saved_AY_Freq);
  if Saved_StdChannelsAllocation <> StdChannelsAllocation then
   ToggleChanAlloc.Caption :=  SetStdChannelsAllocation(Saved_StdChannelsAllocation);
  if Saved_Interrupt_Freq <> Interrupt_Freq then
   SetIntFreqEx(Saved_Interrupt_Freq);
  if Saved_Resampler <> Ord(FilterWant) then
   SetFilter(Saved_Resampler <> 0);
  FeaturesLevel := Saved_FeaturesLevel;
  DetectFeaturesLevel := Saved_DetectFeaturesLevel;
  VortexModuleHeader := Saved_VortexModuleHeader;
  DetectModuleHeader := Saved_DetectModuleHeader;
  if not digsoundthread_active then
   begin
    if Saved_SampleRate <> SampleRate then
     Set_Sample_Rate(Saved_SampleRate);
    if Saved_SampleBit <> SampleBit then
     Set_Sample_Bit(Saved_SampleBit);
    if Saved_NumberOfChannels <> NumberOfChannels then
     Set_Stereo(Saved_NumberOfChannels);
    if (Saved_BufLen_ms <> BufLen_ms) or
       (Saved_NumberOfBuffers <> NumberOfBuffers) then
     SetBuffers(Saved_BufLen_ms,Saved_NumberOfBuffers);
    digsoundDevice := Saved_digsoundDevice;
   end;
  {$IFDEF Windows}
  SetPriority(Saved_Prior);
  {$ENDIF Windows}
 end;
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
    Application.MessageBox(PAnsiChar(Mes_CantCompileTooBig),PAnsiChar(FileName));
    Exit;
   end;
  AssignFile(f,FileName);
  Rewrite(f,1);
  try
   BlockWrite(f,PT3,Size);
   if CW.TSWindow <> nil then
    begin
     TSData.Size1 := Size;
     if not VTM2PT3(@PT3,CW.TSWindow.VTMP,Size) then
      begin
       Application.MessageBox(PAnsiChar(Mes_CantCompileTooBig),PAnsiChar(FileName));
       Exit;
      end;
     BlockWrite(f,PT3,Size);
     TSData.Size2 := Size;
     BlockWrite(f,TSData,SizeOf(TSData));
    end;
  finally
   CloseFile(f);
  end;
 end
else
 begin
  VTM2TextFile(FileName,CW.VTMP,False);
  if CW.TSWindow <> nil then
   VTM2TextFile(FileName,CW.TSWindow.VTMP,True);
 end;
CW.SavedAsText := AsText;
CW.SongChanged := False;
if CW.TSWindow <> nil then
 begin
  CW.TSWindow.SavedAsText := AsText;
  CW.TSWindow.SongChanged := False;
  CW.TSWindow.SetFileName(FileName);
 end;
AddFileName(FileName);
end;

procedure TMainForm.CommonActionUpdate(Sender: TObject);
begin
with Sender as TAction do
 Enabled := MDIChildCount <> 0;
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
 (TMDIChild(ActiveMDIChild).SongChanged or
  ((TMDIChild(ActiveMDIChild).TSWindow <> nil) and
    TMDIChild(ActiveMDIChild).TSWindow.SongChanged));
end;

procedure TMainForm.SaveDialog1TypeChange(Sender: TObject);
var
 s:string;
begin
if SaveDialog1.FilterIndex = 1 then
 s := 'txt'
else
 s := 'pt3';
SaveDialog1.DefaultExt := s;
end;

procedure TMainForm.Stop1Update(Sender: TObject);
begin
Stop1.Enabled := (MDIChildCount <> 0) and IsPlaying;
end;

procedure TMainForm.Play1Execute(Sender: TObject);
var
 i:integer;
begin
if MDIChildCount = 0 then
 Exit;
if TMDIChild(ActiveMDIChild).VTMP^.Positions.Length <= 0 then
 Exit;
if IsPlaying then
 begin
  digsoundthread_stop;
  RestoreControls;
 end;
PlayMode := PMPlayModule;
DisableControls;
CheckSecondWindow;
PlayingWindow[0].Tracks.RemoveSelection(False);
for i := 0 to NumberOfSoundChips-1 do
 begin
  Module_SetPointer(PlayingWindow[i].VTMP,i);
  Module_SetDelay(PlayingWindow[i].VTMP^.Initial_Delay);
  Module_SetCurrentPosition(0);
 end;
InitForAllTypes(True);
digsoundthread_start;
VisTimer.Enabled:=True;
end;

procedure TMainForm.PlayFromPos1Execute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
if TMDIChild(ActiveMDIChild).VTMP^.Positions.Length <= 0 then exit;
if IsPlaying then
 begin
  digsoundthread_stop;
  RestoreControls;
 end;
PlayMode := PMPlayModule;
DisableControls;
CheckSecondWindow;
PlayingWindow[0].Tracks.RemoveSelection(False);
//PlayingWindow[0].RerollToPos(PlayingWindow[0].PositionNumber);
PlayingWindow[0].RerollToLine(0);
digsoundthread_start;
VisTimer.Enabled:=True;
end;

procedure TMainForm.PlayPatExecute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
if IsPlaying then
 begin
  digsoundthread_stop;
  RestoreControls;
 end;
PlayMode := PMPlayPattern;
DisableControls;
PlayingWindow[0].ValidatePattern2(PlayingWindow[0].PatNum);
PlayingWindow[0].Tracks.RemoveSelection(False);
Module_SetPointer(PlayingWindow[0].VTMP,0);
Module_SetDelay(PlayingWindow[0].VTMP^.Initial_Delay);
PlVars[0].CurrentPosition := 65535;
Module_SetCurrentPattern(PlayingWindow[0].PatNum);
InitForAllTypes(False);
digsoundthread_start;
VisTimer.Enabled:=True;
end;

procedure TMainForm.PlayPatFromLineExecute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
if IsPlaying then
 begin
  digsoundthread_stop;
  RestoreControls;
 end;
TMDIChild(ActiveMDIChild).ValidatePattern2(TMDIChild(ActiveMDIChild).PatNum);
TMDIChild(ActiveMDIChild).RestartPlayingPatternLine(False);
end;

procedure TMainForm.Stop1Execute(Sender: TObject);
begin
if (MDIChildCount = 0) or not IsPlaying then exit;
VisTimer.Enabled:=False;
digsoundthread_stop;
RestoreControls;
PlayingWindow[0].Tracks.RemoveSelection(True);
if (TMDIChild(ActiveMDIChild) = PlayingWindow[0]) and
   (PlayingWindow[0].PageControl1.ActivePageIndex = 0) then
 PlayingWindow[0].Tracks.SetFocus;
if NumberOfSoundChips > 1 then
 if (TMDIChild(ActiveMDIChild) = PlayingWindow[1]) and
   (PlayingWindow[1].PageControl1.ActivePageIndex = 0) then
  PlayingWindow[1].Tracks.SetFocus;
end;

procedure TMainForm.SetLoopPosExecute(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
with TMDIChild(ActiveMDIChild) do
 begin
  if (StringGrid1.Selection.Left < VTMP^.Positions.Length) and
     (StringGrid1.Selection.Left <> VTMP^.Positions.Loop) then
   SetLoopPos(StringGrid1.Selection.Left);
  InputPNumber := 0;
 end;
end;

procedure TMainForm.SetLoopPosUpdate(Sender: TObject);
begin
SetLoopPos.Enabled := (MDIChildCount <> 0) and
                      TMDIChild(ActiveMDIChild).StringGrid1.Focused and
                      (TMDIChild(ActiveMDIChild).VTMP^.Positions.Length >
                       TMDIChild(ActiveMDIChild).StringGrid1.Selection.Left);
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
  if (StringGrid1.Selection.Left < VTMP^.Positions.Length) and
     (VTMP^.Positions.Length < 256) then
   begin
    SongChanged := True;
    AddUndo(CAInsertPosition,0,0);
    ChangeList[ChangeCount - 1].CurrentPosition := StringGrid1.Selection.Left;
    New(ChangeList[ChangeCount - 1].PositionList);
    ChangeList[ChangeCount - 1].PositionList^ := VTMP^.Positions;
    i := VTMP^.Positions.Length - StringGrid1.Selection.Left;
    Inc(VTMP^.Positions.Length);
    if StringGrid1.Selection.Left <= VTMP^.Positions.Loop then
     Inc(VTMP^.Positions.Loop);
    for i := StringGrid1.Selection.Left + i - 1 downto
                                 StringGrid1.Selection.Left do
     VTMP^.Positions.Value[i + 1] := VTMP^.Positions.Value[i];
    for i := StringGrid1.Selection.Left to VTMP^.Positions.Length - 1 do
     begin
      s := IntToStr(VTMP^.Positions.Value[i]);
      if i = VTMP^.Positions.Loop then
       s := 'L' + s;
      StringGrid1.Cells[i,0] := s
     end;
    CalcTotLen;
   end;
  InputPNumber := 0;
 end;
end;

procedure TMainForm.InsertPositionUpdate(Sender: TObject);
begin
InsertPosition.Enabled := (MDIChildCount <> 0) and
                      not (IsPlaying and (PlayMode = PMPlayModule)) and
                      TMDIChild(ActiveMDIChild).StringGrid1.Focused and
                      (TMDIChild(ActiveMDIChild).VTMP^.Positions.Length >
                       TMDIChild(ActiveMDIChild).StringGrid1.Selection.Left);
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
 if StringGrid1.Selection.Left < VTMP^.Positions.Length then
  begin
   SongChanged := True;
   AddUndo(CADeletePosition,0,0);
   ChangeList[ChangeCount - 1].CurrentPosition := StringGrid1.Selection.Left;
   New(ChangeList[ChangeCount - 1].PositionList);
   ChangeList[ChangeCount - 1].PositionList^ := VTMP^.Positions;
   i := VTMP^.Positions.Length - StringGrid1.Selection.Left - 1;
   Dec(VTMP^.Positions.Length);
   if StringGrid1.Selection.Left < VTMP^.Positions.Loop then
    Dec(VTMP^.Positions.Loop);
   if i > 0 then
    begin
     for i := StringGrid1.Selection.Left to
                                StringGrid1.Selection.Left + i - 1 do
      VTMP^.Positions.Value[i] := VTMP^.Positions.Value[i + 1];
     for i := StringGrid1.Selection.Left to VTMP^.Positions.Length - 1 do
      begin
       s := IntToStr(VTMP^.Positions.Value[i]);
       if i = VTMP^.Positions.Loop then
        s := 'L' + s;
       StringGrid1.Cells[i,0] := s
      end
    end
   else
    begin
     if (VTMP^.Positions.Loop > 0) and
           (VTMP^.Positions.Length = VTMP^.Positions.Loop) then
      begin
       Dec(VTMP^.Positions.Loop);
       StringGrid1.Cells[VTMP^.Positions.Loop,0] := 'L' +
                          IntToStr(VTMP^.Positions.Value[VTMP^.Positions.Loop])
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
   if VTMP^.Positions.Length < 256 then
    StringGrid1.Cells[VTMP^.Positions.Length,0] := '...'
  end;
 InputPNumber := 0;
 end;
end;

procedure TMainForm.DeletePositionUpdate(Sender: TObject);
begin
DeletePosition.Enabled := (MDIChildCount <> 0) and
                      not (IsPlaying and (PlayMode = PMPlayModule)) and
                      TMDIChild(ActiveMDIChild).StringGrid1.Focused and
                      (TMDIChild(ActiveMDIChild).VTMP^.Positions.Length >
                       TMDIChild(ActiveMDIChild).StringGrid1.Selection.Left);
end;

procedure TMainForm.ToggleLoopingExecute(Sender: TObject);
begin
LoopAllowed := not LoopAllowed;
if LoopAllowed then
 begin
  LoopAllAllowed := False;
  ToggleLoopingAll.Checked := False
 end;
ToggleLooping.Checked := LoopAllowed;
end;

procedure TMainForm.ToggleLoopingAllExecute(Sender: TObject);
begin
LoopAllAllowed := not LoopAllAllowed;
if LoopAllAllowed then
 begin
  LoopAllowed := False;
  ToggleLooping.Checked := False
 end;
ToggleLoopingAll.Checked := LoopAllAllowed;
end;

procedure TMainForm.PlayFromPos1Update(Sender: TObject);
begin

end;

procedure TMainForm.AddFileName(FN: string);
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
MainMenu1.Items[0].Items[j + 6].Visible := MainMenu1.Items[0].Items[j].Visible;
end;

procedure TMainForm.OpenRecent(n: integer);
begin
if (RecentFiles[n] <> '') and FileExists(RecentFiles[n]) then
 begin
  OpenDialog.InitialDir := ExtractFilePath(RecentFiles[n]);
  OpenDialog.FileName := RecentFiles[n];
  CreateMDIChild(RecentFiles[n]);
 end;
end;

procedure TMainForm.RFile1Click(Sender: TObject);
begin
OpenRecent(0);
end;

procedure TMainForm.RFile2Click(Sender: TObject);
begin
OpenRecent(1);
end;

procedure TMainForm.RFile3Click(Sender: TObject);
begin
OpenRecent(2);
end;

procedure TMainForm.RFile4Click(Sender: TObject);
begin
OpenRecent(3);
end;

procedure TMainForm.RFile5Click(Sender: TObject);
begin
OpenRecent(4);
end;

procedure TMainForm.RFile6Click(Sender: TObject);
begin
OpenRecent(5);
end;

procedure TMainForm.digsoundfinalize(var Msg: TMessage);
var
 TS:TMDIChild;
begin
digsoundthread_free; //todo thread уже остановлен, а digsoundthread_free в начале "останавливает" опять
RestoreControls;
if LoopAllAllowed and (MDIChildCount > 1) then
 begin
  TS := TMDIChild(ActiveMDIChild).TSWindow;
  Next;
  //check to don't play TS one more time
  if TMDIChild(ActiveMDIChild) = TS then Next;
  Play1Execute(nil);
 end;
end;

procedure TMainForm.ToggleChipExecute(Sender: TObject);
begin
if ChType = AY_Chip then
 begin
  ChType := YM_Chip;
  ToggleChip.Caption := 'YM'
 end
else
 begin
  ChType := AY_Chip;
  ToggleChip.Caption := 'AY'
 end;
if StdChannelsAllocation in [0..6] then
 SetStdChannelsAllocation(StdChannelsAllocation)
else
 Calculate_Level_Tables;
if IsPlaying then PlayingWindow[0].StopAndRestart;
end;

procedure TMainForm.ToggleChanAllocExecute(Sender: TObject);
var
 CA:integer;
begin
ToggleChanAlloc.Caption := ToggleChanMode;
CA := StdChannelsAllocation;
if CA > 0 then Dec(CA);
SetChannelsAllocationVis(CA);
if IsPlaying then PlayingWindow[0].StopAndRestart;
end;

procedure TMainForm.SetChannelsAllocationVis(CA: integer);
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
5:begin ChanAlloc[0] := 2; ChanAlloc[1] := 1; ChanAlloc[2] := 0 end;
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
    Inc(Tracks.CursorX,(n - c) * 14);
   end;
  ResetChanAlloc;
 end;
end;

procedure TMainForm.DisableControls;
begin
Form1.PlayStarts;
NumberOfSoundChips := 1;
PlayingWindow[0] := TMDIChild(ActiveMDIChild);
PlayingWindow[0].Edit2.Enabled := False;
PlayingWindow[0].UpDown1.Enabled := False;
PlayingWindow[0].Tracks.Enabled := False;
end;

procedure TMainForm.CheckSecondWindow;
begin
if PlayingWindow[0].TSWindow <> nil then
 begin
  PlayingWindow[1] := PlayingWindow[0].TSWindow;
  if (PlayingWindow[0] <> PlayingWindow[1]) and (PlayingWindow[1].VTMP^.Positions.Length <> 0) then
   begin
    NumberOfSoundChips := 2;
    PlayingWindow[1].Edit2.Enabled := False;
    PlayingWindow[1].UpDown1.Enabled := False;
    PlayingWindow[1].Tracks.Enabled := False;
    PlayingWindow[1].TSBut.Enabled := False;
   end;
  PlayingWindow[1].BringToFront; //todo see TMDIChild.FormActivate comment about SendToBack
  PlayingWindow[0].BringToFront;
 end;
PlayingWindow[0].TSBut.Enabled := False;
end;

procedure TMainForm.RestoreControls;
var
 i:integer;
begin
VisTimer.Enabled:=False;
Form1.PlayStops;
for i := 0 to NumberOfSoundChips-1 do
 begin
  PlayingWindow[i].Edit2.Enabled := True;
  PlayingWindow[i].UpDown1.Enabled := True;
  if PlayMode in [PMPlayModule,PMPlayPattern] then
   PlayingWindow[i].Tracks.CursorY := PlayingWindow[i].Tracks.N1OfLines;
  PlayingWindow[i].Tracks.Enabled := True;
  PlayingWindow[i].TSBut.Enabled := True;
 end;
end;

function SetStdChannelsAllocation(CA:integer):string;
var
 Echo:integer;
begin
Result := '';
StdChannelsAllocation := CA;
case ChType of
AY_Chip:
 Echo := 85
else
 Echo := 13;
end;
case StdChannelsAllocation of
0:
 begin
  MidChan := 0;
  Result := 'Mono';
  Index_AL := 255; Index_AR := 255;
  Index_BL := 255; Index_BR := 255;
  Index_CL := 255; Index_CR := 255
 end;
1:
 begin
  MidChan := 1;
  Result := 'ABC';
  Index_AL := 255; Index_AR := Echo;
  Index_BL := 170; Index_BR := 170;
  Index_CL := Echo; Index_CR := 255
 end;
2:
 begin
  MidChan := 2;
  Result := 'ACB';
  Index_AL := 255; Index_AR := Echo;
  Index_CL := 170; Index_CR := 170;
  Index_BL := Echo; Index_BR := 255
 end;
3:
 begin
  MidChan := 0;
  Result := 'BAC';
  Index_BL := 255; Index_BR := Echo;
  Index_AL := 170; Index_AR := 170;
  Index_CL := Echo; Index_CR := 255
 end;
4:
 begin
  MidChan := 2;
  Result := 'BCA';
  Index_BL := 255; Index_BR := Echo;
  Index_CL := 170; Index_CR := 170;
  Index_AL := Echo; Index_AR := 255
 end;
5:
 begin
  MidChan := 0;
  Result := 'CAB';
  Index_CL := 255; Index_CR := Echo;
  Index_AL := 170; Index_AR := 170;
  Index_BL := Echo; Index_BR := 255
 end;
6:
 begin
  MidChan := 1;
  Result := 'CBA';
  Index_CL := 255; Index_CR := Echo;
  Index_BL := 170; Index_BR := 170;
  Index_AL := Echo; Index_AR := 255
 end;
end;
Calculate_Level_Tables;
end;

procedure SetDefault;
var
 IsPl:boolean;
begin
IsPl := digsoundthread_active;
Set_Player_Frq(Interrupt_FreqDef);
if not IsPl then Set_Sample_Rate(SampleRateDef);
Set_Chip_Frq(AY_FreqDef);
if not IsPl then
 begin
  Set_Sample_Bit(SampleBitDef);
  Set_Stereo(NumOfChanDef);
  SetBuffers(BufLen_msDef,NumberOfBuffersDef);
  digsoundDevice := digsoundDeviceDef;
  digsoundDeviceName := digsoundDeviceNameDef;
 end;
SetStdChannelsAllocation(ChanAllocDef);
ChType := YM_Chip;
SetFilter(True);
Calculate_Level_Tables;
end;

procedure ResetPlaying;
begin
digsound_reset;
MkVisPos := 0;
VisPoint := 0;
NOfTicks := 0;
end;

procedure CatchAndResetPlaying;
begin
digsoundloop_catch;
ResetPlaying;
end;

procedure TMainForm.SetIntFreqEx(f: integer);
var
 i:integer;
begin
Set_Player_Frq(f);
for i := 0 to MDIChildCount - 1 do
 with TMDIChild(MDIChildren[i]) do
  ReCalcTimes;
end;

procedure TMainForm.SetSampleTemplate(Tmp: integer);
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
     RedrawSamples;
     if Focused then
      ShowCaret(Handle);
    end;
  end;
end;

procedure TMainForm.AddToSampTemplate(const SamTik: TSampleTick);
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
  ListBox1.Items.Add(GetSampleString(SamTik,False,True));
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
SetSampleTemplate(0);
end;

procedure TMainForm.Togglesamples1Click(Sender: TObject);
begin
ToglSams.Visible := not ToglSams.Visible;
end;

procedure TMainForm.Tracksmanager1Click(Sender: TObject);
begin
TrMng.Visible := not TrMng.Visible;
end;

procedure TMainForm.Globaltransposition1Click(Sender: TObject);
begin
GlbTrans.Visible := not GlbTrans.Visible;
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
GlobalVolume := TrackBar1.Position;
Calculate_Level_Tables;
end;

procedure TMainForm.SetEmulatingChip(ChType: ChTypes);
begin
if ChType <> ChType then
 begin
  ChType := ChType;
  if ChType = AY_Chip then
   ToggleChip.Caption := 'AY'
  else
   ToggleChip.Caption := 'YM';
  Calculate_Level_Tables;
 end;
end;

procedure TMainForm.SaveOptions;

 procedure SaveDW(const Nm:string; const Vl:integer);
 begin
 OptionsWrite(Nm,IntToStr(Vl));
 end;

 procedure SaveStr(const Nm:string; const Vl:string);
 begin
 OptionsWrite(Nm,Vl);
 end;

var
 i:integer;
begin
{$IFDEF Windows}
SetPriority(0);
{$ENDIF Windows}
if OptionsInit(True) then
try
{$IFDEF Windows}
 SaveDW('Priority',Priority);
{$ENDIF Windows}
 SaveDW('ChanAllocIndex',ChanAllocIndex);
 SaveDW('AY_Freq',AY_Freq);
 SaveDW('StdChannelsAllocation',StdChannelsAllocation);
 SaveDW('Interrupt_Freq',Interrupt_Freq);
 SaveDW('SampleRate',SampleRate);
 SaveDW('SampleBit',SampleBit);
 SaveDW('NumberOfChannels',NumberOfChannels);
 SaveDW('BufLen_ms',BufLen_ms);
 SaveDW('NumberOfBuffers',NumberOfBuffers);
 SaveDW('digsoundDevice',digsoundDevice);
 SaveStr('digsoundDeviceName',digsoundDeviceName);
 SaveDW('ChipType',Ord(ChType));
 SaveDW('Filter',Ord(FilterWant));
 SaveDW('FeaturesLevel',FeaturesLevel);
 SaveDW('DetectFeaturesLevel',Ord(DetectFeaturesLevel));
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

 //Specially for Znahar
 if WindowState <> wsMaximized then
  begin
   SaveDW('WindowX',Left);
   SaveDW('WindowY',Top);
   SaveDW('WindowWidth',Width);
   SaveDW('WindowHeight',Height);
  end;
  
 SaveDW('Filtering',Ord(IsFilt));
 SaveDW('FilterQ',Filt_M);
 SaveDW('TrkClBk',TrkClBk);
 SaveDW('TrkClTxt',TrkClTxt);
 SaveDW('TrkClHlBk',TrkClHlBk);
 SaveDW('TrkClSelBk',TrkClSelBk);
 SaveDW('TrkClSelTxt',TrkClSelTxt);

 //specially for Znahar
 for i := 0 to 5 do
  SaveDW(PChar('ToolBar' + IntToStr(i)),Ord(PopupMenu3.Items[i].Checked));

finally
 OptionsDone;
end;
end;

procedure TMainForm.LoadOptions;

 function GetDW(const Nm:string; out Vl:integer):boolean;
 var
  s:string;
 begin
 Result := OptionsRead(Nm,s) and TryStrToInt(s,Vl);
 end;

 function GetStr(const Nm:string; out Vl:string):boolean;
 begin
 Result := OptionsRead(Nm,Vl);
 end;

var
 s:string;
 i,v:integer;

begin
if OptionsInit(False) then
 begin
  {$IFDEF Windows}
  if GetDW('Priority',v) then SetPriority(v);
  {$ENDIF Windows}
  if GetDW('ChanAllocIndex',v) then
   if v <> ChanAllocIndex then
    SetChannelsAllocationVis(v);
  if GetDW('AY_Freq',v) then
   if v <> AY_Freq then
    Set_Chip_Frq(v);
  if GetDW('StdChannelsAllocation',v) then
   if v <> StdChannelsAllocation then
    ToggleChanAlloc.Caption :=  SetStdChannelsAllocation(v);
  if GetDW('Interrupt_Freq',v) then
   if v <> Interrupt_Freq then
    SetIntFreqEx(v);
  if GetDW('ChipType',v) then
   if v in [1,2] then
    SetEmulatingChip(ChTypes(v));
  if GetDW('FeaturesLevel',v) then
   FeaturesLevel := v;
  if GetDW('DetectFeaturesLevel',v) then
   DetectFeaturesLevel := v <> 0;
  if GetDW('VortexModuleHeader',v) then
   VortexModuleHeader := v <> 0;
  if GetDW('DetectModuleHeader',v) then
   DetectModuleHeader := v <> 0;
  if GetDW('SampleRate',v) then
   if v <> SampleRate then
    Set_Sample_Rate(v);
  if GetDW('SampleBit',v) then
   if v <> SampleBit then
    Set_Sample_Bit(v);
  if GetDW('NumberOfChannels',v) then
   if v <> NumberOfChannels then
    Set_Stereo(v);
  if GetDW('BufLen_ms',v) then
   if (v <> BufLen_ms) then
    SetBuffers(v,NumberOfBuffers);
  if GetDW('NumberOfBuffers',v) then
   if (v <> NumberOfBuffers) then
    SetBuffers(BufLen_ms,v);
  if GetDW('digsoundDevice',v) then
   if GetStr('digsoundDeviceName',s) then
    Set_WODevice(v,s);
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

  //Specially for Znahar
  if WindowState <> wsMaximized then
   begin
    if GetDW('WindowX',v) then Left := v;
    if GetDW('WindowY',v) then Top := v;
    if GetDW('WindowWidth',v) then Width := v;
    if GetDW('WindowHeight',v) then Height := v;
   end;

  if GetDW('Filter',v) then
   SetFilter(v <> 0);
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

  //specially for Znahar
  for i := 0 to 5 do
   if GetDW(PChar('ToolBar' + IntToStr(i)),v) then
    SetBar(i,v <> 0);

  OptionsDone;
 end;
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
 w:Word;
 CurrentWindow:TMDIChild;
 s:string;
 rs:TResourceStream;
 fs:TFileStream;
begin
if MDIChildCount = 0 then exit;
CurrentWindow := TMDIChild(ActiveMDIChild);
if SaveDialogSNDH.InitialDir = '' then
 SaveDialogSNDH.InitialDir := OpenDialog.InitialDir;

if CurrentWindow.WinFileName = '' then
 MainForm.SaveDialogSNDH.FileName := 'VTIIModule' + IntToStr(CurrentWindow.WinNumber)
else
 MainForm.SaveDialogSNDH.FileName := ChangeFileExt(ExtractFileName(CurrentWindow.WinFileName),'');

repeat
 if not SaveDialogSNDH.Execute then exit;
 s := LowerCase(ExtractFileExt(SaveDialogSNDH.FileName));
 if s = '.snd' then
  SaveDialogSNDH.FileName := SaveDialogSNDH.FileName + 'h'
 else if s <> '.sndh' then
  SaveDialogSNDH.FileName := SaveDialogSNDH.FileName + '.sndh'
until AllowSave(SaveDialogSNDH.FileName);

SaveDialogSNDH.InitialDir := ExtractFileDir(SaveDialogSNDH.FileName);

rs := TResourceStream.Create(HInstance,'SNDHPLAYER','SNDH');
try
 sndhplsz := rs.Size;

 if not VTM2PT3(@PT3,CurrentWindow.VTMP,Size) then
  begin
   Application.MessageBox(PAnsiChar(Mes_CantCompileTooBig),PAnsiChar(SaveDialogSNDH.FileName));
   Exit;
  end;

 fs := TFileStream.Create(SaveDialogSNDH.FileName,fmCreate);
 try
  fs.CopyFrom(rs,16);

  sndhhdrsz := 10;
  with CurrentWindow do
   begin
    i := Length(VTMP^.Title);
    if i <> 0 then
     begin
      inc(sndhhdrsz,4 + i + 1);
      fs.WriteBuffer(TITL,4);
      fs.WriteBuffer(VTMP^.Title[1],i + 1);
     end;
    i := Length(VTMP^.Author);
    if i <> 0 then
     begin
      inc(sndhhdrsz,4 + i + 1);
      fs.WriteBuffer(COMM,4);
      fs.WriteBuffer(VTMP^.Author[1],i + 1);
     end;
    fs.WriteBuffer(CONV,4);
    i := Length(FullVersString) + 1; Inc(sndhhdrsz,i);
    fs.WriteBuffer(FullVersString[1],i);
    s := '';
    if InputQuery('SNDHv2 Extra TAG','Year of release (empty if no):',s) then
     begin
      s := Trim(s);
      i := Length(s);
      if i <> 0 then
       begin
        Inc(sndhhdrsz,i + 5);
        fs.WriteBuffer(YEAR,4);
        fs.WriteBuffer(s[1],i + 1);
       end;
     end;
    j := round(Interrupt_Freq / 1000);
    s := 'TC' + IntToStr(j);
    i := Length(s) + 1; Inc(sndhhdrsz,i);
    fs.WriteBuffer(s[1],i);
    fs.WriteBuffer(TIME,4);
    i := round(TotInts / j); if i > 65535 then i := 65535;
    fs.WriteWord(SwapW(i));
    if (sndhhdrsz and 1) <> 0 then
     begin
      Inc(sndhhdrsz);
      i := 0; fs.WriteByte(i);
     end;
    fs.CopyFrom(rs,sndhplsz - 16);
    fs.WriteBuffer(PT3,Size);
   end;
  i := -2;
  for j := 0 to 2 do
   begin
    inc(i,4); rs.Seek(i,soBeginning); w := Swap(rs.ReadWord);
    Inc(w,sndhhdrsz);
    fs.Seek(2 + j*4,soBeginning); fs.WriteWord(Swap(w));
   end;
 finally
  fs.Free;
 end;
finally
 rs.Free;
end;
end;

procedure TMainForm.SaveforZXMenuClick(Sender: TObject);
var
 s:string;
 PT3_1,PT3_2:TSpeccyModule;
 i,t,j,k:integer;
 rs:TResourceStream;
 fs:TFileStream;
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
if not VTM2PT3(@PT3_1,CurrentWindow.VTMP,ZXModSize1) then
 begin
  Application.MessageBox(PAnsiChar(Mes_CantCompileTooBig),PAnsiChar(CurrentWindow.Caption));
  Exit;
 end;
ZXModSize2 := 0;
if (CurrentWindow.TSWindow <> nil) and not VTM2PT3(@PT3_2,CurrentWindow.TSWindow.VTMP,ZXModSize2) then
 begin
  Application.MessageBox(PAnsiChar(Mes_CantCompileTooBig),PAnsiChar(CurrentWindow.TSWindow.Caption));
  Exit;
 end;
if CurrentWindow.TSWindow = nil then
 rs := TResourceStream.Create(HInstance,'ZXAYPLAYER','ZXAY')
else
 rs := TResourceStream.Create(HInstance,'ZXTSPLAYER','ZXTS');
try
zxplsz := rs.ReadWord;
zxdtsz := rs.ReadWord;
if ExpDlg.ShowModal <> mrOK then
 Exit;
if SaveDialogZXAY.InitialDir = '' then
 SaveDialogZXAY.InitialDir := OpenDialog.InitialDir;
SaveDialogZXAY.FilterIndex := ExpDlg.RadioGroup1.ItemIndex + 1;
SetDialogZXAYExt;

if CurrentWindow.WinFileName <> '' then
 SaveDialogZXAY.FileName := ChangeFileExt(ExtractFileName(CurrentWindow.WinFileName),'')
else if (CurrentWindow.TSWindow <> nil) and (CurrentWindow.TSWindow.WinFileName <> '') then
 SaveDialogZXAY.FileName := ChangeFileExt(ExtractFileName(CurrentWindow.TSWindow.WinFileName),'')
else
 SaveDialogZXAY.FileName := 'VTIIModule' + IntToStr(CurrentWindow.WinNumber);

repeat
 if not SaveDialogZXAY.Execute then
  Exit;
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
  if ZXModSize1 + ZXModSize2 + zxplsz + zxdtsz > 65536 then
   begin
    Application.MessageBox(PAnsiChar(Mes_SizeTooBig),PAnsiChar(Mes_CantExport));
    Exit;
   end;
  SetLength(pl,zxplsz);
  rs.ReadBuffer(pl[0],zxplsz);
  repeat
   i := rs.ReadWord;
   if i >= zxplsz - 1 then
    break;
    Inc(PWord(@pl[i])^,ZXCompAddr);
  until False;
  repeat
   i := rs.ReadWord;
   if i >= zxplsz then
    break;
   Inc(PByte(@pl[i])^,ZXCompAddr);
  until False;
  repeat
   i := rs.ReadWord;
   if i >= zxplsz then
    break;
    PByte(@pl[i])^ := (rs.ReadWord + ZXCompAddr) shr 8;
  until False;
  if ExpDlg.LoopChk.Checked then pl[10] := pl[10] or 1;
 end;
finally
 rs.Free;
end;
fs := TFileStream.Create(SaveDialogZXAY.FileName,fmCreate);
try
i := ZXModSize1;
case t of
0,1:
 begin
  inc(i,ZXModSize2);
  if t = 0 then
   inc(i,zxplsz + zxdtsz)
  else if CurrentWindow.TSWindow <> nil then
   inc(i,SizeOf(TSData));
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
      Application.MessageBox(PAnsiChar(Mes_HobetaSizeTooBig),PAnsiChar(Mes_CantExport));
      Exit;
     end;
    k := 0;
    for j := 0 to 14 do
     Inc(k,Ind[j]);
    CheckSum := k * 257 + 105;
   end;
  fs.WriteBuffer(hobetahdr,sizeof(hobetahdr));
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
         Length(CurrentWindow.VTMP^.Title) + 1;
    PAuthor := SwapW(j);
    inc(j,Length(CurrentWindow.VTMP^.Author) + 1 - 2);
    PMisc := SwapW(j);
    NumOfSongs := 0;
    FirstSong := 0;
    PSongsStructure := $200;
   end;
  fs.WriteBuffer(AYFileHeader,SizeOf(TAYFileHeader));
  with SongStructure do
   begin
    PSongName := SwapW(4 + SizeOf(TSongData) + SizeOf(TPoints));
    PSongData := $200;
   end;
  fs.WriteBuffer(SongStructure,SizeOf(TSongStructure));

  with AYSongData do
   begin
    ChanA := 0;
    ChanB := 1;
    ChanC := 2;
    Noise := 3;
    j := CurrentWindow.TotInts;
    if (CurrentWindow.TSWindow <> nil) and (CurrentWindow.TSWindow.TotInts > j) then
     j := CurrentWindow.TSWindow.TotInts;
    if j > 65535 then SongLength := 65535 else SongLength := SwapW(j);
    FadeLength := 0;
    if CurrentWindow.TSWindow = nil then
     begin
      HiReg := 0;
      LoReg := 0;
     end
    else
     begin
      j := ZXCompAddr + zxplsz + zxdtsz + ZXModSize1;
      HiReg := j shr 8;
      LoReg := j;
     end;
    PPoints := $400;
    PAddresses := $800;
   end;
  fs.WriteBuffer(AYSongData,SizeOf(TSongData));
  with AYPoints do
   begin
    Stek := SwapW(ZXCompAddr);
    Init := SwapW(ZXCompAddr);
    Inter := SwapW(ZXCompAddr + 5);
    Adr1 := SwapW(ZXCompAddr);
    Len1 := Swap(zxplsz);
    j := 10 + Length(CurrentWindow.VTMP^.Title) +
                      Length(CurrentWindow.VTMP^.Author) +
                      Length(FullVersString) + 3;
    Offs1 := SwapW(j);
    Adr2 := SwapW(ZXCompAddr + zxplsz + zxdtsz);
    Len2 := SwapW(ZXModSize1 + ZXModSize2);
    Offs2 := SwapW(j - 6 + zxplsz);
    Zero := 0;
   end;
  fs.WriteBuffer(AYPoints,SizeOf(TPoints));
  j := Length(CurrentWindow.VTMP^.Title);
  if j <> 0 then
   fs.WriteBuffer(CurrentWindow.VTMP^.Title[1],j + 1)
  else
   fs.WriteByte(j);
  j := Length(CurrentWindow.VTMP^.Author);
  if j <> 0 then
   fs.WriteBuffer(CurrentWindow.VTMP^.Author[1],j + 1)
  else
   fs.WriteByte(j);
  fs.WriteBuffer(FullVersString[1],Length(FullVersString) + 1);
 end;
3:
 begin
  with SCLHdr do
   begin
    SCL := 'SINCLAIR'; NBlk := 2;
    if CurrentWindow.TSWindow <> nil then
     Name1 := 'tsplayer'
    else
     Name1 := 'vtplayer';
    Typ1 := 'C';
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
    Leng2 := ZXModSize1 + ZXModSize2;
    Sect2 := Leng2 shr 8;
    if Leng2 and 255 <> 0 then Inc(Sect2);
    k := 0;
    for j := 0 to sizeof(SCLHdr) - 1 do Inc(k,Ind[j]);
   end;
  fs.WriteBuffer(SCLHdr,sizeof(SCLHdr));
  for j := 0 to zxplsz - 1 do Inc(k,pl[j]);
  for j := 0 to ZXModSize1 - 1 do Inc(k,PT3_1.Index[j]);
  if CurrentWindow.TSWindow <> nil then
   for j := 0 to ZXModSize2 - 1 do Inc(k,PT3_2.Index[j]);
 end;
4:
 begin
  with TAPHdr do
   begin
    Sz := 19; Flag := 0; Typ := 3;
    if CurrentWindow.TSWindow <> nil then
     Name := 'tsplayer  '
    else
     Name := 'vtplayer  ';
    Leng := zxplsz; Start := ZXCompAddr; Trash := 32768;
    k := 0; for j := 2 to 19 do k := k xor Ind[j]; Sum := k;
    fs.WriteBuffer(TAPHdr,21);
    Sz := 2 + zxplsz; Flag := 255;
   end;
  fs.WriteBuffer(TAPHdr,3);
 end;
end;
if t <> 1 then
 fs.WriteBuffer(pl[0],zxplsz);
case t of
4:
 begin
  with TAPHdr do
   begin
    k := 255; for j := 0 to zxplsz - 1 do k := k xor pl[j];
    fs.WriteByte(k);
    Sz := 19; Flag := 0; Typ := 3; Name := '          ';
    Leng := ZXModSize1 + ZXModSize2; Start := ZXCompAddr + zxplsz + zxdtsz; Trash := 32768;
    s := ExtractFileName(SaveDialogZXAY.FileName);
    j := Length(s) - 4;
    if j > 10 then j := 10;
    if j > 0 then Move(s[1],Name,j);
    k := 0; for j := 2 to 19 do k := k xor Ind[j]; Sum := k;
    fs.WriteBuffer(TAPHdr,21);
    Sz := 2 + ZXModSize1 + ZXModSize2; Flag := 255;
   end;
  fs.WriteBuffer(TAPHdr,3);
 end;
3:
 begin
  j := zxplsz mod 256;
  if j <> 0 then
   begin
    j := 256 - j;
    FillChar(pl[0],j,0);
    fs.WriteBuffer(pl[0],j);
   end;
 end;
0:
 begin
  if zxdtsz > zxplsz then SetLength(pl,zxdtsz);
  FillChar(pl[0],zxdtsz,0);
  fs.WriteBuffer(pl[0],zxdtsz);
 end;
end;
fs.WriteBuffer(PT3_1,ZXModSize1);
if CurrentWindow.TSWindow <> nil then
 fs.WriteBuffer(PT3_2,ZXModSize2);
case t of
4:
 begin
  k := 255; for j := 0 to ZXModSize1 - 1 do k := k xor PT3_1.Index[j];
  if CurrentWindow.TSWindow <> nil then
   for j := 0 to ZXModSize2 - 1 do k := k xor PT3_2.Index[j];
  fs.WriteByte(k);
 end;
3:
 begin
  j := (ZXModSize1 + ZXModSize2) mod 256;
  if j <> 0 then
   begin
    j := 256 - j;
    FillChar(pl[0],j,0);
    fs.WriteBuffer(pl[0],j);
   end;
  fs.WriteDWord(k);
 end;
0..1:
 begin
  if (t = 1) and (CurrentWindow.TSWindow <> nil) then
   begin
    TSData.Size1 := ZXModSize1;
    TSData.Size2 := ZXModSize2;
    fs.WriteBuffer(TSData,SizeOf(TSData));
   end;
  with hobetahdr do
   if SectLeng <> i then
    begin
     FillChar(PT3_1,SectLeng - i,0);
     fs.WriteBuffer(PT3_1,SectLeng - i);
    end;
 end;
end;
finally
 fs.Free;
end;
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
4:SaveDialogZXAY.DefaultExt := 'tap';
end;
end;

procedure TMainForm.SaveDialogZXAYTypeChange(Sender: TObject);
begin
SetDialogZXAYExt;
end;

{$IFDEF Windows}
procedure TMainForm.SetPriority(Pr: longword);
var
 HMyProcess:HANDLE;
begin
if Pr <> 0 then
 Priority := Pr
else
 Pr := NORMAL_PRIORITY_CLASS;
HMyProcess := GetCurrentProcess;
SetPriorityClass(HMyProcess,Pr);
//FileClose(HMyProcess); { *Преобразовано из CloseHandle* }
end;
{$ENDIF Windows}

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
   Result := TMDIChild(MainForm.ActiveMDIChild).Tracks = A;
 end;
end;

procedure TMainForm.EditCopy1Update(Sender: TObject);
begin
EditCopy1.Enabled := CanCopy;
end;

procedure TMainForm.EditCut1Update(Sender: TObject);
begin
EditCut1.Enabled := CanCopy;
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
EditPaste1.Enabled := R;
end;

function GetCopyControl(out CT:integer;out WC:TWinControl):boolean;
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
    if Result then CT := 1;
   end;
 end;
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
 1: (WC as TTracks).PasteFromClipboard(False);
 end;
end;

procedure TMainForm.UndoUpdate(Sender: TObject);
begin
Undo.Enabled := (MDIChildCount <> 0) and
                        (TMDIChild(ActiveMDIChild).ChangeCount > 0);
end;

procedure TMainForm.UndoExecute(Sender: TObject);
begin
if (MDIChildCount = 0) then exit;
TMDIChild(ActiveMDIChild).DoUndo(1,True);
end;

procedure TMainForm.RedoUpdate(Sender: TObject);
begin
Redo.Enabled := (MDIChildCount <> 0) and
                        (TMDIChild(ActiveMDIChild).ChangeCount < TMDIChild(ActiveMDIChild).ChangeTop);
end;

procedure TMainForm.RedoExecute(Sender: TObject);
begin
if (MDIChildCount = 0) then exit;
TMDIChild(ActiveMDIChild).DoUndo(1,False);
end;

procedure TMainForm.CheckCommandLine;
var
 i:integer;
begin
i := ParamCount;
if i = 0 then exit;
for i := i downto 1 do CreateMDIChild(ExpandFileName(ParamStr(i)));
end;

function TMainForm.AllowSave(fn:string):boolean;
begin
Result := not FileExists(fn) or
 (MessageDlg('File ''' + fn + ''' exists. Overwrite?',
        mtConfirmation,[mbYes,mbNo],0) = mrYes);
end;

procedure TMainForm.TransposeChannel(WorkWin:TMDIChild;Pat,Chn,i,Semitones:integer);
var
 j:integer;
begin
if WorkWin.VTMP^.Patterns[Pat]^.Items[i].Channel[Chn].Note >= 0 then
 begin
  j := WorkWin.VTMP^.Patterns[Pat]^.Items[i].Channel[Chn].Note + Semitones;
  if (j >= 96) or (j < 0) then exit;
  WorkWin.VTMP^.Patterns[Pat]^.Items[i].Channel[Chn].Note := j;
 end;
end;

procedure TMainForm.TransposeColumns(WorkWin:TMDIChild;Pat:integer;Env:boolean;Chans:TChansArrayBool;LFrom,LTo,Semitones:integer;MakeUndo:boolean);
var
 stk:real;
 i,e{,PLen}:integer;
 f:boolean;
 OldPat:PPattern;
begin
if Semitones = 0 then exit;
with WorkWin do
 begin
  if VTMP^.Patterns[Pat] = nil then exit;
  f := Env or Chans[0] or Chans[1] or Chans[2];
  if not f then exit;
//  PLen := VTMP^.Patterns[Pat]^.Length;
//  if LTo >= PLen then LTo := PLen - 1;
  //Work with all pattern lines even if it greater then pattern length
  if LTo >= MaxPatLen then LTo := MaxPatLen - 1;
  if LFrom > LTo then exit;
  SongChanged := True;
  if MakeUndo then
   begin
    New(OldPat); OldPat^ := VTMP^.Patterns[Pat]^;
   end;
  if Chans[0] then
   for i := LFrom to LTo do
    TransposeChannel(WorkWin,Pat,0,i,Semitones);
  if Chans[1] then
   for i := LFrom to LTo do
    TransposeChannel(WorkWin,Pat,1,i,Semitones);
  if Chans[2] then
   for i := LFrom to LTo do
    TransposeChannel(WorkWin,Pat,2,i,Semitones);
  if Env then
   begin
    stk := exp(-Semitones / 12 * ln(2));
    for i := LFrom to LTo do
     begin
      e := VTMP^.Patterns[Pat]^.Items[i].Envelope; //if e = 0 then e := 1;
      e := round(e * stk);
//      if (e = 1) and (VTMP^.Patterns[Pat]^.Items[i].Envelope = 0) then e := 0;
      if (e >= 0) and (e < $10000) then VTMP^.Patterns[Pat]^.Items[i].Envelope := e;
     end;
   end;
  if MakeUndo then
   begin
    AddUndo(CATransposePattern,Pat,0);
    ChangeList[ChangeCount - 1].Pattern := {%H-}OldPat;
   end;
  if PatNum = Pat then
   begin
    if Tracks.Focused then HideCaret(Tracks.Handle);
    Tracks.RedrawTracks;
    if Tracks.Focused then ShowCaret(Tracks.Handle);
   end;
 end;
end;

procedure TMainForm.TransposeSelection(Semitones:integer);
var
 X1,X2,Y1,Y2:integer;
 Chans:TChansArrayBool;
begin
if Semitones = 0 then exit;
if MDIChildCount = 0 then exit;
with TMDIChild(ActiveMDIChild).Tracks do
 begin
  X2 := CursorX;
  X1 := SelX;
  if X1 > X2 then
   begin
    X1 := X2;
    X2 := SelX
   end;
  Y1 := SelY;
  Y2 := ShownFrom - N1OfLines + CursorY;
  if Y1 > Y2 then
   begin
    Y1 := Y2;
    Y2 := SelY
   end;
  Chans[ChanAlloc[0]] := (X1 <= 8) and (X2 >= 8);
  Chans[ChanAlloc[1]] := (X1 <= 22) and (X2 >= 22);
  Chans[ChanAlloc[2]] := (X1 <= 36) and (X2 >= 36);
  TransposeColumns(TMDIChild(ActiveMDIChild),TMDIChild(ActiveMDIChild).PatNum,
                   X1 <= 3,Chans,Y1,Y2,Semitones,True);
 end;
end;

procedure TMainForm.TransposeUp1Update(Sender: TObject);
begin
TransposeUp1.Enabled := (MDIChildCount <> 0) and
                        TMDIChild(ActiveMDIChild).Tracks.Focused;
end;

procedure TMainForm.TransposeDown1Update(Sender: TObject);
begin
TransposeDown1.Enabled := (MDIChildCount <> 0) and
                        TMDIChild(ActiveMDIChild).Tracks.Focused;
end;

procedure TMainForm.TransposeUp12Update(Sender: TObject);
begin
TransposeUp12.Enabled := (MDIChildCount <> 0) and
                        TMDIChild(ActiveMDIChild).Tracks.Focused;
end;

procedure TMainForm.TransposeDown12Update(Sender: TObject);
begin
TransposeDown12.Enabled := (MDIChildCount <> 0) and
                        TMDIChild(ActiveMDIChild).Tracks.Focused;
end;

procedure TMainForm.TransposeUp1Execute(Sender: TObject);
begin
TransposeSelection(1);
end;

procedure TMainForm.TransposeDown1Execute(Sender: TObject);
begin
TransposeSelection(-1);
end;

procedure TMainForm.TransposeUp12Execute(Sender: TObject);
begin
TransposeSelection(12);
end;

procedure TMainForm.TransposeDown12Execute(Sender: TObject);
begin
TransposeSelection(-12);
end;

//specially for Znahar
procedure TMainForm.SetBar(BarNum: integer; Value: boolean);
begin
PopupMenu3.Items[BarNum].Checked := Value;
case BarNum of
0:
 begin
  ToolButton9.Visible := Value;
  ToolButton1.Visible := Value;
  ToolButton2.Visible := Value;
  ToolButton3.Visible := Value;
  ToolButton31.Visible := Value;
  ToolButton30.Visible := Value;
 end;
1:
 begin
  ToolButton4.Visible := Value;
  ToolButton5.Visible := Value;
  ToolButton6.Visible := Value;
  ToolButton7.Visible := Value;
 end;
2:
 begin
  ToolButton23.Visible := Value;
  ToolButton24.Visible := Value;
  ToolButton22.Visible := Value;
 end;
3:
 begin
  ToolButton8.Visible := Value;
  ToolButton10.Visible := Value;
  ToolButton11.Visible := Value;
  ToolButton12.Visible := Value;
 end;
4:
 begin
  ToolButton14.Visible := Value;
  ToolButton18.Visible := Value;
  ToolButton13.Visible := Value;
  ToolButton20.Visible := Value;
  ToolButton21.Visible := Value;
  ToolButton29.Visible := Value;
  ToolButton15.Visible := Value;
  ToolButton17.Visible := Value;
  ToolButton25.Visible := Value;
  ToolButton16.Visible := Value;
 end;
5:
 begin
  ToolButton26.Visible := Value;
  ToolButton27.Visible := Value;
  ToolButton28.Visible := Value;
 end;
end;
end;

procedure TMainForm.PopupMenu3Click(Sender: TObject);
begin
SetBar((Sender as TMenuItem).Tag, not (Sender as TMenuItem).Checked);
end;

procedure TMainForm.ExpandTwice1Click(Sender: TObject);
var
 PL,NL,i:integer;
 OldPat:PPattern;
begin
if MDIChildCount = 0 then exit;
with TMDIChild(ActiveMDIChild) do
 begin
  PL := DefPatLen;
  if (VTMP^.Patterns[PatNum] <> nil) then
   PL := VTMP^.Patterns[PatNum]^.Length;
  NL := PL * 2;
  if NL <= MaxPatLen then
   begin
    SongChanged := True;
    ValidatePattern2(PatNum);
    New(OldPat); OldPat^ := VTMP^.Patterns[PatNum]^;
    AddUndo(CAExpandCompressPattern,0,0);
    ChangeList[ChangeCount - 1].Pattern := OldPat;
    VTMP^.Patterns[PatNum]^.Length := NL; UpDown5.Position := NL;
    for i := PL - 1 downto 0 do
     begin
      with VTMP^.Patterns[PatNum]^.Items[i*2+1] do
       begin
        Envelope := 0;
        Noise := 0;
        Channel[0] := EmptyChannelLine;
        Channel[1] := EmptyChannelLine;
        Channel[2] := EmptyChannelLine;
       end;
      VTMP^.Patterns[PatNum]^.Items[i*2] := VTMP^.Patterns[PatNum]^.Items[i];
{      with VTMP^.Patterns[PatNum]^.Items[i*2] do
       begin
        Envelope := VTMP^.Patterns[PatNum]^.Items[i].Envelope;
        Noise := VTMP^.Patterns[PatNum]^.Items[i].Noise;
        Channel[0] := VTMP^.Patterns[PatNum]^.Items[i].Channel[0];
        Channel[1] := VTMP^.Patterns[PatNum]^.Items[i].Channel[1];
        Channel[2] := VTMP^.Patterns[PatNum]^.Items[i].Channel[2];
       end;}
     end;
    CheckTracksAfterSizeChanged(NL);
   end
  else
   ShowMessage('To expand pattern size twice original size must be ' +
    IntToStr(MaxPatLen div 2) + ' or smaller.');
 end;
end;

procedure TMainForm.Compresspattern1Click(Sender: TObject);
var
 PL,NL,i:integer;
 OldPat:PPattern;
begin
if MDIChildCount = 0 then exit;
with TMDIChild(ActiveMDIChild) do
 begin
  PL := DefPatLen;
  if (VTMP^.Patterns[PatNum] <> nil) then
   PL := VTMP^.Patterns[PatNum]^.Length;
  NL := PL div 2;
  if NL > 0 then
   begin
    SongChanged := True;
    ValidatePattern2(PatNum);
    New(OldPat); OldPat^ := VTMP^.Patterns[PatNum]^;
    AddUndo(CAExpandCompressPattern,0,0);
    ChangeList[ChangeCount - 1].Pattern := OldPat;
    VTMP^.Patterns[PatNum]^.Length := NL; UpDown5.Position := NL;
    for i := 1 to NL - 1 do
     VTMP^.Patterns[PatNum]^.Items[i] := VTMP^.Patterns[PatNum]^.Items[i*2];
    for i := NL to MaxPatLen - 1 do
     with VTMP^.Patterns[PatNum]^.Items[i] do
      begin
       Envelope := 0;
       Noise := 0;
       Channel[0] := EmptyChannelLine;
       Channel[1] := EmptyChannelLine;
       Channel[2] := EmptyChannelLine;
      end;
    CheckTracksAfterSizeChanged(NL);
   end
  else
   ShowMessage('To compress pattern size twice original size must be 2 or bigger.');
 end;
end;

procedure TMainForm.Merge1Click(Sender: TObject);
begin
if MDIChildCount = 0 then exit;
TMDIChild(ActiveMDIChild).Tracks.PasteFromClipboard(True);
end;

procedure TMainForm.VisTimerTimer(Sender: TObject);
var
 CurVisPos:Int64;
 i:integer;
begin
if IsPlaying and (PlayMode in [PMPlayModule,PMPlayPattern]) and
   digsound_gotposition(CurVisPos) then
 begin
  CurVisPos := CurVisPos mod VisTickMax div VisStep;
  for i := 0 to NumberOfSoundChips-1 do
   with PlayingGrid[CurVisPos] do
    RedrawPlWindow(PlayingWindow[i],M[i] and $1FF,(M[i] shr 9) and $FF,(M[i] shr 17) and $1FF - 1);
 end;
end;

//some MDI actions from Delphi 7 not implemented in Lazarus yet, so temporary here
type
  TTileMode = (tbHorizontal, tbVertical);

procedure DoTile(Form: TForm; TileMode: TTileMode);
{$IFDEF Windows}
const
  TileParams: array[TTileMode] of Word = (MDITILE_HORIZONTAL, MDITILE_VERTICAL);
begin
  if (Form.FormStyle = fsMDIForm) and (Form.ClientHandle <> 0) then
    SendMessage(Form.ClientHandle, WM_MDITILE, TileParams[TileMode], 0);
{$ELSE}
begin
Form.Tile;
{$ENDIF Windows}
end;

procedure TMainForm.WindowArrangeAll1Execute(Sender: TObject);
begin
ArrangeIcons;
end;

procedure TMainForm.WindowCascade1Execute(Sender: TObject);
begin
Cascade;
end;

procedure TMainForm.WindowMinimizeAll1Execute(Sender: TObject);
var
  I: Integer;
begin
  { Must be done backwards through the MDIChildren array }
  for I := MDIChildCount - 1 downto 0 do
    MDIChildren[I].WindowState := wsMinimized;
end;

procedure TMainForm.WindowTileHorizontal1Execute(Sender: TObject);
begin
DoTile(Self, tbHorizontal);
end;

procedure TMainForm.WindowTileVertical1Execute(Sender: TObject);
begin
DoTile(Self, tbVertical);
end;

//shotructs are lost due focus on invisible parent or elsewhere (LCL bug)
procedure TMainForm.WndProc(var TheMessage : TLMessage);
begin
with TheMessage do
case Msg of
  LM_SETFOCUS:
    begin
      TheMessage.Result := 0;
      LCLIntf.SetFocus(Handle);
      Exit;
    end;
end;
inherited WndProc(TheMessage);
end;

end.
