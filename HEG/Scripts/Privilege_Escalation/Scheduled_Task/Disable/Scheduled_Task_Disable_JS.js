var service = new ActiveXObject("Schedule.Service");
service.Connect();
var rootFolder = service.GetFolder("\\"); // Root folder
var task = rootFolder.GetTask("HEG_Scheduled-Task-JS");
task.Enabled = false;