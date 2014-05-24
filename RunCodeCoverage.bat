@Echo OFF
:: Created by KienDN 2014/05/20 
:: This is Windows batch script to output CodeCoverage report on ANDROID app during UnitTest
:: It is based on APACHE ANT and EMMA tool
:: It will only work on the emulator or a rooted device.

:: PRE-CONDITION
:: 1. Put JDK/APACHE ANT/AndroidSDK home directory to your environment PATH
:: Example:
:: JAVA_HOME = c:\Program Files\Java\jdk1.7.0_17
:: PATH = d:\AndroidDevTool\apache-ant-1.9.4\bin\;
:: PATH = d:\AndroidDevTool\adt-bundle-windows-x86_64-20130219\sdk\platform-tools\;
:: PATH = d:\AndroidDevTool\adt-bundle-windows-x86_64-20130219\sdk\tools\

:: 2. Put your App and UnitTest app and this Script file on the same directory
:: Example
:: - WorkspaceFolder
:: ---- AndroidApp
:: ---- AndroidAppTest
:: ---- RunCodeCoverage.bat

:: RUN SCRIPT
:: 1. Double-click RunCodeCoverage.bat and  input ANDROID_APP_FOLDER and ANDROID_TESTAPP_FOLDER folder
:: 2. Or Open Window command line tool and type  RunCodeCoverage.bat ANDROID_APP_FOLDER ANDROID_TESTAPP_FOLDER
:: Example: 
:: RunCodeCoverage.bat SimpleActivity SimpleActivityTest

:: VIEW COVERAGE REPORT
:: 1. Open ANDROID_TESTAPP_FOLDER/bin folder
:: 2. See coverage.html


@echo This script will output CodeCoverage report on ANDROID app!

:: Validate input parameter on Command line tool
:: First parameter

SETLOCAL
IF %1.==. (
	@echo Please input your ANDROID_APP_FOLDER to the first paramater.
	set /p ANDROID_APP_FOLDER=Enter The Value:
) ELSE (
	set ANDROID_APP_FOLDER=%1
)

:: Second parameter
IF %2.==. (
	@echo Please input your ANDROID_TESTAPP_FOLDER to the second paramater.
	set /p ANDROID_TESTAPP_FOLDER=Enter The Value:

) ELSE (
	set ANDROID_TESTAPP_FOLDER=%2
)


IF "%ANDROID_APP_FOLDER%." == "." GOTO Error
IF "%ANDROID_TESTAPP_FOLDER%." == "." GOTO Error

:: Start
@echo ---Starting Code coverage test ---
@echo ANDROID_APP_FOLDER = %ANDROID_APP_FOLDER%
@echo ANDROID_TESTAPP_FOLDER = %ANDROID_TESTAPP_FOLDER%

call android update project -p %~dp0%ANDROID_APP_FOLDER%

call android update test-project -m %~dp0%ANDROID_APP_FOLDER% -p %~dp0%ANDROID_TESTAPP_FOLDER%

pushd %ANDROID_TESTAPP_FOLDER% &&( call ant clean emma debug install test & popd )

REM call ant clean debug

@PAUSE
GOTO:EOF

:Error
@echo Invalid input parameter!

@PAUSE
ENDLOCAL


:: NOTE
rem How to use Parameter?
rem %0 is the program name as it was called.
rem %1 is the first command line parameter
rem %2 is the second command line parameter
rem and so on till %9.
rem %* is an array of all command line parameters
rem %~dp0 will return the Drive and Path to the batch script D:\scripts\
rem %~f0 will return the full pathname D:\scripts\mybatch.cmd.

rem How to declare variable?
rem @echo off set var1=testing 1 2 3
rem echo The variable is "%var1%"