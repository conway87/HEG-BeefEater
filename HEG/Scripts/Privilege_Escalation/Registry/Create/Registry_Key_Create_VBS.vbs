Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Console\HEG_Registry-Key-VBS\HEG", "HEG", "REG_SZ"
Set WshShell = Nothing