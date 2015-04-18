RegisterHotkeys() {
	dlist:=config.sn("//disablelist/*")
	while val:=dlist.item(A_Index-1)
		GroupAdd, disableGroup, % val.text
	
	Hotkey, ^+w, EditList	
	Hotkey, Delete, ButtonRemove, Off
	Hotkey, ^n, ButtonAdd, Off
	
	Hotkey, IfWinNotActive, ahk_group disableGroup
	Hotkey, ~LButton & RButton, CloseWin
	
	Hotkey, IfWinActive
}