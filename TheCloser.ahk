#NoEnv
#SingleInstance,Force
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%

global config:=new Xml("config", A_AppData "\WSNHapps\TheCloser\config.xml")

if (!config.fileExists)
	Setup()

RegisterHotkeys()
BuildTrayMenu()
return


#Include <Anchor>
#Include <BuildTrayMenu>
#Include <class Settings>
#Include <class Xml>
#Include <CloseWin>
#Include <EditList>
#Include <m>
#Include <Open>
#Include <RegisterHotkeys>
#Include <Setup>
#Include <sn>
#Include <ssn>
#Include lib\AddHotkey.ahk