TrayMenu() {
	ico := {Main:"", Dis:"-Disabled", Spec:"-Special"}
	for c, v in ico
		ico[c] := {name:(name:=RegExReplace(A_ScriptName, "\.(ahk|exe)$", v) ".ico"), path:A_ScriptDir "\" name, url:"http://files.wsnhapps.com/TheCloser/" name}
	
	Menu, DefaultAHK, Standard
	Menu, Tray, NoStandard
	Menu, Tray, Add, Edit Window List, EditList
	Menu, Tray, Add, Edit Hotkeys, Open
	Menu, Tray, Add,
	Menu, Tray, Add, Open Settings File, Open
	Menu, Tray, Add, Open Containing Dir, Open
	Menu, Tray, Add, Export Settings, Open
	if (!A_IsCompiled) {
		Menu, Tray, Add
		Menu, Tray, Add, Default AHK Menu, :DefaultAHK
	}
	Menu, Tray, Add,
	Menu, Tray, Add, Check for Update, Open
	Menu, Tray, Add,
	Menu, Tray, Add, Reload, Open
	Menu, Tray, Add, Exit, Open
	Menu, Tray, Default, Edit Window List
	
	for c, v in ico
		if (!FileExist(v.path))
			URLDownloadToFile, % v.url, % v.path
	Menu, Tray, Icon, % FileExist(ico.Main.path) ? ico.Main.path : ""
	
	TrayTip()
}