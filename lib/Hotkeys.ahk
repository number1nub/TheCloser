Hotkeys(key:="", item:="", win:="") {
	static hkList:=[]
	if (!key)
		return hkList
	launch := RegExReplace(RegExReplace(item,"&")," ","_")
	if (!launch && ObjHasKey(hkList, key)) {
		if (ctx:=hkList[key].context) {
			if (hkList[key].neg)
				Hotkey, IfWinNotActive, %ctx%
			else
				Hotkey, IfWinActive, %ctx%
		}
		Hotkey, %key%, Toggle
		hkList[key].state := hkList[key].state ? 0 : 1
		hotkey, IfWinActive
		return
	}
	if (!launch)
		return
	if (win) {
		if (win = "disableGroup") {
			while val:=config.sn("//disablelist/win").Item[A_Index-1]
				GroupAdd, disableGroup, % val.text
			Hotkey, IfWinNotActive, ahk_group disableGroup
			context:="ahk_group disableGroup", neg:=1
		}
		else {
			Hotkey, IfWinActive, %win%
			context:=win, neg:=0
		}
	}
	Hotkey, %key%, %launch%, On
	hkList[key] := {state:1, launch:launch, context:(win ? context:""), neg:neg}
	Hotkey, IfWinActive
	return
}