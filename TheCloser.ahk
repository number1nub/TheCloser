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

#Include <Anchor>
#Include <BackupSettings>
#Include <CheckUpdate>
#Include <class Xml>
#Include <CloseWin>
#Include <CMBox>
#Include <ConvertHotkey>
#Include <EditHotkey>
#Include <EditHotkeys>
#Include <EditList>
#Include <Hotkeys>
#Include <m>
#Include <Open>
#Include <RegisterHotkeys>
#Include <Setup>
#Include <sn>
#Include <ssn>
#Include <TrayMenu>
#Include <TrayTip>