@echo off
set LOGFILE=batch.log
call :LOG > %LOGFILE%
exit /B

:LOG

title Barnabas Ardublock Install For Windows
echo Version 1.5

for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo Current time is %mydate%:%mytime%

: Install CH341 Driver
echo Installing CH341 Driver...
cd CH341SER
start /w setup.exe /s
cd..

: Create libraries and tools folders
set LIBPATH=Documents\Arduino\libraries
set ARDUPATH=Documents\Arduino\tools\ArdublockTool\tool

: Copy Ardublock file and libraries for all windows users (including subdirectories)
for /d %%a in (C:\Users\*) do (

    @echo:
    echo Copying files for %%a
    @echo: 

    :: remove previous versions of Ardublock
    IF EXIST "%%a\%ARDUPATH%" (
        md "%%a\%ARDUPATH%"
        rmdir "%%a\%ARDUPATH%" /s /q
    )


    IF NOT EXIST "%%a\%LIBPATH%" (
        md "%%a\%LIBPATH%"
    )
    IF NOT EXIST "%%a\%ARDUPATH%" (
        md "%%a\%ARDUPATH%"
    )

    xcopy /y %CD%\libraries\* "%%a\%LIBPATH%" /s /i
    xcopy /y %CD%\tools\ArduBlockTool\tool\* "%%a\%ARDUPATH%" /s /i

 
)

