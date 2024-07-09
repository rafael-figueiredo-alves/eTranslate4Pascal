@echo off
SET THEFILE=C:\MeusProjetos\eTranslate4Pascal\Demo\Lazarus\eTranslate_Demo_Lazarus.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.2.2\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o C:\MeusProjetos\eTranslate4Pascal\Demo\Lazarus\eTranslate_Demo_Lazarus.exe C:\MeusProjetos\eTranslate4Pascal\Demo\Lazarus\link12532.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
