IgnoreWinManager() {
	static igWinList, guiTitle:="The Closer Ignore Window Manager"
	
	while, hk:=config.sn("//hotkeys/cmd").Item[A_Index-1]
		hotkeys(hk.text)
	
	Gui, IgWin:Default
	Gui, Margin, 0, 0
	Gui, Font, s11 cBlue, Segoe UI
	Gui, +ToolWindow +Resize
	Gui, Add, ListView, w400 h260 grid NoSortHdr +AltSubmit -Multi vigWinList HWNDh_LVClass, Classes
	Gui, Add, Button, y+0 wp h35, &Delete Window
	Gui, Add, Button, y+0 wp h35, &Add Window
	Gui, Show,, %guiTitle%
	while, dlist:=config.sn("//disablelist/win").Item[A_Index-1]
		LV_Add("", dlist.text)
	return	
	
	IgWinButtonDeleteWindow:
	if (!rw:=LV_GetNext(0, "Focused")) {
		m("You must select an item!", "title:TheCloser Ignore Windows", "!")
		return
	}
	LV_GetText(delWin, rw)
	if (m("Are you sure you want to delete """ delWin "?""", "?", "btn:yn")!="YES")
		return
	LV_Delete(rw)
	config.remove(config.ssn("//disablelist/win[text()='" delWin "']"))
	config.save(1)
	ClassChange:=1
	return
	
	IgWinButtonAddWindow:
	selWinInfo:=WinSelector()
	WinActivate, %guiTitle%
	If (!selWinInfo.use)
		return
	config.under(config.ssn("//disablelist"), "win",, selWinInfo[selWinInfo.use])
	config.save(1)
	LV_Add("", selWinInfo[selWinInfo.use])
	ClassChange:=1
	return
	
	IgWinGuiClose:
	IgWinGuiEscape:
	If (ClassChange) {
		Reload
		Pause
	}
	Gui, Destroy
	while, hk:=config.sn("//hotkeys/cmd").Item[A_Index-1]
		hotkeys(hk.text)
	return
	
	IgWinGuiSize:
	Anchor("SysListView321", "wh")
	Anchor("Button1", "wy", 1)
	Anchor("Button2", "wy", 1)
	return
}