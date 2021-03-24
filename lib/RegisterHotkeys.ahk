RegisterHotkeys() {
	hotkeys("Delete", "ButtonRemove", "Edit TheCloser Windows")
	hotkeys("^n", "ButtonAdd", "Edit TheCloser Windows")
	hotkeys("Enter", "EnterKey", "Edit TheCloser Windows")
	hotkeys("Escape", "CloseUseActive", "Add Active Window")
	hotkeys("Delete", "IgWinButtonDeleteWindow", "The Closer Ignore Window Manager")
	
	;-- Catch any settings changes here --
	if (!config.ssn("//hotkeys/cmd[@name='DClick']"))
		config.add2("hotkeys/cmd", {name:"DClick", description:"Alternate Double-Click Hotkey"}, "MButton", 1)
	
	while, hk:=config.sn("//hotkeys/cmd").Item[A_Index-1], ea:=config.ea(hk) {
		if (ea.name="DClick") {
			altHK := hk.text
			opts  := config.ssn("//options")
			opt   := config.ea(opts)
			if (!opt.DClickTime || !opt.AltHKEnabled) {
				opts := config.add2("options", {DClickTime:(opt.DClickTime>0 ? opt.DClickTime : 175), AltHKEnabled:(opt.AltHKEnabled ? opt.AltHKEnabled : "true")})
				config.save(1)
				opt  := config.ea(opts)
			}
			timeOut := opt.DClickTime*-1
			while val:=config.sn("//disablelist/win").Item[A_Index-1]
				GroupAdd, disableGroup, % val.text
			Hotkey, IfWinNotActive, ahk_group disableGroup
			Hotkey, %altHK%, DClick, % (opt.AltHKEnabled="true" ? "On":"Off")
			Hotkey, IfWinActive
		}
		else
			hotkeys(hk.text, ea.name, ea.description="Main Closer Hotkey" ? "disableGroup" : "")
	}
}