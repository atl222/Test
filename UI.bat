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
:Mangos
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Do you want the default MaNGOS+SD core(Y) or ::
echo    :: a specific github MaNGOS+SD2 core(N)?        :: 
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P PreSpec=Choose an option :
IF /I %PreSpec%==Y goto Preset
IF /I %PreSpec%==N goto GCore
:Preset
SET Profile=mangos
SET Repo=mangos
SET Profile2=scriptdev2
SET Repo2=scriptdev2
goto MCcomp
:Gcore
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Enter the github profile name that contains  ::
echo    :: that contains the desired core.              ::      
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P Profile=Core profile name(case sensitive) : 
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Enter the repisitory name that contains the  ::
echo    :: desired core.                                ::
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P Repo=Core repository name(case sensitive) : 
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Enter the github profile name that contains  ::
echo    :: the desired ScriptDev2.                      ::  
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P Profile2=ScriptDev2 profile name(case sensitive) : 
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Enter the repository name that contains the  ::
echo    :: desired ScriptDev2.                          :: 
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P Repo2=ScriptDev2 repository name(case sensitive) : 
:MCcomp
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Do you want to release MaNGOS core(Y) or to  ::
echo    :: debug MaNGOS core(N)?                        :: 
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P RDB=Choose an option : 
IF %RDB%==Y set debug=Release
IF %RDB%==N set debug=debug
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Do you want a 32bit MaNGOS core(Y) or the    ::
echo    :: 64bit MaNGOS core(N)?                        ::
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P Cbit=Choose an option : 
IF %Cbit%==Y set Win=Win32
IF %Cbit%==N set Win=x64
cls
echo.
echo The core is going to compile now!
echo.
pause
cls
IF EXIST %Repo% cd %Repo%
IF EXIST ..\%Repo% ..\git\bin\git.exe pull git://github.com/%Profile%/%Repo%
IF EXIST ..\%Repo% cd ..\
IF NOT EXIST %Repo% git\bin\git.exe clone git://github.com/%Profile%/%Repo%
pushd %CD%
cd %Repo%
cd src
cd bindings
cls
IF EXIST ScriptDev2 cd ScriptDev2
IF EXIST ..\ScriptDev2 ..\..\..\..\git\bin\git.exe pull git://github.com/%Profile2%/%Repo2%
IF EXIST ..\ScriptDev2 cd ..\
IF NOT EXIST ScriptDev2 ..\..\..\git\bin\git.exe clone git://github.com/%Profile2%/%Repo2%
IF EXIST %Repo2% rename "Repo2%" "ScriptDev2"
cls
cd ../../../
cd %Repo%
pushd %CD%
%WinDir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe win\mangosdVC100.sln /t:rebuild /p:Configuration=%debug%;Platform=%Win% /flp1:logfile=CompileErrors_%debug%_%folder_name%_%win%.log;errorsonly /flp2:logfile=CompileWarnings_%debug%_%folder_name%_%win%.log;warningsonly
cls
cd src\bindings\ScriptDev2
%WinDir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe scriptVC100.sln /t:rebuild /p:Configuration=%debug%;Platform=%Win% /flp1:logfile=CompileErrors_%debug%_%folder_name%_%win%.log;errorsonly /flp2:logfile=CompileWarnings_%debug%_%folder_name%_%win%.log;warningsonly
pause
cls
echo.
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Do you want to import MaNGOS and ScriptDev2  ::
echo    :: database updates(Y/N)?                       ::
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
echo.
set /P MDBU=Choose an option : 
IF %MDBU%==Y goto Mdbu
IF %MDBU%==N goto MCDone
:Mdbu
SET Profile=mangos
SET Repo=mangos
SET Profile2=scriptdev2
SET Repo2=scriptdev2
cls
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Enter your MySQL information below, if you   ::
echo    :: leave it blank, default information is used. ::
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
set /p host=MySQL Host [default:localhost] :
if %host%. == . set host=localhost
set /p user=MySQL User [default:root] :
if %user%. == . set user=root
set /p pass=MySQL Pass [default:ascent] :
if %pass%. == . set pass=ascent
set /p port=MySQL Port [default:3306] :
if %port%. == . set port=3306
cls
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo    ::                                              ::
echo    :: Enter your database names below, if you      ::
echo    :: leave it blank, default information is used. ::
echo    ::                                              ::
echo    ::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
echo.
set /p scriptdev2db=ScriptDev2 DB Name [default:scriptdev2] : 
if %scriptdev2db%. == . set scriptdev2db=scriptdev2
set /p mangosdb=MaNGOS DB Name [default:mangos] :
if %mangosdb%. == . set mangosdb=mangos
set /p charactersdb=Characters DB Name [default:characters] :
if %charactersdb%. == . set charactersdb=characters
set /p realmddb=Realmd DB Name [default:realmd] :
if %realmddb%. == . set realmddb=realmd
cls
for %%i in (%Repo%\sql\updates\0.16\*_mangos*.sql) do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %mangosdb% < %%i
for %%i in (%Repo%\sql\updates\0.16\*_realmd*.sql) do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %realmddb% < %%i
for %%i in (%Repo%\sql\updates\0.16\*_characters*.sql) do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %charactersdb% < %%i
cls
for %%i in (%Repo%\sql\updates\*_mangos*.sql) do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %mangosdb% < %%i
for %%i in (%Repo%\sql\updates\*_realmd*.sql) do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %realmddb% < %%i
for %%i in (%Repo%\sql\updates\*_characters*.sql) do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %charactersdb% < %%i
for %%i in ("%Repo%\src\bindings\ScriptDev2\sql\Updates\*_scriptdev2.sql") do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %scriptdev2db% < %%i
for %%i in ("%Repo%\src\bindings\ScriptDev2\sql\Updates\*_mangos.sql") do echo%%i & mysql.exe -q -s -h %host% --user=%user% --password=%pass% --port=%port% --line_numbers %mangosdb% < %%i
pause
:MCDone
cls
echo. 
echo  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo  ::                                                                             ::
echo  :: Your compiled Core is now located inside %Repo%\bin folder.                 ::
echo  :: If you had any errors during the download/compile, the core didn't compile. ::
echo  :: Warnings are normal!                                                        ::              
IF /I %MDBU%==Y echo  :: Database has been updated! Duplicate entry errors are normal,               ::
IF /I %MDBU%==Y echo  :: it means that the update has already been applied!                          ::
echo  ::                                                                             ::
echo  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo.
pause
goto Atl