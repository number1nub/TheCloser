EditHotkey(cmdname, reload:=""){
	static
	cmd := config.ssn("//hotkeys/cmd[@name='" cmdname "']")
	Gui, 3:Destroy
	Gui, 3:Default
	Gui, Add, Hotkey, w200 vhotkey hwndhotkeyhwnd, % cmd.text
	Gui, Add, Edit, w200 vedit gedithotkey
	Gui, Add, Button, gsavehotkey Default, Save Hotkey
	Gui, Show,, Edit Hotkey
	if (cmd.text~="i)(L|R|M)Button|wheel")
		GuiControl,, Edit1, % cmd.text
	return
	
	3GuiEscape:
	3GuiClose:
	Gui,3:Destroy
	return
	
	edithotkey:
	Gui,3:Submit,Nohide
	GuiControl,3:, %hotkeyhwnd%, %edit%
	return
	
	savehotkey:
	Gui, Submit, Nohide
	if (!Hotkey && edit) {
		if (m("This is a non-standard hotkey. Use it?", "ico:!", "btn:yn")!="Yes")
			return
		hotkey := edit
	}
	Gui, Destroy
	cmd.text := hotkey
	config.save(1)
	;~ Reload
	return
}