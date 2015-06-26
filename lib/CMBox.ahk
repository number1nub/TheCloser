CMBox(msg, btns, opts:="") {
	optVal:=4096, iconVal:={"x":16,"?":32,"!":48,"i":64}, btnVal:={2:4, 3:2}
	btns := IsObject(btns) ? btns : StrSplit(btns, "|")
	optVal += iconVal[opts.ico]+btnVal[btns.MaxIndex()]
	SetTimer, ChangeButtons, 5
	MsgBox, % optVal, % mTitle:=opts.title?opts.title:A_ScriptName, % msg
	IfMsgBox, Yes
		return btns[1]
	else IfMsgBox, OK
		return btns[1]
	else IfMsgBox, Abort
		return btns[1]
	else IfMsgBox, No
		return btns[2]
	else IfMsgBox, Retry
		return btns[2]
	else IfMsgBox, Ignore
		return btns[3]
	
	ChangeButtons:
	IfWinNotExist, %mTitle%
		return
	SetTimer, ChangeButtons, off
	bGap:=3, wGap:=10, charW:=8, nx:=[]
	WinGetPos,,, ww
	ControlGetPos,,, cw1,, Button1
	ControlGetPos,,, cw2,, Button2
	ControlGetPos,,, cw3,, Button3
	req:=[StrLen(btns[1])*charW, StrLen(btns[2])*charW, StrLen(btns[3])*charW]
		, nw:=[cw1<req[1]?req[1]:cw1, cw2<req[2]?req[2]:cw2, cw3<req[3]?req[3]:cw3]
		, nww:=nw[1]+nw[2]+nw[3]+(5*wGap)+(bGap*btns.MaxIndex()-bGap)
		, nx.Push((nww>ww?nww:ww-bGap)-3*(bGap*btns.MaxIndex()-bGap)-nw[1]-nw[2]-nw[3])
		, nx.Push(nx[1]+nw[1]+bGap, nx[1]+nw[1]+bGap+nw[2]+bGap)	
	WinMove,,,,, % nww>ww?nww:ww
	ControlMove, Button1, % nx[1],, % nw[1]
	ControlMove, Button2, % nx[2],, % nw[2]
	ControlMove, Button3, % nx[3],, % nw[3]
	ControlSetText, Button1, % btns[1]
	ControlSetText, Button2, % btns[2]
	ControlSetText, Button3, % btns[3]	
	return
}