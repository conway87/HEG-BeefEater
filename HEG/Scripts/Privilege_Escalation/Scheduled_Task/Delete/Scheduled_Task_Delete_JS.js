var service = new ActiveXObject("Schedule.Service");
service.Connect();
var rootFolder = service.GetFolder("\\"); // Root folder
rootFolder.DeleteTask("HEG_Scheduled-Task-JS", 0);