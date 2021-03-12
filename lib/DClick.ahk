DClick() {
	static clickCount:=""
	
	if (clickCount) {
		SetTimer, DClickTimeOut, Off
		clickCount := ""
		CloseWin()
	}
	else {
		clickCount := 1
		SetTimer, DClickTimeOut, %timeOut%
	}
	return
	
	DClickTimeOut:	;{
		SendInput, % "{" mainHK "}"
		clickCount := 0
	return	;}
}