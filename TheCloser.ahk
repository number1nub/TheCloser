#NoEnv
#SingleInstance,Force
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%

config:=new Xml("config")
global config	;, s:=new Settings()

if (!config.fileExists) {
	wlist := config.add2("winlist")
	config.under(wlist,"win",{display:"Chrome"},"Chrome_Widget_Win1")
	config.under(wlist,"win",{display:"Internet Explorer"},"IEFrame")
	config.under(wlist,"win",{display:"FireFox"},"MozillaWindowClass")
	config.save(1)
}

config.search()

RegisterHotkeys()
BuildTrayMenu()
return


#Include <BuildTrayMenu>
#Include <class Settings>
#Include <class Xml>
#Include <CloseWin>
#Include <EditList>
#Include <m>
#Include <Open>
#Include <RegisterHotkeys>
#Include <sn>
#Include <ssn>
#Include Anchor.ahk