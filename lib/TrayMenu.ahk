TrayMenu() {
	Menu, DefaultAHK, Standard
	Menu, Tray, NoStandard
	Menu, Tray, Add, Edit Window List, EditList
	Menu, Tray, Add, Open Settings File, Open
	Menu, Tray, Add, Open Containing Dir, Open
	Menu, Tray, Add, Backup WinList, Open
	if (!A_IsCompiled) {
		Menu, Tray, Add
		Menu, Tray, Add, Default AHK Menu, :DefaultAHK
	}
	Menu, Tray, Add,
	Menu, Tray, Add, Check for Update, Open
	Menu, Tray, Add,
	Menu, Tray, Add, Exit, Open
	Menu, Tray, Default, Edit Window List
	
	if (A_IsCompiled)
		Menu, Tray, Icon, % A_ScriptFullpath, -159
	else {
		if (!FileExist(ico:=A_ScriptDir "\TheCloser.ico"))
			URLDownloadToFile, http://files.wsnhapps.com/TheCloser/TheCloser.ico, %ico%
		Menu, Tray, Icon, % FileExist(ico) ? ico : ""
	}
	TrayTip()
}