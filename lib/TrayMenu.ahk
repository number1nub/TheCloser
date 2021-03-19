TrayMenu() {
	ico := {Main:"", Dis:"-Disabled", Spec:"-Special", Admin:"-Admin"}
	for c, v in ico
		ico[c] := {name:(name:=RegExReplace(A_ScriptName, "\.(ahk|exe)$", v) ".ico"), path:A_ScriptDir "\" name, url:"http://files.wsnhapps.com/TheCloser/" name}
	
	Menu, DefaultAHK, Standard
	Menu, Tray, NoStandard

	;-- Create menu items for all configurable hotkeys --
	while, hks:=config.sn("//hotkeys/cmd").Item[A_Index-1], ea:=config.ea(hks) {
		Menu, Tray, Add, % ea.name="CloseWin" ? ("Close Window Under Mouse" (hks.text ? "`t(" ConvertHotkey(hks.text) ")":"")) 
											  : (tmp:=(ea.name="DClick" ? "Enable ":"") ea.description (hks.text ? "`t(" ConvertHotkey(hks.text) ")":"")), % (ea.name="DClick" ? "DClickToggle":ea.name)
		if (ea.name = "DClick") {
			AltHKMenuName := tmp
			Menu, Tray, % (config.ea("//options").AltHKEnabled="true" ? "Check":"UnCheck"), %AltHKMenuName%
		}
	}
	
	Menu, Tray, Add,
	Menu, Tray, Add, Open Settings File, MenuAction
	Menu, Tray, Add, Open Containing Dir, MenuAction
	Menu, Tray, Add, Export Settings, BackupSettings
	if (!A_IsCompiled) {
		Menu, Tray, Add
		Menu, Tray, Add, Default AHK Menu, :DefaultAHK
	}
	Menu, Tray, Add,
	Menu, Tray, Add, Check for Update, MenuAction
	Menu, Tray, Add,
	Menu, Tray, Add, Reload, MenuAction
	Menu, Tray, Add, Exit, MenuAction
	
	def := config.ea(defPath:="//hotkeys/cmd[contains(@description, 'Edit')][1]")
	Menu, Tray, Default, % def.description (config.ssn(defPath).text ? "`t(" ConvertHotkey(config.ssn(defPath).text) ")":"")
	
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