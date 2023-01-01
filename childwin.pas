{
This is part of Vortex Tracker II project
(c)2000-2005 S.V.Bulba
Author Sergey Bulba
E-mail: vorobey@mail.khstu.ru
Support page: http://bulba.at.kz/
}

unit Childwin;

interface

uses Windows, Messages, Types, Classes, Graphics, Forms, Controls, StdCtrls, SysUtils,
        trfuncs, ComCtrls, WaveOutAPI, Grids, Menus, MMSystem, AY, Buttons,
  ExtCtrls, Dialogs;

type
  TTracks = class(TWinControl)
  public
    CelW,CelH:integer;
    CursorX,CursorY,SelX,SelY:integer;
    ShownFrom,NOfLines,N1OfLines:integer;
    HLStep:integer;
    ShownPattern:PPattern;
    BigCaret:boolean;
    KeyPressed:integer;
    Clicked:boolean;
    constructor Create(AOwner: TComponent); override;
    procedure DefaultHandler(var Message); override;
    procedure ShowSelection(DC:HDC);
    procedure RemoveSelection(DC:HDC;DontRedraw:boolean);
    procedure SelectAll;
    procedure RedrawTracks(DC:HDC);
    procedure RecreateCaret;
    procedure CreateMyCaret;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure ClearSelection;
  end;

  TTestLine = class(TWinControl)
  public
    CelW,CelH:integer;
    CursorX:integer;
    BigCaret:boolean;
    KeyPressed:integer;
    TestOct:integer;
    TestSample:boolean;
    ParWind:TForm;
    constructor Create(AOwner: TComponent); override;
    procedure DefaultHandler(var Message); override;
    procedure RedrawTestLine(DC:HDC);
    procedure RecreateCaret;
    procedure CreateMyCaret;
    procedure TestLineMouseDown(Sender: TObject; Button: TMouseButton;
     Shift: TShiftState; X, Y: Integer);
    procedure TestLineKeyDown(Sender: TObject; var Key: Word;
     Shift: TShiftState);
    procedure TestLineKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TestLineExit(Sender: TObject);
  end;

  TSamples = class(TWinControl)
  public
    InputSNumber,CelW,CelH:integer;
    CursorX,CursorY{,SelW,SelH}:integer;
    ShownFrom,NOfLines:integer;
    ShownSample:PSample;
    BigCaret:integer;
    constructor Create(AOwner: TComponent); override;
    procedure DefaultHandler(var Message); override;
    procedure RedrawSamples(DC:HDC);
    procedure RecreateCaret;
    procedure CreateMyCaret;
  end;

  TOrnaments = class(TWinControl)
  public
    InputONumber,CelW,CelH:integer;
    CursorX,CursorY{,SelW,SelH}:integer;
    ShownOrnament:POrnament;
    constructor Create(AOwner: TComponent); override;
    procedure DefaultHandler(var Message); override;
    procedure RedrawOrnaments(DC:HDC);
  end;

  TMDIChild = class(TForm)
    PageControl1: TPageControl;
    PatternsSheet: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    UpDown1: TUpDown;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    StringGrid1: TStringGrid;
    Edit6: TEdit;
    UpDown3: TUpDown;
    SamplesSheet: TTabSheet;
    OrnamentsSheet: TTabSheet;
    Edit7: TEdit;
    UpDown4: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    Edit8: TEdit;
    UpDown5: TUpDown;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    UpDown2: TUpDown;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    OptTab: TTabSheet;
    Vtm3xxxGrp: TRadioGroup;
    SaveHead: TRadioGroup;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
    UpDown6: TUpDown;
    Label9: TLabel;
    Edit9: TEdit;
    UpDown7: TUpDown;
    Label10: TLabel;
    Label11: TLabel;
    Edit10: TEdit;
    UpDown8: TUpDown;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    GroupBox3: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    ListBox1: TListBox;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    Label26: TLabel;
    Label27: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    UpDown9: TUpDown;
    UpDown10: TUpDown;
    Edit13: TEdit;
    UpDown11: TUpDown;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    GroupBox4: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    UpDown12: TUpDown;
    Edit14: TEdit;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SaveTextDlg: TSaveDialog;
    LoadTextDlg: TOpenDialog;
    SpeedButton22: TSpeedButton;
    GroupBox5: TGroupBox;
    Edit15: TEdit;
    Label40: TLabel;
    UpDown13: TUpDown;
    CopyOrnBut: TSpeedButton;
    GroupBox6: TGroupBox;
    CopySamBut: TSpeedButton;
    Edit16: TEdit;
    UpDown14: TUpDown;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    GroupBox7: TGroupBox;
    Edit17: TEdit;
    UpDown15: TUpDown;
    AutoHLCheck: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TracksMoveCursorMouse(X,Y:integer;Sel,Mv:boolean);
    procedure TracksKeyDown(Sender: TObject; var Key: Word;
     Shift: TShiftState);
    procedure SamplesKeyDown(Sender: TObject; var Key: Word;
     Shift: TShiftState);
    procedure OrnamentsKeyDown(Sender: TObject; var Key: Word;
     Shift: TShiftState);
    procedure TracksMouseDown(Sender: TObject; Button: TMouseButton;
     Shift: TShiftState; X, Y: Integer);
    procedure SamplesMouseDown(Sender: TObject; Button: TMouseButton;
     Shift: TShiftState; X, Y: Integer);
    procedure OrnamentsMouseDown(Sender: TObject; Button: TMouseButton;
     Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure LoadTrackerModule(Name:string);
    procedure TracksMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure TracksMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure SamplesMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure SamplesMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ValidatePattern2(pat:integer);
    procedure TracksKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Exit(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure RestartPlayingPos(Pos:integer);
    procedure RestartPlayingLine(Line:integer);
    procedure RestartPlayingPatternLine(Enter:boolean);
    procedure StopAndRestart;
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure ChangePattern(n:integer);
    procedure Edit2Change(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure UpDown3ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure UpDown4ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Edit7Exit(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure UpDown5ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure ChangePatternLength(NL:integer);
    procedure Edit1Exit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure RerollToLine;
    procedure RerollToPatternLine;
    procedure ResetChanAlloc;
    procedure Vtm3xxxGrpClick(Sender: TObject);
    procedure SaveHeadClick(Sender: TObject);
    procedure RerollToPos(Pos:integer);
    procedure CreateTracks;
    procedure CreateSamples;
    procedure CreateOrnaments;
    procedure Edit5Change(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure UpDown6ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Edit9Exit(Sender: TObject);
    procedure UpDown7ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure ChangeSample(n:integer);
    procedure ChangeSampleLength(NL:integer);
    procedure ChangeSampleLoop(NL:integer);
    procedure ValidateSample2(sam:integer);
    procedure ChangeOrnament(n:integer);
    procedure ChangeOrnamentLength(NL:integer);
    procedure ChangeOrnamentLoop(NL:integer);
    procedure ValidateOrnament(orn:integer);
    procedure Edit10Exit(Sender: TObject);
    procedure UpDown8ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure ShowSamStats;
    procedure ShowOrnStats;
    procedure CalculatePos0;
    procedure CalculatePos(Line:integer);
    procedure ShowStat;
    procedure CalcTotLen;
    procedure ReCalcTimes;
    procedure ShowAllTots;
    procedure SetInitDelay(nd:integer);
    procedure SamplesVolMouse(x,y:integer);
    procedure TracksMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SamplesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox1Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure AddCurrentToSampTemplate;
    procedure SpeedButton14Click(Sender: TObject);
    procedure CopySampTemplateToCurrent;
    procedure CreateTestLines;
    procedure UpDown9ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Edit11Change(Sender: TObject);
    procedure Edit11Exit(Sender: TObject);
    procedure UpDown10ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Edit12Exit(Sender: TObject);
    procedure UpDown11ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Edit13Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToggleAutoEnv;
    procedure ToggleStdAutoEnv;
    procedure DoAutoEnv(i,j,k:integer);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TracksExit(Sender: TObject);
    procedure Edit14Exit(Sender: TObject);
    procedure DoStep(i:integer);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure LoadOrnament(FN:string);
    procedure LoadSample(FN:string);
    procedure LoadPattern(FN:string);
    procedure SpeedButton21Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SelectPosition(Pos:integer);
    procedure ToggleAutoStep;
    procedure SpeedButton22Click(Sender: TObject);
    procedure UpDown13ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure Edit15Exit(Sender: TObject);
    procedure CopyOrnButClick(Sender: TObject);
    procedure Edit16Exit(Sender: TObject);
    procedure UpDown14ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure CopySamButClick(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure UpDown15ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure AutoHLCheckClick(Sender: TObject);
    procedure CalcHLStep;
    procedure ChangeHLStep(NewStep:integer);
    procedure Edit17Exit(Sender: TObject);
    procedure UpDown15Click(Sender: TObject; Button: TUDBtnType);
  private
    { Private declarations }
  public
    { Public declarations }
    Tracks:TTracks;
    SampleTestLine,OrnamentTestLine:TTestLine;
    Samples:TSamples;
    Ornaments:TOrnaments;
    VTMP:PModule;
    PatNum,SamNum,OrnNum:integer;
    SongChanged:boolean;
    InputPNumber,PositionNumber,
    PosBegin,PosDelay,TotInts,LineInts:integer;
    xc,xt,xn,xe:array[0..2] of integer;
    AutoEnv,AutoStep:boolean;
    AutoEnv0,AutoEnv1,StdAutoEnvIndex:integer;
    OrGenRunning:boolean;
  end;

var
 PlayingWindow:TMDIChild;

implementation

uses Main, options, ShellApi;

{$R *.DFM}

function Ns(n:integer):shortint;
begin
 if n and $10 = 0 then
  Ns := n and $F
 else
  Ns := n or $F0
end;

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if PlayingWindow = Self then
 begin
  StopPlaying;
  MainForm.RestoreControls
 end; 
Action := caFree
end;

procedure TMDIChild.FormCreate(Sender: TObject);
var
 i,j:integer;
begin
 SaveTextDlg.InitialDir := ExtractFilePath(ParamStr(0));
 OrGenRunning := False;
 New(VTMP);
 VTMP.Title := '';
 VTMP.Author := '';
 VTMP.Ton_Table := 2;
 VTMP.Initial_Delay := 3;
 VTMP.Positions.Length := 0;
 VTMP.Positions.Loop := 0;
 for i := 1 to 31 do
  VTMP.Samples[i] := nil;
 for i := 0 to 15 do
  VTMP.Ornaments[i] := nil;
 for i := 0 to MaxPatNum do
  VTMP.Patterns[i] := nil;
 New(VTMP.Patterns[-1]);
 VTMP.Patterns[-1].Length := 2;
 SetLength(VTMP.Patterns[-1].Items,2);
 VTMP.Patterns[-1].Items[0].Envelope := 0;
 VTMP.Patterns[-1].Items[1].Envelope := 0;
 VTMP.Patterns[-1].Items[0].Noise := 0;
 VTMP.Patterns[-1].Items[1].Noise := 0;
 VTMP.Patterns[-1].Items[0].Channel[0] := EmptyChannelLine;
 VTMP.Patterns[-1].Items[0].Channel[1] := EmptyChannelLine;
 VTMP.Patterns[-1].Items[0].Channel[2] := EmptyChannelLine;
 VTMP.Patterns[-1].Items[1].Channel[0] := EmptyChannelLine;
 VTMP.Patterns[-1].Items[1].Channel[1] := EmptyChannelLine;
 VTMP.Patterns[-1].Items[1].Channel[2] := EmptyChannelLine;
 VTMP.Patterns[-1].Items[0].Channel[0].Note := 36;
 VTMP.Patterns[-1].Items[1].Channel[0].Note := 36;
 VTMP.Patterns[-1].Items[0].Channel[0].Sample := 1;
 VTMP.Patterns[-1].Items[1].Channel[0].Sample := 1;
 VTMP.Patterns[-1].Items[0].Channel[0].Envelope := 15;
 VTMP.Patterns[-1].Items[1].Channel[0].Envelope := 15;
 VTMP.Patterns[-1].Items[0].Channel[0].Ornament := 1;
 VTMP.Patterns[-1].Items[0].Channel[0].Volume := 15;
 VTMP.Patterns[-1].Items[1].Channel[0].Volume := 15;
 UpDown1.Max := MaxPatNum;
 UpDown5.Max := MaxPatLen;
 UpDown15.Max := MaxPatLen;
 for i := 0 to 2 do
  begin
   VTMP.IsChans[i].Global_Ton := True;
   VTMP.IsChans[i].Global_Noise := True;
   VTMP.IsChans[i].Global_Envelope := True;
   VTMP.IsChans[i].Sample := 1;
   VTMP.IsChans[i].EnvelopeEnabled := False;
   VTMP.IsChans[i].Ornament := 0;
   VTMP.IsChans[i].Volume := 15
  end;
 VTMP.New3xxxInterpretation := Correct3xxxInterpretation;
 Vtm3xxxGrp.ItemIndex := Ord(not Correct3xxxInterpretation);
 VTMP.VortexModule_Header := VortexModuleHeader;
 SaveHead.ItemIndex := Ord(not VortexModuleHeader);
 for i := 0 to 255 do
  StringGrid1.Cells[i,0] := '...';
 CreateTracks;
 Tracks.TabOrder := 0;
 CreateSamples;
 CreateOrnaments;
 CreateTestLines;
 Samples.TabOrder := 0;
 SampleTestLine.TabOrder := 6;
 Ornaments.TabOrder := 0;
 OrnamentTestLine.TabOrder := 6;
 i := Samples.Left * 2 + Samples.Width;
 SpeedButton13.Left := i;
 SpeedButton14.Left := i;
 SpeedButton23.Left := i;
 SpeedButton25.Left := i;
 SpeedButton24.Left := i;
 GroupBox6.Left := i + SpeedButton24.Width + Samples.Left;
 inc(i,Samples.Left + SpeedButton13.Width);
 Label27.Left := i;
 ListBox1.Left := i;
 i := Label27.Top;
 j := Label27.Height + 4;
 Dec(j,j mod Samples.CelH);
 ListBox1.Top := i + j;
 ListBox1.Height := Samples.Height + Samples.Top - i - j;
 ListBox1.Width := Samples.CelW * 22;
 ListBox1.Font := Samples.Font;
 for i := 0 to Length(MainForm.SampleLineTemplates) - 1 do
  ListBox1.Items.Add(GetSampleString(MainForm.SampleLineTemplates[i],False,True));
 ListBox1.ItemIndex := MainForm.CurrentSampleLineTemplate;
 i := Tracks.Left * 2 + Tracks.Width;
 SpeedButton26.Left := i;
 SpeedButton27.Left := i;
 GroupBox7.Left := i;
 i := ListBox1.Left + ListBox1.Width - Tracks.Left;
 if i < Tracks.Width + GroupBox7.Width + Tracks.Left then
  i := Tracks.Width + GroupBox7.Width + Tracks.Left;
 if i < StringGrid1.Width then
  i := StringGrid1.Width;
 PageControl1.ClientWidth := i + (Tracks.Left + PatternsSheet.Left) * 2;
 i := Tracks.Top + Tracks.Height;
 j := Samples.Top + Samples.Height;
 if i < j then i := j;
 PageControl1.ClientHeight := i + Tracks.Left + PatternsSheet.Top + 4;
 ClientWidth := PageControl1.Width;
 ClientHeight := PageControl1.Height;
 i := MainForm.ClientHeight - MainForm.StatusBar.Height -
                                        MainForm.ToolBar2.Height - 4;
 if (Top <> 0) and (Top + Height  > i) then
  begin
   Top := i - Height;
   if Top < 0 then Top := 0
  end;
 i := MainForm.ClientWidth - 4;
 if (Left <> 0) and (Left + Width  > i) then
  begin
   Left := i - Width;
   if Left < 0 then Left := 0
  end;

 AutoScroll := True;
 PatNum := 0;
 Edit2.Text := IntToStr(PatNum);
 SamNum := 1;
 Edit5.Text := IntToStr(SamNum);
 ShowSamStats;
 OrnNum := 1;
 Edit11.Text := IntToStr(OrnNum);
 ShowOrnStats;
 PositionNumber := 0;
 PosBegin := 0;
 LineInts := 0;
 PosDelay := VTMP.Initial_Delay;
 TotInts := 0;
 AutoEnv := False; StdAutoEnvIndex := 0; AutoEnv0 := 1; AutoEnv1 := 1;
 AutoStep := False;
 xc[0] := SpeedButton1.Left;
 xt[0] := SpeedButton2.Left;
 xn[0] := SpeedButton3.Left;
 xe[0] := SpeedButton4.Left;
 xc[1] := SpeedButton5.Left;
 xt[1] := SpeedButton6.Left;
 xn[1] := SpeedButton7.Left;
 xe[1] := SpeedButton8.Left;
 xc[2] := SpeedButton9.Left;
 xt[2] := SpeedButton10.Left;
 xn[2] := SpeedButton11.Left;
 xe[2] := SpeedButton12.Left;
 ResetChanAlloc;
 SongChanged := False
end;

procedure TMDIChild.ResetChanAlloc;
begin
if Tracks.Focused then HideCaret(Tracks.Handle);
Tracks.RemoveSelection(0,True);
Tracks.RedrawTracks(0);
if Tracks.Focused then
 begin
  SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                        Tracks.CelH * Tracks.CursorY);
  ShowCaret(Tracks.Handle)
 end; 
SpeedButton1.Left := xc[MainForm.ChanAlloc[0]];
SpeedButton2.Left := xt[MainForm.ChanAlloc[0]];
SpeedButton3.Left := xn[MainForm.ChanAlloc[0]];
SpeedButton4.Left := xe[MainForm.ChanAlloc[0]];
SpeedButton5.Left := xc[MainForm.ChanAlloc[1]];
SpeedButton6.Left := xt[MainForm.ChanAlloc[1]];
SpeedButton7.Left := xn[MainForm.ChanAlloc[1]];
SpeedButton8.Left := xe[MainForm.ChanAlloc[1]];
SpeedButton9.Left := xc[MainForm.ChanAlloc[2]];
SpeedButton10.Left := xt[MainForm.ChanAlloc[2]];
SpeedButton11.Left := xn[MainForm.ChanAlloc[2]];
SpeedButton12.Left := xe[MainForm.ChanAlloc[2]]
end;

constructor TTracks.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);
  ControlStyle := [csClickEvents, csSetCaption, csDoubleClicks, csFixedHeight, csCaptureMouse];
  TabStop := True;
  ParentColor := False;
  BevelKind := bkTile;
  BevelInner := bvLowered;
  NOfLines := MainForm.NewTrack_NumberOfLines;
  N1OfLines := NOfLines div 2;
  HLStep := 4;
  KeyPressed := 0;
  Font := MainForm.NewTrack_Font;
  CursorX := 0;
  CursorY := N1OfLines;
  SelX := CursorX;
  SelY := ShownFrom - N1OfLines + CursorY;
  Clicked := False;
  ShownFrom := 0;
  ShownPattern := nil
end;

procedure TMDIChild.CreateTracks;
var
 DC:HDC;
 p:THandle;
 sz:tagSIZE;
begin
 Tracks := TTracks.Create(PatternsSheet);
 Tracks.CelH := abs(Tracks.Font.Height);
 DC :=  GetDC(Tracks.Handle);
 p := SelectObject(DC,Tracks.Font.Handle);
 GetTextExtentPoint32(DC,'0',1,Sz);
 Tracks.CelW := Sz.cx;
 SelectObject(DC,p);
 ReleaseDC(Tracks.Handle,DC);
 Tracks.Left := StringGrid1.Left;
 Tracks.Top := StringGrid1.Top + StringGrid1.Height + 4;
 Tracks.ClientWidth := Tracks.CelW * 52;
 Tracks.ClientHeight := Tracks.CelH * Tracks.NOfLines;
 Tracks.OnKeyDown := TracksKeyDown;
 Tracks.OnKeyUp := TracksKeyUp;
 Tracks.OnExit := TracksExit;
 Tracks.OnMouseDown := TracksMouseDown;
 Tracks.OnMouseMove := TracksMouseMove;
 Tracks.OnMouseWheelUp := TracksMouseWheelUp;
 Tracks.OnMouseWheelDown := TracksMouseWheelDown
end;

constructor TTestLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);
  ControlStyle := [csClickEvents, csSetCaption, csDoubleClicks, csFixedHeight];
  TabStop := True;
  ParentColor := False;
  BevelKind := bkTile;
  BevelInner := bvLowered;
  KeyPressed := 0;
  Font := MainForm.NewTrack_Font;
  TestOct := 4;
  CursorX := 8
end;

procedure TMDIChild.CreateTestLines;
var
 DC:HDC;
 p:THandle;
 sz:tagSIZE;
begin
 SampleTestLine := TTestLine.Create(SamplesSheet);
 SampleTestLine.ParWind := Self;
 SampleTestLine.TestSample := True;
 SampleTestLine.CelH := abs(SampleTestLine.Font.Height);
 DC :=  GetDC(SampleTestLine.Handle);
 p := SelectObject(DC,SampleTestLine.Font.Handle);
 GetTextExtentPoint32(DC,'0',1,Sz);
 SampleTestLine.CelW := Sz.cx;
 SelectObject(DC,p);
 ReleaseDC(SampleTestLine.Handle,DC);
 SampleTestLine.Left := UpDown7.Left + UpDown7.Width + 7;
 SampleTestLine.Top := UpDown7.Top;
 SampleTestLine.ClientWidth := SampleTestLine.CelW * 21;
 SampleTestLine.ClientHeight := SampleTestLine.CelH;
 GroupBox2.Left := SampleTestLine.Left + SampleTestLine.Width + 7;
 SampleTestLine.OnKeyDown := SampleTestLine.TestLineKeyDown;
 SampleTestLine.OnKeyUp := SampleTestLine.TestLineKeyUp;
 SampleTestLine.OnExit := SampleTestLine.TestLineExit;
 SampleTestLine.OnMouseDown := SampleTestLine.TestLineMouseDown;

 OrnamentTestLine := TTestLine.Create(OrnamentsSheet);
 OrnamentTestLine.ParWind := Self;
 OrnamentTestLine.TestSample := False;
 OrnamentTestLine.CelH := abs(OrnamentTestLine.Font.Height);
 DC :=  GetDC(OrnamentTestLine.Handle);
 p := SelectObject(DC,OrnamentTestLine.Font.Handle);
 GetTextExtentPoint32(DC,'0',1,Sz);
 OrnamentTestLine.CelW := Sz.cx;
 SelectObject(DC,p);
 ReleaseDC(OrnamentTestLine.Handle,DC);
 OrnamentTestLine.Left := UpDown7.Left + UpDown7.Width + 7;
 OrnamentTestLine.Top := UpDown7.Top;
 OrnamentTestLine.ClientWidth := OrnamentTestLine.CelW * 21;
 OrnamentTestLine.ClientHeight := OrnamentTestLine.CelH;
 GroupBox4.Left := OrnamentTestLine.Left + OrnamentTestLine.Width + 7;
 OrnamentTestLine.OnKeyDown := OrnamentTestLine.TestLineKeyDown;
 OrnamentTestLine.OnKeyUp := OrnamentTestLine.TestLineKeyUp;
 OrnamentTestLine.OnExit := OrnamentTestLine.TestLineExit;
 OrnamentTestLine.OnMouseDown := OrnamentTestLine.TestLineMouseDown
end;

constructor TSamples.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);
  ControlStyle := [csClickEvents, csSetCaption, csFixedHeight];
  TabStop := True;
  ParentColor := False;
  BevelKind := bkTile;
  BevelInner := bvLowered;
  Font := MainForm.NewTrack_Font;
  NOfLines := 16;
  CursorX := 0;
  CursorY := 0;
  ShownFrom := 0;
  ShownSample := nil
end;

procedure TMDIChild.CreateSamples;
var
 DC:HDC;
 p:THandle;
 sz:tagSIZE;
begin
Samples := TSamples.Create(SamplesSheet);
Samples.CelH := abs(Samples.Font.Height);
DC :=  GetDC(Samples.Handle);
p := SelectObject(DC,Samples.Font.Handle);
GetTextExtentPoint32(DC,'0',1,Sz);
Samples.CelW := Sz.cx;
SelectObject(DC,p);
ReleaseDC(Samples.Handle,DC);
Samples.Left := Edit5.Left;
Samples.Top := Edit5.Left + Edit5.Top + Edit5.Height;
Samples.ClientWidth := Samples.CelW * 40;
Samples.ClientHeight := Samples.CelH * Samples.NOfLines;
Samples.OnKeyDown := SamplesKeyDown;
Samples.OnMouseDown := SamplesMouseDown;
Samples.OnMouseMove := SamplesMouseMove;
Samples.OnMouseWheelUp := SamplesMouseWheelUp;
Samples.OnMouseWheelDown := SamplesMouseWheelDown
end;

constructor TOrnaments.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Parent := TWinControl(AOwner);
  ControlStyle := [csClickEvents, csSetCaption, csFixedHeight];
  TabStop := True;
  ParentColor := False;
  BevelKind := bkTile;
  BevelInner := bvLowered;
  Font := MainForm.NewTrack_Font;
  CursorX := 0;
  CursorY := 0;
  ShownOrnament := nil
end;

procedure TMDIChild.CreateOrnaments;
var
 DC:HDC;
 p:THandle;
 sz:tagSIZE;
 i:integer;
begin
Ornaments := TOrnaments.Create(OrnamentsSheet);
Ornaments.CelH := abs(Ornaments.Font.Height);
DC :=  GetDC(Ornaments.Handle);
p := SelectObject(DC,Ornaments.Font.Handle);
GetTextExtentPoint32(DC,'0',1,Sz);
Ornaments.CelW := Sz.cx;
SelectObject(DC,p);
ReleaseDC(Ornaments.Handle,DC);
Ornaments.Left := Edit5.Left;
Ornaments.Top := Edit5.Left + Edit5.Top + Edit5.Height;
Ornaments.ClientWidth := Ornaments.CelW * 4 * 7;
Ornaments.ClientHeight := Ornaments.CelH * 16;
i := Ornaments.Left * 2 + Ornaments.Width;
SpeedButton19.Left := i;
SpeedButton20.Left := i;
SpeedButton21.Left := i;
GroupBox5.Left := SpeedButton19.Left + SpeedButton19.Width + Ornaments.Left;
Ornaments.OnKeyDown := OrnamentsKeyDown;
Ornaments.OnMouseDown := OrnamentsMouseDown
end;

procedure TTracks.DefaultHandler(var Message);
var
 ps:tagPAINTSTRUCT;
 hDC1:HDC;
begin
  case TMessage(Message).Msg of
    WM_GETDLGCODE:
     begin
      TMessage(Message).Result := -1 xor integer(DLGC_WANTTAB);
      exit
     end;
    WM_PAINT:
      begin
       hDC1 := BeginPaint(Handle,ps);
       RedrawTracks(hDC1);
       EndPaint(Handle,ps);
       TWMPaint(Message).Result := -1
      end;
    WM_SETFOCUS:
      begin
       if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
         not IsWindow(TWMSetFocus(Message).FocusedWnd) then
         TWMSetFocus(Message).FocusedWnd := 0;

       CreateMyCaret;
       SetCaretPos(CelW * (3 + CursorX),CelH * CursorY);
       ShowCaret(Handle);
       TMDIChild(MainForm.ActiveMDIChild).ShowStat;
       TMessage(Message).Result := -1
      end;
    WM_KILLFOCUS:
      begin
       DestroyCaret;
       Clicked := False;
       TMessage(Message).Result := -1
      end;
  end;
  inherited;
end;

procedure TTestLine.DefaultHandler(var Message);
var
 ps:tagPAINTSTRUCT;
 hDC1:HDC;
begin
  case TMessage(Message).Msg of
    WM_GETDLGCODE:
     begin
      TMessage(Message).Result := -1 xor integer(DLGC_WANTTAB);
      exit
     end;
    WM_PAINT:
      begin
       hDC1 := BeginPaint(Handle,ps);
       RedrawTestLine(hDC1);
       EndPaint(Handle,ps);
       TWMPaint(Message).Result := -1
      end;
    WM_SETFOCUS:
      begin
       if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
         not IsWindow(TWMSetFocus(Message).FocusedWnd) then
         TWMSetFocus(Message).FocusedWnd := 0;

       CreateMyCaret;
       SetCaretPos(CelW * CursorX,0);
       ShowCaret(Handle);
       TMDIChild(MainForm.ActiveMDIChild).ShowStat;
       TMessage(Message).Result := -1
      end;
    WM_KILLFOCUS:
      begin
       DestroyCaret;
       TMessage(Message).Result := -1
      end;

  end;
  inherited;
end;

procedure TSamples.DefaultHandler(var Message);
var
 ps:tagPAINTSTRUCT;
 hDC1:HDC;
begin
  case TMessage(Message).Msg of
    WM_GETDLGCODE:
     begin
      TMessage(Message).Result := -1 xor integer(DLGC_WANTTAB);
      exit
     end;
    WM_PAINT:
      begin
       hDC1 := BeginPaint(Handle,ps);
       RedrawSamples(hDC1);
       EndPaint(Handle,ps);
       TWMPaint(Message).Result := -1
      end;
    WM_SETFOCUS:
      begin
       if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
         not IsWindow(TWMSetFocus(Message).FocusedWnd) then
         TWMSetFocus(Message).FocusedWnd := 0;
       InputSNumber := 0;
       CreateMyCaret;
       SetCaretPos(CelW * (3 + CursorX),CelH * CursorY);
       ShowCaret(Handle);
       TMessage(Message).Result := -1
      end;
    WM_KILLFOCUS:
      begin
       DestroyCaret;
       TMessage(Message).Result := -1
      end;

  end;
  inherited;
end;

procedure TOrnaments.DefaultHandler(var Message);
var
 ps:tagPAINTSTRUCT;
 hDC1:HDC;
begin
  case TMessage(Message).Msg of
    WM_GETDLGCODE:
     begin
      TMessage(Message).Result := -1 xor integer(DLGC_WANTTAB);
      exit
     end;
    WM_PAINT:
      begin
       hDC1 := BeginPaint(Handle,ps);
       RedrawOrnaments(hDC1);
       EndPaint(Handle,ps);
       TWMPaint(Message).Result := -1
      end;
    WM_SETFOCUS:
      begin
       if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
         not IsWindow(TWMSetFocus(Message).FocusedWnd) then
         TWMSetFocus(Message).FocusedWnd := 0;
       InputONumber := 0;
       CreateCaret(Handle,0,CelW*3,CelH);
       SetCaretPos(CelW * (3 + CursorX),CelH * CursorY);
       ShowCaret(Handle);
       TMessage(Message).Result := -1
      end;
    WM_KILLFOCUS:
      begin
       DestroyCaret;
       TMessage(Message).Result := -1
      end;

  end;
  inherited;
end;

procedure TTracks.SelectAll;
begin
ShownFrom := 0;
CursorY := N1OfLines;
CursorX := 0;
RecreateCaret;
if ShownPattern = nil then
 SelY := DefPatLen - 1
else
 SelY := ShownPattern.Length - 1;
SelX := 48; 
HideCaret(Handle);
RedrawTracks(0);
SetCaretPos(CelW * (3 + CursorX),
                       CelH * CursorY);
ShowCaret(Handle);
TMDIChild(MainForm.ActiveMDIChild).ShowStat;
end;

procedure TTracks.ShowSelection;
var
 DC1:HDC;
 Y1,Y2,X1,X2,W:integer;
begin
Y1 := SelY - ShownFrom + N1OfLines;
if (SelX = CursorX) and (CursorY = Y1) then exit;
Y2 := CursorY;
if Y1 > Y2 then
 begin
  Y2 := Y1;
  Y1 := CursorY
 end;
if Y1 < 0 then Y1 := 0;
if Y2 >= NOfLines then Y2 := NOfLines - 1;
if Y1 > Y2 then exit;
X2 := CursorX;
X1 := SelX;
if X1 > X2 then
 begin
  X1 := X2;
  X2 := SelX
 end;
if DC = 0 then
 DC1 := GetDC(Handle)
else
 DC1 := DC;
W := 1;
if X2 in [8,22,36] then W := 3;
InvertRect(DC1,Rect((X1 + 3)*CelW,Y1*CelH,(X2 + 3 + W)*CelW,(Y2+1)*CelH));
if DC = 0 then
 ReleaseDC(Handle,DC1);
end;

procedure TTracks.RemoveSelection;
var
 Y2:integer;
begin
Y2 := ShownFrom - N1OfLines + CursorY;
if (SelX = CursorX) and (SelY = Y2) then exit;
if not DontRedraw then ShowSelection(DC);
SelX := CursorX;
SelY := Y2;
//if not DontRedraw then RedrawTracks(DC)
end;

procedure TTracks.RedrawTracks;
var
 i,n,From,i1,k:integer;
 DC1:HDC;
 s:string;
 p:THANDLE;
 Rect:TRect;
 PLen:integer;
begin
if DC = 0 then
 DC1 := GetDC(Handle)
else
 DC1 := DC;
p := SelectObject(DC1,Font.Handle);
From := (N1OfLines - ShownFrom);
n := NOfLines - From;
if ShownPattern = nil then
 PLen := DefPatLen
else
 PLen := ShownPattern.Length;
if PLen < n then
 n := PLen;
if From < 0 then
 begin
  i1 := - From;
  inc(n,From);
  From := 0
 end
else
 i1 := 0;
From := From * CelH;
if From > 0 then
 begin
  Rect.Left := 0;
  Rect.Top := 0;
  Rect.Right := Width;
  Rect.Bottom := From;
  FillRect(DC1,Rect,HBrush(COLOR_BTNFACE + 1));
 end;
SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
SetTextColor(DC1,GetSysColor(COLOR_WINDOWTEXT));
k := CelH * N1OfLines;
for i := i1 to i1 + n - 1 do
 begin
  s := GetPatternLineString(ShownPattern,i,MainForm.ChanAlloc);
  if From = k then
   begin
    SetBkColor(DC1,GetSysColor(COLOR_HIGHLIGHT));
    SetTextColor(DC1,GetSysColor(COLOR_HIGHLIGHTTEXT))
   end
  else if i mod HLStep = 0 then
   SetBkColor(DC1,$f0f0f0);
  TextOut(DC1,0,From,PChar(s),length(s));
  if From = k then
   begin
    SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
    SetTextColor(DC1,GetSysColor(COLOR_WINDOWTEXT))
   end
  else if i mod HLStep = 0 then
   SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
  inc(From,CelH)
 end;
n := CelH*NOfLines;
if From < n then
 begin
  Rect.Left := 0;
  Rect.Top := From;
  Rect.Right := Width;
  Rect.Bottom := n;
  FillRect(DC1,Rect,HBrush(COLOR_BTNFACE + 1));
 end;
SelectObject(DC1,p);
ShowSelection(DC1);
if DC = 0 then
 ReleaseDC(Handle,DC1);
end;

procedure TTestLine.RedrawTestLine;
var
 DC1:HDC;
 s:string;
 p:THANDLE;
begin
if DC = 0 then
 DC1 :=  GetDC(Handle)
else
 DC1 := DC;
p := SelectObject(DC1,Font.Handle);
SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
SetTextColor(DC1,GetSysColor(COLOR_WINDOWTEXT));
with TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)] do
 begin
  s := Int4DToStr(Envelope) + '|' + Int2DToStr(Noise) + '|';
  with Channel[0] do
   begin
    s := s + NoteToStr(Note) + ' ' + SampToStr(Sample) +
         Int1DToStr(Envelope) + Int1DToStr(Ornament) + Int1DToStr(Volume) +
         ' ' + Int1DToStr(Additional_Command.Number) +
         Int1DToStr(Additional_Command.Delay) +
         Int2DToStr(Additional_Command.Parameter);
   end
 end;
TextOut(DC1,0,0,PChar(s),Length(s));
SelectObject(DC1,p);
if DC = 0 then
 ReleaseDC(Handle,DC1)
end;

procedure TSamples.RedrawSamples;
var
 i,k,len,lp:integer;
 DC1:HDC;
 s:string;
 p:THANDLE;
begin
if DC = 0 then
 DC1 :=  GetDC(Handle)
else
 DC1 := DC;
p := SelectObject(DC1,Font.Handle);
if ShownSample = nil then
 begin
  len := 1;
  lp := 0
 end
else
 begin
  len := ShownSample.Length;
  lp := ShownSample.Loop
 end;
if ShownFrom >= len then
 begin
  SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
  SetTextColor(DC1,GetSysColor(COLOR_GRAYTEXT))
 end
else if ShownFrom >= lp then
 begin
  SetBkColor(DC1,GetSysColor(COLOR_HIGHLIGHT));
  SetTextColor(DC1,GetSysColor(COLOR_HIGHLIGHTTEXT))
 end
else
 begin
  SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
  SetTextColor(DC1,GetSysColor(COLOR_WINDOWTEXT))
 end;
k := 0;
for i := ShownFrom to ShownFrom + NOfLines - 1 do
 begin
  if i = lp then
   begin
    SetBkColor(DC1,GetSysColor(COLOR_HIGHLIGHT));
    SetTextColor(DC1,GetSysColor(COLOR_HIGHLIGHTTEXT))
   end
  else if i = len then
   begin
    SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
    SetTextColor(DC1,GetSysColor(COLOR_GRAYTEXT))
   end;
  s := IntToHex(i,2) + '|';
  if (ShownSample = nil) or (i >= ShownSample.Length) then
   begin
    if (ShownSample = nil) and (i = 0) then
     s := s + 'tne +000_ +00(00)_ 0_                '
    else
     s := s + GetSampleString(MainForm.SampleLineTemplates[MainForm.CurrentSampleLineTemplate],True,True)
   end
  else
   s := s + GetSampleString(ShownSample.Items[i],True,True);
  TextOut(DC1,0,k,PChar(s),Length(s));
  Inc(k,CelH)
 end;
SelectObject(DC1,p);
if DC = 0 then
 ReleaseDC(Handle,DC1)
end;

procedure TOrnaments.RedrawOrnaments;
var
 i,len,lp,x,y:integer;
 DC1:HDC;
 s:string;
 p:THANDLE;
begin
if DC = 0 then
 DC1 :=  GetDC(Handle)
else
 DC1 := DC;
p := SelectObject(DC1,Font.Handle);
if ShownOrnament = nil then
 begin
  len := 1;
  lp := 0
 end
else
 begin
  len := ShownOrnament.Length;
  lp := ShownOrnament.Loop
 end;
SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
SetTextColor(DC1,GetSysColor(COLOR_WINDOWTEXT));
x := 0; y := 0;
for i := 0 to 63 do
 begin
  if i = lp then
   begin
    SetBkColor(DC1,GetSysColor(COLOR_HIGHLIGHT));
    SetTextColor(DC1,GetSysColor(COLOR_HIGHLIGHTTEXT))
   end
  else if i = len then
   begin
    SetBkColor(DC1,GetSysColor(COLOR_WINDOW));
    SetTextColor(DC1,GetSysColor(COLOR_GRAYTEXT))
   end;
  s := IntToHex(i,2) + '|';
  if (ShownOrnament = nil) or (i >= ShownOrnament.Length) then
   s := s + '+00 '
  else if ShownOrnament.Items[i] >= 0 then
   s := s + '+' + Int2ToStr(ShownOrnament.Items[i]) + ' '
  else
   s := s + '-' + Int2ToStr(-ShownOrnament.Items[i]) + ' ';
  TextOut(DC1,x,y,PChar(s),Length(s));
  if i and 15 = 15 then
   begin
    y := 0;
    Inc(x,CelW*7)
   end
  else
   Inc(y,CelH)
 end;
SelectObject(DC1,p);
if DC = 0 then
 ReleaseDC(Handle,DC1)
end;

function ColSpace(i:integer):boolean;
begin
Result := i in [4,7,11,16,21,25,30,35,39,44]
end;

const
 ColTabs:array[0..11] of integer =
  (0,5,8,12,17,22,26,31,36,40,45,49);
 SColTabs:array[0..6] of integer =
  (0,5,11,14,19,20,21);
 NoteTabs:array[0..2] of integer =
  (8,22,36);
 NotePoses = [8,22,36];
 SamTabs:array[0..2] of integer =
  (12,26,40);
 SamPoses = [12,26,40];

function ColTab(i:integer):integer;
var
 j:integer;
begin
j := 0;
while i >= ColTabs[j] do Inc(j);
Result := j - 1
end;

function SColTab(i:integer):integer;
var
 j:integer;
begin
j := 0;
while i >= SColTabs[j] do Inc(j);
Result := j - 1
end;

procedure TTracks.CreateMyCaret;
begin
if CursorX in [8,22,36] then
 begin
  BigCaret := True;
  CreateCaret(Handle,0,CelW*3,CelH)
 end
else
 begin
  BigCaret := False;
  CreateCaret(Handle,0,CelW,CelH)
 end
end;

procedure TTracks.RecreateCaret;
begin
if CursorX in [8,22,36] then
 begin
  if not BigCaret then
   begin
    DestroyCaret;
    CreateMyCaret;
    ShowCaret(Handle)
   end
 end
else if BigCaret then
 begin
  DestroyCaret;
  CreateMyCaret;
  ShowCaret(Handle)
 end
end;

procedure TTestLine.CreateMyCaret;
begin
if CursorX = 8 then
 begin
  BigCaret := True;
  CreateCaret(Handle,0,CelW*3,CelH)
 end
else
 begin
  BigCaret := False;
  CreateCaret(Handle,0,CelW,CelH)
 end
end;

procedure TTestLine.RecreateCaret;
begin
if CursorX = 8 then
 begin
  if not BigCaret then
   begin
    DestroyCaret;
    CreateMyCaret;
    ShowCaret(Handle)
   end
 end
else if BigCaret then
 begin
  DestroyCaret;
  CreateMyCaret;
  ShowCaret(Handle)
 end
end;

procedure TSamples.CreateMyCaret;
begin
if CursorX = 5 then
 begin
  BigCaret := 1;
  CreateCaret(Handle,0,CelW*3,CelH)
 end
else if CursorX in [11,14] then
 begin
  BigCaret := -1;
  CreateCaret(Handle,0,CelW*2,CelH)
 end
else
 begin
  BigCaret := 0;
  CreateCaret(Handle,0,CelW,CelH)
 end
end;

procedure TSamples.RecreateCaret;
begin
if ((CursorX = 5) and (BigCaret <> 1)) or
   ((CursorX in [11,14]) and (BigCaret <> -1)) or
   (not (CursorX in [5,11,14]) and (BigCaret <> 0)) then
 begin
  DestroyCaret;
  CreateMyCaret;
  ShowCaret(Handle)
 end
end;

procedure TMDIChild.TracksKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

 procedure RemSel;
 begin
  if not (ssShift in Shift) then
   begin
    HideCaret(Tracks.Handle);
    Tracks.RemoveSelection(0,False);
    ShowCaret(Tracks.Handle)
   end
 end;

 procedure DoNoteKey;
 var
  Note,i,j:integer;
 begin
  if Key >= 256 then exit;
  Note := MainForm.NoteKeys[Key];
  if Note = -3 then exit;
  if Note > 32 then
   begin
    UpDown2.Position := Note and 31;
    exit
   end;
  if Note >= 0 then
   begin
    Inc(Note,(UpDown2.Position - 1) * 12);
    if Shift = [ssShift] then
     Inc(Note,12)
    else if Shift = [ssShift,ssCtrl] then
     Dec(Note,12);
    if longword(Note) >= 96 then exit
   end;
  Tracks.KeyPressed := Key;
  ValidatePattern2(PatNum);
  i := Tracks.ShownFrom - Tracks.N1OfLines + Tracks.CursorY;
  if (i >= 0) and (i < Tracks.ShownPattern.Length) then
   begin
    RemSel;
    SongChanged := True;
    j := MainForm.ChanAlloc[(Tracks.CursorX - 8) div 14];
    if Tracks.ShownPattern.Items[i].Channel[j].Note >= 0 then
     ParamsOfChan[j].Note := Tracks.ShownPattern.Items[i].Channel[j].Note;
    Tracks.ShownPattern.Items[i].Channel[j].Note := Note;
    DoAutoEnv(PatNum,i,j);
    HideCaret(Tracks.Handle);
    DoStep(i);
    Tracks.RedrawTracks(0);
    ShowCaret(Tracks.Handle);
    RestartPlayingLine(i)
   end
 end;

 procedure DoOtherKeys;
 var
  i,n,c:integer;
 begin
  if Tracks.CursorX = 5 then
   i := 1
  else if Tracks.CursorX in SamPoses then
   i := 31
  else
   i := 15;
  if Key in [Ord('0')..Ord('9')] then
   n := Key - Ord('0')
  else
   n := Key - Ord('A') + 10;
  if (n < 0) or (n > i) then exit;
  Tracks.KeyPressed := Key;
  ValidatePattern2(PatNum);
  i := Tracks.ShownFrom - Tracks.N1OfLines + Tracks.CursorY;
  if (i >= 0) and (i < Tracks.ShownPattern.Length) then
   begin
    RemSel;
    SongChanged := True;
    c := (Tracks.CursorX - 8) div 14;
    if c >= 0 then
     c := MainForm.ChanAlloc[c];
    case Tracks.CursorX of
    0:Tracks.ShownPattern.Items[i].Envelope :=
        Tracks.ShownPattern.Items[i].Envelope and $FFF or (n shl 12);
    1:Tracks.ShownPattern.Items[i].Envelope :=
        Tracks.ShownPattern.Items[i].Envelope and $F0FF or (n shl 8);
    2:Tracks.ShownPattern.Items[i].Envelope :=
        Tracks.ShownPattern.Items[i].Envelope and $FF0F or (n shl 4);
    3:Tracks.ShownPattern.Items[i].Envelope :=
        Tracks.ShownPattern.Items[i].Envelope and $FFF0 or n;
    5:Tracks.ShownPattern.Items[i].Noise :=
        Tracks.ShownPattern.Items[i].Noise and 15 or (n shl 4);
    6:Tracks.ShownPattern.Items[i].Noise :=
        Tracks.ShownPattern.Items[i].Noise and $F0 or n;
    12,26,40:Tracks.ShownPattern.Items[i].Channel[c].Sample := n;
    13,27,41:
     begin
      Tracks.ShownPattern.Items[i].Channel[c].Envelope := n;
      DoAutoEnv(PatNum,i,c)
     end;
    14,28,42:Tracks.ShownPattern.Items[i].Channel[c].Ornament := n;
    15,29,43:Tracks.ShownPattern.Items[i].Channel[c].Volume := n;
    17,31,45:
     if Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Number <> n then
      begin
       Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Number := n;
       CalcTotLen
      end;
    18,32,46:Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Delay := n;
    19,33,47:
     if Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Parameter shr 4 <> n then
      begin
       Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Parameter :=
                Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Parameter and 15 or (n shl 4);
       CalcTotLen
      end;
    20,34,48:
     if Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Parameter and 15 <> n then
      begin
       Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Parameter :=
                Tracks.ShownPattern.Items[i].Channel[c].Additional_Command.Parameter and $F0 or n;
       CalcTotLen
      end
    end;
    HideCaret(Tracks.Handle);
//    if Tracks.CursorX in [12,15,26,29,40,43] then //comment -> step in any col
     DoStep(i);
    Tracks.RedrawTracks(0);
    ShowCaret(Tracks.Handle);
    RestartPlayingLine(i)
   end
 end;

 procedure RedrawTrs;
 begin
  HideCaret(Tracks.Handle);
  Tracks.RedrawTracks(0);
  ShowCaret(Tracks.Handle)
 end;

 procedure DoCursorDown;
 var
  To1,PLen:integer;
 begin
  RemSel;
  if Tracks.ShownPattern = nil then
   PLen := DefPatLen
  else
   PLen := Tracks.ShownPattern.Length;
  To1 := PLen - Tracks.ShownFrom + Tracks.N1OfLines;
  if To1 > Tracks.NOfLines then
   To1 := Tracks.NOfLines;
  if (Tracks.CursorY < To1 - 1) and (Tracks.CursorY <> Tracks.N1OfLines) then
   begin
    Tracks.ShowSelection(0);
    Inc(Tracks.CursorY);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                        Tracks.CelH * Tracks.CursorY);
    if ssShift in Shift then
     Tracks.ShowSelection(0)
    else
     Tracks.RemoveSelection(0,True)
   end
  else if Tracks.ShownFrom < PLen - Tracks.CursorY - 1 + Tracks.N1OfLines then
   begin
    Inc(Tracks.ShownFrom);
    if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
    RedrawTrs
   end
  else if Shift = [] then
   begin
    Tracks.ShownFrom := 0;
    Tracks.CursorY := Tracks.N1OfLines;
    Tracks.RemoveSelection(0,True);
    HideCaret(Tracks.Handle);
    Tracks.RedrawTracks(0);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    ShowCaret(Tracks.Handle)
   end;
  ShowStat
 end;

 procedure DoCursorUp;
 var
  From,PLen:integer;
 begin
  RemSel;
  From := (Tracks.N1OfLines - Tracks.ShownFrom);
  if From < 0 then
   From := 0;
  if (Tracks.CursorY > From) and (Tracks.CursorY <> Tracks.N1OfLines) then
   begin
    Tracks.ShowSelection(0);
    Dec(Tracks.CursorY);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                        Tracks.CelH * Tracks.CursorY);
    if ssShift in Shift then
     Tracks.ShowSelection(0)
    else
     Tracks.RemoveSelection(0,True)
   end
  else if Tracks.ShownFrom > Tracks.N1OfLines - Tracks.CursorY then
   begin
    Dec(Tracks.ShownFrom);
    if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
    RedrawTrs
   end
  else if Shift = [] then
   begin
    if Tracks.ShownPattern = nil then
     PLen := DefPatLen
    else
     PLen := Tracks.ShownPattern.Length;
    Tracks.ShownFrom := PLen - 1;
    Tracks.CursorY := Tracks.N1OfLines;
    Tracks.RemoveSelection(0,True);
    HideCaret(Tracks.Handle);
    Tracks.RedrawTracks(0);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    ShowCaret(Tracks.Handle)
   end;
  ShowStat
 end;

 procedure DoCursorLeft;
 var
  min:integer;
 begin
  RemSel;
  min := 0;
  if ssCtrl in Shift then min := 4;
  if Tracks.CursorX > min then
   begin
    Tracks.ShowSelection(0);
    if ssCtrl in Shift then
     Tracks.CursorX := ColTabs[ColTab(Tracks.CursorX) - 1]
    else
     begin
      if Tracks.CursorX in [12,26,40] then
       Dec(Tracks.CursorX,4)
      else if ColSpace(Tracks.CursorX - 1) then
       Dec(Tracks.CursorX,2)
      else
       Dec(Tracks.CursorX)
     end;
    Tracks.RecreateCaret;
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    if ssShift in Shift then
     Tracks.ShowSelection(0)
    else
     Tracks.RemoveSelection(0,True)
   end
 end;

 procedure DoCursorRight;
 var
  max:integer;
 begin
  RemSel;
  max := 48;
  if ssCtrl in Shift then max := 44;
  if Tracks.CursorX < max then
   begin
    Tracks.ShowSelection(0);
    if ssCtrl in Shift then
     Tracks.CursorX := ColTabs[ColTab(Tracks.CursorX) + 1]
    else
     begin
      Inc(Tracks.CursorX);
      if ColSpace(Tracks.CursorX) then
       Inc(Tracks.CursorX)
      else if Tracks.CursorX in [9,23,37] then
       Inc(Tracks.CursorX,3)
     end;
    Tracks.RecreateCaret;
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    if ssShift in Shift then
     Tracks.ShowSelection(0)
    else
     Tracks.RemoveSelection(0,True)
   end
  end;

 type
  TA3 = array[0..2] of boolean;

 procedure GetColsToEdit(var E,N:boolean;var T:TA3;AllPat:boolean);
 begin
  if AllPat then
   begin
    E := True; N := True; T[0] := True; T[1] := True; T[2] := True
   end
  else
   begin
    E := False; N := False; T[0] := False; T[1] := False; T[2] := False;
    if Tracks.CursorX < 4 then
     E := True
    else if Tracks.CursorX < 8 then
     N := True
    else
     T[MainForm.ChanAlloc[(Tracks.CursorX - 8) div 14]] := True
   end
 end;

 procedure DoInsertLine(AllPat:boolean);
 var
  i,j,c:integer;
  E,N:boolean;
  T:TA3;
 begin
  RemSel;
  if Tracks.ShownPattern <> nil then
   begin
    i := Tracks.ShownFrom - Tracks.N1OfLines + Tracks.CursorY;
    if (i >= 0) and (i < Tracks.ShownPattern.Length) then
     begin
      SongChanged := True;
      GetColsToEdit(E,N,T,AllPat);
      if E then
       begin
        for j := Tracks.ShownPattern.Length - 1 downto i do
         Tracks.ShownPattern.Items[j].Envelope :=
          Tracks.ShownPattern.Items[j - 1].Envelope;
        Tracks.ShownPattern.Items[i].Envelope := 0
       end;
      if N then
       begin
        for j := Tracks.ShownPattern.Length - 1 downto i do
         Tracks.ShownPattern.Items[j].Noise :=
          Tracks.ShownPattern.Items[j - 1].Noise;
        Tracks.ShownPattern.Items[i].Noise := 0
       end;
      for c := 0 to 2 do if T[c] then
       begin
        for j := Tracks.ShownPattern.Length - 1 downto i do
         Tracks.ShownPattern.Items[j].Channel[c] :=
          Tracks.ShownPattern.Items[j - 1].Channel[c];
        Tracks.ShownPattern.Items[i].Channel[c] := EmptyChannelLine
       end;
      RedrawTrs
     end
   end
 end;

 procedure DoRemoveLine;
 var
  i,j,c,PLen:integer;
  E,N:boolean;
  T:TA3;
 begin
  RemSel;
  if Tracks.ShownPattern <> nil then
   begin
    i := Tracks.ShownFrom - Tracks.N1OfLines + Tracks.CursorY;
    if (i >= 0) and (i < Tracks.ShownPattern.Length) then
     begin
      SongChanged := True;
      GetColsToEdit(E,N,T,ssCtrl in Shift);
      PLen := Tracks.ShownPattern.Length - 1;
      if E then
       begin
        for j := i + 1 to PLen do
         Tracks.ShownPattern.Items[j - 1].Envelope :=
          Tracks.ShownPattern.Items[j].Envelope;
        Tracks.ShownPattern.Items[PLen].Envelope := 0
       end;
      if N then
       begin
        for j := i + 1 to PLen do
         Tracks.ShownPattern.Items[j - 1].Noise :=
          Tracks.ShownPattern.Items[j].Noise;
        Tracks.ShownPattern.Items[PLen].Noise := 0
       end;
      for c := 0 to 2 do if T[c] then
       begin
        for j := i + 1 to PLen do
         Tracks.ShownPattern.Items[j - 1].Channel[c] :=
          Tracks.ShownPattern.Items[j].Channel[c];
        Tracks.ShownPattern.Items[PLen].Channel[c] := EmptyChannelLine
       end;
      RedrawTrs
     end
   end
 end;

 procedure DoClearLine;
 var
  i,c:integer;
  E,N:boolean;
  T:TA3;
 begin
  RemSel;
  if Tracks.ShownPattern <> nil then
   begin
    i := Tracks.ShownFrom - Tracks.N1OfLines + Tracks.CursorY;
    if (i >= 0) and (i < Tracks.ShownPattern.Length) then
     begin
      SongChanged := True;
      GetColsToEdit(E,N,T,ssCtrl in Shift);
      if E then
       Tracks.ShownPattern.Items[i].Envelope := 0;
      if N then
       Tracks.ShownPattern.Items[i].Noise := 0;
      for c := 0 to 2 do if T[c] then
       Tracks.ShownPattern.Items[i].Channel[c] := EmptyChannelLine;
      RedrawTrs
     end
   end
 end;

var
 From,To1,PLen,i,j,c:integer;
begin
if IsPlaying and (PlayingWindow = Self) and
  (PlayMode <> PMPlayLine) then exit;
case Key of
VK_DOWN:
 DoCursorDown;
VK_UP:
 DoCursorUp;
VK_LEFT:
 DoCursorLeft;
VK_RIGHT:
 DoCursorRight;
VK_HOME:
 begin
  RemSel;
  Tracks.ShowSelection(0);
  Tracks.CursorX := 0;
  Tracks.RecreateCaret;
  if ssCtrl in Shift then
   begin
    Tracks.ShownFrom := 0;
    Tracks.CursorY := Tracks.N1OfLines;
    if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
    ShowStat;
    RedrawTrs
   end;
  SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                       Tracks.CelH * Tracks.CursorY);
  if not (ssCtrl in Shift) and (ssShift in Shift) then Tracks.ShowSelection(0);
  if not (ssShift in Shift) then Tracks.RemoveSelection(0,True)
 end;
VK_END:
 begin
  RemSel;
  Tracks.ShowSelection(0);
  Tracks.CursorX := 48;
  Tracks.RecreateCaret;
  if ssCtrl in Shift then
   begin
    if Tracks.ShownPattern = nil then
     PLen := DefPatLen
    else
     PLen := Tracks.ShownPattern.Length;
    Tracks.ShownFrom := PLen - 1;
    Tracks.CursorY := Tracks.N1OfLines;
    if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
    ShowStat;
    RedrawTrs
   end;
  SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                       Tracks.CelH * Tracks.CursorY);
  if not (ssCtrl in Shift) and (ssShift in Shift) then Tracks.ShowSelection(0);
  if not (ssShift in Shift) then Tracks.RemoveSelection(0,True)
 end;
VK_PRIOR:
 begin
  RemSel;
  if ssCtrl in Shift then
   begin
    Tracks.ShownFrom := 0;
    Tracks.CursorY := Tracks.N1OfLines;
    if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
    HideCaret(Tracks.Handle);
    Tracks.RedrawTracks(0);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    ShowCaret(Tracks.Handle)
   end
  else
   begin
    From := (Tracks.N1OfLines - Tracks.ShownFrom);
    if From < 0 then
     From := 0;
    if (Tracks.CursorY > From) and (Tracks.CursorY <> Tracks.N1OfLines) then
     begin
      Tracks.ShowSelection(0);
      Tracks.CursorY := From;
      SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                          Tracks.CelH * Tracks.CursorY);
      if ssShift in Shift then
       Tracks.ShowSelection(0)
      else
       Tracks.RemoveSelection(0,True)
     end
    else if Tracks.ShownFrom > Tracks.N1OfLines - Tracks.CursorY then
     begin
      Dec(Tracks.ShownFrom,Tracks.NOfLines);
      if Tracks.ShownFrom < 0 then
       begin
        Tracks.ShownFrom := 0;
        Tracks.CursorY := Tracks.N1OfLines
       end
      else if Tracks.N1OfLines >= Tracks.ShownFrom then
       Tracks.CursorY := Tracks.N1OfLines - Tracks.ShownFrom;
      if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
      HideCaret(Tracks.Handle);
      SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                          Tracks.CelH * Tracks.CursorY);
      Tracks.RedrawTracks(0);
      ShowCaret(Tracks.Handle)
     end
    else if not (ssShift in Shift) then
     begin
      if Tracks.ShownPattern = nil then
       PLen := DefPatLen
      else
       PLen := Tracks.ShownPattern.Length;
      Tracks.ShownFrom := PLen - 1;
      Tracks.CursorY := Tracks.N1OfLines;
      Tracks.RemoveSelection(0,True);
      HideCaret(Tracks.Handle);
      Tracks.RedrawTracks(0);
      SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                           Tracks.CelH * Tracks.CursorY);
      ShowCaret(Tracks.Handle)
     end
   end;
  ShowStat
 end;
VK_NEXT:
 begin
  RemSel;
  if Tracks.ShownPattern = nil then
   PLen := DefPatLen
  else
   PLen := Tracks.ShownPattern.Length;
  if ssCtrl in Shift then
   begin
    Tracks.ShownFrom := PLen - 1;
    Tracks.CursorY := Tracks.N1OfLines;
    if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
    HideCaret(Tracks.Handle);
    Tracks.RedrawTracks(0);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    ShowCaret(Tracks.Handle)
   end
  else
   begin
    To1 := PLen - Tracks.ShownFrom + Tracks.N1OfLines;
    if To1 > Tracks.NOfLines then
     To1 := Tracks.NOfLines;
    if (Tracks.CursorY < To1 - 1) and (Tracks.CursorY <> Tracks.N1OfLines) then
     begin
      Tracks.ShowSelection(0);
      Tracks.CursorY := To1 - 1;
      SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                          Tracks.CelH * Tracks.CursorY);
      if ssShift in Shift then
       Tracks.ShowSelection(0)
      else
       Tracks.RemoveSelection(0,True)
     end
    else if Tracks.ShownFrom < PLen - Tracks.CursorY - 1 + Tracks.N1OfLines then
     begin
      Inc(Tracks.ShownFrom,Tracks.NOfLines);
      if Tracks.ShownFrom >= PLen then
       begin
        Tracks.ShownFrom := PLen - 1;
        Tracks.CursorY := Tracks.N1OfLines
       end
      else if Tracks.NOfLines - Tracks.N1OfLines >= PLen - 1 - Tracks.ShownFrom then
       Tracks.CursorY := Tracks.NOfLines - Tracks.N1OfLines + Tracks.ShownFrom - PLen + 1;
      if not (ssShift in Shift) then Tracks.RemoveSelection(0,True);
      HideCaret(Tracks.Handle);
      SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                          Tracks.CelH * Tracks.CursorY);
      Tracks.RedrawTracks(0);
      ShowCaret(Tracks.Handle)
     end
    else if not (ssShift in Shift) then
     begin
      Tracks.ShownFrom := 0;
      Tracks.CursorY := Tracks.N1OfLines;
      Tracks.RemoveSelection(0,True);
      HideCaret(Tracks.Handle);
      Tracks.RedrawTracks(0);
      SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                           Tracks.CelH * Tracks.CursorY);
      ShowCaret(Tracks.Handle)
     end
   end;
  ShowStat
 end;
VK_INSERT:
 if Shift = [] then
  DoInsertLine(False)
 else if Shift = [ssShift] then
  begin
   if MainForm.EditPaste1.Enabled then
    MainForm.EditPaste1.Execute
  end
 else if Shift = [ssCtrl] then
  if MainForm.EditCopy1.Enabled then
   MainForm.EditCopy1.Execute;
VK_BACK:
 DoRemoveLine;
VK_DELETE:
 if Shift = [ssShift] then
  begin
   if MainForm.EditCut1.Enabled then
    MainForm.EditCut1.Execute
  end
 else if (Shift = []) {and ((Tracks.SelX <> Tracks.CursorX) or //commented especially for EA
                           (Tracks.SelY <> Tracks.ShownFrom - Tracks.N1OfLines + Tracks.CursorY))}
                            then
  Tracks.ClearSelection
 else
  DoClearLine;
192:
 begin
  if StringGrid1.CanFocus then
   StringGrid1.SetFocus
 end;
VK_NUMPAD0:
 ToggleAutoEnv;
VK_SPACE:
 ToggleAutoStep;
VK_RETURN:
 if Tracks.KeyPressed <> VK_RETURN then
  begin
   RemSel;
   Tracks.KeyPressed := VK_RETURN;
   ValidatePattern2(PatNum);
   RestartPlayingPatternLine(True);
   Tracks.CursorY := Tracks.N1OfLines;
   SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
   ShowCaret(Tracks.Handle)
  end;
else
  begin
   if (Shift = [ssCtrl]) and (Key = Ord('Y')) then
    DoRemoveLine
   else if (Shift = [ssCtrl]) and ((Key = Ord('A')) or (Key = VK_NUMPAD5)) then
    Tracks.SelectAll
   else if (Shift = [ssCtrl]) and (Key = Ord('I')) then
    DoInsertLine(True)
   else
    if Tracks.KeyPressed <> Key then
     if Tracks.CursorX in NotePoses then
      DoNoteKey
     else
      DoOtherKeys
  end
end
end;

procedure TTestLine.TestLineKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

 procedure DoNoteKey;
 var
  Note:integer;
 begin
  if Key >= 256 then exit;
  Note := MainForm.NoteKeys[Key];
  if Note = -3 then exit;
  if Note > 32 then
   begin
    TestOct := Note and 31;
    if TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Note >= 0 then
     Note := (TMDIChild(ParWind).
                        VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Note mod 12) +
                                                        (TestOct - 1) * 12
    else
     Note := TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Note
   end
  else if Note >= 0 then
   Inc(Note,(TestOct - 1) * 12);
  if Note >= 96 then exit;
  if Shift = [ssShift] then
   begin
    if Note < 96 - 12 then
     Inc(Note,12)
   end
  else if Shift = [ssShift,ssCtrl] then
   if Note >= 12 then
    Dec(Note,12);
  KeyPressed := Key;
  if TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Note >= 0 then
   ParamsOfChan[MidChan].Note :=
        TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Note;
  TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Note := Note;
  TMDIChild(ParWind).DoAutoEnv(-1,Ord(TestSample),0);
  HideCaret(Handle);
  RedrawTestLine(0);
  ShowCaret(Handle);
  TMDIChild(ParWind).RestartPlayingLine(-Ord(TestSample) - 1)
 end;

 procedure DoOtherKeys;
 var
  i,n:integer;
 begin
  if CursorX = 5 then
   i := 1
  else if CursorX = 12 then
   i := 31
  else
   i := 15;
  if Key in [Ord('0')..Ord('9')] then
   n := Key - Ord('0')
  else
   n := Key - Ord('A') + 10;
  if (n < 0) or (n > i) then exit;
  KeyPressed := Key;
  case CursorX of
  0:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope :=
             TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope
                                                and $FFF or (n shl 12);
  1:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope :=
             TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope
                                                and $F0FF or (n shl 8);
  2:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope :=
             TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope
                                                and $FF0F or (n shl 4);
  3:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope :=
             TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Envelope
                                                and $FFF0 or n;
  5:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Noise :=
             TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Noise
                                                and 15 or (n shl 4);
  6:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Noise :=
             TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Noise
                                                and $F0 or n;
  12:
   begin
    TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Sample := n;
    if (n > 0) and TestSample then
     TMDIChild(ParWind).UpDown6.Position := n
   end;
  13:
   begin
    TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Envelope := n;
    TMDIChild(ParWind).DoAutoEnv(-1,Ord(TestSample),0)
   end;
  14:
   begin
    TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Ornament := n;
    if (n > 0) and not TestSample then
     TMDIChild(ParWind).UpDown9.Position := n
   end;
  15:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].Volume := n;
  17:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].
                                        Additional_Command.Number := n;
  18:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].
                                        Additional_Command.Delay := n;
  19:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].
                                        Additional_Command.Parameter :=
     TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].
                              Additional_Command.Parameter and 15 or (n shl 4);
  20:TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].
                                        Additional_Command.Parameter :=
     TMDIChild(ParWind).VTMP.Patterns[-1].Items[Ord(TestSample)].Channel[0].
                              Additional_Command.Parameter and $F0 or n
  end;
  HideCaret(Handle);
  RedrawTestLine(0);
  ShowCaret(Handle);
  TMDIChild(ParWind).RestartPlayingLine(-Ord(TestSample) - 1)
 end;

begin
if Shift = [] then
case Key of
VK_LEFT:
 if CursorX > 0 then
  begin
   if CursorX = 12 then
    Dec(CursorX,4)
   else if ColSpace(CursorX - 1) then
    Dec(CursorX,2)
   else
    Dec(CursorX);
   RecreateCaret;
   SetCaretPos(CelW * CursorX,0)
  end;
VK_RIGHT:
 if CursorX < 20 then
  begin
   Inc(CursorX);
   if ColSpace(CursorX) then
    Inc(CursorX)
   else if CursorX = 9 then
    Inc(CursorX,3);
   RecreateCaret;
   SetCaretPos(CelW * CursorX,0)
  end;
192:
 begin
  if TestSample then
   begin
    if TMDIChild(ParWind).Samples.CanFocus then
     TMDIChild(ParWind).Samples.SetFocus
   end
  else if TMDIChild(ParWind).Ornaments.CanFocus then
   TMDIChild(ParWind).Ornaments.SetFocus
 end
else
  begin
   if KeyPressed <> Key then
    if CursorX in NotePoses then
     DoNoteKey
    else
     DoOtherKeys;
  end;
end
else if Shift = [ssCtrl] then
case Key of
VK_RIGHT:
 if CursorX < 17 then
  begin
   CursorX := ColTabs[ColTab(CursorX) + 1];
   RecreateCaret;
   SetCaretPos(CelW * CursorX,0)
  end;
VK_LEFT:
 if CursorX > 4 then
  begin
   CursorX := ColTabs[ColTab(CursorX) - 1];
   RecreateCaret;
   SetCaretPos(CelW * CursorX,0)
  end
end else if (Shift = [ssCtrl,ssShift]) or
            (Shift = [ssShift]) then
 if KeyPressed <> Key then
  if CursorX in NotePoses then
   DoNoteKey
end;

procedure TMDIChild.SamplesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
type
 TSamToggles = (TgMixTone,TgMixNoise,TgMaskEnv,TgSgnTone,TgSgnNoise,
                TgAccTone,TgAccNoise,TgAccVol,TgSgnToneP,TgSgnToneM,
                TgSgnNoiseP,TgSgnNoiseM,TgAccVolP,TgAccVolM,
                TgAccTone_,TgAccNoise_,TgAccVol_,TgAccToneA,TgAccNoiseA);
 TSamNumbers = (NmTone,NmNoise,NmNoiseAbs,NmVol);

 procedure GetSamParams(var l,i:integer);
 begin
  with Samples do
   begin
    if ShownSample = nil then
     l := 1
    else
     l := ShownSample.Length;
    i := ShownFrom + CursorY
   end
 end;

 procedure DoToggle(n:TSamToggles);
 var
  i,l:integer;
 begin
  with Samples do
   begin
    GetSamParams(l,i);
    if i >= l then exit;
    SongChanged := True;
    ValidateSample2(SamNum);
    with ShownSample.Items[i] do
     case n of
     TgMixTone:
      Mixer_Ton := not Mixer_Ton;
     TgMixNoise:
      Mixer_Noise := not Mixer_Noise;
     TgMaskEnv:
      Envelope_Enabled := not Envelope_Enabled;
     TgSgnTone:
      Add_to_Ton := -Add_to_Ton;
     TgSgnToneP:
      Add_to_Ton := abs(Add_to_Ton);
     TgSgnToneM:
      Add_to_Ton := -abs(Add_to_Ton);
     TgSgnNoise:
      Add_to_Envelope_or_Noise := Ns(-Add_to_Envelope_or_Noise);
     TgSgnNoiseP:
      Add_to_Envelope_or_Noise := Ns(abs(Add_to_Envelope_or_Noise));
     TgSgnNoiseM:
      Add_to_Envelope_or_Noise := Ns(-abs(Add_to_Envelope_or_Noise));
     TgAccTone:
      Ton_Accumulation := not Ton_Accumulation;
     TgAccNoise:
      Envelope_or_Noise_Accumulation := not Envelope_or_Noise_Accumulation;
     TgAccVol:
      if not Amplitude_Sliding then
       begin
        Amplitude_Sliding := True;
        Amplitude_Slide_Up := False
       end
      else if not Amplitude_Slide_Up then
       Amplitude_Slide_Up := True
      else
       Amplitude_Sliding := False;
     TgAccVolP:
      begin
       Amplitude_Sliding := True;
       Amplitude_Slide_Up := True
      end;
     TgAccVolM:
      begin
       Amplitude_Sliding := True;
       Amplitude_Slide_Up := False
      end;
     TgAccVol_:
      Amplitude_Sliding := False;
     TgAccTone_:
      Ton_Accumulation := False;
     TgAccNoise_:
      Envelope_or_Noise_Accumulation := False;
     TgAccToneA:
      Ton_Accumulation := True;
     TgAccNoiseA:
      Envelope_or_Noise_Accumulation := True
     end;
    HideCaret(Handle);
    RedrawSamples(0);
    ShowCaret(Handle)
   end
 end;

 procedure DoToggleSpace;
 begin
  case Samples.CursorX of
  0..2:
   DoToggle(TSamToggles(Samples.CursorX));
  4..7:
   DoToggle(TgSgnTone);
  8:
   DoToggle(TgAccTone);
  10..15:
   DoToggle(TgSgnNoise);
  17:
   DoToggle(TgAccNoise);
  19,20:
   DoToggle(TgAccVol)
  end
 end;

 procedure DoTogglePlus;
 begin
  case Samples.CursorX of
  4..7:
   DoToggle(TgSgnToneP);
  10..15:
   DoToggle(TgSgnNoiseP);
  19,20:
   DoToggle(TgAccVolP)
  end
 end;

 procedure DoToggleMinus;
 begin
  case Samples.CursorX of
  4..7:
   DoToggle(TgSgnToneM);
  10..15:
   DoToggle(TgSgnNoiseM);
  19,20:
   DoToggle(TgAccVolM)
  end
 end;

 procedure DoToggleAccA;
 begin
  case Samples.CursorX of
  4..8:
   DoToggle(TgAccToneA);
  10..17:
   DoToggle(TgAccNoiseA)
  end
 end;

 procedure DoToggle_;
 begin
  case Samples.CursorX of
  4..8:
   DoToggle(TgAccTone_);
  10..17:
   DoToggle(TgAccNoise_);
  19,20:
   DoToggle(TgAccVol_)
  end
 end;                   

 procedure DoNumber(n:TSamNumbers);
 var
  i,l:integer;
 begin
  with Samples do
   begin
    GetSamParams(l,i);
    if i >= l then exit;
    SongChanged := True;
    ValidateSample2(SamNum);
    with ShownSample.Items[i] do
     case n of
     NmTone:
      if Add_to_Ton < 0 then
       Add_to_Ton := -InputSNumber
      else
       Add_to_Ton := InputSNumber;
     NmNoise:
      if Add_to_Envelope_or_Noise < 0 then
       Add_to_Envelope_or_Noise := Ns(-InputSNumber)
      else
       Add_to_Envelope_or_Noise := Ns(InputSNumber);
     NmNoiseAbs:
      Add_to_Envelope_or_Noise := Ns(InputSNumber);
     NmVol:
      Amplitude := InputSNumber
     end;
    HideCaret(Handle);
    RedrawSamples(0);
    ShowCaret(Handle)
   end
 end;

 procedure DoDigit(n:integer);
 var
  nm:integer;
 begin
  nm := Samples.InputSNumber * 16 + n;
  case Samples.CursorX of
  4..8:
   begin
    if nm > $FFF then
     nm := n;
    Samples.InputSNumber := nm;
    DoNumber(NmTone)
   end;
  10,11:
   begin
    if nm > $10 then
     nm := n;
    Samples.InputSNumber := nm;
    DoNumber(NmNoise)
   end;
  14,17:
   begin
    if nm > $1F then
     nm := n;
    Samples.InputSNumber := nm;
    DoNumber(NmNoiseAbs)
   end;
  19,20:
   begin
    if nm > $F then
     nm := n;
    Samples.InputSNumber := nm;
    DoNumber(NmVol)
   end
  end
 end;

begin
if (Shift <> []) or not (Key in [Ord('0')..Ord('9'),
                                 Ord('A')..Ord('F')]) then
 Samples.InputSNumber := 0;
if Shift = [] then
case Key of
VK_NEXT:
 begin
  if (Samples.CursorY < Samples.NOfLines - 1) then
   begin
    Samples.CursorY := Samples.NOfLines - 1;
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
   end
  else if Samples.ShownFrom < 64 - Samples.NOfLines then
   begin
    Inc(Samples.ShownFrom,Samples.NOfLines);
    if Samples.ShownFrom > 64 - Samples.NOfLines then
     Samples.ShownFrom := 64 - Samples.NOfLines;
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    ShowCaret(Samples.Handle)
   end
 end;
VK_PRIOR:
 begin
  if (Samples.CursorY > 0) then
   begin
    Samples.CursorY := 0;
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
   end
  else if Samples.ShownFrom > 0 then
   begin
    Dec(Samples.ShownFrom,Samples.NOfLines);
    if Samples.ShownFrom < 0 then
     Samples.ShownFrom := 0;
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    ShowCaret(Samples.Handle)
   end
 end;
VK_HOME:
 if Samples.CursorX <> 0 then
  begin
   Samples.CursorX := 0;
   Samples.RecreateCaret;
   SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
  end;
VK_END:
 if Samples.CursorX <> 20 then
  begin
   Samples.CursorX := 20;
   Samples.RecreateCaret;
   SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
  end;
VK_DOWN:
 begin
  if (Samples.CursorY < Samples.NOfLines - 1) then
   begin
    Inc(Samples.CursorY);
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
   end
  else if Samples.ShownFrom < 64 - Samples.NOfLines then
   begin
    Inc(Samples.ShownFrom);
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    ShowCaret(Samples.Handle)
   end
 end;
VK_UP:
 begin
  if (Samples.CursorY > 0) then
   begin
    Dec(Samples.CursorY);
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
   end
  else if Samples.ShownFrom > 0 then
   begin
    Dec(Samples.ShownFrom);
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    ShowCaret(Samples.Handle)
   end
 end;
VK_LEFT:
 if Samples.CursorX > 0 then
  begin
   if Samples.CursorX in [4,10,19] then
    Dec(Samples.CursorX,2)
   else if Samples.CursorX in [8,14,17] then
    Dec(Samples.CursorX,3)
   else
    Dec(Samples.CursorX);
   Samples.RecreateCaret;
   SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
  end;
VK_RIGHT:
 if Samples.CursorX < 20 then
  begin
   Inc(Samples.CursorX);
   if Samples.CursorX in [3,9,13,16,18] then
    Inc(Samples.CursorX)
   else if Samples.CursorX = 6 then
    Samples.CursorX := 8
   else if Samples.CursorX = 12 then
    Samples.CursorX := 14
   else if Samples.CursorX = 15 then
    Samples.CursorX := 17;
   Samples.RecreateCaret;
   SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
  end;
Ord('T'):
 DoToggle(TgMixTone);
Ord('N'):
 DoToggle(TgMixNoise);
Ord('M'):
 DoToggle(TgMaskEnv);
Ord(' '):
 DoToggleSpace;
$BB,VK_ADD:
 DoTogglePlus;
$BD,VK_SUBTRACT:
 DoToggleMinus;
Ord('0')..Ord('9'):
 DoDigit(Key - Ord('0')); 
Ord('A')..Ord('F'):
 DoDigit(Key - Ord('A') + 10);
192:
 if SampleTestLine.CanFocus then
  SampleTestLine.SetFocus
end
else if Shift = [ssCtrl] then
case Key of
VK_NEXT,VK_END:
 begin
  if ((Key = VK_END) and (Samples.CursorX <> 20)) or
     (Samples.CursorY < Samples.NOfLines - 1) then
   begin
    if Key = VK_END then
     begin
      Samples.CursorX := 20;
      Samples.RecreateCaret
     end;
    Samples.CursorY := Samples.NOfLines - 1;
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
   end;
  if Samples.ShownFrom < 64 - Samples.NOfLines then
   begin
    Samples.ShownFrom := 64 - Samples.NOfLines;
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    ShowCaret(Samples.Handle)
   end
 end;
VK_PRIOR,VK_HOME:
 begin
  if ((Key = VK_HOME) and (Samples.CursorX <> 0)) or
     (Samples.CursorY > 0) then
   begin
    if Key = VK_HOME then
     begin
      Samples.CursorX := 0;
      Samples.RecreateCaret
     end;
    Samples.CursorY := 0;
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
   end;
  if Samples.ShownFrom > 0 then
   begin
    Samples.ShownFrom := 0;
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    ShowCaret(Samples.Handle)
   end
 end;
VK_RIGHT:
 if Samples.CursorX < 20 then
  begin
   Samples.CursorX := SColTabs[SColTab(Samples.CursorX) + 1];
   Samples.RecreateCaret;
   SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
  end;
VK_LEFT:
 if Samples.CursorX > 0 then
  begin
   if Samples.CursorX > 4 then
    Samples.CursorX := SColTabs[SColTab(Samples.CursorX) - 1]
   else if Samples.CursorX = 4 then
    Samples.CursorX := 2
   else
    Dec(Samples.CursorX); 
   Samples.RecreateCaret;
   SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
  end;
end
else if Shift = [ssShift] then
case Key of
Ord('6'):
 DoToggleAccA;
$BB:
 DoTogglePlus;
$BD:
 DoToggle_
end
else if Shift = [ssAlt] then
case Key of
VK_RIGHT:
 AddCurrentToSampTemplate;
VK_LEFT:
 CopySampTemplateToCurrent
end
end;

procedure TMDIChild.OrnamentsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
type
 TOrnToggles = (TgSgn,TgSgnP,TgSgnM);

 procedure GetOrnParams(var l,i:integer);
 begin
  with Ornaments do
   begin
    if ShownOrnament = nil then
     l := 1
    else
     l := ShownOrnament.Length;
    i := CursorY + (CursorX div 7) * 16
   end
 end;

 procedure DoToggles(n:TOrnToggles);
 var
  i,l:integer;
 begin
  with Ornaments do
   begin
    GetOrnParams(l,i);
    if i >= l then exit;
    SongChanged := True;
    ValidateOrnament(OrnNum);
    case n of
    TgSgn:
     ShownOrnament.Items[i] := -ShownOrnament.Items[i];
    TgSgnP:
     ShownOrnament.Items[i] := Abs(ShownOrnament.Items[i]);
    TgSgnM:
     ShownOrnament.Items[i] := -Abs(ShownOrnament.Items[i])
    end; 
    HideCaret(Handle);
    RedrawOrnaments(0);
    ShowCaret(Handle)
   end
 end;

 procedure DoToggleSpace;
 begin
  DoToggles(TgSgn)
 end;

 procedure DoTogglePlus;
 begin
  DoToggles(TgSgnP)
 end;

 procedure DoToggleMinus;
 begin
  DoToggles(TgSgnM)
 end;

 procedure DoNumber;
 var
  i,l:integer;
 begin
  with Ornaments do
   begin
    GetOrnParams(l,i);
    if i >= l then exit;
    SongChanged := True;
    ValidateOrnament(OrnNum);
    with ShownOrnament^ do
     if Items[i] < 0 then
      Items[i] := -InputONumber
     else
      Items[i] := InputONumber;
    HideCaret(Handle);
    RedrawOrnaments(0);
    ShowCaret(Handle)
   end
 end;

 procedure DoDigit(n:integer);
 var
  nm:integer;
 begin
  nm := Ornaments.InputONumber * 10 + n;
  if nm > 95 then
   nm := n;
  Ornaments.InputONumber := nm;
  DoNumber
 end;

begin
if (Shift <> []) or not (Key in [Ord('0')..Ord('9')]) then
 Ornaments.InputONumber := 0;
if Shift = [] then
case Key of
VK_NEXT:
 begin
  Ornaments.CursorY := 15;
  SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
 end;
VK_PRIOR:
 begin
  Ornaments.CursorY := 0;
  SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
 end;
VK_HOME:
 if Ornaments.CursorX <> 0 then
  begin
   Ornaments.CursorX := 0;
   SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
  end;
VK_END:
 if Ornaments.CursorX <> 21 then
  begin
   Ornaments.CursorX := 21;
   SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
  end;
VK_DOWN:
 begin
  if Ornaments.CursorY < 15 then
   begin
    Inc(Ornaments.CursorY);
    SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
   end
  else if Ornaments.CursorX < 21 then
   begin
    Ornaments.CursorY := 0;
    Inc(Ornaments.CursorX,7);
    SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
   end
 end;
VK_UP:
 begin
  if Ornaments.CursorY > 0 then
   begin
    Dec(Ornaments.CursorY);
    SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
   end
  else if Ornaments.CursorX > 0 then
   begin
    Ornaments.CursorY := 15;
    Dec(Ornaments.CursorX,7);
    SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
   end
 end;
VK_LEFT:
 if Ornaments.CursorX > 0 then
  begin
   Dec(Ornaments.CursorX,7);
   SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
  end;
VK_RIGHT:
 if Ornaments.CursorX < 21 then
  begin
   Inc(Ornaments.CursorX,7);
   SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
  end;
Ord(' '):
 DoToggleSpace;
$BB,VK_ADD:
 DoTogglePlus;
$BD,VK_SUBTRACT:
 DoToggleMinus;
Ord('0')..Ord('9'):
 DoDigit(Key - Ord('0'));
192:
 if OrnamentTestLine.CanFocus then
  OrnamentTestLine.SetFocus
end
else if Shift = [ssCtrl] then
case Key of
VK_NEXT,VK_END:
 begin
  Ornaments.CursorY := 15;
  Ornaments.CursorX := 21;
  SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
 end;
VK_PRIOR,VK_HOME:
 begin
  Ornaments.CursorY := 0;
  Ornaments.CursorX := 0;
  SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
 end;
end
else if Shift = [ssShift] then
case Key of
$BB:
 DoTogglePlus
end
{else if Shift = [ssAlt] then
case Key of
VK_RIGHT:
 AddCurrentToSampTemplate;
VK_LEFT:
 CopySampTemplateToCurrent
end}
end;

procedure TMDIChild.TracksMoveCursorMouse(X,Y:integer;Sel,Mv:boolean);
var
 x1,y1,i,PLen:integer;
begin
if Mv and not Tracks.Clicked then exit;
x1 := X div Tracks.CelW - 3;
y1 := Y div Tracks.CelH;
if Y < 0 then dec(y1);
i := Tracks.N1OfLines - Tracks.ShownFrom;
if Tracks.ShownPattern = nil then
 PLen := DefPatLen
else
 PLen := Tracks.ShownPattern.Length;
if Mv then
 begin
  if y1 < i then y1 := i
  else if y1 >= i + PLen then y1 := i + PLen - 1;
  if x1 < 0 then x1 := 0
  else if x1 > 48 then x1 := 48;
 end
else Tracks.Clicked := (y1 >= i) and (y1 < i + PLen) and
                       (x1 >= 0) and not ColSpace(x1);
if (y1 >= i) and (y1 < i + PLen) and
   (x1 >= 0) and not ColSpace(x1) then
 begin
  if x1 in [9..10] then
   x1 := 8
  else if x1 in [23..24] then
   x1 := 22
  else if x1 in [37..38] then
   x1 := 36;
  if (Tracks.CursorX <> x1) or (Tracks.CursorY <> y1) then
   begin
    if Tracks.Focused then HideCaret(Tracks.Handle);
    Tracks.ShowSelection(0);
    Tracks.CursorX := x1;
    Tracks.CursorY := y1;
    if Tracks.CursorY >= Tracks.NOfLines then
     begin
      Inc(Tracks.ShownFrom,Tracks.CursorY - Tracks.NOfLines + 1);
      Tracks.CursorY := Tracks.NOfLines - 1;
      Tracks.RedrawTracks(0)
     end
    else if Tracks.CursorY < 0 then
     begin
      Inc(Tracks.ShownFrom,Tracks.CursorY);
      Tracks.CursorY := 0;
      Tracks.RedrawTracks(0)
     end
    else if Sel then
     Tracks.ShowSelection(0)
    else
     Tracks.RemoveSelection(0,True);
    if Tracks.Focused then ShowCaret(Tracks.Handle);
   end
  else if not Sel then
   Tracks.RemoveSelection(0,False)
 end;
if Tracks.Focused then
 begin
  Tracks.RecreateCaret;
  SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                        Tracks.CelH * Tracks.CursorY)
 end;
ShowStat
end;

procedure TMDIChild.TracksMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
TracksMoveCursorMouse(X,Y,GetKeyState(VK_SHIFT) and 128 <> 0,False);
if not Tracks.Focused then Windows.SetFocus(Tracks.Handle)
end;

procedure TTestLine.TestLineMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 x1:integer;
begin
x1 := X div CelW;
if x1 in [9..10] then x1 := 8;
if not ColSpace(x1) then CursorX := x1;
if Focused then
 begin
  RecreateCaret;
  SetCaretPos(CelW * CursorX,0)
 end
else
 Windows.SetFocus(Handle)
end;

procedure TMDIChild.SamplesVolMouse(x,y:integer);
var
 l,i:integer;
begin
Dec(x,21);
if (x < 0) or (x > 15) then exit;
with Samples do
 begin
  if ShownSample = nil then
   l := 1
  else
   l := ShownSample.Length;
  i := ShownFrom + y;
  if i >= l then exit;
  SongChanged := True;
  ValidateSample2(SamNum);
  ShownSample.Items[i].Amplitude := x;
  if Focused then
   HideCaret(Handle);
  RedrawSamples(0);
  if Focused then
   ShowCaret(Handle)
 end
end;

procedure TMDIChild.SamplesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 x1,y1,i,l:integer;
 b:boolean;
begin
Samples.InputSNumber := 0;
x1 := X div Samples.CelW - 3;
y1 := Y div Samples.CelH;
if (y1 >= 0) and (y1 < Samples.NOfLines) and
   (x1 >= 0) and not (x1 in [3,9,13,16,18,21..36]) then
 begin
  if x1 in [6..7] then
   x1 := 5
  else if x1 = 12 then
   x1 := 11
  else if x1 = 15 then
   x1 := 14;
  Samples.CursorX := x1;
  Samples.CursorY := y1
 end;
if Shift = [ssRight] then
 begin
  SamplesVolMouse(x1,y1);
  with Samples do
   begin
    if ShownSample = nil then
     l := 1
    else
     l := ShownSample.Length;
    i := ShownFrom + y1;
    if i < l then
     begin
      ValidateSample2(SamNum);
      b := True;
      with ShownSample.Items[i] do
       case x1 of
       0:Mixer_Ton := not Mixer_Ton;
       1:Mixer_Noise := not Mixer_Noise;
       2:Envelope_Enabled := not Envelope_Enabled;
       4:Add_to_Ton := -Add_to_Ton;
       8:Ton_Accumulation := not Ton_Accumulation;
       10:Add_to_Envelope_or_Noise := Ns(-Add_to_Envelope_or_Noise);
       17:Envelope_or_Noise_Accumulation := not Envelope_or_Noise_Accumulation;
       20:if not Amplitude_Sliding then
        begin
         Amplitude_Sliding := True;
         Amplitude_Slide_Up := False
        end
       else if not Amplitude_Slide_Up then
        Amplitude_Slide_Up := True
       else
        Amplitude_Sliding := False;
      else
       b := False;
      end;
      if b then
       begin
        SongChanged := True;
        if Focused then
         HideCaret(Handle);
        RedrawSamples(0);
        if Focused then
         ShowCaret(Handle)
       end
     end
   end
 end;
if Samples.Focused then
 begin
  Samples.RecreateCaret;
  SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                        Samples.CelH * Samples.CursorY)
 end
else
 Windows.SetFocus(Samples.Handle)
end;

procedure TMDIChild.TracksMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if (ssLeft in Shift) and Tracks.Focused then
 TracksMoveCursorMouse(X,Y,True,True)
end;

procedure TMDIChild.SamplesMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if Shift = [ssRight] then
 begin
  Samples.InputSNumber := 0;
  SamplesVolMouse(X div Samples.CelW - 3,Y div Samples.CelH)
 end
end;

procedure TMDIChild.OrnamentsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 x1,y1,i,l:integer;
begin
Ornaments.InputONumber := 0;
x1 := X div Ornaments.CelW - 3;
y1 := Y div Ornaments.CelH;
if (y1 >= 0) and (y1 <= 15) and
   (x1 >= 0) and not (x1 in [3..6,10..13,17..20,24]) then
 begin
  if x1 in [1..2] then
   x1 := 0
  else if x1 in [8..9] then
   x1 := 7
  else if x1 in [15..16] then
   x1 := 14
  else if x1 in [22..23] then
   x1 := 21;
  Ornaments.CursorX := x1;
  Ornaments.CursorY := y1
 end;
if Shift = [ssRight] then
 begin
  if x1 in [0,7,14,21] then
   with Ornaments do
    begin
     if ShownOrnament = nil then
      l := 1
     else
      l := ShownOrnament.Length;
     i := (x1 div 7) * 16 + y1;
     if i < l then
      begin
       SongChanged := True;
       ValidateOrnament(OrnNum);
       ShownOrnament.Items[i] := -ShownOrnament.Items[i];
       if Focused then
        HideCaret(Handle);
       RedrawOrnaments(0);
       if Focused then
        ShowCaret(Handle)
      end
    end
 end;
if Ornaments.Focused then
 begin
  SetCaretPos(Ornaments.CelW * (3 + Ornaments.CursorX),
                        Ornaments.CelH * Ornaments.CursorY)
 end
else
 Windows.SetFocus(Ornaments.Handle)
end;

procedure TMDIChild.FormDestroy(Sender: TObject);
var
 i:integer;
begin
Tracks.Free;
for i := 1 to 31 do
 if VTMP.Samples[i] <> nil then
  VTMP.Samples[i].Items := nil;
for i := 0 to 15 do
 if VTMP.Ornaments[i] <> nil then
  VTMP.Ornaments[i].Items := nil;
for i := -1 to MaxPatNum do
 if VTMP.Patterns[i] <> nil then
  VTMP.Patterns[i].Items := nil;
Dispose(VTMP)
end;

procedure TMDIChild.LoadTrackerModule(Name:string);
const
 ers:array[1..6] of string =
  ('Module not found',
   'Syntax error',
   'Parameter out of range',
   'Unexpected end of file',
   'Bad sample structure',
   'Bad pattern structure');
var
 ZXP:PSpeccyModule;
 i:integer;
 FileType:Available_Types;
 s:string;
begin
New(ZXP);
FileType := LoadAndDetect(ZXP,Name,i);
case FileType of
Unknown:
 begin
  i := LoadModuleFromText(Name,VTMP);
  if i <> 0 then
   begin
    Close;
    MessageBox(MainForm.Handle,PChar(ers[i] + ' (line: ' + IntToStr(TxtLine) + ')'),
               'Text module loader error',MB_ICONEXCLAMATION);
    exit
   end;
  FileType := PT3File
 end;
PT2File:
 PT22VTM(ZXP,VTMP);
PT1File:
 PT12VTM(ZXP,VTMP);
STCFile:
 STC2VTM(ZXP,i,VTMP);
STPFile:
 STP2VTM(ZXP,VTMP);
SQTFile:
 SQT2VTM(ZXP,VTMP);
ASCFile:
 ASC2VTM(ZXP,VTMP);
PSCFile:
 PSC2VTM(ZXP,VTMP);
FLSFile:
 FLS2VTM(ZXP,VTMP);
GTRFile:
 GTR2VTM(ZXP,VTMP);
FTCFile:
 FTC2VTM(ZXP,VTMP);
PT3File:
 PT32VTM(ZXP,VTMP);
end;
Dispose(ZXP);
if FileType = Unknown then exit;
Vtm3xxxGrp.ItemIndex := Ord(not VTMP.New3xxxInterpretation);
SaveHead.ItemIndex :=  Ord(not VTMP.VortexModule_Header);
MainForm.AddFileName(Name);
if VTMP.Positions.Length > 0 then
 begin
  UpDown1.Position := VTMP.Positions.Value[0];
  Tracks.ShownPattern := VTMP.Patterns[VTMP.Positions.Value[0]];
  if Tracks.ShownPattern <> nil then
   UpDown5.Position := VTMP.Patterns[VTMP.Positions.Value[0]].Length
  else
   UpDown5.Position := DefPatLen
 end
else
 begin
  Tracks.ShownPattern := VTMP.Patterns[0];
  if VTMP.Patterns[0] <> nil then
   UpDown5.Position := VTMP.Patterns[0].Length
  else
   UpDown5.Position := DefPatLen
 end;
if AutoHLCheck.Checked then CalcHLStep;
UpDown3.Position := VTMP.Initial_Delay;
UpDown4.Position := VTMP.Ton_Table;
Edit3.Text := VTMP.Title;
Edit4.Text := VTMP.Author;
PosDelay := VTMP.Initial_Delay;
for i := 0 to VTMP.Positions.Length - 1 do
 begin
  s := IntToStr(VTMP.Positions.Value[i]);
  if i = VTMP.Positions.Loop then
   s := 'L' + s;
  StringGrid1.Cells[i,0] := s
 end;
Samples.ShownSample := VTMP.Samples[1];
if VTMP.Samples[1] <> nil then
 begin
  UpDown7.Position := VTMP.Samples[1].Length;
  UpDown8.Position := VTMP.Samples[1].Loop;
  ShowSamStats
 end;
Ornaments.ShownOrnament := VTMP.Ornaments[1];
if VTMP.Ornaments[1] <> nil then
 begin
  UpDown11.Position := VTMP.Ornaments[1].Length;
  UpDown10.Position := VTMP.Ornaments[1].Loop;
  ShowOrnStats
 end;
CalcTotLen;
SongChanged := False
end;

procedure TMDIChild.TracksMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
 PLen:integer;
begin
Handled := True;
if Tracks.ShownPattern = nil then
 PLen := DefPatLen
else
 PLen := Tracks.ShownPattern.Length;
if Tracks.ShownFrom < PLen - 1 then
  begin
   Inc(Tracks.ShownFrom);
   HideCaret(Tracks.Handle);
   if (Tracks.CursorY > 0) and
      (Tracks.CursorY <> Tracks.N1OfLines) then
    begin
     Dec(Tracks.CursorY);
     SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                              Tracks.CelH * Tracks.CursorY);
    end
   else if GetKeyState(VK_SHIFT) and 128 = 0 then
    Tracks.RemoveSelection(0,True);
   Tracks.RedrawTracks(0);
   ShowCaret(Tracks.Handle)
  end
else
   begin
    Tracks.ShownFrom := 0;
    Tracks.CursorY := Tracks.N1OfLines;
    Tracks.RemoveSelection(0,True);
    HideCaret(Tracks.Handle);
    Tracks.RedrawTracks(0);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    ShowCaret(Tracks.Handle)
   end;
ShowStat
end;

procedure TMDIChild.TracksMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
 PLen:integer;
begin
Handled := True;
if Tracks.ShownFrom > 0 then
  begin
   Dec(Tracks.ShownFrom);
   HideCaret(Tracks.Handle);
   if (Tracks.CursorY < Tracks.NOfLines - 1) and
      (Tracks.CursorY <> Tracks.N1OfLines) then
    begin
     Inc(Tracks.CursorY);
     SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                              Tracks.CelH * Tracks.CursorY);
    end
   else if GetKeyState(VK_SHIFT) and 128 = 0 then
    Tracks.RemoveSelection(0,True);
   Tracks.RedrawTracks(0);
   ShowCaret(Tracks.Handle)
  end
 else
   begin
    if Tracks.ShownPattern = nil then
     PLen := DefPatLen
    else
     PLen := Tracks.ShownPattern.Length;
    Tracks.ShownFrom := PLen - 1;
    Tracks.CursorY := Tracks.N1OfLines;
    Tracks.RemoveSelection(0,True);
    HideCaret(Tracks.Handle);
    Tracks.RedrawTracks(0);
    SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                         Tracks.CelH * Tracks.CursorY);
    ShowCaret(Tracks.Handle)
   end;
ShowStat
end;

procedure TMDIChild.SamplesMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
Samples.InputSNumber := 0;
Handled := True;
if Samples.ShownFrom < 64 - Samples.NOfLines then
   begin
    Inc(Samples.ShownFrom);
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    if Samples.CursorY > 0 then
     begin
      Dec(Samples.CursorY);
      SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                              Samples.CelH * Samples.CursorY)
     end;
    ShowCaret(Samples.Handle)
   end
 else
   begin
    Samples.ShownFrom := 0;
    Samples.CursorY := 0;
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                         Samples.CelH * Samples.CursorY);
    ShowCaret(Samples.Handle)
   end
end;

procedure TMDIChild.SamplesMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
Samples.InputSNumber := 0;
Handled := True;
if Samples.ShownFrom > 0 then
   begin
    Dec(Samples.ShownFrom);
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    if Samples.CursorY < Samples.NOfLines - 1 then
     begin
      Inc(Samples.CursorY);
      SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                              Samples.CelH * Samples.CursorY);
     end;
    ShowCaret(Samples.Handle)
   end
 else
   begin
    Samples.ShownFrom := 64 - Samples.NOfLines;
    Samples.CursorY := Samples.NOfLines - 1;
    HideCaret(Samples.Handle);
    Samples.RedrawSamples(0);
    SetCaretPos(Samples.CelW * (3 + Samples.CursorX),
                         Samples.CelH * Samples.CursorY);
    ShowCaret(Samples.Handle)
   end
end;

procedure TMDIChild.ValidatePattern2;
begin
ValidatePattern(pat,VTMP);
if pat = PatNum then
 Tracks.ShownPattern := VTMP.Patterns[PatNum]
end;
 
procedure TMDIChild.TracksKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Tracks.KeyPressed = Key then
 begin
  if (PlayMode in [PMPlayLine,PMPlayPattern]) and
      IsPlaying and (PlayingWindow = Self) then
   begin
    ResetPlaying;
    PlayMode := PMPlayLine
   end;
  Tracks.KeyPressed := 0
 end
end;

procedure TTestLine.TestLineKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if KeyPressed = Key then
 begin
  if (PlayMode = PMPlayLine) and
      IsPlaying and (PlayingWindow = ParWind) then
   ResetPlaying;
  KeyPressed := 0
 end
end;

procedure TMDIChild.RestartPlayingPos(Pos:integer);
begin
if not IsPlaying then exit;
if PlayMode <> PMPlayModule then exit;
if PlayingWindow <> Self then exit;
if not Reseted then ResetPlaying;
RerollToPos(Pos);
UnresetPlaying
end;

procedure TMDIChild.RestartPlayingLine;
var
 NT:array[0..2] of integer;
 i:integer;
 EnvP,EnvT:integer;
begin
if IsPlaying then
 begin
  if PlayMode <> PMPlayLine then exit;
  ResetPlaying
 end;
Form1.PlayStarts;
PlayingWindow := Self;
PlayMode := PMPlayLine;
EnvP := Env_Base;
EnvT := AYRegisters.EnvType;
Module_SetPointer(VTMP);
if Line >= 0 then
 begin
  for i := 0 to 2 do
   NT[i] := ParamsOfChan[i].Note;
  InitForAllTypes(False);
  for i := 0 to 2 do
   ParamsOfChan[i].Note := NT[i];
  for i := 0 to 2 do
   if VTMP.IsChans[i].EnvelopeEnabled then
    begin
     Env_Base := EnvP;
     SetEnvelopeRegister(EnvT);
     break
    end;
  for i := 0 to 2 do
   if ((VTMP.Patterns[PatNum].Items[Line].Channel[i].Note = -1) and
       (VTMP.Patterns[PatNum].Items[Line].Channel[i].Envelope in
                                                        [1..14])) then
    ParamsOfChan[i].SoundEnabled := True;
  Module_SetCurrentPattern(PatNum);
  Pattern_SetCurrentLine(Line)
 end
else
 begin
  NT[0] := ParamsOfChan[MidChan].Note;
  InitForAllTypes(False);
  ParamsOfChan[MidChan].Note := NT[0];
  if VTMP.IsChans[MidChan].EnvelopeEnabled then
   begin
    Env_Base := EnvP;
    SetEnvelopeRegister(EnvT)
   end;
  if ((VTMP.Patterns[-1].Items[-(Line + 1)].Channel[0].Note = -1) and
      (VTMP.Patterns[-1].Items[-(Line + 1)].Channel[0].Envelope in
                                                       [1..14])) then
   ParamsOfChan[MidChan].SoundEnabled := True;
  Module_SetCurrentPattern(-1);
  Pattern_SetCurrentLine(-(Line + 1))
 end;
Pattern_PlayCurrentLine;
LineReady := True;
if IsPlaying then
 UnresetPlaying
else
 StartWOThread
end;

procedure TMDIChild.RestartPlayingPatternLine;
begin
if IsPlaying then
 begin
  if PlayMode <> PMPlayLine then exit;
  ResetPlaying
 end;
PlayMode := PMPlayPattern;
if Enter then
 begin
  Form1.PlayStarts;
  PlayingWindow := Self
 end 
else
 MainForm.DisableControls; 
Tracks.RemoveSelection(0,False);
Module_SetPointer(VTMP);
Module_SetDelay(VTMP.Initial_Delay);
CurrentPosition := 65535;
Module_SetCurrentPattern(PatNum);
InitForAllTypes(False);
RerollToPatternLine;
if IsPlaying then
 UnresetPlaying
else
 StartWOThread
end;

procedure TMDIChild.StopAndRestart;
begin
if not IsPlaying then exit;
if Reseted then exit;
if PlayMode <> PMPlayModule then exit;
ResetPlaying;
RerollToLine;
UnresetPlaying
end;

procedure TMDIChild.RerollToPos;
var
 i:integer;
begin
Module_SetPointer(VTMP);
Module_SetDelay(VTMP.Initial_Delay);
Module_SetCurrentPosition(0);
InitForAllTypes(True);
if Pos > 0 then
 begin
  repeat
   i := Module_PlayCurrentLine;
  until (i = 2) and (CurrentPosition = Pos);
  LineReady := True
 end
end;

procedure TMDIChild.RerollToLine;
var
 i:integer;
begin
Module_SetDelay(VTMP.Initial_Delay);
Module_SetCurrentPosition(0);
InitForAllTypes(True);
if PositionNumber > 0 then
 begin
  repeat
   i := Module_PlayCurrentLine
  until (i = 2) and (CurrentPosition = PositionNumber);
  LineReady := True
 end;
if Tracks.ShownFrom > 0 then
 begin
  repeat
   i := Module_PlayCurrentLine
  until (i = 1) and (CurrentLine = Tracks.ShownFrom + 1);
  LineReady := True
 end
end;

procedure TMDIChild.RerollToPatternLine;
var
 i,j:integer;
begin
LineReady := False;
j := Tracks.ShownFrom - Tracks.N1OfLines + Tracks.CursorY;
if (j > 0) and (j < Tracks.ShownPattern.Length) then
 begin
  repeat
   i := Pattern_PlayCurrentLine
  until (i = 1) and (CurrentLine = j + 1);
  LineReady := True
 end
end;

procedure TMDIChild.SelectPosition;
begin
if Pos < VTMP.Positions.Length then
 begin
  PositionNumber := Pos;
  CalculatePos0;
  if IsPlaying and (PlayMode = PMPlayModule) then
   RestartPlayingPos(Pos)
  else if not IsPlaying or (PlayMode <> PMPlayPattern) then
   UpDown1.Position := VTMP.Positions.Value[Pos]
 end
else
 begin
  PosBegin := TotInts;
  Label25.Caption := IntsToTime(PosBegin);
  Label24.Caption := '(' + IntToStr(PosBegin);
 end; 
InputPNumber := 0
end;

procedure TMDIChild.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
SelectPosition(ACol)
end;

procedure TMDIChild.StringGrid1KeyPress(Sender: TObject; var Key: Char);
var
 s:string;
begin
case Key of
'0'..'9':
 if not (IsPlaying and (PlayMode = PMPlayModule)) and
    (StringGrid1.Selection.Left <= VTMP.Positions.Length) then
  begin
   InputPNumber := InputPNumber * 10 + Ord(Key) - Ord('0');
   if InputPNumber > MaxPatNum then
    InputPNumber := Ord(Key) - Ord('0');
   SongChanged := True;
   if StringGrid1.Selection.Left = VTMP.Positions.Length then
    Inc(VTMP.Positions.Length);
   VTMP.Positions.Value[StringGrid1.Selection.Left] := InputPNumber;
   s := IntToStr(InputPNumber);
   if StringGrid1.Selection.Left = VTMP.Positions.Loop then
    s := 'L' + s;
   StringGrid1.Cells[StringGrid1.Selection.Left,0] := s;
   CalcTotLen;
   ValidatePattern2(InputPNumber);
   UpDown1.Position := InputPNumber;
   exit
  end
end;
InputPNumber := 0
end;

procedure TMDIChild.Edit2Exit(Sender: TObject);
begin
Edit2.Text := IntToStr(UpDown1.Position)
end;

procedure TMDIChild.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 x1,y1:integer;
 sel:TGridRect;
begin
if (Button = mbRight) and not IsPlaying then
 begin
  StringGrid1.MouseToCell(X,Y,x1,y1);
  sel.Left := x1;
  sel.Right := x1;
  sel.Top := y1;
  sel.Bottom := y1;
  StringGrid1.Selection := Sel;
  SelectPosition(x1)
 end
end;

procedure TMDIChild.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if Key <> #8 then
 if (Length(Edit3.Text) >= 32) and (Edit3.SelLength = 0) then
  begin
   Beep;
   Key := #0
  end
end;

procedure TMDIChild.Edit3Change(Sender: TObject);
var
 s:string;
begin
if Edit3.Modified then
 begin
  SongChanged := True;
  s := Edit3.Text;
  if Length(s) > 32 then
   begin
    SetLength(s,32);
    Edit3.Text := s
   end;
  VTMP.Title := s
 end
end;

procedure TMDIChild.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
if Key <> #8 then
 if (Length(Edit4.Text) >= 32) and (Edit4.SelLength = 0) then
  begin
   Beep;
   Key := #0
  end
end;

procedure TMDIChild.Edit4Change(Sender: TObject);
var
 s:string;
begin
if Edit4.Modified then
 begin
  SongChanged := True;
  s := Edit4.Text;
  if Length(s) > 32 then
   begin
    SetLength(s,32);
    Edit4.Text := s
   end;
  VTMP.Author := s
 end
end;

procedure TMDIChild.ChangePattern(n:integer);
var
 l:integer;
begin
PatNum := n;
Tracks.ShownPattern := VTMP.Patterns[PatNum];
if VTMP.Patterns[PatNum] = nil then
 l := DefPatLen
else
 l := VTMP.Patterns[PatNum].Length;
UpDown5.Position := l;
if AutoHLCheck.Checked then CalcHLStep;
Tracks.ShownFrom := 0;
if Tracks.Focused then
 HideCaret(Tracks.Handle);
if Tracks.CursorY > l - 1 + Tracks.N1OfLines then
 begin
  Tracks.CursorY := l - 1 + Tracks.N1OfLines;
  if Tracks.Focused then
   SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                      Tracks.CelH * Tracks.CursorY)
 end
else if Tracks.CursorY < Tracks.N1OfLines then
 begin
  Tracks.CursorY := Tracks.N1OfLines;
  if Tracks.Focused then
   SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                      Tracks.CelH * Tracks.CursorY)
 end;
Tracks.RemoveSelection(0,True);
Tracks.RedrawTracks(0);
if Tracks.Focused then
 ShowCaret(Tracks.Handle)
end;

procedure TMDIChild.UpDown1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [0..MaxPatNum];
if AllowChange then
 ChangePattern(NewValue)
end;

procedure TMDIChild.Edit2Change(Sender: TObject);
begin
if PatNum <> UpDown1.Position then
 ChangePattern(UpDown1.Position)
end;

procedure TMDIChild.Edit6Exit(Sender: TObject);
begin
Edit6.Text := IntToStr(UpDown3.Position)
end;

procedure TMDIChild.Edit6Change(Sender: TObject);
begin
SetInitDelay(UpDown3.Position)
end;

procedure TMDIChild.UpDown3ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [1..255];
if AllowChange then
 SetInitDelay(NewValue)
end;

procedure TMDIChild.UpDown4ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [0..3];
if AllowChange and (VTMP.Ton_Table <> NewValue) then
 begin
  SongChanged := True;
  VTMP.Ton_Table := NewValue
 end
end;

procedure TMDIChild.Edit7Exit(Sender: TObject);
begin
Edit7.Text := IntToStr(UpDown4.Position)
end;

procedure TMDIChild.Edit7Change(Sender: TObject);
begin
if VTMP.Ton_Table <> UpDown4.Position then
 begin
  SongChanged := True;
  VTMP.Ton_Table := UpDown4.Position
 end
end;

procedure TMDIChild.Edit8Exit(Sender: TObject);
begin
Edit8.Text := IntToStr(UpDown5.Position);
ChangePatternLength(UpDown5.Position)
end;

procedure TMDIChild.UpDown5ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := (NewValue > 0) and (NewValue <= MaxPatLen);
if AllowChange then
 ChangePatternLength(NewValue)
end;

procedure TMDIChild.ChangePatternLength(NL:integer);
var
 i,j:integer;
begin
ValidatePattern2(PatNum);
if NL <> VTMP.Patterns[PatNum].Length then
 begin
  SongChanged := True;
  SetLength(VTMP.Patterns[PatNum].Items,NL);
  for i := VTMP.Patterns[PatNum].Length to NL - 1 do
   begin
    VTMP.Patterns[PatNum].Items[i].Noise := 0;
    VTMP.Patterns[PatNum].Items[i].Envelope := 0;
    for j := 0 to 2 do
     begin
      VTMP.Patterns[PatNum].Items[i].Channel[j].Note := -1;
      VTMP.Patterns[PatNum].Items[i].Channel[j].Sample := 0;
      VTMP.Patterns[PatNum].Items[i].Channel[j].Ornament := 0;
      VTMP.Patterns[PatNum].Items[i].Channel[j].Volume := 0;
      VTMP.Patterns[PatNum].Items[i].Channel[j].Envelope := 0;
      VTMP.Patterns[PatNum].Items[i].Channel[j].Additional_Command.Number := 0;
      VTMP.Patterns[PatNum].Items[i].Channel[j].Additional_Command.Delay := 0;
      VTMP.Patterns[PatNum].Items[i].Channel[j].Additional_Command.Parameter := 0
     end
   end;
  VTMP.Patterns[PatNum].Length := NL;
  if AutoHLCheck.Checked then CalcHLStep;
  if Tracks.ShownFrom >= NL then
   Tracks.ShownFrom := NL - 1;
  if Tracks.Focused then
   HideCaret(Tracks.Handle);
  if Tracks.CursorY > NL - Tracks.ShownFrom - 1 + Tracks.N1OfLines then
   begin
    Tracks.CursorY := NL - Tracks.ShownFrom - 1 + Tracks.N1OfLines;
    if Tracks.Focused then
     SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                        Tracks.CelH * Tracks.CursorY);
   end;
  Tracks.RemoveSelection(0,True);
  Tracks.RedrawTracks(0);
  if Tracks.Focused then
   ShowCaret(Tracks.Handle);
  CalcTotLen;
  CalculatePos0
 end
end;

procedure TMDIChild.Edit1Exit(Sender: TObject);
begin
Edit1.Text := IntToStr(UpDown2.Position)
end;

procedure TMDIChild.SpeedButton1Click(Sender: TObject);
begin
if VTMP.IsChans[0].Global_Ton and
   VTMP.IsChans[0].Global_Noise and
   VTMP.IsChans[0].Global_Envelope then
 begin
  VTMP.IsChans[0].Global_Ton := False;
  VTMP.IsChans[0].Global_Noise := False;
  VTMP.IsChans[0].Global_Envelope := False;
  SpeedButton2.Down := False;
  SpeedButton3.Down := False;
  SpeedButton4.Down := False
 end
else
 begin
  VTMP.IsChans[0].Global_Ton := True;
  VTMP.IsChans[0].Global_Noise := True;
  VTMP.IsChans[0].Global_Envelope := True;
  SpeedButton2.Down := True;
  SpeedButton3.Down := True;
  SpeedButton4.Down := True
 end;
StopAndRestart
end;

procedure TMDIChild.SpeedButton2Click(Sender: TObject);
begin
VTMP.IsChans[0].Global_Ton := SpeedButton2.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton3Click(Sender: TObject);
begin
VTMP.IsChans[0].Global_Noise := SpeedButton3.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton4Click(Sender: TObject);
begin
VTMP.IsChans[0].Global_Envelope := SpeedButton4.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton5Click(Sender: TObject);
begin
if VTMP.IsChans[1].Global_Ton and
   VTMP.IsChans[1].Global_Noise and
   VTMP.IsChans[1].Global_Envelope then
 begin
  VTMP.IsChans[1].Global_Ton := False;
  VTMP.IsChans[1].Global_Noise := False;
  VTMP.IsChans[1].Global_Envelope := False;
  SpeedButton6.Down := False;
  SpeedButton7.Down := False;
  SpeedButton8.Down := False
 end
else
 begin
  VTMP.IsChans[1].Global_Ton := True;
  VTMP.IsChans[1].Global_Noise := True;
  VTMP.IsChans[1].Global_Envelope := True;
  SpeedButton6.Down := True;
  SpeedButton7.Down := True;
  SpeedButton8.Down := True
 end;
StopAndRestart
end;

procedure TMDIChild.SpeedButton6Click(Sender: TObject);
begin
VTMP.IsChans[1].Global_Ton := SpeedButton6.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton7Click(Sender: TObject);
begin
VTMP.IsChans[1].Global_Noise := SpeedButton7.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton8Click(Sender: TObject);
begin
VTMP.IsChans[1].Global_Envelope := SpeedButton8.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton9Click(Sender: TObject);
begin
if VTMP.IsChans[2].Global_Ton and
   VTMP.IsChans[2].Global_Noise and
   VTMP.IsChans[2].Global_Envelope then
 begin
  VTMP.IsChans[2].Global_Ton := False;
  VTMP.IsChans[2].Global_Noise := False;
  VTMP.IsChans[2].Global_Envelope := False;
  SpeedButton10.Down := False;
  SpeedButton11.Down := False;
  SpeedButton12.Down := False
 end
else
 begin
  VTMP.IsChans[2].Global_Ton := True;
  VTMP.IsChans[2].Global_Noise := True;
  VTMP.IsChans[2].Global_Envelope := True;
  SpeedButton10.Down := True;
  SpeedButton11.Down := True;
  SpeedButton12.Down := True
 end;
StopAndRestart
end;

procedure TMDIChild.SpeedButton10Click(Sender: TObject);
begin
VTMP.IsChans[2].Global_Ton := SpeedButton10.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton11Click(Sender: TObject);
begin
VTMP.IsChans[2].Global_Noise := SpeedButton11.Down;
StopAndRestart
end;

procedure TMDIChild.SpeedButton12Click(Sender: TObject);
begin
VTMP.IsChans[2].Global_Envelope := SpeedButton12.Down;
StopAndRestart
end;

procedure TMDIChild.Vtm3xxxGrpClick(Sender: TObject);
begin
SongChanged := True;
VTMP.New3xxxInterpretation := not Boolean(Vtm3xxxGrp.ItemIndex)
end;

procedure TMDIChild.SaveHeadClick(Sender: TObject);
begin
SongChanged := True;
VTMP.VortexModule_Header := not Boolean(SaveHead.ItemIndex)
end;

procedure TMDIChild.Edit5Change(Sender: TObject);
begin
if SamNum <> UpDown6.Position then
 ChangeSample(UpDown6.Position)
end;

procedure TMDIChild.Edit5Exit(Sender: TObject);
begin
Edit5.Text := IntToStr(UpDown6.Position)
end;

procedure TMDIChild.UpDown6ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [1..31];
if AllowChange then
 ChangeSample(NewValue)
end;

procedure TMDIChild.Edit9Exit(Sender: TObject);
begin
Edit9.Text := IntToStr(UpDown7.Position);
ChangeSampleLength(UpDown7.Position)
end;

procedure TMDIChild.UpDown7ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [1..64];
if AllowChange then
 ChangeSampleLength(NewValue)
end;

procedure TMDIChild.ChangeSample(n:integer);
var
 l:integer;
begin
SamNum := n;
with SampleTestLine do
 begin
  VTMP.Patterns[-1].Items[1].Channel[0].Sample := n;
  if Focused then
   HideCaret(Handle);
  RedrawTestLine(0);
  if Focused then
   ShowCaret(Handle)
 end;
Samples.ShownSample := VTMP.Samples[SamNum];
if VTMP.Samples[SamNum] = nil then
 l := 1
else
 l := VTMP.Samples[SamNum].Length;
UpDown7.Position := l;
if VTMP.Samples[SamNum] = nil then
 l := 0
else
 l := VTMP.Samples[SamNum].Loop;
UpDown8.Position := l;
Samples.ShownFrom := 0;
Samples.CursorX := 0;
Samples.CursorY := 0;
if Samples.Focused then
 begin
  Samples.RecreateCaret;
  SetCaretPos(Samples.CelW * 3,0);
  HideCaret(Samples.Handle)
 end;
Samples.RedrawSamples(0);
if Samples.Focused then
 ShowCaret(Samples.Handle);
ShowSamStats
end;

procedure TMDIChild.ChangeSampleLength(NL:integer);
var
 i:integer;
begin
if (VTMP.Samples[SamNum] = nil) and (NL = 1) then exit;
ValidateSample2(SamNum);
if NL <> VTMP.Samples[SamNum].Length then
 begin
  SongChanged := True;
  SetLength(VTMP.Samples[SamNum].Items,NL);
  for i := VTMP.Samples[SamNum].Length to NL - 1 do
   VTMP.Samples[SamNum].Items[i] :=
    MainForm.SampleLineTemplates[MainForm.CurrentSampleLineTemplate];
  VTMP.Samples[SamNum].Length := NL;
  if VTMP.Samples[SamNum].Loop >= VTMP.Samples[SamNum].Length then
   begin
    VTMP.Samples[SamNum].Loop := VTMP.Samples[SamNum].Length - 1;
    UpDown8.Position := VTMP.Samples[SamNum].Loop
   end;
  if Samples.Focused then
   HideCaret(Samples.Handle);
  Samples.RedrawSamples(0);
  if Samples.Focused then
   ShowCaret(Samples.Handle);
  ShowSamStats
 end
end;

procedure TMDIChild.ChangeSampleLoop(NL:integer);
begin
if (VTMP.Samples[SamNum] = nil) then exit;
if (NL <> VTMP.Samples[SamNum].Loop) and (NL < VTMP.Samples[SamNum].Length) then
 begin
  SongChanged := True;
  VTMP.Samples[SamNum].Loop := NL;
  if Samples.Focused then
   HideCaret(Samples.Handle);
  Samples.RedrawSamples(0);
  if Samples.Focused then
   ShowCaret(Samples.Handle);
  ShowSamStats
 end
end;

procedure TMDIChild.ShowSamStats;
var
 l:integer;
begin
Label13.Caption := SampToStr(SamNum);
if VTMP.Samples[SamNum] = nil then
 l := 0
else
 l := VTMP.Samples[SamNum].Loop;
Label14.Caption := IntToHex(l,1);
if VTMP.Samples[SamNum] = nil then
 l := 1
else
 l := VTMP.Samples[SamNum].Length;
Label17.Caption := IntToHex(l,1);
Label19.Caption := IntToHex(l - 1,1)
end;

procedure TMDIChild.ChangeOrnament(n:integer);
var
 l:integer;
begin
OrnNum := n;
with OrnamentTestLine do
 begin
  VTMP.Patterns[-1].Items[0].Channel[0].Ornament := n;
  if Focused then
   HideCaret(Handle);
  RedrawTestLine(0);
  if Focused then
   ShowCaret(Handle)
 end;
Ornaments.ShownOrnament := VTMP.Ornaments[OrnNum];
if VTMP.Ornaments[OrnNum] = nil then
 l := 1
else
 l := VTMP.Ornaments[OrnNum].Length;
UpDown11.Position := l;
if VTMP.Ornaments[OrnNum] = nil then
 l := 0
else
 l := VTMP.Ornaments[OrnNum].Loop;
UpDown10.Position := l;
Ornaments.CursorX := 0;
Ornaments.CursorY := 0;
if Ornaments.Focused then
 begin
  SetCaretPos(Ornaments.CelW * 3,0);
  HideCaret(Ornaments.Handle)
 end;
Ornaments.RedrawOrnaments(0);
if Ornaments.Focused then
 ShowCaret(Ornaments.Handle);
ShowOrnStats
end;

procedure TMDIChild.ChangeOrnamentLength(NL:integer);
var
 i:integer;
begin
if (VTMP.Ornaments[OrnNum] = nil) and (NL = 1) then exit;
ValidateOrnament(OrnNum);
if NL <> VTMP.Ornaments[OrnNum].Length then
 begin
  SongChanged := True;
  SetLength(VTMP.Ornaments[OrnNum].Items,NL);
  for i := VTMP.Ornaments[OrnNum].Length to NL - 1 do
   VTMP.Ornaments[OrnNum].Items[i] := 0;
  VTMP.Ornaments[OrnNum].Length := NL;
  if VTMP.Ornaments[OrnNum].Loop >= VTMP.Ornaments[OrnNum].Length then
   begin
    VTMP.Ornaments[OrnNum].Loop := VTMP.Ornaments[OrnNum].Length - 1;
    UpDown10.Position := VTMP.Ornaments[OrnNum].Loop
   end;
  if Ornaments.Focused then
   HideCaret(Ornaments.Handle);
  Ornaments.RedrawOrnaments(0);
  if Ornaments.Focused then
   ShowCaret(Ornaments.Handle);
  ShowOrnStats
 end
end;

procedure TMDIChild.ChangeOrnamentLoop(NL:integer);
begin
if (VTMP.Ornaments[OrnNum] = nil) then exit;
if (NL <> VTMP.Ornaments[OrnNum].Loop) and (NL < VTMP.Ornaments[OrnNum].Length) then
 begin
  SongChanged := True;
  VTMP.Ornaments[OrnNum].Loop := NL;
  if Ornaments.Focused then
   HideCaret(Ornaments.Handle);
  Ornaments.RedrawOrnaments(0);
  if Ornaments.Focused then
   ShowCaret(Ornaments.Handle);
  ShowOrnStats
 end
end;

procedure TMDIChild.ShowOrnStats;
var
 l:integer;
begin
Label33.Caption := IntToHex(OrnNum,1);
if VTMP.Ornaments[OrnNum] = nil then
 l := 0
else
 l := VTMP.Ornaments[OrnNum].Loop;
Label34.Caption := IntToHex(l,1);
if VTMP.Ornaments[OrnNum] = nil then
 l := 1
else
 l := VTMP.Ornaments[OrnNum].Length;
Label37.Caption := IntToHex(l,1);
Label39.Caption := IntToHex(l - 1,1)
end;

procedure TMDIChild.ValidateSample2;
begin
ValidateSample(sam,VTMP);
if sam = SamNum then
 Samples.ShownSample := VTMP.Samples[SamNum]
end;

procedure TMDIChild.ValidateOrnament;
begin
if VTMP.Ornaments[orn] = nil then
 begin
  New(VTMP.Ornaments[orn]);
  VTMP.Ornaments[orn].Loop := 0;
  VTMP.Ornaments[orn].Length := 1;
  SetLength(VTMP.Ornaments[orn].Items,1);
  VTMP.Ornaments[orn].Items[0] := 0;
  if orn = OrnNum then
   Ornaments.ShownOrnament := VTMP.Ornaments[OrnNum]
 end
end;

procedure TMDIChild.Edit10Exit(Sender: TObject);
begin
Edit10.Text := IntToStr(UpDown8.Position);
ChangeSampleLoop(UpDown8.Position)
end;

procedure TMDIChild.UpDown8ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
var
 l:integer;
begin
if VTMP.Samples[SamNum] = nil then
 l := 1
else
 l := VTMP.Samples[SamNum].Length;
AllowChange := (NewValue >= 0) and (NewValue < l);
if AllowChange then
 ChangeSampleLoop(NewValue)
end;

procedure TMDIChild.CalculatePos0;
begin
PosBegin := GetPositionTime(VTMP,PositionNumber,PosDelay);
LineInts := 0;
Label25.Caption := IntsToTime(PosBegin);
Label24.Caption := '(' + IntToStr(PosBegin)
end;

procedure TMDIChild.CalculatePos;
var
 i:integer;
begin
if (PositionNumber >= VTMP.Positions.Length) or
   (VTMP.Positions.Value[PositionNumber] <> PatNum) then exit;
LineInts := GetPositionTimeEx(VTMP,PositionNumber,PosDelay,Line);
i := PosBegin + LineInts;
Label25.Caption := IntsToTime(i);
Label24.Caption := '(' + IntToStr(i)
end;

procedure TMDIChild.ShowStat;
begin
if (VTMP.Positions.Length > 0) and
   (StringGrid1.Selection.Left < VTMP.Positions.Length) and
   (VTMP.Positions.Value[PositionNumber] = PatNum) then
 CalculatePos(Tracks.ShownFrom + Tracks.CursorY - Tracks.N1OfLines)
end;

procedure TMDIChild.ShowAllTots;
begin
Label20.Caption := IntsToTime(TotInts);
Label21.Caption := IntToStr(TotInts) + ')'
end;

procedure TMDIChild.CalcTotLen;
begin
TotInts := GetModuleTime(VTMP);
ShowAllTots
end;

procedure TMDIChild.ReCalcTimes;
begin
Label20.Caption := IntsToTime(TotInts);
Label25.Caption := IntsToTime(PosBegin + LineInts)
end;

procedure TMDIChild.SetInitDelay(nd:integer);
begin
if VTMP.Initial_Delay <> nd then
 begin
  SongChanged := True;
  VTMP.Initial_Delay := UpDown3.Position;
  CalcTotLen;
  CalculatePos0;
  if IsPlaying then
   RestartPlayingPos(PositionNumber)
 end
end;

procedure TMDIChild.ListBox1Click(Sender: TObject);
begin
MainForm.SetSampleTemplate(ListBox1.ItemIndex)
end;

procedure TMDIChild.SpeedButton13Click(Sender: TObject);
begin
AddCurrentToSampTemplate
end;

procedure TMDIChild.AddCurrentToSampTemplate;
var
 i:integer;
begin
with Samples do
 begin
  if ShownSample = nil then exit;
  i := ShownFrom + CursorY;
  if i >= ShownSample.Length then exit;
  MainForm.AddToSampTemplate(ShownSample.Items[i])
 end
end;

procedure TMDIChild.SpeedButton14Click(Sender: TObject);
begin
CopySampTemplateToCurrent
end;

procedure TMDIChild.CopySampTemplateToCurrent;
var
 i,l:integer;
begin
with Samples do
 begin
  if ShownSample = nil then
   l := 1
  else
   l := ShownSample.Length;
  i := ShownFrom + CursorY;
  if i >= l then exit;
  ValidateSample2(SamNum);
  ShownSample.Items[i] :=
        MainForm.SampleLineTemplates[MainForm.CurrentSampleLineTemplate];
  if Focused then
   HideCaret(Handle);
  RedrawSamples(0);
  if Focused then
   ShowCaret(Handle)
 end
end;

procedure TMDIChild.UpDown9ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [1..15];
if AllowChange then
 ChangeOrnament(NewValue)
end;

procedure TMDIChild.Edit11Change(Sender: TObject);
begin
if OrnNum <> UpDown9.Position then
 ChangeOrnament(UpDown9.Position)
end;

procedure TMDIChild.Edit11Exit(Sender: TObject);
begin
Edit11.Text := IntToStr(UpDown9.Position)
end;

procedure TMDIChild.UpDown10ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
var
 l:integer;
begin
if VTMP.Ornaments[OrnNum] = nil then
 l := 1
else
 l := VTMP.Ornaments[OrnNum].Length;
AllowChange := (NewValue >= 0) and (NewValue < l);
if AllowChange then
 ChangeOrnamentLoop(NewValue)
end;

procedure TMDIChild.Edit12Exit(Sender: TObject);
begin
Edit12.Text := IntToStr(UpDown10.Position);
ChangeOrnamentLoop(UpDown10.Position)
end;

procedure TMDIChild.UpDown11ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [1..64];
if AllowChange then
 ChangeOrnamentLength(NewValue)
end;

procedure TMDIChild.Edit13Exit(Sender: TObject);
begin
Edit13.Text := IntToStr(UpDown11.Position);
ChangeOrnamentLength(UpDown11.Position)
end;

procedure TMDIChild.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift = [ssCtrl] then
 begin
  case Key of
  Ord('E'),VK_NUMPAD0:
   ToggleAutoEnv;
  Ord('R'):
   ToggleAutoStep
  end 
 end
else if Shift = [ssCtrl,ssAlt] then
 if Key = Ord('E') then
  ToggleStdAutoEnv
end;

procedure TMDIChild.ToggleAutoEnv;
begin
AutoEnv := not AutoEnv;
SpeedButton15.Down := AutoEnv
end;

procedure TMDIChild.ToggleStdAutoEnv;
begin
if not AutoEnv then ToggleAutoEnv;
if StdAutoEnvIndex = StdAutoEnvMax then
 StdAutoEnvIndex := 0
else
 Inc(StdAutoEnvIndex);
AutoEnv0 := StdAutoEnv[StdAutoEnvIndex,0];
AutoEnv1 := StdAutoEnv[StdAutoEnvIndex,1];
SpeedButton16.Caption := IntToStr(AutoEnv0);
SpeedButton18.Caption := IntToStr(AutoEnv1)
end;

procedure TMDIChild.SpeedButton17Click(Sender: TObject);
begin
ToggleStdAutoEnv
end;

procedure TMDIChild.SpeedButton15Click(Sender: TObject);
begin
ToggleAutoEnv
end;

procedure TMDIChild.SpeedButton16Click(Sender: TObject);
begin
if not AutoEnv then ToggleAutoEnv;
StdAutoEnvIndex := -1;
if AutoEnv0 = 9 then
 AutoEnv0 := 1
else
 Inc(AutoEnv0);
SpeedButton16.Caption := IntToStr(AutoEnv0)
end;

procedure TMDIChild.SpeedButton18Click(Sender: TObject);
begin
if not AutoEnv then ToggleAutoEnv;
StdAutoEnvIndex := -1;
if AutoEnv1 = 9 then
 AutoEnv1 := 1
else
 Inc(AutoEnv1);
SpeedButton18.Caption := IntToStr(AutoEnv1)
end;

procedure TMDIChild.DoAutoEnv;
var
 Nt:integer;
begin
if AutoEnv then
 begin
  Nt := VTMP.Patterns[i].Items[j].Channel[k].Note;
  if Nt >= 0 then
   case VTMP.Patterns[i].Items[j].Channel[k].Envelope of
   8,12:
    VTMP.Patterns[i].Items[j].Envelope :=
     round(GetNoteFreq(VTMP.Ton_Table,Nt) * AutoEnv0 / AutoEnv1 / 16);
   10,14:
    VTMP.Patterns[i].Items[j].Envelope :=
     round(GetNoteFreq(VTMP.Ton_Table,Nt) * AutoEnv0 / AutoEnv1 / 32)
   end
 end
end;

procedure TMDIChild.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Shift = []) and (Key = 192) then
 if Tracks.CanFocus then
  Tracks.SetFocus
end;

procedure TMDIChild.TracksExit(Sender: TObject);
begin
if (PlayMode = PMPlayLine) and
    IsPlaying and (PlayingWindow = Self) then
 ResetPlaying;
Tracks.KeyPressed := 0
end;

procedure TTestLine.TestLineExit(Sender: TObject);
begin
if (PlayMode = PMPlayLine) and
    IsPlaying and (PlayingWindow = ParWind) then
 ResetPlaying;
KeyPressed := 0
end;

procedure TMDIChild.Edit14Exit(Sender: TObject);
begin
Edit14.Text := IntToStr(UpDown12.Position)
end;

procedure TMDIChild.DoStep;
var
 t:integer;
begin
if not AutoStep then exit;
t := UpDown12.Position;
if t <> 0 then
 begin
  Inc(t,i);
  if (t >= 0) and (t < Tracks.ShownPattern.Length) then
   begin
    Tracks.ShownFrom := t;
    if Tracks.CursorY <> Tracks.N1OfLines then
     begin
      Tracks.CursorY := Tracks.N1OfLines;
      SetCaretPos(Tracks.CelW * (3 + Tracks.CursorX),
                        Tracks.CelH * Tracks.CursorY)
     end;
    Tracks.RemoveSelection(0,True)
   end
 end
end;

procedure TMDIChild.SpeedButton20Click(Sender: TObject);
begin
SaveTextDlg.Title := 'Save ornament in text file';
if SaveTextDlg.Execute then
 begin
  SaveTextDlg.InitialDir := ExtractFilePath(SaveTextDlg.FileName);
  AssignFile(TxtFile,SaveTextDlg.FileName);
  Rewrite(TxtFile);
  try
   Writeln(TxtFile,'[Ornament]');
   SaveOrnament(VTMP,UpDown9.Position)
  finally
   CloseFile(TxtFile)
  end
 end
end;

procedure TMDIChild.SpeedButton19Click(Sender: TObject);
begin
LoadTextDlg.Title := 'Load ornament from text file';
if LoadTextDlg.Execute then
 begin
  LoadTextDlg.InitialDir := ExtractFilePath(LoadTextDlg.FileName);
  LoadOrnament(LoadTextDlg.FileName)
 end
end;

procedure TMDIChild.LoadOrnament;
var
 f:TextFile;
 s:string;
begin
if not UpDown11.Enabled then
 begin
  ShowMessage('Stop playing before loading ornament');
  exit
 end;
AssignFile(f,FN);
Reset(f);
try
 repeat
  if eof(f) then
   begin
    ShowMessage('Ornament data not found');
    exit
   end;
  Readln(f,s);
  s := UpperCase(Trim(s));
 until s = '[ORNAMENT]';
 Readln(f,s);
finally
 CloseFile(f)
end;
if not RecognizeOrnamentString(s,UpDown9.Position,VTMP) then
 ShowMessage('Bad file structure')
else
 begin
  SongChanged := True;
  Ornaments.ShownOrnament := VTMP.Ornaments[UpDown9.Position];
  ChangeOrnament(UpDown9.Position)
 end 
end;

procedure TMDIChild.SpeedButton21Click(Sender: TObject);
const
 FN = 'VTIITempOrnament.txt';
var
 tmpp,dir:string;
 ExCode:DWORD;
 SI:STARTUPINFO;
 PI:PROCESS_INFORMATION;
begin
if OrGenRunning then exit;
SetLength(tmpp,MAX_PATH + 1);
GetTempPath(MAX_PATH,PChar(tmpp));
tmpp := PChar(tmpp) + FN;
if FileExists(tmpp) then
 if not DeleteFile(tmpp) then
  begin
   ShowMessage('Plug-in communication error: cannot delete file.');
   exit
  end;
dir := ExtractFilePath(ParamStr(0));
FillChar(SI,sizeof(SI),0);
SI.cb := sizeof(SI);
if not CreateProcess(PChar(dir + 'orgen.exe'),PChar(dir + 'orgen.exe ' + FN),
        nil,nil,False,0,nil,PChar(dir),SI,PI) then
 RaiseLastOSError
else
 begin
  OrGenRunning := True;
  SpeedButton21.Enabled := False;
  repeat
   if not GetExitCodeProcess(PI.hProcess,ExCode) then
    begin
     ShowMessage('Plug-in communication error: no answer.');
     OrGenRunning := False;
     SpeedButton21.Enabled := True;
     exit
    end;
   if ExCode = STILL_ACTIVE then
    Application.ProcessMessages
  until ExCode <> STILL_ACTIVE;
  OrGenRunning := False;
  SpeedButton21.Enabled := True;
  if FileExists(tmpp) then
   begin
    LoadOrnament(tmpp);
    DeleteFile(tmpp)
   end 
 end
end;

procedure TMDIChild.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose := not OrGenRunning
end;

procedure TMDIChild.ToggleAutoStep;
begin
AutoStep := not AutoStep;
SpeedButton22.Down := AutoStep
end;

procedure TMDIChild.SpeedButton22Click(Sender: TObject);
begin
ToggleAutoStep
end;

procedure TMDIChild.UpDown13ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [1..15]
end;

procedure TMDIChild.Edit15Exit(Sender: TObject);
begin
Edit15.Text := IntToStr(UpDown13.Position)
end;

procedure TMDIChild.CopyOrnButClick(Sender: TObject);
var
 NewOrn,N,i:integer;
begin
NewOrn := UpDown13.Position;
if NewOrn = OrnNum then exit;
SongChanged := True;
ValidateOrnament(OrnNum);
ValidateOrnament(NewOrn);
VTMP.Ornaments[NewOrn].Loop := VTMP.Ornaments[OrnNum].Loop;
VTMP.Ornaments[NewOrn].Length := VTMP.Ornaments[OrnNum].Length;
N := Length(VTMP.Ornaments[OrnNum].Items);
SetLength(VTMP.Ornaments[NewOrn].Items,N);
for i := 0 to N - 1 do
 VTMP.Ornaments[NewOrn].Items[i] := VTMP.Ornaments[OrnNum].Items[i];
UpDown9.Position := UpDown13.Position
end;

procedure TMDIChild.Edit16Exit(Sender: TObject);
begin
Edit16.Text := IntToStr(UpDown14.Position)
end;

procedure TMDIChild.UpDown14ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := NewValue in [1..31]
end;

procedure TMDIChild.CopySamButClick(Sender: TObject);
var
 NewSam,N,i:integer;
begin
NewSam := UpDown14.Position;
if NewSam = SamNum then exit;
SongChanged := True;
ValidateSample2(SamNum);
ValidateSample2(NewSam);
VTMP.Samples[NewSam].Loop := VTMP.Samples[SamNum].Loop;
VTMP.Samples[NewSam].Length := VTMP.Samples[SamNum].Length;
N := Length(VTMP.Samples[SamNum].Items);
SetLength(VTMP.Samples[NewSam].Items,N);
for i := 0 to N - 1 do
 VTMP.Samples[NewSam].Items[i] := VTMP.Samples[SamNum].Items[i];
UpDown6.Position := UpDown14.Position
end;

procedure TMDIChild.SpeedButton23Click(Sender: TObject);
begin
MainForm.ResetSampTemplate
end;

procedure TMDIChild.SpeedButton24Click(Sender: TObject);
begin
SaveTextDlg.Title := 'Save sample in text file';
if SaveTextDlg.Execute then
 begin
  SaveTextDlg.InitialDir := ExtractFilePath(SaveTextDlg.FileName);
  AssignFile(TxtFile,SaveTextDlg.FileName);
  Rewrite(TxtFile);
  try
   Writeln(TxtFile,'[Sample]');
   SaveSample(VTMP,UpDown6.Position)
  finally
   CloseFile(TxtFile)
  end
 end
end;

procedure TMDIChild.SpeedButton25Click(Sender: TObject);
begin
LoadTextDlg.Title := 'Load sample from text file';
if LoadTextDlg.Execute then
 begin
  LoadTextDlg.InitialDir := ExtractFilePath(LoadTextDlg.FileName);
  LoadSample(LoadTextDlg.FileName)
 end
end;

procedure TMDIChild.LoadSample;
var
 s:string;
begin
if not UpDown7.Enabled then
 begin
  ShowMessage('Stop playing before loading sample');
  exit
 end;
AssignFile(TxtFile,FN);
Reset(TxtFile);
try
 repeat
  if eof(TxtFile) then
   begin
    ShowMessage('Sample data not found');
    exit
   end;
  Readln(TxtFile,s);
  s := Trim(s);
 until UpperCase(s) = '[SAMPLE]';
 s := LoadSampleDataTxt(SamNum,VTMP);
 if s <> '' then
  begin
   ShowMessage(s);
   exit
  end 
finally
 CloseFile(TxtFile)
end;
SongChanged := True;
ValidateSample2(SamNum);
ChangeSample(SamNum)
end;

procedure TMDIChild.SpeedButton26Click(Sender: TObject);
begin
LoadTextDlg.Title := 'Load pattern from text file';
if LoadTextDlg.Execute then
 begin
  LoadTextDlg.InitialDir := ExtractFilePath(LoadTextDlg.FileName);
  LoadPattern(LoadTextDlg.FileName)
 end
end;

procedure TMDIChild.LoadPattern;
var
 s:string;
 i:integer;
begin
if not UpDown5.Enabled then
 begin
  ShowMessage('Stop playing before loading pattern');
  exit
 end;
AssignFile(TxtFile,FN);
Reset(TxtFile);
try
 repeat
  if eof(TxtFile) then
   begin
    ShowMessage('Pattern data not found');
    exit
   end;
  Readln(TxtFile,s);
  s := Trim(s);
 until UpperCase(s) = '[PATTERN]';
 i := LoadPatternDataTxt(PatNum,VTMP);
 if i <> 0 then
  begin
   ShowMessage('Bad file structure');
   exit
  end
finally
 CloseFile(TxtFile)
end;
SongChanged := True;
ValidatePattern2(PatNum);
ChangePattern(PatNum)
end;

procedure TMDIChild.SpeedButton27Click(Sender: TObject);
var
 p:integer;
begin
p := UpDown1.Position;
SaveTextDlg.Title := 'Save pattern in text file';
if SaveTextDlg.Execute then
 begin
  SaveTextDlg.InitialDir := ExtractFilePath(SaveTextDlg.FileName);
  AssignFile(TxtFile,SaveTextDlg.FileName);
  Rewrite(TxtFile);
  try
   Writeln(TxtFile,'[Pattern]');
   SavePattern(VTMP,p)
  finally
   CloseFile(TxtFile)
  end
 end
end;

const
 ClipHdrPat = 'Vortex Tracker II v1.0 Pattern'#13#10;

procedure TTracks.CopyToClipboard;
var
 hglbCopy:HGLOBAL;
 s:string;
 lptstrCopy:PChar;
 X1,X2,Y1,Y2,i,l,ps:integer;
// sc:array[0..2] of string;
begin
if not OpenClipboard(MainForm.Handle) then exit;
try
 EmptyClipboard;
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
 l := Length(ClipHdrPat) + 51 * (Y2 - Y1 + 1) + 1;
 hglbCopy := GlobalAlloc(GMEM_MOVEABLE and GMEM_DDESHARE,l);
 lptstrCopy := GlobalLock(hglbCopy);
 try
  ps := Length(ClipHdrPat);
  Move(ClipHdrPat[1],lptstrCopy^,ps);
  for i := Y1 to Y2 do
   begin
    s := GetPatternLineString(ShownPattern,i,MainForm.ChanAlloc) + #13#10;
    for l := 0 to X1 - 1 do s[l + 4] := #32;
    l := 1;
    if X2 in NotePoses then l := 3;
    for l := X2 + l to 48 do s[l + 4] := #32;
{    for l1 := 0 to 2 do               //no need to convert to ABC, I think...
     begin
      SetLength(sc[l1],13);
      sc[MainForm.ChanAlloc[l1]] := Copy(s,12 + 14*l1,13)
     end;
    for l1 := 0 to 2 do
     Move(sc[l1][1],s[12 + 14*l1],13);}
    Move(s[4],pointer(integer(lptstrCopy) + ps)^,51 + Ord(i = Y2));
    inc(ps,51)
   end
 finally
  GlobalUnlock(hglbCopy)
 end;
 SetClipboardData(CF_TEXT,hglbCopy)
finally
 CloseClipboard
end
end;

procedure TTracks.CutToClipboard;
begin
CopyToClipboard;
ClearSelection
end;

procedure TTracks.PasteFromClipboard;

 function GetStr(lps:PChar;var s:string):boolean;
 var
  ps:PChar;
  l:integer;
 begin
  Result := False;
  ps := StrScan(lps,#13);
  if ps = nil then exit;
  l := integer(ps) - integer(lps);
  SetLength(s,l);
  Move(lps^,s[1],l);
  Result := True
 end;

var
 hglb:HGLOBAL;
 lps,ps:PChar;
 X1,X2,Y1,Y2,sz,l,i,j,k,m:integer;
 s:string;
 nums:array[0..MaxPatLen-1,0..32] of integer;
begin
if not IsClipboardFormatAvailable(CF_TEXT) then exit;
if not OpenClipboard(MainForm.Handle) then exit;
try
 hglb := GetClipboardData(CF_TEXT);
 if hglb = 0 then exit;
 lps := GlobalLock(hglb);
 try
  sz := StrLen(lps);
  if not GetStr(lps,s) then exit;
  if (s + #13#10) <> ClipHdrPat then exit;
  integer(ps) := integer(lps) + Length(s) + 2;
  FillChar(nums,SizeOf(nums),255);
  l := 0;
  while (integer(ps) + 2 - integer(lps) < sz) and (l < MaxPatLen) do
   begin
    if not GetStr(ps,s) then exit;
    inc(integer(ps),Length(s) + 2);
    if Length(s) <> 49 then exit;
    for j := 0 to 3 do
     if s[j + 1] <> #32 then
      begin
       if not SGetNumber(s[j + 1],15,i) then exit;
       nums[l,j] := i
      end;
    if s[6] <> #32 then
     begin
      if not SGetNumber(s[6],1,i) then exit;
      nums[l,4] := i
     end;
    if s[7] <> #32 then
     begin
      if not SGetNumber(s[7],15,i) then exit;
      nums[l,5] := i
     end;
    for k := 0 to 2 do
     begin
      if s[9 + k*14] <> #32 then
       begin
        if not SGetNote(Copy(s,9 + k*14,3),i) then exit;
        nums[l,6 + k*9] := i + 256
       end;
      if s[13 + k*14] <> #32 then
       begin
        if not SGetNumber(s[13 + k*14],31,i) then exit;
        nums[l,7 + k*9] := i
       end;
      for j := 0 to 2 do
       if s[14 + k*14 + j] <> #32 then
        begin
         if not SGetNumber(s[14 + k*14 + j],15,i) then exit;
         nums[l,8 + k*9 +j] := i
        end;
      for j := 0 to 3 do
       if s[18 + k*14 + j] <> #32 then
        begin
         if not SGetNumber(s[18 + k*14 + j],15,i) then exit;
         nums[l,11 + k*9 +j] := i
        end
     end;
    inc(l);
   end
 finally
  GlobalUnlock(hglb)
 end
finally
 CloseClipboard
end;
if l = 0 then exit;
i := 0;
while (i <= 32) and (nums[0,i] < 0) do inc(i);
if i = 33 then exit;
j := 32;
while (j >= 0) and (nums[0,i] < 0) do dec(j);
TMDIChild(MainForm.ActiveMDIChild).SongChanged := True;
TMDIChild(MainForm.ActiveMDIChild).ValidatePattern2(TMDIChild(MainForm.ActiveMDIChild).PatNum);
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
if (X1 = X2) and (Y1 = Y2) then
 begin
  X2 := 48;
  Y2 := ShownPattern.Length - 1
 end;
if l > Y2 - Y1 + 1 then
 l := Y2 - Y1 + 1;
for l := 0 to l - 1 do
 begin
  m := X1;
  for k := i to j do if nums[l,k] >= 0 then
   begin
    if m in NotePoses then
     begin
      if nums[l,k] >= 256 - 2 then
       ShownPattern.Items[Y1 + l].Channel[MainForm.ChanAlloc[(m - 8) div 14]].Note := nums[l,k] - 256
     end
    else
     begin
      if m = 5 then
       sz := 1
      else if m in SamPoses then
       sz := 31
      else
       sz := 15;
      if nums[l,k] <= sz then
       begin
        sz := (m - 8) div 14; if sz >= 0 then sz := MainForm.ChanAlloc[sz];
        case m of
        0:ShownPattern.Items[Y1 + l].Envelope :=
          ShownPattern.Items[Y1 + l].Envelope and $FFF or (nums[l,k] shl 12);
        1:ShownPattern.Items[Y1 + l].Envelope :=
          ShownPattern.Items[Y1 + l].Envelope and $F0FF or (nums[l,k] shl 8);
        2:ShownPattern.Items[Y1 + l].Envelope :=
          ShownPattern.Items[Y1 + l].Envelope and $FF0F or (nums[l,k] shl 4);
        3:ShownPattern.Items[Y1 + l].Envelope :=
          ShownPattern.Items[Y1 + l].Envelope and $FFF0 or nums[l,k];
        5:ShownPattern.Items[Y1 + l].Noise :=
          ShownPattern.Items[Y1 + l].Noise and 15 or (nums[l,k] shl 4);
        6:ShownPattern.Items[Y1 + l].Noise :=
          ShownPattern.Items[Y1 + l].Noise and $F0 or nums[l,k];
        12,26,40:ShownPattern.Items[Y1 + l].Channel[sz].Sample := nums[l,k];
        13,27,41:ShownPattern.Items[Y1 + l].Channel[sz].Envelope := nums[l,k];
        14,28,42:ShownPattern.Items[Y1 + l].Channel[sz].Ornament := nums[l,k];
        15,29,43:ShownPattern.Items[Y1 + l].Channel[sz].Volume := nums[l,k];
        17,31,45:ShownPattern.Items[Y1 + l].Channel[sz].Additional_Command.Number := nums[l,k];
        18,32,46:ShownPattern.Items[Y1 + l].Channel[sz].Additional_Command.Delay := nums[l,k];
        19,33,47:ShownPattern.Items[Y1 + l].Channel[sz].Additional_Command.Parameter :=
                 ShownPattern.Items[Y1 + l].Channel[sz].Additional_Command.Parameter and 15 or (nums[l,k] shl 4);
        20,34,48:ShownPattern.Items[Y1 + l].Channel[sz].Additional_Command.Parameter :=
                 ShownPattern.Items[Y1 + l].Channel[sz].Additional_Command.Parameter and $F0 or nums[l,k];
        end
       end
     end;
    if m >= 48 then break;
    Inc(m);
    if ColSpace(m) then
     Inc(m)
    else if m in [9,23,37] then
     Inc(m,3);
    if m > X2 then break
   end
 end;
RemoveSelection(0,True);
HideCaret(Handle);
RedrawTracks(0);
ShowCaret(Handle);
TMDIChild(MainForm.ActiveMDIChild).CalcTotLen;
TMDIChild(MainForm.ActiveMDIChild).ShowStat
end;

procedure TTracks.ClearSelection;
var
 X1,X2,Y1,Y2,c,m:integer;
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
TMDIChild(MainForm.ActiveMDIChild).SongChanged := True;
TMDIChild(MainForm.ActiveMDIChild).ValidatePattern2(TMDIChild(MainForm.ActiveMDIChild).PatNum);
for Y1 := Y1 to Y2 do
 begin
  m := X1;
  repeat
   c := (m - 8) div 14; if c >= 0 then c := MainForm.ChanAlloc[c];
   if m in NotePoses then
    ShownPattern.Items[Y1].Channel[c].Note := -1
   else
    case m of
    0:ShownPattern.Items[Y1].Envelope := ShownPattern.Items[Y1].Envelope and $FFF;
    1:ShownPattern.Items[Y1].Envelope := ShownPattern.Items[Y1].Envelope and $F0FF;
    2:ShownPattern.Items[Y1].Envelope := ShownPattern.Items[Y1].Envelope and $FF0F;
    3:ShownPattern.Items[Y1].Envelope := ShownPattern.Items[Y1].Envelope and $FFF0;
    5:ShownPattern.Items[Y1].Noise := ShownPattern.Items[Y1].Noise and 15;
    6:ShownPattern.Items[Y1].Noise := ShownPattern.Items[Y1].Noise and $F0;
    12,26,40:ShownPattern.Items[Y1].Channel[c].Sample := 0;
    13,27,41:ShownPattern.Items[Y1].Channel[c].Envelope := 0;
    14,28,42:ShownPattern.Items[Y1].Channel[c].Ornament := 0;
    15,29,43:ShownPattern.Items[Y1].Channel[c].Volume := 0;
    17,31,45:ShownPattern.Items[Y1].Channel[c].Additional_Command.Number := 0;
    18,32,46:ShownPattern.Items[Y1].Channel[c].Additional_Command.Delay := 0;
    19,33,47:ShownPattern.Items[Y1].Channel[c].Additional_Command.Parameter :=
             ShownPattern.Items[Y1].Channel[c].Additional_Command.Parameter and 15;
    20,34,48:ShownPattern.Items[Y1].Channel[c].Additional_Command.Parameter :=
             ShownPattern.Items[Y1].Channel[c].Additional_Command.Parameter and $F0;
    end;
   if m >= 48 then break;
   Inc(m);
   if ColSpace(m) then
    Inc(m)
   else if m in [9,23,37] then
    Inc(m,3)
  until m > X2
 end;
HideCaret(Handle);
RedrawTracks(0);
ShowCaret(Handle);
TMDIChild(MainForm.ActiveMDIChild).CalcTotLen;
TMDIChild(MainForm.ActiveMDIChild).ShowStat
end;

procedure TMDIChild.UpDown15ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
AllowChange := (NewValue > 0) and (NewValue <= MaxPatLen);
if AllowChange then ChangeHLStep(NewValue)
end;

procedure TMDIChild.AutoHLCheckClick(Sender: TObject);
begin
if AutoHLCheck.Checked then CalcHLStep
end;

procedure TMDIChild.CalcHLStep;
var
 PLen,NS:integer;
begin
if Tracks.ShownPattern = nil then
 PLen := DefPatLen
else
 PLen := Tracks.ShownPattern.Length;
if PLen mod 5 = 0 then
 NS := 5
else if PLen mod 3 = 0 then
 NS := 3
else
 NS := 4;
if NS <> Tracks.HLStep then
 UpDown15.Position := NS
end;

procedure TMDIChild.Edit17Exit(Sender: TObject);
begin
if not Edit17.Modified then exit;
AutoHLCheck.Checked := False;
Edit17.Text := IntToStr(UpDown15.Position);
ChangeHLStep(UpDown15.Position)
end;

procedure TMDIChild.ChangeHLStep(NewStep:integer);
begin
if Tracks.HLStep <> NewStep then
 begin
  Tracks.HLStep := NewStep;
  Tracks.RedrawTracks(0)
 end
end;

procedure TMDIChild.UpDown15Click(Sender: TObject; Button: TUDBtnType);
begin
AutoHLCheck.Checked := False
end;

end.
