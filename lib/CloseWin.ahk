CloseWin() {
	MouseGetPos,,, win
	WinGetTitle, winTitle, ahk_id %win%
	WinGetClass, winClass, ahk_id %win%
	
	;TODO: Use the win config settings to send customized keys per window
	if winTitle contains % s.winList
		SendInput, {Blind}^{F4}
	else if winClass contains % s.winList
		SendInput, {Blind}^{F4}
	else
		WinClose, ahk_id %win%
	return
}