m(t*) {
	opt:=4096, cnt:=0, icons:={x:16,"?":32,"!":48,i:64}, btns:={c:1,oc:1,co:1,ync:3,nyc:3,cyn:3,cny:3,yn:4,ny:4,rc:5,cr:5}
	for c, v in t {
		btn1:=ico1:=ttl1:=""
		if RegExMatch(v, "i)btn:(c|\w{2,3})", btn)||RegExMatch(v, "i)ico:(x|\?|\!|i)", ico)||RegExMatch(v, "i)(?:ttl|title):(.+)", ttl)
			opt+=btn1?btns[btn1]:ico1?icons[ico1]:0, title.=ttl1?ttl1:""
		else
			txt .= (txt ? "`n" : "") (v ? v : "")
	}
	MsgBox, % opt, % title, % txt
	IfMsgBox,OK
		return "OK"
	else IfMsgBox,Yes
		return "YES"
	else IfMsgBox,No
		return "NO"
	else IfMsgBox,Cancel
		return "CANCEL"
	else IfMsgBox,Retry
		return "RETRY"
}