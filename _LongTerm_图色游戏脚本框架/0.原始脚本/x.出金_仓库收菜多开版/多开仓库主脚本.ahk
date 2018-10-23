/*
2018年05月13日

*/

#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%
yh = "
topDir := % delStrL(a_workingdir, 13)	;顶部路径

{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     不变文本控件
Gui, Add, Text, x16 y10 w170 h16 , 请选择仓库账号：
Gui, Add, Text, x16 y269 w30 h16 , 窗1:
Gui, Add, Text, x16 y289 w30 h16 , 窗2:
Gui, Add, Text, x16 y309 w30 h16 , 窗3:
Gui, Add, Text, x16 y329 w30 h16 , 窗4:

}

{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     主要控件
Gui, Add, Text, vworkAcc1 x46 y269 w118 h16 , 0	;工作账号1
Gui, Add, Text, vworkAcc2 x46 y289 w118 h16 , 0	;工作账号2
Gui, Add, Text, vworkAcc3 x46 y309 w118 h16 , 0	;工作账号3
Gui, Add, Text, vworkAcc4 x46 y329 w118 h16 , 0	;工作账号4

Gui, Add, Button, gdelWin1 x166 y267 w20 h18 , -	;窗1账号删除
Gui, Add, Button, gdelWin2 x166 y287 w20 h18 , -	;窗2账号删除
Gui, Add, Button, gdelWin3 x166 y307 w20 h18 , -	;窗3账号删除
Gui, Add, Button, gdelWin4 x166 y327 w20 h18 , -	;窗4账号删除

Gui, Add, ListBox, gLBmainx vLBmain x16 y27 w170 h240 , AccList	;列表

Gui, Add, Button, gROE x16 y352 w170 h30 , 启     动

}

{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先启动
gosub, 关闭雷电模拟器及脚本	
gosub, 检查雷电路径
gosub, 删除临时文件
gosub, 检查账号文件
gosub, 完善诸控件
Gui, Show, x1681 y220 h395 w200, 仓库收菜多开版
}
Return

/*
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     确定变量备注
LdCtrlLP := % LdPath "\dnconsole.exe"	;雷电控制器长路径

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     临时路径备注
% A_WorkingDir "\nWork*.job"		工作账号临时文件
% A_WorkingDir "\ST*.ahk"		临时脚本
% A_workingdir "\AccStore\*.acc"	仓库账号文件

*/

GuiClose:
ExitApp

完善诸控件:
GuiControl, , LBmain, |
loop, % A_workingdir "\AccStore\*.acc"
	GuiControl, , LBmain, % A_LoopFileName
return

LBmainx:
if a_guievent = % "DoubleClick"
{
	guiCGt(LBmain)
	if !LBmain
		return
	if ((LBmain = guiCGtRT(workAcc1)) 
	or (LBmain = guiCGtRT(workAcc2)) 
	or (LBmain = guiCGtRT(workAcc3)) 
	or (LBmain = guiCGtRT(workAcc4))) {
		msgbox, 该账号已被选择
		return
	}
	if (!guiCGtRT(workAcc1)) {
		guiChan(LBmain, workAcc1)
		return
	}
	if (!guiCGtRT(workAcc2)) {
		guiChan(LBmain, workAcc2)
		return
	}
	if (!guiCGtRT(workAcc3)) {
		guiChan(LBmain, workAcc3)
		return
	}
	if (!guiCGtRT(workAcc4)) {
		guiChan(LBmain, workAcc4)
		return
	}
	if guiCGtRT(workAcc4) {
		msgbox, 至多选择4个账号`n按减号可以选择删除工作账号
		return
	}
}
return

ROE:	;启动脚本
ROE := !ROE
if ROE
{
	if !guiCGtRT(workAcc1) {
		ROE :=
		msgbox, 错误！未选择账号文件
		return
	}
	TrayTip, , 脚本启动
	Del_F(A_WorkingDir "\ST*.ahk")
	
	
	if guiCGtRT(workAcc4) {	; 4位
		loopN := 4
		gosub, 启动脚本
		return
	}
	if guiCGtRT(workAcc3) {	; 3位
		loopN := 3
		gosub, 启动脚本
		return		
	}
	if guiCGtRT(workAcc2) {	; 2位
		loopN := 2
		gosub, 启动脚本
		return		
	}
	if guiCGtRT(workAcc1) {	; 1位
		loopN := 1
		gosub, 启动脚本
		return		
	}
	
}
else {
	loop 4 
		winclose, % "GoST" A_Index
}
return

启动脚本:
SNum := 1
WorkWinN := % "ST" SNum
ThisWinN := % "GoST" SNum

fileread, mainS, % A_WorkingDir "\GoSTx.ahk"	;脚本主要内容，置于最后
Loop %loopN%
{
	if a_index = 1
		ngoacname := %  guiCGtRT(workAcc1)
	else if a_index = 2
		ngoacname := %  guiCGtRT(workAcc2)
	else if a_index = 3
		ngoacname := %  guiCGtRT(workAcc3)
	else if a_index = 4
		ngoacname := %  guiCGtRT(workAcc4)
	FileRead, GOTAC, % A_WorkingDir "\AccStore\" ngoacname
	FileAppend, % GOTAC, % A_WORKINGDIR "\nWork" A_Index ".job", UTF-8
	FileAppend, % "SNum := " A_Index "`nWorkWinN := `% " yh "ST" yh " SNum`nThisWinN := `% " yh "GoST" yh " SNum`n" mainS, % A_WORKINGDIR "\ST" A_Index ".ahk", UTF-8
	Sleep 100
}
Loop %loopN%
{
	run, % a_workingdir "\ST" A_Index ".ahk"
	WinWait, % "GoST" A_Index
	Sleep 200
	ggggg := % A_Index
	Loop {
		If !WINEXIST("GoST" ggggg)
			break
	}
}
SetTimer, 重复检查窗口, -10000
return

重复检查窗口:
loop 4 {
	if winexist("ST" A_Index) {
		WinActivate, % "ST" A_Index
		if a_index = 1
			WinMove, % "ST" A_Index, , 1, 1
		else if a_index = 2
			WinMove, % "ST" A_Index, , 550, 1
		else if a_index = 3	
			WinMove, % "ST" A_Index, , 1, 455
		else if a_index = 4
			WinMove, % "ST" A_Index, , 550, 455
	}
}
SetTimer, 重复检查窗口, -10000
return


关闭雷电模拟器及脚本:
Loop 10 ;关闭所有脚本
	winclose, % "GoST" A_Index
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

删除临时文件:
Del_F(A_WorkingDir "\ST*.ahk")
Del_F(A_WorkingDir "\nWork*.job")
return

检查账号文件:
if (!fileexist(a_workingdir "\AccStore\*.acc")) {
	msgbox, 账号文件夹【AccStore】不存在仓库账号`n脚本将退出
	ExitApp
}
return

!1::
if fileexist(A_WorkingDir "\ST1.ahk") {
	msgbox, 257, 提示, 是否重启1号子脚本？
	IfMsgBox Yes
		run, % A_WorkingDir "\ST1.ahk"
}
else
	MsgBox, 错误，1号子脚本不存在
return

!2::
if fileexist(A_WorkingDir "\ST2.ahk") {
	msgbox, 257, 提示, 是否重启2号子脚本？
	IfMsgBox Yes
		run, % A_WorkingDir "\ST2.ahk"
}
else
	MsgBox, 错误，2号子脚本不存在
return

!3::
if fileexist(A_WorkingDir "\ST3.ahk") {
	msgbox, 257, 提示, 是否重启3号子脚本？
	IfMsgBox Yes
		run, % A_WorkingDir "\ST3.ahk"
}
else
	MsgBox, 错误，3号子脚本不存在
return

!4::
if fileexist(A_WorkingDir "\ST4.ahk") {
	msgbox, 257, 提示, 是否重启3号子脚本？
	IfMsgBox Yes
		run, % A_WorkingDir "\ST4.ahk"
}
else
	MsgBox, 错误，4号子脚本不存在
return


delWin1:	; 1=2 ，2=3 , 3=4 , 4=0
guicontrol, , workAcc1, % guiCGtRT(workAcc2)
guicontrol, , workAcc2, % guiCGtRT(workAcc3)
guicontrol, , workAcc3, % guiCGtRT(workAcc4)
guicontrol, , workAcc4, 0
return

delWin2:	; 2=3 ，3=4 ，4= 0
guicontrol, , workAcc2, % guiCGtRT(workAcc3)
guicontrol, , workAcc3, % guiCGtRT(workAcc4)
guicontrol, , workAcc4, 0
return

delWin3:	; 3=4，4=0
guicontrol, , workAcc3, % guiCGtRT(workAcc4)
guicontrol, , workAcc4, 0
return

delWin4:	; 4=0
guicontrol, , workAcc4, 0
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     必要函数
delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
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

guiCGt(ByRef Gvar) {	;将GUI控件保存至唯一参数，即gui变量名
	GuiControlGet, Gvar, , Gvar
}

guiCGtRT(ByRef Gvar) {	;将GUI控件保存至唯一参数，返回该变量
	GuiControlGet, Gvar, , Gvar
	return, % Gvar
}


Del_F(filLP) { ;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}
}

guiChan(newtex, ByRef gVar) { ;GUI改变文本函数，若为选择型控件，newText可为0或1
	GuiControl, , gVar, % newtex
}

