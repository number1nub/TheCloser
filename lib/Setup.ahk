Setup() {
	hk := config.add2("hotkeys")
	config.under(hk, "cmd", {name:"CloseWin", description:"Main Closer Hotkey"}, "~LButton & RButton")
	config.under(hk, "cmd", {name:"EditList", description:"Open closer window list settings"}, "^+w")
	wlist := config.add2("winlist")
	config.under(wlist, "win", {display:"Chrome"}, "Chrome_Widget_Win1")
	config.under(wlist, "win", {display:"Internet Explorer"}, "IEFrame")
	config.under(wlist, "win", {display:"FireFox"}, "MozillaWindowClass")
	config.save(1)
}