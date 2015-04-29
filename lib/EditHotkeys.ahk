EditHotkeys() {
	static
	Gui, EditHotkeys:Default
	Gui, Add, TreeView, gtvClick
	Gui, Add, Button, gEditHK, &Edit
	Gui, Add, Button, x+10 gButtonClose, &Close
	hkTV:=TV_Add("Hotkeys"), hks:=config.sn("//hotkeys/cmd")
	while hk:=hks.item(A_Index-1), ea:=config.ea(hk)
		TV_Add(ea.description, hkTV)
	TV_Modify(TV_GetNext(), "Expand")
	Gui, Show,, Edit TheCloser Hotkeys
	return
	
	tvClick:
	if (A_GuiEvent != "DoubleClick")
		return
	EditHK:
	Gui, Submit, NoHide
	TV_GetText(tvItem, TV_GetSelection())
	if (!tvItem:=config.ssn("//hotkeys/cmd[@description='" tvItem "']/@name").text)
		return
	EditHotkey(tvItem)
	return
	
	EditHotkeysGuiClose:
	EditHotkeysGuiEscape:
	ButtonClose:
	Gui, Destroy
	Reload
	return
}