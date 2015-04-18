CloseWin() {
	MouseGetPos,,, id
	WinGetTitle, winTitle, ahk_id %id%
	WinGetClass, winClass, ahk_id %id%
	
	if (!win:=config.ssn("//winlist/win[contains(text(), '" winTitle "')]")) {
		if (!win:=config.ssn("//winlist/win[contains(text(), '" winClass "')]")) {
			WinClose, ahk_id %id%
			return
		}
	}
	skeys:=config.ea(win).send, skeys:=skeys?skeys:"^{F4}"
	SendInput, % "{Blind}" skeys
}