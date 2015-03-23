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
	
	GuiClose:
	GuiEscape:
		ControlGet, items, List,, ListBox1, Edit TheCloser Windows
		s.winList := items
		s.Save()
		Gui, Destroy
		return
}