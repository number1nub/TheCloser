CheckCredentials() {
	if (!A_IsAdmin) {
		ans := CMBox("Currently NOT running with admin privileges...`n`nAttempt to re-launch with administrator privileges?"
				   , "Yes - Reload as Admin|No - Continue|Cancel - Exit TheCloser", {ico:"i"})
		if (Instr(ans, "No - Continue"))
			return
		else if (InStr(ans, "Yes - Reload"))
			run *RunAs "%A_ScriptFullPath%"
		ExitApp
	}
}