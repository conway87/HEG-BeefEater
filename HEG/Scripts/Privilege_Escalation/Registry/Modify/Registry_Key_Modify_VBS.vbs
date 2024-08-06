Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.RegWrite "HKCU\Console\HEG_Registry-Key-VBS\HEG", "Updated", "REG_SZ"
Set WshShell = Nothing