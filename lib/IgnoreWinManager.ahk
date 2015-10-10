IgnoreWinManager() {
	static igWinList, guiTitle:="The Closer Ignore Window Manager"
	
	while, hk:=config.sn("//hotkeys/cmd").Item[A_Index-1]
		hotkeys(hk.text)
	
	Gui, IgWin:Default
	Gui, Margin, 0, 0
	Gui, Font, s11 cBlue, Segoe UI
	Gui, +ToolWindow +Resize
	Gui, Add, ListView, w400 h260 grid NoSortHdr +AltSubmit -Multi vigWinList HWNDh_LVClass, Classes
	Gui, Add, Button, y+0 wp h35, &Add Window
	Gui, Add, Button, y+0 wp h35, &Edit Window
	Gui, Add, Button, y+0 wp h35, &Delete Window
	Gui, Show,, %guiTitle%
	while, dlist:=config.sn("//disablelist/win").Item[A_Index-1]
		LV_Add("", dlist.text)
	return	
	
	IgWinButtonAddWindow:
	selWinInfo := WinSelector()
	WinActivate, %guiTitle%
	If (!selWinInfo.use)
		return
	if (!dwins:=config.ssn("//disablelist"))
		dwins:=config.add2("disablelist")
	config.under(dwins, "win",, selWinInfo[selWinInfo.use])
	config.save(1)
	LV_Add("", selWinInfo[selWinInfo.use])
	ClassChange:=1
	return
	
	IgWinButtonEditWindow:
	if (!rw:=LV_GetNext()) {
		m("You must select an item!", "title:TheCloser Ignore Windows", "!")
		return
	}
	LV_GetText(editWin, rw)
	InputBox, newWin, Edit Ignore Window, Window title/class:,,, 140,,,,, %editWin%
	if (ErrorLevel || !newWin || Trim(newWin)=Trim(editWin))
		return
	LV_Modify(rw,, newWin)
	config.ssn("//disablelist/win[text()='" editWin "']").text := newWin
	config.save(1)
	ClassChange:=1
	return
	
	IgWinButtonDeleteWindow:
	if (!rw:=LV_GetNext()) {
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