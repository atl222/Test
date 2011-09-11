title MP-CD Project
@echo off
color 0A
mode con cols=110 lines=38
IF NOT EXIST git goto MysGit
IF NOT EXIST Cmake goto Cmake
IF NOT EXIST %WinDir%\Microsoft.NET\Framework\ goto NET
git\bin\git.exe clone git://github.com/atl222/Test.git
xcopy Test\UI.bat "." /i /e /y
IF NOT EXIST UnRAR_32.exe xcopy Test\UnRAR_32.exe "." /i /e /y
IF NOT EXIST mysql.exe xcopy Test\mysql.exe "." /i /e /y
rmdir /s /q Test
set Version=Version 0.1a
cls
echo. UI has been updated
echo.
echo. - Rewrting the whole code
echo.
pause
GOTO Atl
:MysGit
cls
echo. UI.bat can't detect Git folder! Please install MysGit into the 
echo. same folder as this application and re-run UI.bat!
pause
exit
:NET
cls
echo. UI.bat can't detect Microsoft Net Framework! Please install it
echo. and re-run Ui.bat!
pause
exit
:Cmake
cls
echo. UI.bat can't detect cmake folder! Please install cmake into the
echo. same folder as this application and re-run UI.bat!
pause
exit
:Atl
cls
echo.
echo                        Last updated on %date%
echo.   :::::::::::::::::::::::::::::::::::::::::::::::::: 
echo    ::                                              :: 
echo    ::  !!!!!!!!   !!!!  !!!!   !!!!!!!!  !!!!!!!!  ::
echo    ::  !!    !!   !! !!!! !!   !!        !!        ::
echo    ::  !!!!!!!! - !!  !!  !! - !!      - !!        ::
echo    ::  !!    !!   !!      !!   !!        !!        ::
echo    ::  !!    !!   !!      !!   !!!!!!!!  !!!!!!!!  ::
echo    ::                                              ::
echo    ::  Atlantis      Multi       Core    Compiler  ::
echo    ::                                              ::
echo    ::      Copyright 2010 All Rights Reserved      ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::                                             
echo                      Currently running %Version%
echo.                  
echo.
echo    Welcome , %USERNAME%! What would you like to do?
echo.
echo.
echo    1 - Compile a MaNGOS(+SD2) core
echo    2 - Compile a Trinity Core
echo    3 - Import a full MaNGOS DB (UDB)
echo    4 - Import a full Trinity DB (TDB)
echo    I - Requirement List
echo    X - Exit
echo.
set /P Choice=Enter the number of your choice :
IF /I %Choice%==1 goto Mangos
IF /I %Choice%==2 goto Trinity
IF /I %Choice%==3 goto UDB
IF /I %Choice%==4 goto TDB
IF /I %Choice%==I goto Info
If /I %Choice%==X Exit