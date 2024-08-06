Dim service, rootFolder
Set service = CreateObject("Schedule.Service")
service.Connect
Set rootFolder = service.GetFolder("\") ' Root folder
rootFolder.DeleteTask "HEG_Scheduled-Task-VBS", 0
Set service = Nothing
Set rootFolder = Nothing