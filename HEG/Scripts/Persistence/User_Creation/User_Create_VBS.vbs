Set objNetwork = CreateObject("WScript.Network")
strComputer = objNetwork.ComputerName
Set objUser = GetObject("WinNT://" & strComputer & "")
Set objNewUser = objUser.Create("user", "HEG_User-VBS")
objNewUser.SetPassword "x^Bu4SV*3e$n"
objNewUser.SetInfo
