Dim fso, shell, scriptPath, mainDir, exePath
Dim service, rootFolder, taskDef, taskSettings, execAction

Function FindMainDir(startPath)
    Dim currentPath, mainDir, parentPath
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
            FindMainDir = ""
            Exit Function
        End If
        currentPath = parentPath
    Loop
End Function

Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

scriptPath = fso.GetParentFolderName(WScript.ScriptFullName)
mainDir = FindMainDir(scriptPath)

If mainDir <> "" Then
    exePath = fso.BuildPath(mainDir, "Tools\Legacy_Tooling.exe")

    If fso.FileExists(exePath) Then
        Set service = CreateObject("Schedule.Service")
        service.Connect
        Set rootFolder = service.GetFolder("\")
        Set taskDef = service.NewTask(0)
        Set taskSettings = taskDef.Settings
        taskSettings.Enabled = True
        taskSettings.StartWhenAvailable = True
        Set execAction = taskDef.Actions.Create(0)
        execAction.Path = exePath
        rootFolder.RegisterTaskDefinition "HEG_Scheduled-Task-VBS", taskDef, 6, Null, Null, 3, Null
    End If
End If

Set fso = Nothing
Set shell = Nothing
Set service = Nothing
Set rootFolder = Nothing
Set taskDef = Nothing
Set taskSettings = Nothing
Set execAction = Nothing

