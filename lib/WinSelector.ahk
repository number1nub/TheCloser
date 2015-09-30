WinSelector() {
	global selWinInfo:={}
	classTool_active := 1
	
	setTimer, classget, 200
	Hotkey, Esc, classTool_end, On
	Hotkey, F8, classTool_copy, On
	Hotkey, F9, titleTool_copy, On
	
	while classTool_active
		sleep 20
	
	setTimer, classget, Off
	ToolTip, ,,, 6
	Hotkey, Esc, classTool_end, Off
	Hotkey, F8, classTool_copy, Off
	Hotkey, F9, titleTool_copy, Off
	return selWinInfo
	
	classget:
	WinGetClass, selClass, A
	WinGetTitle, selTitle, A
	selWinInfo.class:=selClass, selWinInfo.title:=selTitle
	Tooltip, % Format("CLASS:`t{1}`nTITLE:`t{2}`n`nPress <F8> to Add Class`nPress <F9> to add Title`n`nPress <Esc> to cancel", selClass, selTitle),,, 6
	return
	
	classTool_copy:
	titleTool_copy:
	selWinInfo.use := StrReplace(A_ThisLabel, "Tool_copy")
	classTool_active := 0
	return
	
	classTool_end:
	selWinInfo.use := ""
	classTool_active := 0
	return
}