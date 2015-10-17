CheckAdmin() {
	if (!A_IsAdmin) {
		if (%true% = "admin") {
			MsgBox, 4148,, Failed to get admin credentials.`n`nTry again?
			IfMsgBox, No
				ExitApp
		}
		Run, *RunAs "%A_ScriptFullPath%" admin
		ExitApp
	}
	return 1
}