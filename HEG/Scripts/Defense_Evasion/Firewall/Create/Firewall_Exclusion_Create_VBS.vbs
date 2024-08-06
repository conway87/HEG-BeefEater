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
    exePath = fso.BuildPath(mainDir, "Tools\Legacy_Tooling.exe")

    If fso.FileExists(exePath) Then
        Dim objFirewall, objPolicy, objApplication
        Set objFirewall = CreateObject("HNetCfg.FwMgr")
        Set objPolicy = objFirewall.LocalPolicy.CurrentProfile
        Set objApplication = CreateObject("HNetCfg.FwAuthorizedApplication")
        objApplication.Name = "HEG_Firewall-Exclusion-VBS"
        objApplication.ProcessImageFileName = exePath
        objApplication.Enabled = True
        objPolicy.AuthorizedApplications.Add(objApplication)
    End If
End If

If Err.Number <> 0 Then
    ' Optionally handle or log the error if needed
End If
