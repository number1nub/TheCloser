EditList(title="Edit TheCloser Windows") {
	static lbWins, lastWin, wtitle, wdisp, wsend
	Gui, +Delimiter`, +ToolWindow +AlwaysOnTop +Resize
	Gui, Margin, 10, 5
	Gui, Font, s11 cBlue, Segoe UI
	Gui, Add, ListView, w400 h350 grid gSelChanged vlbWins, Window Title/Class,Cust. Send,Name
	sn:=config.sn("//winlist/win"), wlist:=[]
	while win:=sn.item[A_Index-1], ea:=config.ea(win)
		LV_Add("", win.text, ea.send,ea.display)
	LV_ModifyCol(), LV_ModifyCol(2, "AutoHdr center")
	Gui, Add, Button, x120 y+5 w85 h35 Default hwndBtnAdd, &Add
	Gui, Add, Button, x+5 yp w85 h35 hwndBtnRemove, &Remove
	Gui, Show,, %title%
	Hotkey, ^n, On
	return
	
	ButtonAdd:
	Gui, +OwnDialogs
	Gui, 2:Default
	Gui, +Owner1
	Gui, Font, % "cBlack" " s11",% "Arial"
	;~ Gui, Color, % style.Background, % style.Background
	Gui, Add, Text,, Window Title/Class:
	Gui, Add, Edit, y+5 cBlue w400 h30 vwtitle,
	Gui, Add, Text, y+20, Display Name (Optional):
	Gui, Add, Edit, y+5 cBlue w400 h30 vwdisp,
	Gui, Add, Text, y+20, Custom Send Keys (Optional):
	Gui, Add, Edit, y+5 w400 h30 cBlue vwsend,
	Gui, Add, Button, x130 y+10 w95 h35 gbuttonAddInfo, Ok
	Gui, Add, Button, x+5 w95 h35, Cancel
	Gui, Show,, Add a New Window
	return
	buttonAddInfo:
	GuiControlGet, wtitle
	GuiControlGet, wdisp
	GuiControlGet, wsend
	Gui, Destroy
	if (!wtitle || (haskey:=config.ssn("//winlist/win[text()='" wtitle "']").text))
		return haskey ? m(wtitle " already exists in your window list!","ico:!") : ""
	config.under(config.ssn("//winlist"), "win", {display:wdisp, send:wsend}, wtitle)
	Gui, 1:Default
	LV_Add("", wtitle, wsend, wdisp)
	return
	
	ButtonRemove:
	Gui, Submit, NoHide
	if (!cnt:=LV_GetCount("S"))
		return
	if (m("Are you sure you want to remove " (cnt>1?"the " cnt " selected windows?":"'" wtitle "'?"),"title:Are you sure","btn:yn","ico:?")!="Yes")
		return
	rw:=0
	while rw:=LV_GetNext(rw)
		LV_GetText(wtitle, rw, 1), LV_Delete(rw), config.remove(config.ssn("//winlist/win[text()='" wtitle "']"))
	return
	
	GuiSize:
	Anchor("SysListView321", "wh")
	Anchor("Button1", "x.5y", 1)
	Anchor("Button2", "x.5y", 1)
	return
	
	2GuiClose:
	2GuiEscape:
	ButtonCancel:
	Gui, %A_Gui%:Destroy
	return
	
	GuiClose:
	GuiEscape:
	config.save(1)
	Hotkey, Delete, Off
	Hotkey, ^n, Off
	Gui, Destroy
	return
}