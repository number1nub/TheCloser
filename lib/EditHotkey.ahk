EditHotkey(cmdname){
	static hotkey, edit, init, cmd
	
	cmd := config.ssn("//hotkeys/cmd[@name='" cmdname "']")
	Gui, 3:Destroy
	Gui, 3:Default
	Gui, +OwnerEditHK
	Gui, Font, s10 bold, Segoe UI
	Gui, Add, Text,, % config.ssn("//hotkeys/cmd[@name='" cmdname "']/@description").text
	Gui, Font, Norm
	Gui, Add, Hotkey, y+10 w250 vhotkey hwndhotkeyhwnd, % (init:=cmd.text)
	Gui, Add, Edit, wp vedit gedithotkey
	Gui, Add, Button, gsavehotkey Default, &Save
	Gui, Show,, % "Edit Hotkey" 
	if (cmd.text~="i)(L|R|M)Button|wheel")
		GuiControl,, Edit1, % cmd.text
	return
	
	3GuiEscape:
	3GuiClose:
	Gui, Submit, NoHide
	curHK := (!hotkey && edit) ? edit : hotkey
	if (curHK != init)
		goto, savehotkey
	Gui,3:Destroy
	return
	
	edithotkey:
	Gui, Submit, Nohide
	GuiControl,, msctls_hotkey321, %edit%
	return
	
	savehotkey:
	Gui, 3:Submit, Nohide
	if (!Hotkey && edit) {
		if (m("This is a non-standard hotkey. Use it?", "ico:!", "btn:yn")!="Yes")
			return
		hotkey := edit
	}
	Gui, 3:Destroy
	cmd.text := hotkey
	config.save(1)
	EditHotkeys(1)
	return
}