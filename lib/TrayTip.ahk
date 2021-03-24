TrayTip() {
	ver := (!version || version=";auto_version") ? " (pre-release)" : " v" version
	txt := RegExReplace(A_ScriptName, "\.(ahk|exe)\s*$") ver " is running...`n"
	while hks:=config.sn("//hotkeys/cmd[@name='CloseWin' or @name='DClick']").Item[A_Index-1], ea:=config.ea(hks) {
		if (!hks.text )
			Continue
		txt .= "`n" ea.description " - <" ConvertHotkey(hks.text) ">"
	}
	Menu, Tray, Tip, %txt%
}