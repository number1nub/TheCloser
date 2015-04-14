BuildTrayMenu() {
	Menu, DefaultAHK, Standard
	Menu, Tray, NoStandard
	Menu, Tray, Add, Edit Window List, EditList
	Menu, Tray, Add, Open winList.txt File, Open
	Menu, Tray, Add, Open Containing Dir, Open
	Menu, Tray, Add, Backup WinList, Open
	if (!A_IsCompiled) {
		Menu, Tray, Add
		Menu, Tray, Add, Default AHK Menu, :DefaultAHK
	}
	Menu, Tray, Add, 
	Menu, Tray, Add, Exit, Open
	Menu, Tray, Default, Edit Window List
	
	if (A_IsCompiled)
		Menu, Tray, Icon, % A_ScriptFullpath, -159
	else
		Menu, Tray, Icon, % FileExist(mIco:=A_ScriptDir "\TheCloser.ico") ? mIco : ""
}