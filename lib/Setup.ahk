Setup() {
	config.add2("options", {DClickTime:175, AltHKEnabled:"true"})
	hk := config.add2("hotkeys")
	config.under(hk, "cmd", {name:"CloseWin", description:"Main Closer Hotkey"}, "~LButton & RButton")
	config.under(hk, "cmd", {name:"DClick", description:"Alternate Double-Click Hotkey"}, "MButton")
	config.under(hk, "cmd", {name:"EditList", description:"Edit Special Close Window List"}, "^+w")
	config.under(hk, "cmd", {name:"IgnoreWinManager", description:"Edit Ignore Windows"})
	config.under(hk, "cmd", {name:"EditHotkeys", description:"Customize Hotkeys"})
	wlist := config.add2("winlist")
	config.under(wlist, "win", {display:"Chrome"}, "Chrome_WidgetWin_1")
	config.under(wlist, "win", {display:"Internet Explorer"}, "IEFrame")
	config.under(wlist, "win", {display:"FireFox"}, "MozillaWindowClass")
	config.add2("disablelist")
	config.save(1)
}