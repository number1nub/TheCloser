IgnoreWinManager() {
	hotkeys(config.ssn("//hotkeys/cmd[@name='CloseWin']").text)
	
	Gui, IgWin:Default
	Gui, Margin, 0, 0
	Gui, Font, s11 cBlue, Segoe UI
	Gui, +ToolWindow +Resize
	Gui, Add, ListView, w320 h260 grid NoSortHdr +AltSubmit -Multi HWNDh_LVClass, Classes
	Gui, Add, Button, y+0 w320 h35, &Delete Window
	Gui, Add, Button, y+0 w320 h35, &Add Window
	Gui, Show,, The Closer Ignore Window Manager
	while, dlist:=config.sn("//disablelist/win").Item[A_Index-1]
		LV_Add("", dlist.text)
	return	
	
	IgWinButtonDeleteWindow:
	if (!rw:=LV_GetNext(0)) {
		m("You must select an item!","!")
		return
	}
	LV_GetText(delWin, rw)
	if (m("Are you sure you want to delete " delWin "?", "?", "btn:yn")!="YES")
		return
	LV_Delete(rw)
	config.remove(config.ssn("//disablelist/win[text()='" delWin "']"))
	config.save(1)
	ClassChange:=1
	return
	
	IgWinButtonAddWindow:
	selWinInfo:=WinSelector()
	WinActivate, The Closer Ignore Window Manager
	If (!selWinInfo.use)
		return
	config.under(config.ssn("//disablelist"), "win",, selWinInfo[selWinInfo.use])
	config.save(1)
	LV_Add("", selWinInfo[selWinInfo.use])
	ClassChange:=1
	return
	
	IgWinGuiClose:
	If (ClassChange) {
		if ((ans:=m("You must restart TheCloser to apply changes.","","Restart now?","?","btn:ync"))="YES") {
			Reload
			Pause
		}
		else if (ans="CANCEL")
			return
	}
	Gui, Destroy
	hotkeys(config.ssn("//hotkeys/cmd[@name='CloseWin']").text)
	return
	
	IgWinGuiSize:
	Anchor("SysListView321", "wh")
	Anchor("Button1", "wy", 1)
	Anchor("Button2", "wy", 1)
	return
}