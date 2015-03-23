ButtonAdd() {
	Gui, +OwnDialogs
	InputBox, v, Add Closer Window, Enter new title/class
	if (ErrorLevel||!v)
		return
	GuiControl,, ListBox1, %v%
	return
}