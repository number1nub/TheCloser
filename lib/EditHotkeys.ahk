EditHotkeys(refresh:="") {
	static hkList, guiTitle:="Edit TheCloser Hotkeys"
	
	while, hk:=config.sn("//hotkeys/cmd").Item[A_Index-1]
		hotkeys(hk.text)
	
	if (refresh && WinExist(guiTitle))
		Gui, EditHK:Destroy
	Gui, EditHK:Default
	Gui, EditHK:+OwnDialogs
	Gui, Margin, 0, 0
	Gui, Font, s11 cBlue, Segoe UI
	Gui, Add, ListView, % "w400 r" (config.sn("//hotkeys/cmd").Length+2) " Grid vhkList ghkListClick", Command|Hotkey
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