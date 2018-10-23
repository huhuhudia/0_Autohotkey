#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
SetWorkingDir %a_scriptdir%
Loop
{
	IfExist, % a_workingdir "\CHjeon\NowGo.id"
		break
	else
		sleep 200
}
settimer, 检测激活窗口, 100
return

检测激活窗口:
Loop
{
	IfWinExist, ahk_class Notepad
		WinClose, ahk_class Notepad
	else
		break
}
IfExist % a_workingdir "\CHjeon\NowGo.id"
{
	wokwintitle := % getL(a_workingdir "\CHjeon\NowGo.id", 1)
	WinActivate, % wokwintitle
	WinMove, % wokwintitle, , , , 998, 578
	sleep 200
}
IfWinNotExist, 天帝宝库
	ExitApp
return

;获取某行字符串
getL(filLP, linenum := 1)
{
	IfExist, % filLP
	{
		Filereadline, caa, % filLP, % linenum
		if caa
			return % caa
		else
			return 0
	}
	else
		return 0
}

