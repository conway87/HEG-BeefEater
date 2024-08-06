function findMainDir(startPath) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var currentPath = startPath;
    while (true) {
        var mainDir = fso.BuildPath(currentPath, "HEG");
        if (fso.FolderExists(mainDir)) {
            return mainDir;
        }
        var parentPath = fso.GetParentFolderName(currentPath);
        if (parentPath === currentPath) {
            return null;
        }
        currentPath = parentPath;
    }
}

var objShell = new ActiveXObject("WScript.Shell");
var fso = new ActiveXObject("Scripting.FileSystemObject");
var scriptPath = objShell.CurrentDirectory;
var mainDir = findMainDir(scriptPath);

if (mainDir) {
    var exePath = fso.BuildPath(mainDir, "Tools\\Updated_Tooling.exe");
    var objFirewall = new ActiveXObject("HNetCfg.FwMgr");
    var objPolicy = objFirewall.LocalPolicy.CurrentProfile;
    var appFound = false;
    var colApplications = new Enumerator(objPolicy.AuthorizedApplications);
    
    for (; !colApplications.atEnd(); colApplications.moveNext()) {
        var objApp = colApplications.item();
        if (objApp.Name == "HEG_Firewall-Exclusion-JS") {
            objApp.ProcessImageFileName = exePath;
            appFound = true;
            break;
        }
    }
    
}
