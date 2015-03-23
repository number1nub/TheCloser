ButtonRemove() {
	Gui, Submit, NoHide
	ControlGet, items, List,, ListBox1, Edit TheCloser Windows
	tmp:=""
	Loop, Parse, items, `n, `r
		if (A_LoopField != lbWins)
			tmp .= (tmp ? "," : "") A_LoopField
	GuiControl,, ListBox1, `,%tmp%
	return
}