EditList(title="Edit TheCloser Windows") {
	static lbWins, lastWin
	Gui, +Delimiter`,
	Gui, +ToolWindow +AlwaysOnTop
	Gui, Margin, 10, 5
	Gui, Font, s11 cBlue, Segoe UI
	Gui, Add, ListBox, w300 h350 sort AltSubmit hwndlbWinsID gSelChanged vlbWins, % s.winList
	Gui, Add, Button, x70 y+5 w85 h35 Default hwndBtnAdd, &Add
	Gui, Add, Button, x+5 yp w85 h35 disabled hwndBtnRemove, &Remove
	Gui, Show,, %title%
	
	Hotkey, ^n, On
	return
	
	ButtonAdd:
	Gui, +OwnDialogs
	InputBox, v, Add Closer Window, Enter new title/class
	if (ErrorLevel || !v || (hk:=s.KeyList.HasKey(v))) {
		m(hk ? v " already exists in your window list!" : "Invalid entry","ico:!")
		return
	}
	s.winList .= (s.winList ? "," : "") v
	GuiControl,, ListBox1, % s.winList
	return
	
	SelChanged:
	Gui, Submit, NoHide
	GuiControl, % "Enable" (lbWins ? 1:0), Button2
	Hotkey, Delete, % lbWins ? "On" : "Off"
	return
	
	ButtonRemove:
	Gui, Submit, NoHide
	if (!lbWins)
		return	
	if (m("Remove """ (s.list)[lbWins] "?""","title:Are you sure","btn:yn","ico:?")="Yes")		
		GuiControl,, ListBox1, % "`," s.Remove(lbWins)
	return
	
	GuiClose:
	GuiEscape:
	s.Save()
	Hotkey, Delete, Off
	Hotkey, ^n, Off
	Gui, Destroy
	return
}