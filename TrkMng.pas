{
This is part of Vortex Tracker II project
(c)2000-2005 S.V.Bulba
Author Sergey Bulba
E-mail: vorobey@mail.khstu.ru
Support page: http://bulba.at.kz/
}

unit TrkMng;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons;

type
  TTrMng = class(TForm)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown2: TUpDown;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Edit4: TEdit;
    UpDown4: TUpDown;
    GroupBox3: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GroupBox4: TGroupBox;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox5: TGroupBox;
    SpeedButton5: TSpeedButton;
    GroupBox6: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label5: TLabel;
    Edit5: TEdit;
    UpDown5: TUpDown;
    Button1: TButton;
    Label6: TLabel;
    Edit6: TEdit;
    UpDown6: TUpDown;
    Label7: TLabel;
    Edit7: TEdit;
    UpDown7: TUpDown;
    GroupBox7: TGroupBox;
    Edit8: TEdit;
    UpDown8: TUpDown;
    Label8: TLabel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
    procedure TracksOp(FPat,FLin,FChn,TPat,TLin,TChn,TrOp:integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Transp(Pat,Lin,Chn:integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TrMng: TTrMng;

implementation

uses Main, Childwin, TrFuncs;

{$R *.DFM}

var
 CurrentWindow:TMDIChild;

procedure TTrMng.TracksOp;
var
 FPLen,TPLen,i,j:integer;
 cl:TChannelLine;
 OldPat:PPattern;
 Flg:boolean;
begin
if CurrentWindow = nil then exit;
with CurrentWindow do
 begin
  if (VTMP.Patterns[FPat] = nil) and (VTMP.Patterns[TPat] = nil) then exit;
  ValidatePattern2(FPat);
  ValidatePattern2(TPat);
  if TrOp = 0 then
   begin
    New(OldPat); OldPat^ := VTMP.Patterns[TPat]^;
   end
  else if MessageDlg('This operation cannot be undo. Are you sure you want to continue?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  DisposeUndo(True);
  FPLen := VTMP.Patterns[FPat].Length;
  TPLen := VTMP.Patterns[TPat].Length;
  Flg := False;
  for i := 0 to TrMng.UpDown5.Position - 1 do
   begin
    if (i + FLin >= FPLen) or (i + TLin >= TPLen) then break;
    Flg := True;
    if TrMng.CheckBox1.Checked then
     begin
      j := VTMP.Patterns[FPat].Items[i + FLin].Envelope;
      case TrOp of
      0:VTMP.Patterns[TPat].Items[i + TLin].Envelope := j;
      1:begin
         VTMP.Patterns[TPat].Items[i + TLin].Envelope := j;
         VTMP.Patterns[FPat].Items[i + FLin].Envelope := 0
        end;
      2:begin
         VTMP.Patterns[FPat].Items[i + FLin].Envelope := VTMP.Patterns[TPat].Items[i + TLin].Envelope;
         VTMP.Patterns[TPat].Items[i + TLin].Envelope := j
        end
      end
     end;
    if TrMng.CheckBox2.Checked then
     begin
      j := VTMP.Patterns[FPat].Items[i + FLin].Noise;
      case TrOp of
      0:VTMP.Patterns[TPat].Items[i + TLin].Noise := j;
      1:begin
         VTMP.Patterns[TPat].Items[i + TLin].Noise := j;
         VTMP.Patterns[FPat].Items[i + FLin].Noise := 0
        end;
      2:begin
         VTMP.Patterns[FPat].Items[i + FLin].Noise := VTMP.Patterns[TPat].Items[i + TLin].Noise;
         VTMP.Patterns[TPat].Items[i + TLin].Noise := j
        end
      end
     end;
    cl := VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn];
    case TrOp of
    0:VTMP.Patterns[TPat].Items[i + TLin].Channel[TChn] := cl;
    1:begin
       VTMP.Patterns[TPat].Items[i + TLin].Channel[TChn] := cl;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Note := -1;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Sample := 0;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Ornament := 0;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Volume := 0;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Envelope := 0;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Additional_Command.Number := 0;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Additional_Command.Delay := 0;
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn].Additional_Command.Parameter := 0
      end;
    2:begin
       VTMP.Patterns[FPat].Items[i + FLin].Channel[FChn] := VTMP.Patterns[TPat].Items[i + TLin].Channel[TChn];
       VTMP.Patterns[TPat].Items[i + TLin].Channel[TChn] := cl
      end
    end
   end;
  if Flg then
   begin
    SongChanged := True;
    if TrOp = 0 then
     begin
      AddUndo(CATracksManagerCopy,TPat,0);
      ChangeList[ChangeCount - 1].Pattern := OldPat
     end 
   end
  else if TrOp = 0 then
   Dispose(OldPat);
  if (PatNum = TPat) or (PatNum = FPat) then Tracks.RedrawTracks(0)
 end
end;

procedure TTrMng.SpeedButton2Click(Sender: TObject);
begin
TracksOp(UpDown1.Position,UpDown2.Position,UpDown6.Position,UpDown3.Position,UpDown4.Position,UpDown7.Position,0)
end;

procedure TTrMng.SpeedButton1Click(Sender: TObject);
begin
TracksOp(UpDown3.Position,UpDown4.Position,UpDown7.Position,UpDown1.Position,UpDown2.Position,UpDown6.Position,0)
end;

procedure TTrMng.SpeedButton4Click(Sender: TObject);
begin
TracksOp(UpDown1.Position,UpDown2.Position,UpDown6.Position,UpDown3.Position,UpDown4.Position,UpDown7.Position,1)
end;

procedure TTrMng.SpeedButton3Click(Sender: TObject);
begin
TracksOp(UpDown3.Position,UpDown4.Position,UpDown7.Position,UpDown1.Position,UpDown2.Position,UpDown6.Position,1)
end;

procedure TTrMng.SpeedButton5Click(Sender: TObject);
begin
TracksOp(UpDown1.Position,UpDown2.Position,UpDown6.Position,UpDown3.Position,UpDown4.Position,UpDown7.Position,2)
end;

procedure TTrMng.Transp;
var
 PLen,i,st,j:integer;
 stk:real;
 OldPat:PPattern;
 Flg:boolean;
begin
if CurrentWindow = nil then exit;
with CurrentWindow do
 begin
  if VTMP.Patterns[Pat] = nil then exit;
  st := TrMng.UpDown8.Position; if st = 0 then exit;
  New(OldPat); OldPat^ := VTMP.Patterns[Pat]^;
  stk := exp(-st / 12 * ln(2));
  PLen := VTMP.Patterns[Pat].Length;
  Flg := False;
  for i := 0 to TrMng.UpDown5.Position - 1 do
   begin
    if i + Lin >= PLen then break;
    Flg := True;
    if TrMng.CheckBox1.Checked then
     VTMP.Patterns[Pat].Items[i + Lin].Envelope := round(VTMP.Patterns[Pat].Items[i + Lin].Envelope * stk);
    if VTMP.Patterns[Pat].Items[i + Lin].Channel[Chn].Note >= 0 then
     begin
      j := VTMP.Patterns[Pat].Items[i + Lin].Channel[Chn].Note + st;
      if j >= 96 then
       j := 95
      else if j < 0 then
       j := 0;
      VTMP.Patterns[Pat].Items[i + Lin].Channel[Chn].Note := j
     end
   end;
  if Flg then
   begin
    SongChanged := True;
    AddUndo(CATransposePattern,Pat,0);
    ChangeList[ChangeCount - 1].Pattern := OldPat
   end
  else
   Dispose(OldPat); 
  if PatNum = Pat then Tracks.RedrawTracks(0)
 end
end;

procedure TTrMng.SpeedButton6Click(Sender: TObject);
begin
Transp(UpDown1.Position,UpDown2.Position,UpDown6.Position)
end;

procedure TTrMng.SpeedButton7Click(Sender: TObject);
begin
Transp(UpDown3.Position,UpDown4.Position,UpDown7.Position)
end;

procedure TTrMng.FormCreate(Sender: TObject);
begin
UpDown5.Max := MaxPatLen;
UpDown5.Position := MaxPatLen;
UpDown2.Max := MaxPatLen - 1;
UpDown4.Max := MaxPatLen - 1
end;

procedure TTrMng.FormShow(Sender: TObject);
begin
if MainForm.MDIChildCount = 0 then
 CurrentWindow := nil
else
 CurrentWindow := TMDIChild(MainForm.ActiveMDIChild);
end;

end.
