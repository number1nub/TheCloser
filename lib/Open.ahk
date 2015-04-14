Open() {
	if (A_ThisMenuItem = Format("Open {1} File",s.name))
		Run, % "*edit " s.name
	else if (A_ThisMenuItem = "Open Containing Dir")
		Run, explore %A_ScriptDir%
	else if (A_ThisMenuItem = "Exit")
		ExitApp
	else if (A_ThisMenuItem = "Backup WinList") {
		Gui +OwnDialogs
		FileSelectFile, oPath, S 24, % Format("{1}\{2}.bak",A_ScriptDir,s.name), Select where the backup should be saved:, Backup File (*.bak;*.txt)
		if (ErrorLevel || !oPath)
			return
		s.Save(oPath)
	}
}