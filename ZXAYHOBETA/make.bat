Cmp C000.bin C201.bin ZXAY.bin 651
@if errorlevel 1 goto fail
Cmp C000TS.bin C201TS.bin ZXTS.bin 951
@if errorlevel 1 goto fail
BRCC32 ZX.rc
@goto ex
:fail
@echo Cmp parameter error
:ex