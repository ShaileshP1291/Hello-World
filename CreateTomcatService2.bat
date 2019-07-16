@echo off
setlocal

rem server path
set server=%~1
set webappname=%~2
set version=%~3
set JVM_SIZE=%~4
set SVC_NAME=%~5
rem "true" or "false"
set CAS=%~6

set SERVICE_NAME_INTERNAL=%SVC_NAME%_%VERSION%

if "%CAS%"=="true"  set dirname=current2
if "%CAS%"=="false" set dirname=currentNoCAS

if "%CAS%"=="true"  set EnvVariables=%~7
if "%CAS%"=="false" set EnvVariables=

set os=win_b64

set CATALINA_HOME=%server%\%os%\code\tomcat\%dirname%
set SERVICE_BAT="%CATALINA_HOME%\bin\service.bat"

set JAVA_HOME=C:\Java\jdk1.8.0_92

rem stop the service
net stop %SERVICE_NAME_INTERNAL%

rem remove previous service
call %SERVICE_BAT% remove %SERVICE_NAME_INTERNAL%

rem create service
call %SERVICE_BAT% install %SERVICE_NAME_INTERNAL%

if "AMD64"=="%PROCESSOR_ARCHITECTURE%" set EXECUTABLE="%CATALINA_HOME%\bin\TomEE.amd64.exe"
if "x86"=="%PROCESSOR_ARCHITECTURE%"   set EXECUTABLE="%CATALINA_HOME%\bin\TomEE.x86.exe"

rem modify the service
if "%CAS%"=="true"  set PR_DISPLAYNAME=3DEXPERIENCE %version% 3DSpace2 TomEE
if "%CAS%"=="false" set PR_DISPLAYNAME=3DEXPERIENCE %version% 3DSpaceNoCAS TomEE

if "%CAS%"=="true"  set PR_DESCRIPTION=3DEXPERIENCE %version% 3DSpace2 TomEE
if "%CAS%"=="false" set PR_DESCRIPTION=3DEXPERIENCE %version% 3DSpaceNoCAS TomEE

set RegCmd=reg
if "AMD64"=="%PROCESSOR_ARCHITECTURE%"  set RegCmd=%SystemRoot%\SysWOW64\reg.exe
if "AMD64"=="%PROCESSOR_ARCHITEW6432%"  set RegCmd=%SystemRoot%\SysWOW64\reg.exe

rem replace _EQUAL_ by = char
if "%CAS%"=="true" set EnvVariables=%EnvVariables:_EQUAL_==%

%RegCmd% add "HKLM\SOFTWARE\Apache Software Foundation\Procrun 2.0\%SERVICE_NAME_INTERNAL%\Parameters" /v Environment /t REG_MULTI_SZ /f /d "Path=%server%\%os%\code\bin;%%Path%%\0%EnvVariables%"

%EXECUTABLE% //US//%SERVICE_NAME_INTERNAL% --Startup=auto

rem small setting if for test only
if "%JVM_SIZE%" == "small"   %EXECUTABLE% //US//%SERVICE_NAME_INTERNAL% ++JvmOptions "-Xmn256m;-XX:MetaspaceSize=128m;-XX:MaxMetaspaceSize=128m;-XX:SurvivorRatio=3;-XX:+DisableExplicitGC;-XX:+UseCompressedOops;-Dfile.encoding=UTF-8" --JvmMs 960 --JvmMx 960 --JvmSs 512
if "%JVM_SIZE%" == "medium"  %EXECUTABLE% //US//%SERVICE_NAME_INTERNAL% ++JvmOptions "-Xmn512m;-XX:MetaspaceSize=128m;-XX:MaxMetaspaceSize=256m;-XX:SurvivorRatio=3;-XX:+DisableExplicitGC;-XX:+UseCompressedOops;-Dfile.encoding=UTF-8" --JvmMs 1536 --JvmMx 1536 --JvmSs 1024
if "%JVM_SIZE%" == "large"   %EXECUTABLE% //US//%SERVICE_NAME_INTERNAL% ++JvmOptions "-Xmn1024m;-XX:MetaspaceSize=256m;-XX:MaxMetaspaceSize=256m;-XX:SurvivorRatio=3;-XX:+DisableExplicitGC;-XX:+UseCompressedOops;-Dfile.encoding=UTF-8" --JvmMs 2048 --JvmMx 2048 --JvmSs 1024	

exit /b 0
