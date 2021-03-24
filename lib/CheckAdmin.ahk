CheckAdmin(req:="") {
	if (!A_IsAdmin) {
		if (%true% = "/admin") {
			Switch m("ico:?", "title:ADMIN RIGHTS"(req?" REQUIRED":""), "btn:" (req?"yn":"ctc"), "Failed to reload as Admin.`n", "Try again" (req?"?":" or continue without Admin credentials?")) {
				Case "CONTINUE":
					return false
				Case "TRY AGAIN","YES":
					Run, *RunAs "%A_ScriptFullPath%" /admin
			}
			ExitApp
		}
		Run, *RunAs "%A_ScriptFullPath%" /admin
		Exitapp
	}
	return true
}