@echo off
setlocal

set baseDir=%cd%
set exePath=%baseDir%\Tools\Updated_Tooling.exe
if not exist "%exePath%" (
    exit /b 1
)


SCHTASKS /CHANGE /TN "HEG_Scheduled-Task-CMD" /TR "%exePath%" /RU "SYSTEM" /RP ""

endlocal
