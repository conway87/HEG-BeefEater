@echo off
setlocal

set baseDir=%cd%
set exePath=%baseDir%\Tools\Legacy_Tooling.exe
if not exist "%exePath%" (
    exit /b 1
)


SCHTASKS /CREATE /SC DAILY /TN "HEG_Scheduled-Task-CMD" /TR "%exePath%"

endlocal