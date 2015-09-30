#NoEnv
#SingleInstance,Force
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%
CheckCredentials()

global config:=new xml("config", A_AppData "\WSNHapps\TheCloser\config.xml")
if (!config.fileExists)
	Setup()
TrayMenu()
CheckUpdate()
RegisterHotkeys()
return


#Include Lib\Anchor.ahk
#Include lib\BackupSettings.ahk
#Include lib\CheckCredentials.ahk
#Include lib\CheckUpdate.ahk
#Include lib\class Xml.ahk
#Include lib\CloseWin.ahk
#Include lib\CMBox.ahk
#Include lib\ConvertHotkey.ahk
#Include lib\EditHotkey.ahk
#Include lib\EditHotkeys.ahk
#Include lib\EditList.ahk
#Include lib\Hotkeys.ahk
#Include lib\IgnoreWinManager.ahk
#Include lib\m.ahk
#Include lib\MenuAction.ahk
#Include lib\RegisterHotkeys.ahk
#Include lib\Setup.ahk
#Include lib\sn.ahk
#Include lib\ssn.ahk
#Include lib\TrayMenu.ahk
#Include lib\TrayTip.ahk
#Include lib\WinSelector.ahk