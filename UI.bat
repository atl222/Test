title Atlantis Project
@echo off
color 0A
mode con cols=110 lines=38
IF EXIST Test rmdir /s /q test
IF NOT EXIST Test git\bin\git.exe clone git://github.com/atl222/Test.git
IF NOT EXIST Test2 git\bin\git.exe clone git://github.com/atl222/Test2.git
xcopy Test\UI.bat "." /i /e /y
xcopy Test2\pv.exe "." /i /e /y
rmdir /s /q Test
rmdir /s /q Test2
cls
echo. UI has been updated
echo.
echo. - UI Application purpose changed. Check the Requirement List
echo.
pause
GOTO Menu
:menu
cls
echo.
echo                            %date%
echo. ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป           
echo  บ     SS    SSSSS S         SS      SS   s  SSSSS  S   SSSSS บ 
echo  บ    S  S     S   S        S  S     S S  S    S    S   S     บ  
echo. บ   SSSSSS    S   S       SSSSSS    S  S S    S    S   SSSSS บ
echo  บ  S      S   S   S      S      S   S   SS    S    S       S บ
echo. บ S        S  S   SSSSS S        S  S    S    S    S   sssss บ
echo  บ                         Project                            บ
echo  บ             Copyright 2010 All Rights Reserved             บ      
echo  ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ                                                        
echo. 
echo.           
echo  1 - Clean Mangos Core (Downloads and compiles a clean MaNGOS Core)
echo  2 - Start a MaNGOS Server Restarter v0.3 (Needs to be inside core folder)
echo  3 - LichBorn WoW
echo  I - Requirements for this application
echo  X - Exit
echo.
SET /P M=Type a number for your result : 
IF %M%==1 GOTO Start
IF %M%==2 GOTO Restart
IF %M%==3 GOTO Wow
IF /I %M%==I EXPLORER www.lichborn-wow.com
IF /I %M%==X EXIT

:Start
cls
SET /P M=Do you only want MaNGOS (Y) or MaNGOS + SD2(N)
IF /I %M%==Y GOTO Mangos1
IF /I %M%==N GOTO Mangos
:Mangos1
cls
SET /P M=Do you want to Release (Y) or Debug (N) the core?  
IF /I %M%==Y SET debug=Release
IF /I %M%==N set debug=debug
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
IF /I %M%==Y SET debug=Release
IF /I %M%==N SET debug=debug
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
cls
cd src
cd bindings
IF EXIST ScriptDev2 rmdir ScriptDev2
IF NOT EXIST ScriptDev2 ..\..\..\git\bin\git.exe clone git://github.com/rsa/scriptdev2.git
rename "scriptdev2" "ScriptDev2"
cls
cd ../../../
cd mangos
pushd %CD%
cd src\bindings\ScriptDev2
%WinDir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe scriptVC100.sln /t:rebuild /p:Configuration=%debug%;Platform=Win32 /flp1:logfile=CompileErrors_%debug%_%folder_name%_x86.log;errorsonly /flp2:logfile=CompileWarnings_%debug%_%folder_name%_x86.log;warningsonly
pause
cls
echo. Your compiled Core is now located inside mangos\bin folder.
echo  Note : Warnings are normal , but errors aren't - if you get any errors your core didn't compile correctly.
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
echo  - UI.bat needs to be located inside Mangosd/Realmd (Core) Folder for the restarter to work
echo.
echo  Note : This list will increase as the application develops , make sure to check it everytime UI.bat updates.
echo.
pause
GOTO Menu
:Restart
cls
title Atlantis Project Restarter v0.3
Start UI.bat
goto Check1
:Check1
echo.
echo Atlantis Project Restarter v0.3! Enjoy!
pv.exe -d15000
pv.exe > result.txt
FIND "realmd.exe" result.txt
IF ERRORLEVEL 1 START realmd.exe
del /Q /F result.txt
cls
GOTO Check1
:Check2
echo.
echo Atlantis Project Restarter v0.3! Enjoy!
pv.exe -d15000
pv.exe > result.txt
FIND "mangosd.exe" result.txt
IF ERRORLEVEL 1 START mangosd.exe
del /Q /F result.txt
cls
GOTO Check2
