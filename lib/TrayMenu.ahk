TrayMenu() {
	ico := {Main:"", Dis:"-Disabled", Spec:"-Special", Admin:"-Admin"}
	for c, v in ico
		ico[c] := {name:(name:=RegExReplace(A_ScriptName, "\.(ahk|exe)$", v) ".ico"), path:A_ScriptDir "\" name, url:"http://files.wsnhapps.com/TheCloser/" name}
	
	Menu, DefaultAHK, Standard
	Menu, Tray, NoStandard
	Menu, Tray, Add, Edit Window List, EditList
	Menu, Tray, Add, Edit Hotkeys, MenuAction
	Menu, Tray, Add,
	Menu, Tray, Add, Open Settings File, MenuAction
	Menu, Tray, Add, Open Containing Dir, MenuAction
	Menu, Tray, Add, Export Settings, MenuAction
	if (!A_IsCompiled) {
		Menu, Tray, Add
		Menu, Tray, Add, Default AHK Menu, :DefaultAHK
	}
	Menu, Tray, Add,
	Menu, Tray, Add, Check for Update, MenuAction
	Menu, Tray, Add,
	Menu, Tray, Add, Reload, MenuAction
	Menu, Tray, Add, Exit, MenuAction
	
	Menu, Tray, Default, Edit Window List
	
	for c, v in ico {
		if (!FileExist(v.path)) {
			URLDownloadToFile, % v.url, % v.path
			FileGetSize, fsize, % v.path
			if (fsize < 500)
				FileDelete, % v.path
		}
	}
	if (A_IsAdmin)
		Menu, Tray, Icon, % FileExist(ico.Admin.path) ? ico.Admin.path : FileExist(ico.Main.path) ? ico.Main.path : ""
	else
		Menu, Tray, Icon, % FileExist(ico.Main.path) ? ico.Main.path : ""
	
	TrayTip()
}