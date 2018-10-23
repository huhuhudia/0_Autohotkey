#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %a_scriptdir%

Loop
{
	winclose, VirtualBox Headless Frontend
	IfWinNotExist, VirtualBox Headless Frontend
		break
}
Loop
{
	winclose, 天帝宝库
	IfWinNotExist, 天帝宝库
		break
}
Loop
{
	winclose, TDStatus
	IfWinNotExist, TDStatus
		break
}
Run, % a_workingdir "\5-成号模式.ahk"
winwait, 幻剑-成号
sleep 500
ControlClick, X86 Y69, 幻剑-成号, , L, 1
winwait, 天帝宝库
sleep 500
ControlClick, X108 Y209, 天帝宝库, , L, 1
ExitApp
return

