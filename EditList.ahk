EditList() {
	static lbWins
	Gui, +Delimiter`,
	Gui, +ToolWindow +AlwaysOnTop
	Gui, Margin, 10, 5
	Gui, Font, s11 cBlue, Segoe UI
	Gui, Add, ListBox, w300 h350 hwndlbWinsID vlbWins, % s.winList
	Gui, Add, Button, x70 y+5 w85 h35 Default, &Add
	Gui, Add, Button, x+5 yp w85 h35, &Remove
	Gui, Show,, Edit TheCloser Windows
	return
	
	ButtonAdd:
		Gui, +OwnDialogs
		InputBox, v, Add Closer Window, Enter new title/class
		if (ErrorLevel||!v)
			return
		GuiControl,, ListBox1, %v%
		return
	
	ButtonRemove:
		Gui, Submit, NoHide
		ControlGet, items, List,, ListBox1, Edit TheCloser Windows
		tmp:=""
		Loop, Parse, items, `n, `r
			if (A_LoopField != lbWins)
				tmp .= (tmp ? "," : "") A_LoopField
		GuiControl,, ListBox1, `,%tmp%
		return
	
	GuiClose:
	GuiEscape:
		ControlGet, items, List,, ListBox1, Edit TheCloser Windows
		s.winList := items
		s.Save()
		Gui, Destroy
		return
}