var objShell = new ActiveXObject("WScript.Shell");
objShell.RegWrite("HKCU\\Console\\HEG_Registry-Key-JS\\HEG", "Updated", "REG_SZ");
objShell = null;