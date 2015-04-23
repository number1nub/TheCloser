RegisterHotkeys() {
	hotkeys("Delete", "ButtonRemove", "Edit TheCloser Windows")
	hotkeys("^n", "ButtonAdd", "Edit TheCloser Windows")
	hotkeys("Escape", "CloseUseActive", "Add Active Window")
	
	hks := config.sn("//hotkeys/cmd")
	while, hk:=hks.item(A_Index-1), ea:=config.ea(hk)
		hotkeys(hk.text, ea.name, ea.description="Main Closer Hotkey" ? "disableGroup" : "")
}