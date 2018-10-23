#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
WinSet, alwaysontop, on ,幻剑收菜辅助
settimer, 检测辅助是否存在及窗口是否激活状态, 10
return

检测辅助是否存在及窗口是否激活状态:

Loop
{
	IfWinNotExist, 幻剑收菜辅助
	{
		ExitApp
		return
	}
	IfNotExist, % a_workingdir "\go.go"
		sleep 50
	else
		break
}
IfWinNotActive, AccStore
	WinActivate, AccStore
return