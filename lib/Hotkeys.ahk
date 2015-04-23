Hotkeys(key:="", item:="", win:="") {
	static hkList := []
	if (!key)
		return hkList
	launch := RegExReplace(RegExReplace(item,"&")," ","_")
	if (!launch && ObjHasKey(hkList, key)) {
		Hotkey, %key%, Toggle
		hkList[key].state := hkList[key].state ? 0 : 1
		return
	}
	if (!launch)
		return
	if (win) {
		if (win = "disableGroup") {
			dlist := config.sn("//disablelist/win")
			while val:=dlist.item(A_Index-1)
				GroupAdd, disableGroup, % val.text
			Hotkey, IfWinNotActive, ahk_group disableGroup
		}
		else
			Hotkey, IfWinActive, %win%
	}
	Hotkey, %key%, %launch%, On
	hkList[key] := {state:1, launch:launch}
	Hotkey, IfWinActive
	return
}