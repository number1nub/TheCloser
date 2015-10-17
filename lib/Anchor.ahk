Anchor(ctrl, anchor="", redraw=false) {
	Static Ptr, PtrSize, GetParent, GetWindowInfo, SetWindowPos, RedrawWindow, c, cs, cl=0, g, gs, gl=0, gi, gpi, gw, gh
	if (!Ptr)
		Ptr:=A_PtrSize?"Ptr":"UInt", PtrSize:=A_PtrSize?A_PtrSize:4, AStr:=A_IsUnicode?"AStr":"Str", Module:=DllCall("GetModuleHandle","Str","user32",Ptr), GetParent:=DllCall("GetProcAddress",Ptr,Module,AStr,"GetParent",Ptr), GetWindowInfo:=DllCall("GetProcAddress",Ptr,Module,AStr,"GetWindowInfo",Ptr), SetWindowPos:=DllCall("GetProcAddress",Ptr,Module,AStr,"SetWindowPos",Ptr), RedrawWindow:=DllCall("GetProcAddress",Ptr,Module,AStr,"RedrawWindow",Ptr), cs:=PtrSize+8, gs:=PtrSize+4, VarSetCapacity(c,cs*255,0), VarSetCapacity(g,gs*99,0), VarSetCapacity(gi,60,0), NumPut(60,gi,0,"UInt")
	if !WinExist("ahk_id " ctrl) {
		GuiControlGet, t, Hwnd, %ctrl%
		if (!ErrorLevel)
			ctrl := t
		else
			ControlGet, ctrl, Hwnd, , %ctrl%
	}
	DllCall(GetWindowInfo,Ptr,gp:=DllCall(GetParent,Ptr,ctrl,Ptr),Ptr,&gi,"Int"), giw:=NumGet(gi,28,"Int")-NumGet(gi,20,"Int"), gih:=NumGet(gi,32,"Int")-NumGet(gi,24,"Int")
	if (gp != gpi) {
		gpi := gp
		Loop, %gl% {
			if (NumGet(g,cb:=gs*(A_Index - 1),Ptr)==gp) {
				gw:=NumGet(g,cb+PtrSize,"Short"), gh:=NumGet(g,cb+PtrSize+2,"Short"), gf:=1
				break
			}
		}
		if (!gf)
			NumPut(gp,g,gl,Ptr), NumPut(gw:=giw,g,gl+PtrSize,"Short"), NumPut(gh:=gih,g,gl+PtrSize+2,"Short"), gl+=gs
	}
	ControlGetPos, dx, dy, dw, dh, , ahk_id %ctrl%
	Loop, %cl% {
		if (NumGet(c, cb := cs * (A_Index - 1), Ptr) == ctrl) {
			if (anchor = "") {
				cf = 1
				break
			}
			giw-=gw, gih-=gh, as:=1, dx:=NumGet(c,cb+PtrSize,"Short"), dy:=NumGet(c,cb+PtrSize+2,"Short"), cw:=dw, dw:=NumGet(c,cb+PtrSize+4,"Short"), ch:=dh, dh:=NumGet(c,cb+PtrSize+6,"Short")
			Loop, Parse, anchor, xywh
				if (A_Index > 1)
					av:=SubStr(anchor, as, 1), as+=1+StrLen(A_LoopField), d%av% += (InStr("yh", av) ? gih : giw) * (A_LoopField + 0 ? A_LoopField : 1)
			DllCall(SetWindowPos,Ptr,ctrl,Ptr,0,"Int",dx,"Int",dy,"Int",InStr(anchor,"w") ? dw : cw,"Int",InStr(anchor,"h") ? dh : ch,"UInt",0x0004,"Int")
			if (redraw)
				DllCall(RedrawWindow,Ptr,ctrl,Ptr,0,Ptr,0,"UInt",0x0001 | 0x0100,"Int")
			return
		}
	}
	if (cf != 1)
		cb:=cl, cl+=cs
	bx:=NumGet(gi,48,"UInt"),by:=NumGet(gi,16,"Int") - NumGet(gi,8,"Int") - gih - NumGet(gi,52,"UInt")
	if (cf = 1)
		dw-=giw-gw, dh-=gih-gh
	NumPut(ctrl,c,cb,Ptr), NumPut(dx-bx,c,cb+PtrSize,"Short"), NumPut(dy-by,c,cb+PtrSize+2,"Short"), NumPut(dw,c,cb+PtrSize+4,"Short"), NumPut(dh,c,cb + PtrSize + 6,"Short")
	return, True
}