TrayTip() {
	txt := RegExReplace(A_ScriptName, "\.(ahk|exe)\s*$") (Version ? " v" Version:"") " is running...`n"
	while hks:=config.sn("//hotkeys/cmd").Item[A_Index-1], ea:=config.ea(hks) {
		if (ea.name="CloseWin" && hks.text~="i)DClick:")
			txt .= "`nDouble-Click <" mainHK "> - " ea.description
		else
			txt .= "`n<" ConvertHotkey(hks.text) "> - " ea.description
	}
	Menu, Tray, Tip, %txt%
}