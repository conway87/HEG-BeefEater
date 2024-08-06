var service = new ActiveXObject("Schedule.Service");
service.Connect();
var rootFolder = service.GetFolder("\\"); // Root folder
var taskDef = rootFolder.GetTask("HEG_Scheduled-Task-JS").Definition;
var taskSettings = taskDef.Settings;
taskSettings.Enabled = true;
var execAction = taskDef.Actions.Item(1);
execAction.Path = "calc.exe";
rootFolder.RegisterTaskDefinition("HEG_Scheduled-Task-JS", taskDef, 6, null, null, 3, null);
