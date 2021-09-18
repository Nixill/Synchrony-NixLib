@echo off
cd /d %~dp0\..
echo Close manually when done.
:Start
echo.
set LINK=
set /p MOD_NAME="Enter mod name or 'this' to add link to the library: "
if "%MOD_NAME%"=="this" (
	for %%I in (.) do set MOD_NAME=%%~nxI
	SET LINK=build
) else (
	SET LINK=lib
)
set TARGET=..\%MOD_NAME%\scripts

IF NOT EXIST %TARGET% (
	echo Invalid mod name: %MOD_NAME%
	GOTO Start
)

mklink /D %LINK%\%MOD_NAME% ..\%TARGET% && (echo Linked '%LINK%\%MOD_NAME%' to '%TARGET%')
GOTO Start
