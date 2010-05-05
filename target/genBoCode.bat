@ECHO OFF
IF "%OS%" == "Windows_NT" setlocal

set SCRIPT_NAME=genBoCode.bat
set EXECUTABLE_CLASS=com.fpg.ec.utility.IbatisDSLCommand
set CURRENT_DIR=%cd%
set EXEC_CLASSPATH=.;"%CURRENT_DIR%\GenBoCode-0.0.3-SNAPSHOT-jar-with-dependencies.jar";

set JAVA_EXECUTABLE=java
if "%JAVA_HOME%" == "" goto execute
set JAVA_EXECUTABLE="%JAVA_HOME%\bin\java"

:execute
java -cp %EXEC_CLASSPATH% -jar GenBoCode-0.0.3-SNAPSHOT-jar-with-dependencies.jar -m %*

pause;

