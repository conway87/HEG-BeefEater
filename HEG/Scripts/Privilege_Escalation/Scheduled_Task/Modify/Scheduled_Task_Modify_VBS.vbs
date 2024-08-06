Function FindMainDir(startPath)
    Dim fso, currentPath, mainDir, parentPath
    Set fso = CreateObject("Scripting.FileSystemObject")
    currentPath = startPath
    Do While True
        mainDir = fso.BuildPath(currentPath, "HEG")
        If fso.FolderExists(mainDir) Then
            FindMainDir = mainDir
            Exit Function
        End If
        parentPath = fso.GetParentFolderName(currentPath)
        If parentPath = currentPath Then
            FindMainDir = Null
            Exit Function
        End If
        currentPath = parentPath
    Loop
End Function

Dim shell, fso, scriptPath, mainDir, newExePath, service, rootFolder, taskDef, actions, execAction
Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptPath = shell.CurrentDirectory
mainDir = FindMainDir(scriptPath)

If Not IsNull(mainDir) Then
    newExePath = fso.BuildPath(mainDir, "Tools\Updated_Tooling.exe")

    If fso.FileExists(newExePath) Then
        Set service = CreateObject("Schedule.Service")
        service.Connect()
        Set rootFolder = service.GetFolder("\") ' Root folder
        Set taskDef = rootFolder.GetTask("HEG_Scheduled-Task-VBS").Definition ' Get the task definition
        Set actions = taskDef.Actions
        Set execAction = actions.Item(1) ' Assuming the first action is the one to modify
        execAction.Path = newExePath ' Update to the new executable
        rootFolder.RegisterTaskDefinition "HEG_Scheduled-Task-VBS", taskDef, 6, Null, Null, 3, Null ' Update the task
    Else
        WScript.Echo "New executable not found: " & newExePath
    End If
Else
    WScript.Echo "Main directory not found."
End If
