var objShell = new ActiveXObject("WScript.Shell");
objShell.RegDelete("HKCU\\Console\\HEG_Registry-Key-JS\\");
objShell = null;