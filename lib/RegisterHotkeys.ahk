RegisterHotkeys() {
	dlist:=config.sn("//disablelist/*")
	while val:=dlist.item(A_Index-1)
		GroupAdd, disableGroup, % val.text
	
	Hotkey, % config.ssn("//hotkeys/cmd[@name='EditList']").text, EditList	
	Hotkey, Delete, ButtonRemove, Off
	Hotkey, ^n, ButtonAdd, Off
	
	Hotkey, IfWinNotActive, ahk_group disableGroup
	Hotkey, % config.ssn("//hotkeys/cmd[@name='CloseWin']").text, CloseWin
	
	Hotkey, IfWinActive
}