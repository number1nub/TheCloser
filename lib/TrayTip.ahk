TrayTip() {	
	Menu, Tray, Tip, % StrReplace("TheCloser v;auto_version is running...`n`n", "Version=")
		 . "Press <" ConvertHotkey(config.ssn("//hotkeys/cmd[@name='CloseWin']").text) "> to close window under mouse`n"
		 . "Press <" ConvertHotkey(config.ssn("//hotkeys/cmd[@name='EditList']").text) "> to edit the window list"
}