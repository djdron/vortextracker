{
Compares 'C000_1.bin' and 'C201_2.bin' and creates 'ZX_3.bin' with tables of
differencies and player, compiled at 0000 address
Used Vortex Tracker II v1.0 PT3 and Universal PT2'n'PT3 Turbo Sound players
for ZX Spectrum by S.V.Bulba
(c)2003-2007 S.V.Bulba
}
var
 f:file;
 b1,b2:array of byte;
 l,i,d:integer;
 codelen:integer;
 s,File1,File2,File3:string;
begin
if ParamCount <> 4 then halt(1);
File1 := ParamStr(1);
File2 := ParamStr(2);
File3 := ParamStr(3);
s := ParamStr(4);
codelen := 0;
for i := 1 to length(s) do
 case s[i] of
 '0'..'9':codelen := codelen*16+ord(s[i])-ord('0');
 'a'..'f':codelen := codelen*16+ord(s[i])-ord('a')+10;
 'A'..'F':codelen := codelen*16+ord(s[i])-ord('A')+10;
 else halt(1);
 end;
if codelen > 65535 then halt(1);
AssignFile(f,File1);
Reset(f,1);
l := FileSize(f) - codelen;
if l < 0 then halt(1);
SetLength(b1,codelen);
SetLength(b2,codelen);
BlockRead(f,b1[0],codelen);
CloseFile(f);
AssignFile(f,File2);
Reset(f,1);
BlockRead(f,b2[0],codelen);
CloseFile(f);
AssignFile(f,File3);
Rewrite(f,1);
BlockWrite(f,codelen,2);
BlockWrite(f,l,2);
Seek(f,codelen + 4);
i := 0;
while i < codelen - 1 do
 begin
  d := b2[i] - b1[i];
  if (d = 1) and (b2[i+1] - b1[i+1] = 2) then
   begin
    BlockWrite(f,i,2);
    b2[i] := b1[i];
    inc(i);
    Dec(b1[i],$C0);
    b2[i] := b1[i]
   end;
  inc(i);
 end;
i := -1;
BlockWrite(f,i,2);
for i := 0 to codelen - 1 do
 if b2[i] - b1[i] = 1 then
  BlockWrite(f,i,2);
i := -1;
BlockWrite(f,i,2);
for i := 0 to codelen - 1 do
 if b2[i] - b1[i] = 2 then
  begin
   BlockWrite(f,i,2);
   Dec(b1[i],$C0);
  end;
i := -1;
BlockWrite(f,i,2);
Seek(f,4);
BlockWrite(f,b1[0],codelen);
CloseFile(f);
end.