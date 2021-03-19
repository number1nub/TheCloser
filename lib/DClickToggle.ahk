DClickToggle() {
	DClickToggle:
	opts  := config.ssn("//options")
	wasOn := (config.ea(opts).AltHKEnabled="true")
	opts.SetAttribute("AltHKEnabled", wasOn ? "false" : "true")
	config.save(1)
	Menu, Tray, % (wasOn ? "UnCheck" : "Check"), %AltHKMenuName%
	while val:=config.sn("//disablelist/win").Item[A_Index-1]
		GroupAdd, disableGroup, % val.text
	Hotkey, IfWinNotActive, ahk_group disableGroup
	Hotkey, %altHK%, Toggle
	Hotkey, IfWinActive
	return
}