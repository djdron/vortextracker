{
This is part of Vortex Tracker II project
(c)2000-2022 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://bulba.untergrund.net/
}

program VT;

{$mode objfpc}{$H+}

uses
  Forms, Interfaces,
  Main in 'main.pas' {MainForm},
  ChildWin {MDIChild},
  About in 'about.pas' {AboutBox},
  trfuncs in 'trfuncs.pas',
  options in 'options.pas' {Form1},
  TrkMng in 'TrkMng.pas' {TrMng},
  GlbTrn in 'GlbTrn.pas' {GlbTrans},
  ExportZX in 'ExportZX.pas' {ExpDlg},
  FXMImport in 'FXMImport.pas' {FXMParams},
  selectts in 'selectts.pas' {TSSel},
  TglSams {ToglSams},
  Config, WinVersion, Languages, digsound, digsoundcode, AY;

{$R SNDH\SNDH.RC}
{$R ZXAYHOBETA\ZX.RC}
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TTrMng, TrMng);
  Application.CreateForm(TGlbTrans, GlbTrans);
  Application.CreateForm(TExpDlg, ExpDlg);
  Application.CreateForm(TFXMParams, FXMParams);
  Application.CreateForm(TTSSel, TSSel);
  Application.CreateForm(TToglSams, ToglSams);
  MainForm.CheckCommandLine;
  Application.Run;
end.
