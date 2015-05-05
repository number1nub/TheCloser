CloseWin() {
	MouseGetPos,,, id
	WinGetTitle, winTitle, ahk_id %id%
	WinGetClass, winClass, ahk_id %id%
	if (!closeKeys:=config.ssn("//winlist/win[contains(text(), '" winClass "')]")) {
		if (!closeKeys:=config.ssn("//winlist/win[contains(text(), '" winTitle "')]")) {
			WinClose, ahk_id %id%
			return
		}
	}
	WinActivate, ahk_id %id%
	SendInput, % "{Blind}" (closeKeys ? closeKeys : "^{F4}")
}