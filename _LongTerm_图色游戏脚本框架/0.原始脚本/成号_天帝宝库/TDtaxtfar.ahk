#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
SetWorkingDir %a_scriptdir%
CoordMode, tooltip, screen
SetTimer, TDText, 10
return

TDText:
IfWinExist, VirtualBox Headless Frontend
	run, % a_workingdir "\TDreload.ahk"
IfWinExist, TDStatus
	gosub, existText
else
	gosub, notexistText
gosub, 所有账号工作完成检测
return

existText:	;窗口存在时间检测
fartime := % A_Now
Loop
{
	IfWinNotExist, TDStatus
		break
	else
	{
		ToolTip, % "main窗口显示时间：" overT(fartime), 137, 937
		if overT(fartime) >= 300
			run, % a_workingdir "\TDreload.ahk"
	}
	IfWinNotExist, ahk_class LDPlayerMainFrame
	{
		ExitApp
		return
	}
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	gosub, 所有账号工作完成检测
	sleep 15
}

return

notexistText:
fartime := % A_Now
Loop
{
	IfWinExist, TDStatus
		break
	else
	{
		ToolTip, % "main窗口消失时间：" overT(fartime), 137, 937
		if overT(fartime) >= 50
			run, % a_workingdir "\TDreload.ahk"
	}
	IfWinNotExist, ahk_class LDPlayerMainFrame
	{
		ExitApp
		return
	}
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	gosub, 所有账号工作完成检测
	sleep 15
}
return

overT(ByRef startTime, unit := "S")	;当前时间减去初始时间
{
	nowtime := % A_Now
	EnvSub, nowtime, % startTime, % unit
	return % nowtime
}

所有账号工作完成检测:
IfWinNotExist, 天帝宝库
{
	Loop
	{
		IfExist, % a_workingdir "\note\" a_yyyy a_mm a_dd ".note"
		{
			
			nextday0 := % A_YYYY A_MM A_DD 000000
			EnvAdd, nextday0, 86400, S	
			EnvSub, nextday0, % A_Now, S
			ToolTip, % nextday0 "秒后将重启脚本", 137, 937
		}
		IfNotExist, % a_workingdir "\note\" a_yyyy a_mm a_dd ".note"
		{
			run, % a_workingdir "\TDreload.ahk"
			ExitApp
			break
			return
		}
		IfWinNotExist, ahk_class LDPlayerMainFrame
			ExitApp
	}
}
return



