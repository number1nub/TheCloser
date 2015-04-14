class Settings
{
	static defaults:="Chrome_WidgetWin_1,IEFrame,MozillaWindowClass"	
	
	__New(info="") {
		this.dir := info.dir ? info.dir : A_ScriptDir
		this.name := info.name ? info.name : "winList.txt"
		this.Load()
	}
	
	Path {
		get {
			return Format("{1}\{2}",RegExReplace(this.dir,"\\$"),this.name)
		}
		set {
			return	;Disable setting Path directly
		}
	}
	
	WinList{
		get {
			return this._winList
		}
		set {
			if (!value)
				return
			bak:=this._winList, this._winList:="", tmp:=""	;, this.list:=[]
			if (IsObject(value)) {
				for c, v in value
					tmp .= (tmp ? "," : "") v
			}
			else if (InStr(value, "`n")) {
				Loop, Parse, value, `n, `r
				{
					tmp.=(tmp ? "," : "") A_LoopField
				}
			}
			else if (InStr(value, ",") || value.len>1) {
				tmp := value
			}
			else {
				this._winList:=bak
				return m("Invalid assignment value for winList.","ico:!")
			}
			return this._winList := tmp
		}
	}
	
	List {
		get {
			return this.ToArray(this._winList)
		}
		set {
			return	;Disable setting List directly
		}
	}
	
	KeyList {
		get {
			return this.ToArray(this._winList, "CSV", 1)
		}
		set {
			return	;Disable setting KeyList directly
		}
	}
	
	Remove(win) {
		if not win is number
			win := this.KeyList[win]
		tmp:=this.List, tmp.Delete(win)
		return this.WinList:=tmp
	}
	
	ToArray(str, delim:="CSV", asKey:="") {
		retVal:=[]
		if (IsObject(str))
			return str
		Loop, Parse, str, %delim%, "`r"
			retVal[(asKey ? A_LoopField : A_Index)] := asKey ? A_Index : A_LoopField		
		return retVal
	}
	
	Load() {
		this._winList:="", tmp:=""
		Loop, Read, % this.path
			tmp.=(tmp?",":"") A_LoopReadLine
		this._winList := tmp ? tmp : Settings.defaults
	}
	
	Save(path="", backup="") {
		newTxt:="", outPath:=path?path:this.path
		SplitPath, outPath, outName, outDir
		try {
			if (FileExist(outPath)) {
				if (backup)
					FileMove, % outPath, % outPath ".bak", 1
				else
					FileDelete, % outPath
			}
			else if (!FileExist(outDir))
				FileCreateDir, % outDir
			for c, v in this.list
				newTxt .= (newTxt ? "`n" : "") v
			FileAppend, %newTxt%, % outPath
		}
		catch e
			m("Something went wrong while trying to save the winList file...", "ico:!")
	}
}