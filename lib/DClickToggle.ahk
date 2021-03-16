DClickToggle() {
	sPath := "//options/@AltHKEnabled"
	config.ssn(sPath).text := config.ea("//options").AltHKEnabled ? 0 : 1
	config.save(1)
	Menu, Tray, % (config.ea("//options").AltHKEnabled ? "Check" : "UnCheck"), %AltHKMenuName%
	while val:=config.sn("//disablelist/win").Item[A_Index-1]
		GroupAdd, disableGroup, % val.text
	Hotkey, IfWinNotActive, ahk_group disableGroup
	Hotkey, %altHK%, Toggle
	Hotkey, IfWinActive
}