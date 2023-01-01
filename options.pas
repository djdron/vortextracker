{
This is part of Vortex Tracker II project
(c)2000-2006 S.V.Bulba
Author Sergey Bulba
E-mail: vorobey@mail.khstu.ru
Support page: http://bulba.at.kz/
}

unit options;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TForm1 = class(TForm)
    OpsPages: TPageControl;
    TabSheet1: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button3: TButton;
    FontDialog1: TFontDialog;
    Label3: TLabel;
    AYEmu: TTabSheet;
    ChipSel: TRadioGroup;
    ChanSel: TRadioGroup;
    IntSel: TRadioGroup;
    CurWinds: TTabSheet;
    ChanVisAlloc: TRadioGroup;
    OpMod: TTabSheet;
    RadioGroup1: TRadioGroup;
    SaveHead: TRadioGroup;
    WOAPITAB: TTabSheet;
    SR: TRadioGroup;
    BR: TRadioGroup;
    NCh: TRadioGroup;
    Buff: TGroupBox;
    TrackBar1: TTrackBar;
    LbLen: TLabel;
    TrackBar2: TTrackBar;
    LbNum: TLabel;
    Label4: TLabel;
    LBTot: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    Opt: TRadioGroup;
    Label7: TLabel;
    LBChg: TLabel;
    ChFreq: TRadioGroup;
    SelDev: TGroupBox;
    Edit3: TEdit;
    Button4: TButton;
    ComboBox1: TComboBox;
    FiltersGroup: TGroupBox;
    FiltChk: TCheckBox;
    FiltNK: TTrackBar;
    Label9: TLabel;
    Label10: TLabel;
    OtherOps: TTabSheet;
    PriorGrp: TRadioGroup;
    EdChipFrq: TEdit;
    EdIntFrq: TEdit;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ColorDialog1: TColorDialog;
    procedure Edit1Exit(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ChipSelClick(Sender: TObject);
    procedure ChanSelClick(Sender: TObject);
    procedure IntSelClick(Sender: TObject);
    procedure ChanVisAllocClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure SRClick(Sender: TObject);
    procedure BRClick(Sender: TObject);
    procedure NChClick(Sender: TObject);
    procedure PlayStarts;
    procedure PlayStops;
    procedure OptClick(Sender: TObject);
    procedure ChFreqClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure SaveHeadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FiltChkClick(Sender: TObject);
    procedure FiltNKChange(Sender: TObject);
    procedure PriorGrpClick(Sender: TObject);
    function GetValue(const s:string):integer;
    procedure EdChipFrqExit(Sender: TObject);
    procedure EdIntFrqExit(Sender: TObject);
    procedure ChangeTrColor(Lb1,Lb2:TLabel;Bk:boolean);
    procedure Label8Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses AY, WaveOutAPI, Main, Childwin, trfuncs, MMSystem;

{$R *.DFM}

function TForm1.GetValue(const s:string):integer;
var
 Er:integer;
begin
Val(Trim(s),Result,Er);
if Er <> 0 then Result := -1
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
Edit1.Text := IntToStr(UpDown1.Position)
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
FontDialog1.Font := Edit2.Font;
if FontDialog1.Execute then
 begin
  Edit2.Font := FontDialog1.Font;
  Edit2.Text := FontDialog1.Font.Name
 end
end;

procedure TForm1.ChipSelClick(Sender: TObject);
begin
MainForm.SetEmulatingChip(ChTypes(ChipSel.ItemIndex + 1))
end;

procedure TForm1.ChanSelClick(Sender: TObject);
begin
if StdChannelsAllocation <> ChanSel.ItemIndex then
 MainForm.ToggleChanAlloc.Caption :=  SetStdChannelsAllocation(ChanSel.ItemIndex)
end;

procedure TForm1.IntSelClick(Sender: TObject);
var
 f:integer;
begin
case IntSel.ItemIndex of
0:f := 50000;
1:f := 48828;
2:f := 60000;
3:f := 100000;
4:f := 200000;
5:
 begin
  if not EdIntFrq.Focused and EdIntFrq.CanFocus then
   begin
    EdIntFrq.SelectAll;
    EdIntFrq.SetFocus;
   end;
  f := GetValue(EdIntFrq.Text);
  if f < 0 then exit
 end;
else exit
end;
if f <> Interrupt_Freq then
 MainForm.SetIntFreqEx(f)
end;

procedure TForm1.ChanVisAllocClick(Sender: TObject);
begin
MainForm.SetChannelsAllocationVis(ChanVisAlloc.ItemIndex)
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
Correct3xxxInterpretation := RadioGroup1.ItemIndex <> 1;
Detect3xxxInterpretation := RadioGroup1.ItemIndex = 2
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
SetBuffers(TrackBar1.Position,NumberOfBuffers);
LBLen.Caption := IntToStr(BufLen_ms) + ' ms';
LBTot.Caption := IntToStr(BufLen_ms * NumberOfBuffers) + ' ms';
LBChg.Caption := LBTot.Caption
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
SetBuffers(BufLen_ms,TrackBar2.Position);
LBNum.Caption := IntToStr(NumberOfBuffers);
LBTot.Caption := IntToStr(BufLen_ms * NumberOfBuffers) + ' ms';
LBChg.Caption := LBTot.Caption
end;

procedure TForm1.SRClick(Sender: TObject);
begin
case SR.ItemIndex of
0:SetSampleRate(11025);
1:SetSampleRate(22050);
2:SetSampleRate(44100);
3:SetSampleRate(48000)
end
end;

procedure TForm1.BRClick(Sender: TObject);
begin
case BR.ItemIndex of
0:SetBitRate(8);
1:SetBitRate(16)
end
end;

procedure TForm1.NChClick(Sender: TObject);
begin
SetNChans(NCh.ItemIndex + 1)
end;

procedure TForm1.PlayStarts;
begin
SR.Enabled := False;
BR.Enabled := False;
NCh.Enabled := False;
Buff.Enabled := False;
Label7.Visible := True;
LBChg.Visible := True;
SelDev.Enabled := False
end;

procedure TForm1.PlayStops;
begin
SR.Enabled := True;
BR.Enabled := True;
NCh.Enabled := True;
Buff.Enabled := True;
Label7.Visible := False;
LBChg.Visible := False;
SelDev.Enabled := True
end;

procedure TForm1.OptClick(Sender: TObject);
begin
Set_Optimization(Opt.ItemIndex = 0);
FiltersGroup.Visible := Optimization_For_Quality
end;

procedure TForm1.ChFreqClick(Sender: TObject);
var
 f:integer;
begin
case ChFreq.ItemIndex of
0:f := 1773400;
1:f := 1750000;
2:f := 2000000;
3:f := 1000000;
4:f := 3500000;
5:
 begin
  if not EdChipFrq.Focused and EdChipFrq.CanFocus then
   begin
    EdChipFrq.SelectAll;
    EdChipFrq.SetFocus;
   end; 
  f := GetValue(EdChipFrq.Text);
  if f < 0 then exit
 end;
else exit
end;
if f <> AY_Freq then
 SetAYFreq(f)
end;

procedure TForm1.Button4Click(Sender: TObject);
var
 i,n:integer;
 WOC:WAVEOUTCAPS;
begin
ComboBox1.Visible := False;
n := waveOutGetNumDevs;
if n = 0 then
 begin
  WODevice := WAVE_MAPPER;
  Edit3.Text := 'Wave mapper';
  exit
 end;
ComboBox1.Clear;
ComboBox1.Items.Add('Wave mapper');
for i := 0 to n - 1 do
 begin
  WOCheck(waveOutGetDevCaps(i,@WOC,SizeOf(WOC)));
  ComboBox1.Items.Add(WOC.szPname)
 end;
if Integer(WODevice) > n - 1 then WODevice := WAVE_MAPPER;
ComboBox1.ItemIndex := Integer(WODevice) + 1;
ComboBox1Change(Sender);
ComboBox1.Visible := True
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
WODevice := ComboBox1.ItemIndex - 1;
Edit3.Text := ComboBox1.Items[WODevice + 1]
end;

procedure TForm1.SaveHeadClick(Sender: TObject);
begin
VortexModuleHeader := SaveHead.ItemIndex <> 1;
DetectModuleHeader := SaveHead.ItemIndex = 2
end;

procedure TForm1.FormShow(Sender: TObject);
begin
OpsPages.SetFocus
end;

procedure TForm1.FiltChkClick(Sender: TObject);
begin
SetFilter(FiltChk.Checked,Filt_M)
end;

procedure TForm1.FiltNKChange(Sender: TObject);
begin
SetFilter(IsFilt,round(exp(FiltNK.Position * Ln(2))))
end;


procedure TForm1.PriorGrpClick(Sender: TObject);
begin
if PriorGrp.ItemIndex = 0 then
 MainForm.SetPriority(NORMAL_PRIORITY_CLASS)
else
 MainForm.SetPriority(HIGH_PRIORITY_CLASS)
end;

procedure TForm1.EdChipFrqExit(Sender: TObject);
begin
if ChFreq.ItemIndex <> 5 then
 ChFreq.ItemIndex := 5
else
 ChFreqClick(Sender)
end;

procedure TForm1.EdIntFrqExit(Sender: TObject);
begin
if IntSel.ItemIndex <> 5 then
 IntSel.ItemIndex := 5
else
 IntSelClick(Sender)
end;

procedure TForm1.ChangeTrColor;
begin
if Bk then
 ColorDialog1.Color := Lb1.Color
else
 ColorDialog1.Color := Lb1.Font.Color;
if ColorDialog1.Execute then
 if Bk then
  begin
   Lb1.Color := ColorDialog1.Color;
   if Lb2 <> nil then
    Lb2.Color := ColorDialog1.Color;
  end
 else
  begin
   Lb1.Font.Color := ColorDialog1.Color;
   if Lb2 <> nil then
    Lb2.Font.Color := ColorDialog1.Color;
  end;
end;

procedure TForm1.Label8Click(Sender: TObject);
begin
ChangeTrColor(Label8,Label11,True)
end;

procedure TForm1.Label12Click(Sender: TObject);
begin
ChangeTrColor(Label12,Label13,True)
end;

procedure TForm1.Label14Click(Sender: TObject);
begin
ChangeTrColor(Label14,nil,True)
end;

procedure TForm1.Label11Click(Sender: TObject);
begin
ChangeTrColor(Label8,Label11,False);
Label14.Font.Color := Label8.Font.Color;
end;

procedure TForm1.Label13Click(Sender: TObject);
begin
ChangeTrColor(Label12,Label13,False);
end;

end.
