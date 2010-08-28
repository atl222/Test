title Atlantis Project
@echo off
mode con cols=105 lines=33
IF EXIST Test rmdir /s /q test
IF NOT EXIST Test git\bin\git.exe clone git://github.com/atl222/Test.git
xcopy Test\UI.bat "." /i /e /y
rmdir /s /q Test
cls
echo. UI has been updated
echo.
pause
GOTO Menu
:menu
cls
echo. ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป           
echo  บ     SS    SSSSS S         SS      SS   s  SSSSS  S   SSSSS บ 
echo  บ    S  S     S   S        S  S     S S  S    S    S   S     บ  
echo. บ   SSSSSS    S   S       SSSSSS    S  S S    S    S   SSSSS บ
echo  บ  S      S   S   S      S      S   S   SS    S    S       S บ
echo. บ S        S  S   SSSSS S        S  S    S    S    S   sssss บ
echo  บ                         Project                            บ
echo  บ                          3.3.5                             บ
echo  บ             Copyright 2010 All Rights Reserved             บ      
echo  ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ                                                        
echo.            
echo  Type in a number for a result
echo.
echo  1 - Core Status (Current Core Status)
echo  2 - Database Status (Current Database Status)
echo  3 - Clean Mangos Core (Downloads and compiles a clean MaNGOS Core)
echo  4 - Comming Soon (Stuff thats not ready yet)
echo  5 - Requirements for this application
echo  X - Exit
echo.
SET /P M=Type a number for your result : 
IF %M%==1 GOTO Core
IF %M%==2 GOTO Database
IF %M%==3 GOTO Start
IF %M%==4 GOTO New
IF %M%==5 GOTO Info
IF %M%==X EXIT
IF %M%==x EXIT
:CORE
cls
echo.
echo Core status : Using Clean Mangos + Clean SD2
echo.
pause
GOTO menu
:Database
cls
echo.
echo Database status : Database is functional
echo.
pause
GOTO menu
:Start
cls
SET /P M=Do you only want MaNGOS (Y) or MaNGOS + SD2(N)
IF %M%==Y GOTO Mangos1
IF %M%==N GOTO Mangos
:Mangos1
cls
SET /P M=Do you want to Release (Y) or Debug (N) the core?  
IF %M%==Y SET debug=Release
IF %M%==N set debug=debug
cls
echo. Core is going to compile now.
echo.
pause
cls
IF EXIST mangos rmdir /s /q mangos
IF NOT EXIST Mangos git\bin\git.exe clone git://github.com/mangos/mangos
cls
pushd %CD%
cd mangos
%WinDir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe win\mangosdVC100.sln /t:rebuild /p:Configuration=%debug%;Platform=Win32 /flp1:logfile=CompileErrors_%debug%_%folder_name%_x86.log;errorsonly /flp2:logfile=CompileWarnings_%debug%_%folder_name%_x86.log;warningsonly
pause
cls
echo. Your compiled Core is now located inside mangos\bin folder.
echo.
pause
GOTO Menu
:Mangos
cls
SET /P M=Do you want to release (Y) or Debug (N) the core?  
IF %M%==Y SET debug=Release
IF %M%==N SET debug=debug
cls
echo. Core is going to compile now.
echo.
pause
cls
IF EXIST mangos rmdir /s /q mangos
IF NOT EXIST Mangos git\bin\git.exe clone git://github.com/mangos/mangos.git
cls
cls
pause
pushd %CD%
cd mangos
%WinDir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe win\mangosdVC100.sln /t:rebuild /p:Configuration=%debug%;Platform=Win32 /flp1:logfile=CompileErrors_%debug%_%folder_name%_x86.log;errorsonly /flp2:logfile=CompileWarnings_%debug%_%folder_name%_x86.log;warningsonly
echo. Part 1 Done
echo.
pause
cd src
cd bindings
IF EXIST ScriptDev2 rmdir ScriptDev2
IF NOT EXIST ScriptDev2 ..\..\..\git\bin\git.exe clone git://github.com/rsa/scriptdev2.git
rename "scriptdev2" "ScriptDev2"
cd ../../
pushd %CD%
cd mangos\src\bindings\ScriptDev2\
%WinDir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe scriptVC100.sln /t:rebuild /p:Configuration=%debug%;Platform=Win32 /flp1:logfile=CompileErrors_%debug%_%folder_name%_x86.log;errorsonly /flp2:logfile=CompileWarnings_%debug%_%folder_name%_x86.log;warningsonly
pause
cls
echo. Your compiled Core is now located inside mangos\bin folder.
echo.
pause
exit
:New
cls
echo.
echo    - New Custom Atlantis Core
echo    - Option to Compile a BETA Cataclysm Core
echo    - Autobroadcast on the server
echo    - PvP Announcer
echo    - PvP Tokens
echo    - Patches to ready the core+db for Cataclysm
echo    - Option to download diffrent database's
echo.
pause
GOTO Menu 
:Info
cls
echo. To use this application you need the following :
echo.
echo  - Visual Studio 2010
echo. - Git (You need to install GIT in the same folder as this app - for now.)
echo. - SDK Platform for Windows
echo  - .Net Framework 4.0
echo.
pause
GOTO Menu