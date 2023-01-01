{
This is part of Vortex Tracker II project
(c)2000-2006 S.V.Bulba
Author Sergey Bulba
E-mail: vorobey@mail.khstu.ru
Support page: http://bulba.at.kz/
}

unit GlbTrn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TGlbTrans = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox4: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    UpDown8: TUpDown;
    Edit8: TEdit;
    Label8: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Button1: TButton;
    Button2: TButton;
    procedure Edit2Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit8Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Trans(Pat:integer);
    procedure TransChn(Pat,i,Chn:integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GlbTrans: TGlbTrans;

implementation

uses Main, Childwin, trfuncs;

{$R *.DFM}

var
  CurrentWindow:TMDIChild;
  st:integer;
  stk:real;

procedure TGlbTrans.Edit2Exit(Sender: TObject);
begin
Edit2.Text := IntToStr(UpDown1.Position)
end;

procedure TGlbTrans.FormShow(Sender: TObject);
begin
if MainForm.MDIChildCount = 0 then
 begin
  CurrentWindow := nil;
  Button1.Enabled := False
 end 
else
 begin
  CurrentWindow := TMDIChild(MainForm.ActiveMDIChild);
  Button1.Enabled := True;
  UpDown1.Position := CurrentWindow.PatNum
 end;
Edit8.SelectAll;
Edit8.SetFocus
end;

procedure TGlbTrans.Edit8Exit(Sender: TObject);
begin
Edit8.Text := IntToStr(UpDown8.Position)
end;

procedure TGlbTrans.TransChn;
var
 j:integer;
begin
if CurrentWindow.VTMP.Patterns[Pat].Items[i].Channel[Chn].Note >= 0 then
 begin
  j := CurrentWindow.VTMP.Patterns[Pat].Items[i].Channel[Chn].Note + st;
  if j >= 96 then
   j := 95
  else if j < 0 then
   j := 0;
  CurrentWindow.VTMP.Patterns[Pat].Items[i].Channel[Chn].Note := j
 end
end;

procedure TGlbTrans.Trans;
var
 PLen,i:integer;
begin
with CurrentWindow do
 begin
  if VTMP.Patterns[Pat] = nil then exit;
  SongChanged := True;
  PLen := VTMP.Patterns[Pat].Length;
  if GlbTrans.CheckBox1.Checked then
   for i := 0 to PLen - 1 do
    TransChn(Pat,i,0);
  if GlbTrans.CheckBox2.Checked then
   for i := 0 to PLen - 1 do
    TransChn(Pat,i,1);
  if GlbTrans.CheckBox3.Checked then
   for i := 0 to PLen - 1 do
    TransChn(Pat,i,2);
  if GlbTrans.CheckBox4.Checked then
   for i := 0 to PLen - 1 do
    VTMP.Patterns[Pat].Items[i].Envelope :=
                round(VTMP.Patterns[Pat].Items[i].Envelope * stk);
  if PatNum = Pat then
   Tracks.RedrawTracks(0)
 end;
end;

procedure TGlbTrans.Button1Click(Sender: TObject);
var
 i:integer;
begin
if CurrentWindow = nil then exit;
if not CheckBox1.Checked and
   not CheckBox2.Checked and
   not CheckBox3.Checked and
   not CheckBox4.Checked then exit;
st := UpDown8.Position;
if st = 0 then exit;
stk := exp(-st / 12 * ln(2));
if RadioButton1.Checked then
 begin
  if MessageDlg('This operation cannot be undo. Are you sure you want to continue?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
   begin
    CurrentWindow.DisposeUndo(True);
    for i := 0 to MaxPatNum do Trans(i)
   end;
 end
else
 begin
  if CurrentWindow.VTMP.Patterns[UpDown1.Position] = nil then exit;
  CurrentWindow.AddUndo(CATransposePattern,UpDown1.Position,0);
  New(CurrentWindow.ChangeList[CurrentWindow.ChangeCount - 1].Pattern);
  CurrentWindow.ChangeList[CurrentWindow.ChangeCount - 1].Pattern^ := CurrentWindow.VTMP.Patterns[UpDown1.Position]^;
  Trans(UpDown1.Position)
 end;
end;

end.
