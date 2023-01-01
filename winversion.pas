{
This is part of Vortex Tracker II project
(c)2000-2022 S.V.Bulba
Author Sergey Bulba
E-mail: svbulba@gmail.com
Support page: http://bulba.untergrund.net/
}

unit WinVersion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Dialogs, LCLIntf, LCLType, lazutf8,
  {$IFDEF Windows}
  Windows,
  {$ENDIF Windows}
  Types;

  procedure CheckStringFitting(handle:THandle;var s:string;w:integer);
  function GetProcessFileName:string;
  {$IFNDEF Windows}
  procedure NonWin;
  {$ENDIF Windows}
//  procedure CmdExecute(const cmd:string;const pars:array of string);

implementation

{$IFNDEF Windows}
uses
 Languages;
{$ENDIF Windows}

{procedure CmdExecute(const cmd:string;const pars:array of string);
var
 i:integer;
begin
with TProcess.Create(nil) do
 try
  Executable := cmd;
  for i := 0 to Length(pars)-1 do
   Parameters.Add(pars[i]);
  Options := [poWaitonexit];
  Execute;
 finally
  Free;
 end;
end;}

procedure CheckStringFitting(handle:THandle;var s:string;w:integer);
var
 sz:TSize;
 len,nch:integer;
begin
len := Length(s); //в байтах - вроде фича LCL, а не баг
if not LCLIntf.GetTextExtentExPoint(handle,PChar(s),len,w,@nch,nil,Sz) then exit;
len := UTF8Length(s);
if nch < len then s := UTF8Copy(s,1,nch-3)+'...';
end;

function GetProcessFileName:string;
begin
Result := ParamStr{UTF8}(0);
end;

{$IFNDEF Windows}
procedure NonWin;
begin
MessageDlg(Mes_WinVersion,mtInformation,[mbOk],0);
end;
{$ENDIF Windows}

end.
