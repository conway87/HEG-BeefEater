Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegDelete "HKCU\Console\HEG_Registry-Key-VBS\"
Set WshShell = Nothing