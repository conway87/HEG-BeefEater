Set objFirewall = CreateObject("HNetCfg.FwMgr")
Set objPolicy = objFirewall.LocalPolicy.CurrentProfile
For Each objApplication In objPolicy.AuthorizedApplications
    If objApplication.Name = "HEG_Firewall-Exclusion-VBS" Then
        objPolicy.AuthorizedApplications.Remove(objApplication.ProcessImageFileName)
        Exit For
    End If
Next
