Cmp 647
@if errorlevel 1 goto fail
BRCC32 ZX.rc
@goto ex
:fail
@echo Cmp parameter error
:ex