#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
setworkingdir %a_scriptdir%
ToFoPa := % delStrL(a_workingdir, 6)
ProExit("AutoHotkey.exe")
run, % ToFoPa "\0.新主控端.ahk"
run, % a_workingdir "\GoRCmain.ahk"
WinWait, 幻剑日常主脚本
sleep 500
ControlClick, x118 y160, 幻剑日常主脚本
return


ProExit(proName)
{
	loop
	{
		Process, Close, % proName
		sleep 100
		if !errorlevel
		{
			break
		}
	}
}

delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}