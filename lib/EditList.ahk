EditList(title="Edit TheCloser Windows") {
	static lbWins, lastWin, wtitle, wdisp, wsend, actTitle, actClass, ignoreWins:={Progman:"Program Manager", CabinetWClass:"Windows Explorer"}
	WinGetActiveTitle, actTitle
	WinGetClass, actClass, A
	Gui, +Delimiter`, +ToolWindow +AlwaysOnTop +Resize
	Gui, Margin, 10, 5
	Gui, Font, s11 cBlue, Segoe UI
	Gui, Add, ListView, w550 h350 grid altsubmit vlbWins glvclick, Window Title/Class,Cust. Send,Name
	sn:=config.sn("//winlist/win"), wlist:=[]
	while win:=sn.item[A_Index-1], ea:=config.ea(win)
		LV_Add("", RegExReplace(win.text,"%a_space%",A_Space), ea.send, ea.display)
	LV_ModifyCol(), LV_ModifyCol(2, "AutoHdr center")
	Gui, Add, Button, x125 y+5 w85 h35, &Add
	Gui, Add, Button, x+5 w85 h35, &Edit
	Gui, Add, Button, x+5 yp w85 h35, &Remove
	Gui, Show,, %title%
	return
	
	lvclick:
	if (A_GuiEvent="DoubleClick")
		goto, ButtonEdit
	else if (A_GuiEvent="K" && GetKeyName(Format("vk{:x}", A_EventInfo))="F2") {
		
	}
	return
	
	ButtonAdd:
	ButtonEdit:
	editmode:=(A_ThisLabel = "ButtonEdit")
	if (editmode && !LV_GetCount("S")=1)
		return
	if (editmode)
		rw:=LV_GetNext(), LV_GetText(wtitle, rw), editwin:=config.ssn("//winlist/win[text()='" RegExReplace(RegExReplace(wtitle,"^\s+","%a_space%"),"\s+$","%a_space%") "']"), editatt:=config.ea(editwin)
	Gui, +OwnDialogs
	Gui, 2:Default
	Gui, +Owner1
	Gui, Font, % "cBlack" " s11",% "Arial"
	;~ Gui, Color, % style.Background, % style.Background
	Gui, Add, Text, Section, Window Title/Class:
	Gui, Add, Edit, y+5 cBlue w400 h30 vwtitle, % editmode ? RegExReplace(RegExReplace(editwin.text,"^%a_space%",A_Space),"%a_space%$",A_Space) : ""
	Gui, Add, Text, xs y+20, Display Name (Optional):
	Gui, Add, Edit, y+5 cBlue w400 h30 vwdisp, % editmode ? editatt.display : ""
	Gui, Add, Text, y+20, Custom Send Keys (Optional):
	Gui, Add, Edit, y+5 w400 h30 cBlue vwsend, % editmode ? editatt.send : ""
	Gui, Add, Button, x120 y+10 w95 h35 default gbuttonAddInfo, Ok
	Gui, Add, Button, x+5 w95 h35 gButtonCancel, Cancel
	Gui, Show,, Add a New Window
	if (!editmode && (actTitle || actClass) && !config.ssn("//winlist/win[text()='" actClass "']") && !ObjHasKey(ignoreWins, actClass)) {
		exists := 0
		Loop, % config.sn("//winlist/win").length			
			exists += InStr(actTitle, config.ssn("//winlist/win[" A_Index "]").text)
		if (!exists) {
			Hotkey, Escape, CloseUseActive, On
			if (resp:=CMBox(Format("Use active window?`n`nTITLE:`n{1}`n`nCLASS:`n{2}",actTitle,actClass),"No|Yes - Use Title|Yes - Use Class",{ico:"?",title:"Add Active Window"}))
				GuiControl,, wtitle, % InStr(resp, "Title") ? actTitle : actClass
			Hotkey, Escape, CloseUseActive, Off
		}
	}
	actTitle := actClass := ""
	GuiControl, Focus, wtitle
	SendInput, {End}
	return
	
	EnterKey:
	goto, % LV_GetCount("S") < 1 ? "ButtonAdd" : "ButtonEdit"
	return
	
	buttonAddInfo:
	GuiControlGet, wtitle
	GuiControlGet, wdisp
	GuiControlGet, wsend
	Gui, Destroy
	if (!wtitle || (!editmode && (haskey:=config.ssn("//winlist/win[text()='" wtitle "']").text)))
		return (haskey ? m(wtitle " already exists in your window list!","ico:!") : "")
	Gui, 1:Default
	if (!editmode) {
		config.under(config.ssn("//winlist"), "win", {display:wdisp, send:wsend}, RegExReplace(RegExReplace(wtitle,"^\s+","%a_space%"),"\s+$","%a_space%"))
		LV_Add("", wtitle, wsend, wdisp)
	}
	else {
		editwin.text := RegExReplace(RegExReplace(wtitle,"^\s+","%a_space%"),"\s+$","%a_space%")
		editwin.setAttribute("display", wdisp)
		editwin.setAttribute("send", wsend)
		LV_Modify(rw,, wtitle, wSend, wdisp)
	}
	return
	
	ButtonRemove:
	Gui, 2:Submit, NoHide
	if (!cnt:=LV_GetCount("S")) {
		m("You must select a window first!", "ico:!")
		return
	}
	LV_GetText(wtitle, LV_GetNext(), 1)
	if (m("Are you sure you want to remove " (cnt>1 ? "the " cnt " selected windows?" : "'" wtitle "'?"), "title:Are you sure", "btn:yn", "ico:?") != "Yes")
		return
	rw:=0
	while rw:=LV_GetNext(rw)
		LV_GetText(wtitle, rw, 1), LV_Delete(rw), config.remove(config.ssn("//winlist/win[text()='" RegExReplace(RegExReplace(wtitle,"^\s+","%a_space%"),"\s+$","%a_space%") "']"))
	return
	
	GuiSize:
	Anchor("SysListView321", "wh")
	Anchor("Button1", "x.5y", 1)
	Anchor("Button2", "x.5y", 1)
	Anchor("Button3", "x.5y", 1)
	return
	
	CloseUseActive:
	ControlClick, Button1, Add Active Window
	return
	
	2GuiClose:
	2GuiEscape:
	ButtonCancel:
	Gui, %A_Gui%:Destroy
	editmode:=""
	return
	
	GuiClose:
	GuiEscape:
	config.save(1)
	Gui, Destroy
	return
}