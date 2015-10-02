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


#Include <Anchor>
#Include <BackupSettings>
#Include <CheckCredentials>
#Include <CheckUpdate>
#Include <class Xml>
#Include <CloseWin>
#Include <CMBox>
#Include <ConvertHotkey>
#Include <EditHotkey>
#Include <EditHotkeys>
#Include <EditList>
#Include <Hotkeys>
#Include <IgnoreWinManager>
#Include <m>
#Include <MenuAction>
#Include <RegisterHotkeys>
#Include <Setup>
#Include <sn>
#Include <ssn>
#Include <TrayMenu>
#Include <TrayTip>
#Include <WinSelector>