BackupSettings() {
		Gui +OwnDialogs
		curfPath := config.file
		SplitPath, curfPath, curName, curDir
		lastBUDir:=config.get("//backup/@dir", curDir), lastBUName:=config.get("//backup/@name", curName ".bak")
		FileSelectFile, oPath, S 24, % Format("{1}\{2}",lastBUDir,lastBUName), Select where the backup should be saved:, Backup File (*.bak;*.xml)
		if (ErrorLevel || !oPath || oPath = config.file)
			return
		if (FileExist(oPath))
			FileDelete, %oPath%
		config.save(1)
		FileCopy, % config.file, %oPath%, 1
		m(ErrorLevel ? "There was an error while backing up settings..." : "Successfully backed up config file!", ErrorLevel ? "ico:!" : "ico:i")
		SplitPath, oPath, oName, oDir
		config.add2("backup", {dir:oDir, name:oName})
		config.save(1)
	}