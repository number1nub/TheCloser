#NoEnv
#SingleInstance,Force
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%
global config:=new Xml("config",A_AppData "\WSNHapps\TheCloser\config.xml")
if (!config.fileExists)
	Setup()
TrayMenu()
CheckUpdate()
RegisterHotkeys()
return

#Include <AddHotkey>
#Include <Anchor>
#Include <CheckUpdate>
#Include <class Xml>
#Include <CloseWin>
#Include <ConvertHotkey>
#Include <EditList>
#Include <m>
#Include <Open>
#Include <RegisterHotkeys>
#Include <Setup>
#Include <sn>
#Include <ssn>
#Include <TrayMenu>
#Include <TrayTip>