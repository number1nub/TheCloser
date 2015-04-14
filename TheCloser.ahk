#NoEnv
#SingleInstance,Force
SetWorkingDir, %A_ScriptDir%

global s := new Settings()

RegisterHotkeys()
BuildTrayMenu()
return


#Include <BuildTrayMenu>
#Include <class Settings>
#Include <CloseWin>
#Include <EditList>
#Include <m>
#Include <Open>
#Include <RegisterHotkeys>