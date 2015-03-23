#NoEnv
#SingleInstance,Force
SetWorkingDir, %A_ScriptDir%

global s := new Settings({name: "winList.txt"})

RegisterHotkeys()
BuildTrayMenu()
return


#Include class Settings.ahk
#Include BuildTrayMenu.ahk
#Include EditList.ahk
#Include Open.ahk
#Include RegisterHotkeys.ahk
#Include CloseWin.ahk
#Include m.ahk