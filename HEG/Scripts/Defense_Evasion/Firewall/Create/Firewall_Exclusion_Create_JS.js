var objShell = new ActiveXObject("WScript.Shell");
var fso = new ActiveXObject("Scripting.FileSystemObject");

function findMainDir(startPath) {
    var currentPath = startPath;
    while (true) {
        var mainDir = fso.BuildPath(currentPath, "HEG");
        if (fso.FolderExists(mainDir)) {
            return mainDir;
        }
        var parentPath = fso.GetParentFolderName(currentPath);
        if (parentPath === currentPath) {
            break;
        }
        currentPath = parentPath;
    }
    return null;
}

try {
    // Start the search from the current script's directory
    var scriptPath = objShell.CurrentDirectory;
    var mainDir = findMainDir(scriptPath);

    if (!mainDir) {
        throw new Error("HEG directory not found.");
    }


    var exePath = fso.BuildPath(mainDir, "Tools\\Legacy_Tooling.exe");
    var objFirewall = new ActiveXObject("HNetCfg.FwMgr");
    var objPolicy = objFirewall.LocalPolicy.CurrentProfile;
    var objApplication = new ActiveXObject("HNetCfg.FwAuthorizedApplication");
    objApplication.Name = "HEG_Firewall-Exclusion-JS";
    objApplication.ProcessImageFileName = exePath;
    objApplication.Enabled = true;
    objPolicy.AuthorizedApplications.Add(objApplication);
} catch (error) {}