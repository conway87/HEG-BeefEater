Set objFirewall = CreateObject("HNetCfg.FwMgr")
Set objPolicy = objFirewall.LocalPolicy.CurrentProfile
For Each objApplication In objPolicy.AuthorizedApplications
    If objApplication.Name = "HEG_Firewall-Exclusion-VBS" Then
        objApplication.Enabled = FALSE
        Exit For
    End If
Next
