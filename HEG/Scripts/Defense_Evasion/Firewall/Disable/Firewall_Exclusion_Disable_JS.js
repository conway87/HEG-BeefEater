var objFirewall = new ActiveXObject("HNetCfg.FwMgr");
var objPolicy = objFirewall.LocalPolicy.CurrentProfile;

// Find the application rule by its name
for (var e = new Enumerator(objPolicy.AuthorizedApplications); !e.atEnd(); e.moveNext()) {
    var objApplication = e.item();
    if (objApplication.Name === "HEG_Firewall-Exclusion-JS") {
        objApplication.Enabled = false;
        break;
    }
}
