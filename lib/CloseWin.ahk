CloseWin() {
	MouseGetPos,,, id
	WinGetTitle, winTitle, ahk_id %id%
	WinGetClass, winClass, ahk_id %id%
	if (!closeKeys:=config.ssn("//winlist/win[contains(text(), '" winClass "')]/@send").text) {
		if (!closeKeys:=config.ssn("//winlist/win[contains(text(), '" winTitle "')]/@send").text) {
			WinClose, ahk_id %id%
			return
		}
	}
	WinActivate, ahk_id %id%
	sKeys := closeKeys ? closeKeys : "^{F4}"
	SendInput, % "{Blind}" sKeys
}