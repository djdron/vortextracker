Vortex Tracker II v1.0 beta 12
(c)2000-2005 S.V.Bulba
Author Sergey Bulba
E-mail: vorobey@mail.khstu.ru
Support page: http://bulba.at.kz/

History
-------

The Vortex Tracker II idea is based on the Vortex Tracker. I and Roman
Scherbakov have started Vortex Tracker project at summer 2000, and the work was
stopped at autumn 2000 in not finished state. At August 2002 I decided to
restart work alone with new name Vortex Tracker II.

What is it?
-----------

Vortex Tracker II is a complete music editor for creating and editing music for
AY-3-8910, AY-3-8912 or YM2149F sound chips. Sound output is realized by sound
chips emulation through standard Windows digital sound devices, so, real sound
chips are not required. Vortex Tracker II uses standard Win32 functions and does
not require any additional libraries.

Vortex Tracker II can import ZX Spectrum music files (modules) of next types:

 1) Pro Tracker 3.xx (file mask is *.pt3);
 2) Pro Tracker 2.xx (*.pt2);
 3) Pro Tracker 1.xx (*.pt1);
 4) Flash Tracker (*.fls);
 5) Fast Tracker (*.ftc);
 6) Global Tracker 1.x (*.gtr);
 7) Pro Sound Creator 1.xx (*.psc);
 8) compiled ASC Sound Master modules (*.asc);
 9) compiled Sound Tracker and Super Sonic modules (*.stc);
 10) compiled Sound Tracker Pro modules (*.stp);
 11) compiled SQ-Tracker modules (*.sqt);
 12) Amadeus (Fuxoft AY Language) modules (*.fxm, *.ay).


VT II detects module type only by filename extension (mask), and no any
additional checks are performed. These extensions are used in well-known player
called Ay_Emul. Any other extensions are analized as text files.

Vortex Tracker II saves result only in one format is Pro Tracker 3.xx (*.pt3).
You can play these files in different players-emulators (the most known is
Win32 emulator Ay_Emul), on real ZX Spectrum in many players (Pusher, Quick
Commander, BestView, ZXAmp and so on) or by built-in playing routine. Also you
can include YM-sound into your PC-programs (see Ay_Emul sources, YM-Engine or
SquareTone at http://bulba.at.kz/).

During editing you can save work versions of module in text format. It allows
to save all temporary not used ornaments, samples and patterns. Also, text
format is easy editable in any text editor. Of course, text format is only
one chance to save your music, if PT3 saving is not available due size
limitations (65536 bytes).

In fact, Vortex Tracker II is Win32 version of ZX Spectrum Pro Tracker 3.xx.
The most compatible version is Pro Tracker v3.695 of Alone Coder (a.k.a. Dima
Bystrov). Vortex Tracker II is fully compatible with any Pro Tracker v3.5x in
"ProTracker 3.5" mode.

All supported formats are converted to Pro Tracker 3 compatible format,
therefore some information can be lost, because of ZX music formats are very
badly compatible between each other. More information about converting you can
see in 'Tracker limitations.rus.txt' file.

New 3xxx interpretation is supported in last Pro Tracker 3 versions from Alone
Coder (v3.6 and higher).

During editing total time length and current time position are calculated
automatically (for demomakers).

Note: new 3xxx interpretation changes behavior of ASC modules import also.

This version has next new features:

05/29/2005:

1. Fixed error in PT2 importer: memory before sample import was not clear.

06/14/2005:

2. Fixed horrible mistake: if you open save or some other dialogs during playing
   in "Loop among all opened modules" and next window start playing before you
   will finish, dialog will work with new active window. From this version
   all dialogs work with window, which was active during calling dialog.
   
09/16/2005:

3. Added import of PSC v1.00-1.03 modules.

09/30/2005:

4. Added import of compiled PSM (Pro Sound Maker by Denis Dratov) modules. They
   must be compiled by original (author's) compiler.

Known problems
--------------

See readme.rus.txt

Short manual
------------

Next keys are used.

 Pattern editor keys
 ~~~~~~~~~~~~~~~~~~~

1. In a note cel

1.1. NoteKeys:

                          Q 2 W 3 E R 5 T 6 Y 7 U I 9 O 0 P [ = ]
  Z S X D C V G B H N J M , L . ; /

  | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
  | C#| D#| | F#| G#| A#| | C#| D#| | F#| G#| A#| | C#| D#| | F#|
  C   D   E F   G   A   B C   D   E F   G   A   B C   D   E F   G

So fortepiano keys are emulated with range more than two octaves.

- If cursor in a note cell of track column, use numpad keys from 1 to 8 to
 (only when NumLock is on), key "A" for 
(R--) and key "K"  (---).

1.2. Shift+NoteKeys - input note one octave higher.

1.3. Shift+Ctrl+NoteKeys - input note one octave lower.

1.4. A - for sound off in channel command (R--).

1.5. K - for delete note (---).

1.6. From 1 to 8 at NumPad - choose current octave number.

During inputing numbers from NumPad NumLock must be turned on.

2. Pattern navigation (cursor control)

2.1. Up, Down, Left, Right - move cursor in four directions.

2.2. PageUp, PageDown - move cursor to page up or down.

2.3. Home, End - move cursor to begin or end of line.

2.4. Ctrl+Right, Ctrl+Left - quick cursor moving among columns.

2.5. Ctrl+PageUp, Ctrl+PageDown - move cursor to top or bottom of column.

2.6. Ctrl+Home, Ctrl+End - move to top of first or bottom of last column.

2.7. Mouse clicks - move cursor to desired cel.

2.8. Mouse wheel - scroll pattern up/down.

3. Pattern's area selection

3.1. Shift+cursor control keys (i.2.) - select rectangular area of pattern.

3.2. Ctrl+A, Ctrl+5 on NumPad - select all pattern.

3.3. Moving mouse with pushed left button.

3.4. Shift+mouse click - select from cursor to desired cel.

3.5. Shift+mouse wheel - not reset/add to selection.

4. Jumps from edit pattern to other objects

4.1. Tab - jup from one window control to other in predefined order.

4.2. Shift+Tab - same in reverse order.

4.3. ` (back apostrophe, usually over Tab key) - quick switch between pattern
and position list editors.

5. Deleting

5.1. BackSpace - delete current track line (with moving).
                                                          
5.2. Ctrl+BackSpace, Ctrl+Y - delete current pattern line (with moving).

5.3. Delete - clear selection's values or value at cursor position.

5.4. Ctrl+Delete - clear pattern line values.


6. Inserting empty lines

6.1. Insert - insert empty track line (with moving).

6.2. Ctrl+I - insert empty pattern line (with moving).


7. Working with Windows Clipboard

7.1. Ctrl+C, Ctrl+Insert - copy selection to clipbord.

7.2. Ctrl+X, Shift+Delete - same with clearing selection values.

7.3. Ctrl+V, Shift+Insert - inserting from clipboard (to right and to down from
cursor or from upper left corner of selection). In case of selection is defined,
insertion not exceeds its bounds.

8. Test playing of pattern's part

8.1. Any pushed key during inputing data - play current line.

8.2. Pushed Enter key - play pattern from current cursor position until key
is pushed. If any looping is on, pattern will be playing ciclically,

9. Other

9.1. 0 on NumPad - on/off Auto Envelope.

9.2. Space - on/off Auto Step.


 Common keys
 ~~~~~~~~~~~

1. Play controls

1.1. F5 - play module from current position.

1.2. F6 - play module from start.

1.3. F7 - play current pattern from current line.

1.4. F8 - play current pattern from start.

1.5. Esc - stop playing and go to edit pattern; also use to free sound device.

1.6. Ctrl+L - module and pattern loop playing on/off.

1.7. Ctrl+Alt+L - loop playing among all opened modules on/off. If only one
module is opened or pattern is playing, it works as usual loop.

2. Sound chip emulation

2.1. Ctrl+Alt+C - toggle chip type (AY-3-8910/12 or YM2149F).

2.2. Ctrl+Alt+A - toggle channel allocation (Mono, ABC, ACB and BAC, all other
can be selected in 'Options' dialog).

3. Editing

3.1. Ctrl+E - toggle autoenvelope mode to autocalculating envelope period by its
type and current note.

3.2. Ctrl+R - toggle autostep (edit spacing).

3.3. Ctrl+T - call Track Manager dialog.

3.4. Ctrl+Alt+T - call Global Transposition dialog.

4. Standard keys

4.1. Alt+F4 - close Vortex Tracker II.

4.2. Ctrl+F4 - close active window with module.

4.3. Ctrl+F6 - cyclic choosing of opened modules.

4.4. Ctrl+O - call open dialog.

4.5. Ctrl+S - save module.

4.6. Tab, Shift+Tab - ciclical jums between window controls (forward and
backward).

4.7. Alt+BackSpace - undo last change.


 Positions list editor keys
 ~~~~~~~~~~~~~~~~~~~~~~~~~~

1. ` - jump to/from pattern editor.

2. Left, Right or left mouse button - select position (during playing selected
position will restart playing).

3. Right mouse button - select position and call popup menu.

4. L - set loop position.

5. From 0 to 9 - enter pattern number for selected position.

6. Del - delete position with moving.

7. Ins - insert position with moving.

- In the sample editor:

Up, Down, Left, Right, PageUp, PageDown, Home, End, Ctrl+Right, Ctrl+Left,
Ctrl+PageUp, Ctrl+PageDown, Ctrl+Home, Ctrl+End for navigation.

In any position of editing sample:

T - toggle on/off tone mask
N - toggle on/off noise mask
M - toggle on/off envelope mask
Alt+Right - add current sample line into sample line templates list
Alt+Left - copy selected line from sample line templates into current sample
	   line.

In 'TNE' columns:
Space - toggle on/off corresponding mask

In any '+' and '-' columns:
Space - toggle sign
Shift+'=', '=', Numpad '+' - change sign to '+'
'-', Numpad '-' - change sign to '-'
Shift+6 ('^') - turning on accumulation in corresponding column '^'
Shift+'-' ('_') - turning off accumulation in corresponding column '_'
0-9,A-F - enter hexadecimal numbers

In any '^' and '_' columns:
Space - on/off accumulation
Shift+6 ('^') - turning on accumulation '^'
Shift+'-' ('_') - turning off accumulation '_'
0-9,A-F - enter hexadecimal numbers

In last column (volume control) '+', '-' and '_':
Space - toggle three variants
Shift+'-' ('_') - don't change sample volume '_'
'-',  Numpad '-' - decrease sample volume by one '-'
'+',  Numpad '+' - increase sample volume by one '+'
0-9,A-F - enter hexadecimal numbers

In the number fields:
0-9,A-F - enter hexadecimal numbers
Space - change sign, in amplitude column - volume control
Shift+'=', '=', Numpad '+' - change sign to '+'
'-', Numpad '-' - change sign to '-'
Shift+6 ('^') - turning on accumulation '^'
Shift+'-' ('_') - turning off accumulation '_'

Any non-digital key or mouse clicking reset number inputting counter.

Right mouse clicking in amplitude visualization field ('*' symbols) to choose
corresponding amplitude.

Moving mouse with clicked right button in amplitude visualization field to
draw amplitude.

Right mouse click in some sample cells to toggle corresponding value.

- In the ornament editor:

Up, Down, Left, Right, PageUp, PageDown, Home, End, Ctrl+PageUp, Ctrl+PageDown,
Ctrl+Home, Ctrl+End for navigation

0-9 - input decimal numbers

Space - toggle number sign

Shift+'=', Numpad '+' - set '+' sign

'-', Numpad '-' - set '-' sign

Right mouse click to toggle sign of corresponding value.

- In sample and ornament test fields navigation and editing same as in patterns
editor.

Maximum length of title and author strings is 32 chars.

Highligt step for pattern lines can be adjusted in pattern window. If Auto is
on, step is autoselected from 3,4 and 5 depending of pattern length.

You can load VT II modules into ZX Spectrum Pro Tracker 3.69x. It can load
modules with VT II header and with *.pt3 file extension.

For playing module by standard ZX Spectrum playing routine don't select song
speed smaller than 2 (3 for old players) or better use VT II built-in player
without such limitations.

To moral support author of VT II, select new Vortex Tracker II header, please.

Save command available only after starting editing of song.

Header types
------------

Current version can save three header types in PT3-file.

1) 'Vortex Tracker II 1.0 module: '

This header means, that module can contain all VT II abilities, including new
3xxx interpretation. However, module can be played with old PT3-players without
any problems in most cases.

2) 'ProTracker 3.6 compilation of '

This header means same abilities, as previous one. It need for some players,
which require old header style.

3) 'ProTracker 3.5 compilation of '

This header means, that module must be played with old 3xxx command
interpretation.

Files->Options... menu
----------------------

'New window' tab sheet

Here view of new windows with tracks can be adjusted. You can select number of
lines of track (from 3 to 64) and choose font. Select only monowidth fonts like
a Courier, Courier New and FixedSys, otherwise your tracks will be as trash.

'Windows' tab sheet

Visual channels allocation in patterns editor.

'Chip emulation' tab sheet

Choose chip type, chip and interrupt frequency, hearable channels allocation,
and one of emulation algorithm. Some changes can be listened after time is shown
in lower right corner of tab sheet. Some musicians use tricks, which can be
rightly emulated only in "for quality" mode. Some of them can be emulated
rightly only with filter (checked by default). Of course, high quality requires
more processor time. So, if your system can not produce solid sound, reduce
emulation quality or decrease bitrate or samplerate at 'Wave out' tabsheet.


'Compatibility' tab sheet

These are global compatibility options. If you need to adjust only current
module, see corresponding tab sheet on its window.

 3xxx command style

 - Vortex Tracker II - new 3xxx command interpretation. It affects to playing
                       and ASC modules import.
 - Pro Tracker 3.5 - old behavior of 3xxx command. Also ASC modules will be
                     imported for playing with old PT3 players.
 - Try detect - allow VT to detect it. For PT3 are used header analyzing (see
                rules above). For PT2 is used old style. For all other - new.

 Save with header

 You can recommend to VT II save one of header type. Anyway, VT II uses known
 rules (see 'Header types').

'Wave out' tab sheet

This is wave out sound options. All options are not available during playing. To
stop playing press corresponding button of the sheet.

 Sample rate

  Samples frequency, more values for more quality, but it requires more system
  resources. Some sound cards not support 44100 and 48000 Hz, so can be error
  messages are displayed (or sound quality will be worse).

 Bit rate

  Sample size, more value for more quality.

 Channels

  Mono or Stereo.

 Wave out device

  'Wave mapper' as default. To get full device list, push 'Get full list'
  button.

 Buffers

  Buffer size and number of buffers. Try to find optimal values for you system.
  Smaller buffer size for quicker reaction. More buffers for stable sound. Total
  length of buffers are calculated at low side of group. My system has stable
  sound even with 6 buffers of 5 ms length.

'Other' tab sheet

 Application priority

  Select normal or high priority. High priority is a only one way to get stable
  sound in background of Windows 9x/Me systems.
  
Track manager
-------------

To call press Ctrl+T or choose corresponding Edit menu option. You can copy
any part of any pattern to any place of any pattern.

In Location 1 and Location 2 group adjust pattern number, first line number and
channel number. In Area group set number of lines, and if you need check noise
and envelope tracks.

To copy one location to another simply press corresponding button in Copy group.
Also you can move or swap locations (see Move and Swap groups).

Also you can transpose any location to desired number of semitones (see
Transposition group). Positive values for up and negative for down. If you
check Envelope track (Area group), it'll be transposed too.

Global Transposition
--------------------

To call press Ctrl+Alt+T or choose corresponding Edit menu option. You can
transpose one or more tracks of whole module or of selected pattern. This
dialog allows avoid multiple using of Tracks manager. Adjusting and using same
as in Tracks manager.


Menu Files->Save and Files->Save as...
--------------------------------------

In appeared save dialog select in dropdown list file type for saving module:
either work text format (TXT) or Pro Tracker 3 (PT3) for final compilation.
During saving PT3 format, VT II removes all not used samples, ornaments and
patterns.


Menu Files->Exports->Save in SNDH (Atari ST)
--------------------------------------------

Saving in SNDH format for playing on Atari ST (or in SNDH-players and emulators
of Atari ST). There is universal MC68000 player used in SNDH, it supports all
note and volume tables (starting from PT 3.3), PT3 module version is analyzed
during initialization. Player is based on Ay_Emul procedures. SNDHs are not
packed by PACKICE in this version. Player size is about 10 Kb; start address is
not fixed.

Menu Files->Exports->Save with ZX Spectrum player
-------------------------------------------------

Saving with ZX Spectrum player. Supported formats: HOBETA with player ($c),
HOBETA without player ($m), .AY of EMUL subtype, SCL and TAP. .AY-format not
allows using 0 address. Player can be adjusted: you can disable looping of
module, check 'Disable loop' for that. In SCL and TAP formats, player and module
both are saved separately (in two differnt files). It is better than HOBETA,
because variables area between player and module is not saved. Player features
and instructions can be found in ZXPlayer.txt file. Source text of player can be
found in archive with VTII sources, and also at http://bulba.at.kz/

Thanks to
---------

- Roman Scherbakov (a.k.a. V_Soft) for idea and picture.
- Konstantin Yeliseyev (a.k.a. Hacker KAY) for AY and YM level tables.
- Dmitry Bystrov (a.k.a. Alone Coder) for information about Pro Tracker 3.xx.
- Roman Petrov (a.k.a. Megus) for ideas about ideal AY tracker.
- Macros for testing, test files, wishes about interface and for support.
- Shiru Otaku for plug-in, testing, wishes and bug-reports.
- Polaris for wishes and test modules.
- Black Groove (a.k.a. Key-Jee) for bug-reports, wishes and test modules.
- Ilya Abrosimov (a.k.a. EA) for bug-reports and wishes.
- Pavel A. Sukhodolsky for help and formats discussion.
- Slava Kalinin for distribution VT II among AY-musicians.
- Asi for bugreports and wishes.
- Denis Seleznev for icon pictures.
- Spectre for help in debugging and wishes about ZX PT3-player.
- Ivan Roshin for help in writing new ZX PT3-player.
- Jecktor for addapting PT3-player sources to XAS.
- HalfElf for using in xLook Far Manager plug-in.

Thanks to musicians using VT II:
Shiru Otaku
Key-Jee
EA
Alone Coder
Siril
z00m
Asi
Rolemusic
Karbofos
Kyv
and you ;)


Distribution
------------

Vortex Tracker II is free program. There are two kind of original distribution:
binary (VT.exe with documentation) and sources (source files as Delphi 7 project
with documentation). You can use and distribute sources freely, simply credit me
somewhere in your projects, where you include all or part of the sources and
(or) my algorithms.

Sergey Bulba

24 of August 2002 - 30 of September 2005
