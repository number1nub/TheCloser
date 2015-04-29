Open() {
	if (RegExMatch(A_ThisMenuItem, "i)Edit (.+) Hotkey", m))
		EditHotkey(m1)
	else if (A_ThisMenuItem = "Edit Hotkeys")
		EditHotkeys()
	else if (A_ThisMenuItem = "Open Settings File")
		Run, % "*edit """ config.file """"
	else if (A_ThisMenuItem = "Open Containing Dir")
		Run, explore %A_ScriptDir%
	else if (A_ThisMenuItem = "Exit")
		ExitApp
	else if (A_ThisMenuItem = "Reload")
		Reload
	else if (A_ThisMenuItem = "Backup Settings")
		BackupSettings()
	else if (A_ThisMenuItem = "Check for Update")
		if (!CheckUpdate())
			m("No update found.", "ico:i")	
}