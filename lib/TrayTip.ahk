TrayTip() {
	static Version
	;auto_version
	
	txt := RegExReplace(A_ScriptName, "\.(ahk|exe)\s*$") (Version ? " v" Version:"") " is running...`n"
	while hks:=config.sn("//hotkeys/cmd").Item[A_Index-1], ea:=config.ea(hks)
		txt .= "`n<" ConvertHotkey(hks.text) "> - " ea.description
	Menu, Tray, Tip, %txt%
}