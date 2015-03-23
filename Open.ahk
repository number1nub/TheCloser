Open() {
	if (InStr(A_ThisMenuItem, s.name))
		Run, % "*edit " s.name
	else if (InStr(A_ThisMenuItem, "Dir")||InStr(A_ThisMenuItem, "Folder"))
		Run, explore %A_ScriptDir%
}