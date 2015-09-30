Setup() {
	hk := config.add2("hotkeys")
	config.under(hk, "cmd", {name:"CloseWin", description:"Main Closer Hotkey"}, "~LButton & RButton")
	config.under(hk, "cmd", {name:"EditList", description:"Edit Special Close Window List"}, "^+w")
	config.under(hk, "cmd", {name:"IgnoreWinManager", description:"Edit Ignore Windows"}, "^+i")
	wlist := config.add2("winlist")
	config.under(wlist, "win", {display:"Chrome"}, "Chrome_WidgetWin_1")
	config.under(wlist, "win", {display:"Internet Explorer"}, "IEFrame")
	config.under(wlist, "win", {display:"FireFox"}, "MozillaWindowClass")
	config.add2("disablelist")
	config.save(1)
}