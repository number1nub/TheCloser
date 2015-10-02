MenuAction() {
	if (A_ThisMenuItem = "Open Settings File")
		Run, % "*edit """ config.file """"
	else if (A_ThisMenuItem = "Open Containing Dir")
		Run, % "explorer.exe /select, """ config.file """"
	else if (A_ThisMenuItem = "Exit")
		ExitApp
	else if (A_ThisMenuItem = "Reload") {
		Reload
		Pause
	}
	else if (A_ThisMenuItem = "Check for Update") {
		if (!CheckUpdate())
			m("No update found.", "ico:i")
	}
}