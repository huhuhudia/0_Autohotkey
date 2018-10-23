/*
2018年05月28日
*/

#NoEnv
#Persistent
#SingleInstance force

setworkingdir %a_scriptdir%

topDir := % delStrL(a_workingdir, 7)	;顶部路径
gh = _
yh = "
Gui, Add, Text, x26 y7 w40 h20 , 区号：
Gui, Add, Text, vquhao x66 y7 w60 h20 , None
Gui, Add, Button, gROE x6 y27 w120 h30 , 启     动

Gui, +AlwaysOnTop
gosub, 关闭雷电模拟器及脚本	
gosub, 检查雷电路径
gosub, 删除临时文件
gosub, 检查账号文件

Gui, Show, x1583 y566 h63 w133, 盟主脚本
Return

GuiClose:
ExitApp



删除临时文件:
Del_F(A_WorkingDir "\MZ*.ahk")
loop 12
	Del_F(A_WorkingDir "\7Acc\" A_Index ".acc")
return

ROE:
if !kkkkk {
	kkkkk := 1
	Loop, % a_workingdir "\7Acc\*.acc"
		FileCopy, % a_loopfilelongpath, % a_workingdir "\7Acc\" a_index ".acc"
	FileRead, Smain, % a_workingdir "\GoMZ.ahk"
	loop 6 
		FileAppend, % "sNum := " A_Index "`nwName := % " yh "MZ" yh " sNum`ntName := % " yh "GoMZ" yh " sNum`n`n" Smain, % A_WorkingDir "\MZ" A_Index ".ahk", UTF-8
	sleep 1000
	loop 6 {
		ggg := % A_Index 
		run, % a_workingdir "\MZ" ggg ".ahk"
		sleep 800
		loop {
			if !winexist("GoMZ" ggg)
				break
		}
	}
	settimer, 排列窗口, -12000
}
else
	msgbox, 错误,请勿重复启动脚本`n退出请按Alt + Esc
return

排列窗口:
loop 6 {
	if WinExist("MZ" A_Index) {
		WinActivate, % "MZ" A_Index
		if A_Index = 1
			WinMove, % "MZ" A_Index, , 5, 5
		else
			WinMove, % "MZ" A_Index, , % 5 + (sNum - 1) * 60, % 5 + (sNum - 1) * 15
	}
	Sleep 100
}
settimer, 排列窗口, -12000
return

检查账号文件:
if (!fileexist(a_workingdir "\7Acc\*.acc")) {
	msgbox, 账号文件夹【AccStore】不存在仓库账号`n脚本将退出
	ExitApp
}
loop, % a_workingdir "\7Acc\*.acc"
	nmac := % a_index
if nmac < 6
{
	msgbox, 请保证【7Acc】文件夹中有6个账号文件`n当前脚本无法正常运行`n脚本将退出
	ExitApp
}
loop, % a_workingdir "\7Acc\*.acc"
{
	if a_index = 1
	{
		cl := % A_LoopFileName
		StringGetPos, dd, cl, _
		StringLeft, cl, cl, % dd
		GuiControl, , quhao, % cl
		
	}
	else {
		dl := % A_LoopFileName
		StringGetPos, dd, dl, _
		StringLeft, dl, dl, % dd
		if dl != % cl
		{
			msgbox, 错误！`n账号文件中区号不一致`n脚本无法正常运行`n脚本将退出
			ExitApp
		}
	}
}
return

关闭雷电模拟器及脚本:
Loop 6 ;关闭所有脚本
	winclose, % "GoMZ" A_Index
ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")
return


检查雷电路径:
if (!FileExist(topDir "\PathOfLD_x.path")) {	;检查是否存在雷电模拟器路径文件
	msgbox, 雷电模拟器路径不存在`n请于主控端设置路径`n当前脚本将退出
	ExitApp
	return
}
LdPath := getL(topDir "\PathOfLD_x.path")	;获取雷电模拟器路径
if (!FileExist(LdPath "\dnconsole.exe")) {	;检查是否存在雷电模拟器
	msgbox, 雷电模拟器路径错误`n脚本将无法运行`n请于主控端设置正确路径`n当前脚本将退出。
	ExitApp
	return
}
LdCtrlLP := % LdPath "\dnconsole.exe"
return



Del_F(filLP) { ;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
			FileDelete, % filLP
		IfNotExist, % filLP
			break
	}
}

getL(filLP, linenum := 1) { ;获取某行字符串，无返回0
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

ProExit(proName) { ;关闭所有同名进程  
	loop
	{
		Process, Close, % proName
		sleep 100
		if !errorlevel
			break
	}
}

delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}