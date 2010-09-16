title Atlantis Project
@echo off
color 0A
mode con cols=110 lines=38
IF EXIST Test rmdir /s /q test
IF NOT EXIST Test git\bin\git.exe clone git://github.com/atl222/Test.git
IF NOT EXIST pv.exe git\bin\git.exe clone git://github.com/atl222/Test2.git
xcopy Test\UI.bat "." /i /e /y
xcopy Test2\pv.exe "." /i /e /y
IF NOT EXIST UnRAR_32.exe xcopy Test\UnRAR_32.exe "." /i /e /y
IF NOT EXIST mysql.exe xcopy Test\mysql.exe "." /i /e /y
rmdir /s /q Test
rmdir /s /q Test2
IF NOT EXIST RAR mkdir RAR
set mysql_folder=mysql.exe
cls
echo. UI has been updated
echo.
echo. - UI Application purpose changed. Check the Requirement List.
echo.
pause
GOTO Atl
:Atl
cls
echo.
echo                         %date%
echo. ������������������������������������������������������������ͻ           
echo  �     SS    SSSSS S         SS      SS   s  SSSSS  S   SSSSS � 
echo  �    S  S     S   S        S  S     S S  S    S    S   S     �  
echo. �   SSSSSS    S   S       SSSSSS    S  S S    S    S   SSSSS �
echo  �  S      S   S   S      S      S   S   SS    S    S       S �
echo. � S        S  S   SSSSS S        S  S    S    S    S   sssss �
echo  �                         Project                            �
echo  �             Copyright 2010 All Rights Reserved             �      
echo  ������������������������������������������������������������ͼ                                                        
echo.   
echo  Welcome to the Atlantis project , %USERNAME%
echo.      
echo  1 - Clean Mangos Core (Downloads and compiles a clean MaNGOS Core)
echo  2 - Compile a core from a specific GITHUB address (May have some errors)
echo  3 - Start a MaNGOS Server Restarter v0.3 (Needs to be inside core folder)
echo  4 - LichBorn WoW
echo  C - Calculator (Starts a Calculator in this window, UI opens in a second one)
echo  E - RAR Extractor (Extracts Any RAR Files with 1 Click)
echo  H - Hangman (Relax with a game of Hangman)
echo  I - Requirements for this application
echo  X - Exit
echo.
SET /P Option=Type a number/letter for your result : 
IF %Option%==1 GOTO Start
IF %Option%==2 GOTO Gcompile
IF %Option%==3 GOTO Restart
IF %Option%==4 GOTO Wow
IF %Option%==5 Goto Database
IF /I %Option%==C GOTO Calc
IF /I %Option%==E GOTO Extracting
IF /I %Option%==H GOTO Relax
IF /I %Option%==I GOTO Info
IF /I %Option%==X EXIT
:Start
cls
SET /P Core=Do you only want MaNGOS (Y) or MaNGOS + SD2(N)
IF /I %Core%==Y GOTO Mangos1
IF /I %Core%==N GOTO Mangos
:Mangos1
cls
SET /P Compile=Do you want to Release (Y) or Debug (N) the core?  
IF /I %Compile%==Y SET debug=Release
IF /I %Compile%==N set debug=debug
cls
echo. Core is going to download and compile now.
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
echo  Note : If you had any errors during the download/compile, the core didn't compile.
echo.
echo  Warrnings are normal
echo.
pause
GOTO atl
:Mangos
cls
SET /P SD2=Do you want to release (Y) or Debug (N) the core?  
IF /I %SD2%==Y SET debug=Release
IF /I %SD2%==N SET debug=debug
cls
echo. Core is going to download and compile now.
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
echo.
echo  Note : If you had any errors during the download/compile, the core didn't compile.
echo.
echo  Warnings are normal.
echo.
pause
GOTO atl
:Calc
cls
title Atlantis Project Calculator
Start UI.bat
goto Calc1
:Calc1
color 0e
echo --------------------------------------------------------------
echo              Atlantis Project Calculator
echo --------------------------------------------------------------
echo.
set /p sum=
set /a ans=%sum%
echo.
echo = %ans%
echo --------------------------------------------------------------
pause
cls
echo Previous Answer: %ans%
goto Calc1
pause
exit
:Extracting
cls
cd RAR
IF NOT EXIST Extracted mkdir Extracted
cls
echo. Place your RAR Files inside the RAR Folder.
echo.
explorer ..\RAR
echo. Press any key to extract the rar files...
pause>nul
cls
..\UnRAR_32.exe x -u -y "*.rar" "Extracted\"
pause
cd ..\
cls
echo. EXTRACTING DONE! You will find your extracted files inside:
echo. %foldername%\RAR\Extracted\
pause
GOTO atl
:Wow
cls
explorer http://www.lichborn-wow.com
GOTO Atl
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
GOTO Atl
:Restart
cls
title Atlantis Project Restarter v0.3
Start UI.bat
goto Check1
:Relax
cls
Start UI.bat
goto Hangman
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
:GCompile
rem Experimental option , not working fully , yet.
cls
echo. Enter the github profile name that contains the desired core (exp. Atl222)
set /P Profile=Address (case sensetive) : 
cls
echo. Enter the core repository (exp. : Mangos , Core).
set /P Repo=Repository (case sensetive) : 
cls
SET /P Compile=Do you want to Release (Y) or Debug (N) the core?  
IF /I %Compile%==Y SET debug=Release
IF /I %Compile%==N set debug=debug
cls
echo. Core is going to download/compile now.
echo.
pause
cls
IF EXIST %Repo% rmdir /s /q %Repo%
IF NOT EXIST %Repo% git\bin\git.exe clone git://github.com/%Profile%/%Repo%
cls
pushd %CD%
%WinDir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe %Repo%\win\mangosdVC100.sln /t:rebuild /p:Configuration=%debug%;Platform=Win32 /flp1:logfile=CompileErrors_%debug%_%folder_name%_x86.log;errorsonly /flp2:logfile=CompileWarnings_%debug%_%folder_name%_x86.log;warningsonly
pause
cls
echo. Your compiled core should be located inside the %Repo%/Bin folder!
echo.
echo  Note : If you had any errors during the download/compile, the core didn't compile.
echo.
pause
GOTO atl
rem Experimental!
cls
set /P DB=Do you want to import the database? (Y/N)
IF /I %DB%=N Goto Atl
IF /I %DB%=Y GOTO Database
:Database
cls
set /p svr=What is your MySQL host name?	[Default:localhost]		: 
if %svr%. == . set svr=localhost
set /p user=What is your MySQL user name?	[Default:root]			: 
if %user%. == . set user=root
set /p pass=What is your MySQL password?	[Default:mangos]		: 
if %pass%. == . set pass=mangos
set /p port=What is your MySQL port?	[Default:3306]			: 
if %port%. == . set port=3306
cls
set /p scriptdev2db=What is your ScriptDev2 DB name?	[Default:scriptdev2]        : 
if %scriptdev2db%. == . set scriptdev2db=scriptdev2
set /p mangosdb=What is your MaNGOS DB name?		[Default:mangos]        : 
if %mangosdb%. == . set mangosdb=mangos
set /p charactersdb=What is your characters DB name?	[Default:characters]        : 
if %charactersdb%. == . set charactersdb=characters
set /p realmddb=What is your realmd DB name?		[Default:realmd]        : 
if %realmddb%. == . set realmddb=realmd
cls
for %%i in (%Repo%\sql\updates\0.16\*_mangos*.sql) do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %mangosdb% < %%i
for %%i in (%Repo%\sql\updates\0.16\*_realmd*.sql) do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %realmddb% < %%i
for %%i in (%Repo%\sql\updates\0.16\*_characters*.sql) do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %charactersdb% < %%i
cls
for %%i in (%Repo%\sql\updates\*_mangos*.sql) do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %mangosdb% < %%i
for %%i in (%Repo%\sql\updates\*_realmd*.sql) do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %realmddb% < %%i
for %%i in (%Repo%\sql\updates\*_characters*.sql) do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %charactersdb% < %%i
for %%i in ("%Repo%\src\bindings\ScriptDev2\sql\Updates\*_scriptdev2.sql") do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %scriptdev2db% < %%i
for %%i in ("%Repo%\src\bindings\ScriptDev2\sql\Updates\*_mangos.sql") do echo %%i & %mysql_folder% -q -s -h %svr% --user=%user% --password=%pass% --port=%port% --line_numbers %mangosdb% < %%i
echo.
pause
cls
echo. Database has been updated , "Duplicate" errors are normal.
pause
goto Atl
:Hangman
title Atlantis Project - Hangman
setlocal enabledelayedexpansion
:menu
cls
echo Main Menu
echo To Play A Game, Press 1
echo To exit, Press 2
set /p menu=
if not defined menu goto menu
if /i %menu% equ 1 (
set menu=
goto Startgame
)
if /i %menu% equ 2 (
set menu=
set finishing=1
goto :EOF
)
set menu=
goto menu

:goodcheck
set /a wcheck= %wcheck% + 1
goto wordadd

:startgame
cls
set hang=12
set /a randomnumber=%time:~9,2%
:numberadjustment
call :w%randomnumber%
if defined finishing (goto :EOF>nul)
cls
set /a randomnumber= ( %randomnumber% * ( ( %randomnumber% * 75 ) /100 ) ) / ( %randomnumber% + 14 ) + ( %randomnumber% * 4 ) / ( %randomnumber% * 3 )
if /i randomnumber GEQ 10 (
set randomnumber=%randomnumber:~0,2%
) ELSE (
set randomnumber=%randomnumber:~0,1%
)
goto numberadjustment


:gotword
if defined justchecking (goto goodcheck)
set letternumber=0
:lettersorting
set x=!letternumber!
set Letter%letternumber%=!word:~%x%,1!
set Space%letternumber%=_
if NOT "!Letter%letternumber%!"=="" (
set /a letternumber= %letternumber% + 1
goto lettersorting
)


set space=
set /a spacenumber=0
:spacecalculator
set space=%space% #Space%spacenumber%#
set /a spacenumber= %spacenumber% + 1
if /i %spacenumber% equ %letternumber% (goto 1guess) else (goto spacecalculator)


:1guess
set score=0
set allguesses=letters:

:guess
cls
goto hang%hang%
:keepguessing
echo.
Echo Guess The Word: %space:#=!%
if %hang%==1 ( echo Last Guess!) else (
echo %Hang% Guesses Left 
)
echo You've guessed these %allguesses%
echo.
echo Guess Your Letter
set guess=
Set /p guess=
if not defined guess (goto guess)
set guess=%guess:~0,1%
if "%guess%"=="!" (goto guess)

echo You Guessed %guess%

if "%allguesses:~8%"=="" goto SkipCheckAlreadyGuess
echo %allguesses:~8% | find /i "%guess%" >nul
if /i %errorlevel% equ 0 (
echo You've already guessed that.
pause>nul
goto guess
)

:SkipCheckAlreadyGuess

set allguesses=%allguesses% %guess%


set poonumber=%letternumber%
if not defined score (set score=0)
if not defined oldscore (set oldscore=0)

:processguess
set verifyletter=!Letter%poonumber%!
if /i "%guess%"=="%verifyletter%" (
set /a score= !score! + 1
goto letteradjust
)
goto resume

:letteradjust
set Space%poonumber%=!Letter%poonumber%!
set !Letter%poonumber%=LETTERDONE

:resume
set /a poonumber=%poonumber% - 1
if /i %poonumber% lss 0 (goto noletter)
goto processguess



:noletter
if /i %score% GTR %oldscore% (goto gotletter)
Echo Sorry, wrong.
set /a hang= !hang! - 1
if !hang!==0 (goto dead)
pause>nul
set /a oldscore= %score%
cls
goto guess


:gotletter
echo Well done!
if %letternumber%==%score% (goto win)
pause>nul
set /a oldscore= %score%
goto guess

:dead
cls
echo Sorry, you died.
echo The word was "%word%".
pause>nul
goto endofall


:win
cls
echo You Won!
echo The word was "%word%"!
echo Well done!
pause>nul

:endofall
set space=
set cheddar=
set word=
set oldscore=
set score=
set letternumber=
set poonumber=
set spacenumber=
set anotherword=
set randomnumber=
set hang=
set guess=
set verifyletter=
set x=0
:endset
if defined Letter%x% (
set Letter%x%=
set /a x= %x% + 1
goto endset
)
set x=0
:endset2
if defined Space%x% (
set Letter%x%=
set /a x= %x% + 1
goto endset2
)
set x=

:askagain
cls
echo Go to the menu (enter 1) or quit (enter 2)?
set /p cheddar=""
if not defined cheddar goto askagain
if %cheddar%==1 (
set cheddar=
goto menu)
if %cheddar%==2 (
set finishing=1
goto :EOF)
goto askagain



:hang12
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto keepguessing


:hang11
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo  ________________________________
echo [________________________________]
goto keepguessing


:hang10
echo  _
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang9
echo   ______________________________
echo [ ]_____________________________]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang8
echo   _____________________________
echo [ ]____________________________]
echo [ ]   /  /
echo [ ]  /  / 
echo [ ] /  /  
echo [ ]/  /   
echo [ ]  /    
echo [ ] /     
echo [ ]/      
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang7
echo   ______________________________
echo [ ]__________________(-)________]
echo [ ]   /  /           (-)
echo [ ]  /  /            (-)
echo [ ] /  /             (_)
echo [ ]/  /    
echo [ ]  /     
echo [ ] /     
echo [ ]/      
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]       
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang6
echo    _____________________________
echo [ ]__________________(-)________]
echo [ ]   /  /           (-)
echo [ ]  /  /            (-)
echo [ ] /  /            _(_)_
echo [ ]/  /            / *_* \
echo [ ]  /             ] ___ [
echo [ ] /              \_____/
echo [ ]/   
echo [ ]    
echo [ ]    
echo [ ]    
echo [ ]    
echo [ ]    
echo [ ]    
echo [ ]    
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang5
echo    _____________________________
echo [ ]__________________(-)________]
echo [ ]   /  /           (-)
echo [ ]  /  /            (-)
echo [ ] /  /            _(_)_
echo [ ]/  /            / *_* \
echo [ ]  /             ] ___ [
echo [ ] /              \_____/
echo [ ]/                 [ ]
echo [ ]                  [ ]
echo [ ]                  [ ]
echo [ ]                  [_]
echo [ ]                  
echo [ ]             
echo [ ]             
echo [ ]             
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang4
echo    _____________________________
echo [ ]__________________(-)________]
echo [ ]   /  /           (-)
echo [ ]  /  /            (-)
echo [ ] /  /            _(_)_
echo [ ]/  /            / *_* \
echo [ ]  /             ] ___ [
echo [ ] /              \_____/
echo [ ]/                 [ ]_______
echo [ ]                  [ ]_______]
echo [ ]                  [ ]
echo [ ]                  [_]
echo [ ]                 
echo [ ]            
echo [ ]            
echo [ ]            
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang3
echo    _____________________________
echo [ ]__________________(-)________]
echo [ ]   /  /           (-)
echo [ ]  /  /            (-)
echo [ ] /  /            _(_)_
echo [ ]/  /            / *_* \
echo [ ]  /             ] ___ [
echo [ ] /              \_____/
echo [ ]/          _______[ ]_______
echo [ ]          [_______[ ]_______]
echo [ ]                  [ ]
echo [ ]                  [_]
echo [ ]  
echo [ ]  
echo [ ]  
echo [ ]   
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing



:hang2
echo    _____________________________
echo [ ]__________________(-)________]
echo [ ]   /  /           (-)
echo [ ]  /  /            (-)
echo [ ] /  /            _(_)_
echo [ ]/  /            / *_* \
echo [ ]  /             ] ___ [
echo [ ] /              \_____/
echo [ ]/          _______[ ]_______
echo [ ]          [_______[ ]_______]
echo [ ]                  [ ]
echo [ ]                  [ ]
echo [ ]                 / _ \
echo [ ]                /__ \ \
echo [ ]                     \ \
echo [ ]                      \_\
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:hang1
echo    _____________________________
echo [ ]__________________(-)________]
echo [ ]   /  /           (-)
echo [ ]  /  /            (-)
echo [ ] /  /            _(_)_
echo [ ]/  /            / *_* \
echo [ ]  /             ] ___ [
echo [ ] /              \_____/
echo [ ]/          _______[ ]_______
echo [ ]          [_______[ ]_______]
echo [ ]                  [ ]
echo [ ]                  [ ]
echo [ ]                 / _ \
echo [ ]                / / \ \
echo [ ]               / /   \ \
echo [ ]              /_/     \_\
echo [ ]                                      
echo [_]_____________________________
echo [________________________________]
goto keepguessing


:w0
set word=Bugger
goto gotword
:w1
set word=Willy
goto gotword
:w2
set word=Jelly
goto gotword
:w3
set word=Nipple
goto gotword
:w4
set word=Poo
goto gotword
:w5
set word=Dog
goto gotword
:w6
set word=Rat
goto gotword
:w7
set word=Cat
goto gotword
:w8
set word=Orange
goto gotword
:w9
set word=Purple
goto gotword
:w10
set word=Curry
goto gotword
:w11
set word=Pickle
goto gotword
:w12
set word=Porridge
goto gotword
:w13
set word=Apple
goto gotword
:w14
set word=Loop
goto gotword
:w15
set word=Balloon
goto gotword
:w16
set word=Drive
goto gotword

:w17
set word=Pork
goto gotword

:w18
set word=Fornicate
goto gotword

:w19
set word=Fag
goto gotword

:w20
set word=Monkey
goto gotword

:w21
set word=Crispy
goto gotword

:w22
set word=Beef
goto gotword

:w23
set word=Constitutional
goto gotword

:w24
set word=Educational
goto gotword

:w25
set word=Abnormality
goto gotword

:w26
set word=Retarded
goto gotword

:w27
set word=Fornication
goto gotword

:w28
set word=Rubbing
goto gotword

:w29
set word=Resin
goto gotword

:w30
set word=French
goto gotword

:w31
set word=Pipeline
goto gotword

:w32
set word=Ripple
goto gotword

:w33
set word=Punk
goto gotword

:w34
set word=Turtle
goto gotword

:w35
set word=Antler
goto gotword

:w36
set word=Raindeer
goto gotword

:w37
set word=Document
goto gotword

:w38
set word=Hill
goto gotword

:w39
set word=Steak
goto gotword

:w40
set word=Stake
goto gotword

:w41
set word=Staple
goto gotword

:w42
set word=Hang
goto gotword

:w43
set word=Man
goto gotword

:w44
set word=Alcohol
goto gotword

:w45
set word=Nicotine
goto gotword

:w46
set word=Cigarette
goto gotword

:w47
set word=Triple
goto gotword

:w48
set word=Lime
goto gotword

:w49
set word=Wire
goto gotword

:w50
set word=Plaster
goto gotword

:w51
set word=Christmas
goto gotword

:w52
set word=Holiday
goto gotword

:w53
set word=Dynamite
goto gotword

:w54
set word=Lemming
goto gotword

:w55
set word=Pizza
goto gotword

:w56
set word=Suckle
goto gotword

:w57
set word=Trip
goto gotword

:w58
set word=Course
goto gotword

:w59
set word=Cruise
goto gotword

:w60
set word=Marquee
goto gotword

:w61
set word=Balance
goto gotword

:w62
set word=Scale
goto gotword

:w63
set word=Stuffing
goto gotword

:w64
set word=Storage
goto gotword

:w65
set word=Pot
goto gotword

:w66
set word=Tank
goto gotword

:w67
set word=Tassle
goto gotword

:w68
set word=Silenced
goto gotword

:w69
set word=Sniff
goto gotword
:w70
set word=Green
goto gotword

:w71
set word=Dolphin
goto gotword
:w72
set word=Echo
goto gotword

:w73
set word=Wheat
goto gotword