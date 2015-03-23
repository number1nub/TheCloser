class Settings
{
	__New(info="") {
		this.dir := info.dir ? info.dir : A_ScriptDir
		this.name := info.name ? (RegExMatch(info.name, "\.\w{2,5}$") ? info.name : info.name ".txt") : "winList.txt"
		if (!FileExist(this.path))
			FileAppend, Chrome_WidgetWin_1`nIEFrame`nfirefox`nMozillaWindowClass, % this.path
		Loop, Read, % this.path
			this._winList .= (this._winList ? "," : "") A_LoopReadLine
	}
	
	Path[] {
		get {
			return this.dir "\" this.name
		}
		set {
			return
		}
	}
	
	WinList[] {
		get {
			return this._winList
		}
		set {
			if (InStr(value, "`n"))
				Loop, Parse, value, `n, `r
					csv .= (csv ? "," : "") A_LoopField
			else
				csv := value
			return this._winList := csv
		}
	}
	
	Save() {
		try {
			FileDelete, % this.Path
			list := this.winList
			Loop, Parse, list, CSV
				newTxt .= (newTxt ? "`n" : "") A_LoopField 
			FileAppend, % newTxt, % this.Path
		} catch e {
			m("Something went wrong while trying to save the winList file...", "ico:!")
		}
	}
}