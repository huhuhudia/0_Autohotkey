#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
setworkingdir %a_scriptdir%
settimer, 窗口检测, 10
return

窗口检测:
Loop {	;当工作文件及相关窗口存在时，才进行工作
	sleep 10
	if (fileexist(a_workingdir "\go.go") and WinExist("ZCX"))
		break
	if (!winexist("幻剑创建账号脚本")) {
		ExitApp
		return
	}
}
WinActivate, ZCX
WinMove, ZCX, , 100, 100, 998, 578
return