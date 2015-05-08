CloseWin() {
	MouseGetPos,,, id
	WinGetTitle, winTitle, ahk_id %id%
	WinGetClass, winClass, ahk_id %id%
	while win:=config.sn("//winlist/win").Item[A_Index-1], sk:=config.ea(win).send {
		if (win.text=winClass || InStr(winTitle, win.text)) {
			SendInput, % "{Blind}" (sk ? sk : "^{F4}")
			return
		}
	}
	WinClose, ahk_id %id%
}