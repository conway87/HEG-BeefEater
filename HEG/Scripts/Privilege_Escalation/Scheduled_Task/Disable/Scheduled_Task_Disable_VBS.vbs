Dim service, rootFolder, task
Set service = CreateObject("Schedule.Service")
service.Connect
Set rootFolder = service.GetFolder("\") ' Root folder
Set task = rootFolder.GetTask("HEG_Scheduled-Task-VBS")
task.Enabled = False
Set service = Nothing
Set rootFolder = Nothing
Set task = Nothing