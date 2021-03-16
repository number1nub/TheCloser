RegisterHotkeys() {
	hotkeys("Delete", "ButtonRemove", "Edit TheCloser Windows")
	hotkeys("^n", "ButtonAdd", "Edit TheCloser Windows")
	hotkeys("Enter", "EnterKey", "Edit TheCloser Windows")
	hotkeys("Escape", "CloseUseActive", "Add Active Window")
	hotkeys("Delete", "IgWinButtonDeleteWindow", "The Closer Ignore Window Manager")
	
	while, hk:=config.sn("//hotkeys/cmd").Item[A_Index-1], ea:=config.ea(hk) {
		if (ea.name="DClick") {
			altHK := hk.text
			if (!timeOut:=(Abs(config.get("//options/@DClickTime", ""))*-1)) {
				config.add2("options", {DClickTime:150})
				config.save(1)
				timeOut := -150
			}
			while val:=config.sn("//disablelist/win").Item[A_Index-1]
				GroupAdd, disableGroup, % val.text
			Hotkey, IfWinNotActive, ahk_group disableGroup
			Hotkey, %altHK%, DClick, % (config.ea("//options").AltHKEnabled ? "On":"Off")
			Hotkey, IfWinActive
		}
		else
			hotkeys(hk.text, ea.name, (ea.description="Main Closer Hotkey" || ea.description~="Alternate") ? "disableGroup" : "")
	}
}