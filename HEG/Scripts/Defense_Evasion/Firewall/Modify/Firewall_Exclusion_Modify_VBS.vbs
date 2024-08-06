Function FindMainDir(startPath)
    Dim fso, currentPath, mainDir, parentPath
    Set fso = CreateObject("Scripting.FileSystemObject")
    currentPath = startPath
    Do
        mainDir = fso.BuildPath(currentPath, "HEG")
        If fso.FolderExists(mainDir) Then
            FindMainDir = mainDir
            Exit Function
        End If
        parentPath = fso.GetParentFolderName(currentPath)
        If parentPath = currentPath Then
            Exit Function
        End If
        currentPath = parentPath
    Loop
    FindMainDir = Nothing
End Function

On Error Resume Next
Dim objShell, fso, scriptPath, mainDir, exePath
Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

scriptPath = objShell.CurrentDirectory
mainDir = FindMainDir(scriptPath)

If Not IsEmpty(mainDir) Then
    exePath = fso.BuildPath(mainDir, "Tools\Updated_Tooling.exe")

    If fso.FileExists(exePath) Then
        
        Dim objFirewall, objPolicy, authorizedApps, app, ruleName
        Set objFirewall = CreateObject("HNetCfg.FwMgr")
        Set objPolicy = objFirewall.LocalPolicy.CurrentProfile
        Set authorizedApps = objPolicy.AuthorizedApplications
        ruleName = "HEG_Firewall-Exclusion-VBS"
        
        Dim appFound
        appFound = False
        
        For Each app In authorizedApps
            If app.Name = ruleName Then
                app.ProcessImageFileName = exePath
                app.Enabled = True
                appFound = True
                Exit For
            End If
        Next
    End If
End If

If Err.Number <> 0 Then
    ' Optionally handle or log the error if needed
End If
