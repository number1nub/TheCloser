#NoEnv
#SingleInstance,Force
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%
CheckAdmin()

global config:=new xml("config", A_AppData "\WSNHapps\TheCloser\config.xml"), altHK:="", AltHKMenuName:="", timeOut:="", version:=";auto_version"
if (!config.fileExists)
	Setup()
CheckUpdate()
RegisterHotkeys()
TrayMenu()
return

DClickToggle() {
	sPath := "//options/@AltHKEnabled"
	config.ssn(sPath).text := config.ea("//options").AltHKEnabled ? 0 : 1
	config.save(1)
	Menu, Tray, % (config.ea("//options").AltHKEnabled ? "Check" : "UnCheck"), %AltHKMenuName%
	Hotkey, %altHK%, DClick, % (config.ea("//options").AltHKEnabled ? "On" : "Off")
}

#Include <Anchor>
#Include <BackupSettings>
#Include <CheckAdmin>
#Include <CheckUpdate>
#Include <class Xml>
#Include <CloseWin>
#Include <CMBox>
#Include <ConvertHotkey>
#Include <DClick>
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