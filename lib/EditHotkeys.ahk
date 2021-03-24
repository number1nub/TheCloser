EditHotkeys(refresh:="") {
	static hkList, guiTitle:="Edit TheCloser Hotkeys"
	
	;Disable all configurable hotkeys
	while, hk:=config.sn("//hotkeys/cmd").Item[A_Index-1]
		hotkeys(hk.text)
	if (FileExist(ico:="TheCloser-Disabled.ico"))
		Menu, Tray, Icon, %ico%

	if (refresh && WinExist(guiTitle))
		Gui, EditHK:Destroy
	Gui, EditHK:Default +OwnDialogs +AlwaysOnTop
	Gui, Margin, 0, 0
	Gui, Font, s11 cRed, Segoe UI
	Gui, Add, Text, w400 h35 0x200 center, (Hotkeys disabled while open)
	Gui, Font, cBlue norm, Segoe UI
	Gui, Add, ListView, % "wp r" (config.sn("//hotkeys/cmd").Length+2) " Grid vhkList ghkListClick", Command|Hotkey
	Gui, Add, Button, y+0 wp default gEditHK, &Edit
	Gui, Add, Button, y+0 wp gButtonClose, &Close
	Gui, Show,, %guiTitle%
	Goto, HKListRefresh
	return
	
	hkListClick: 
	if (A_GuiEvent != "DoubleClick")
		return
	EditHK:
	LV_GetText(selItem, rw:=LV_GetNext())
	if (!selItem:=config.ssn("//hotkeys/cmd[@description='" selItem "']/@name").text)
		return
	EditHotkey(selItem)
	return
	
	EditHKGuiClose:
	EditHKGuiEscape:
	ButtonClose:
	Gui, EditHK:Destroy
	Reload
	return
	
	HKListRefresh:
	GuiControl, EditHK:-Redraw, hkList
	LV_Delete()
	while hk:=config.sn("//hotkeys/cmd").Item[A_Index-1], ea:=config.ea(hk)
		LV_Add("", ea.description, hk.text)
	LV_ModifyCol(), LV_ModifyCol(2, "Center")
	GuiControl, EditHK:+Redraw, hkList
	return
}