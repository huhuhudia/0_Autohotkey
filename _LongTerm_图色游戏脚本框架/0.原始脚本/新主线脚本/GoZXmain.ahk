/*
2018年04月25日
*/

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先声明  
#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%
IfNotExist, % A_WORKINGDIR "\note"
	FileCreateDir, % a_workingdir "\note"
yinhao = "
ToFoPa := % delStrL(a_workingdir, 6)	;设置顶上主文件夹下路径
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     不改变文本  
Gui, Add, Text, x6 y7 w60 h20 , 主线号数：
Gui, Add, Text, x26 y37 w50 h20 , 窗口数：
Gui, Add, Text, x96 y7 w60 h20 , 今日完成：

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     主要GUI控件  

Gui, Add, Text, vZXhaoS x66 y7 w30 h20 , 0	;主线号数
Gui, Add, Text, vtoDayDone x156 y7 w40 h20 , 0	;今日完成
Gui, Add, DropDownList, R15 vwinNum x76 y34 w90 h20 , 1	;窗口数
Gui, Add, Button, grunZX x26 y67 w150 h30 , 启   动

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先启动  
gosub, NLMAKE
gosub, 查询可用主线账号数量
gosub, 删除临时账号文件
gosub, 删除多余日志文件
gosub, 检查雷电多开器
gosub, 关闭所有现行模拟器
gosub, 删除zx临时文件
gosub, 完善窗口数列表

Gui, Show, x1551 y500 h113 w201, 幻剑主线脚本
Return

GuiClose:
gosub, NLMAKE
ExitApp



;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     主要脚本  

runZX:	;此为启动按钮
roe := !roe
if roe {
	settimer, 窗口调整, 30000
	Del_F(A_WorkingDir "\NowgoZX*.log")	;登录临时文件
	if !ggg
		ggg := 1
	else
		ggg := % ggg + 1
	if ggg = 1
		gosub, 转移账号至临时文件夹
	Del_F(a_workingdir "\ZX*.ahk")
	run, % LdPath "\dnmultiplayer.exe"	;启动多开器
	WinWait, ahk_class LDMultiPlayerMainFrame	;等待多开器启动
	
	SLEEP 1000
	GuiControlGet, winNum, , winNum
	Cr_AfterDel(winNum, A_WorkingDir "\GoZX.cho")	;创建选择窗口文件
	loop %winNum% {
		FileRead, mainFileZX, % a_workingdir "\GoZX.ahk"
		FileAppend, % "gotthenum `:`= " A_Index "`n" "winName `:`= `% " yinhao "ZX" yinhao " gotthenum`n" mainFileZX, % A_WorkingDir "\ZX" A_Index ".ahk", UTF-8
		sleep 1000
		run, % A_WorkingDir "\ZX" A_Index ".ahk"
		sleep 1000
		dl := % A_Index
		loop {
			gosub, 检测无用弹窗及查询完成情况
			sleep 500
			if !winexist("DlZX" dl)
				break
		}
		Sleep 500
	}
}
else {
	Del_F(A_WorkingDir "\NowgoZX*.log")	;登录临时文件
	WinClose, Ctrl助手
	loop 12
		WinClose, % "DlZX" a_index
	loop 12
		WinClose, % "GoZX" a_index
}
settimer, 检测无用弹窗及查询完成情况, 500
return


检测无用弹窗及查询完成情况:
IfWinExist, ahk_class #32770
	ControlClick, x265 y447, ahk_class #32770
return


转移账号至临时文件夹:
GuiControlGet, winNum, , winNum
Loop, % ToFoPa "\1-主线\*.acc"
{	
	yuShu := % Mod(a_index, winNum)
	if yuShu
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" yuShu "\*.*", 1
	else
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" winNum "\*.*", 1
}
return

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     有关按钮及首先启动续  
检查雷电多开器:
if (!FileExist(ToFoPa "\PathOfLD_x.path")) {	;检查是否存在雷电模拟器路径文件
	msgbox, 雷电模拟器路径不存在`n请于主控端设置路径`n当前脚本将退出
	ExitApp
	return
}
LdPath := getL(ToFoPa "\PathOfLD_x.path")	;获取雷电模拟器路径
if (!FileExist(LdPath "\dnmultiplayer.exe")) {	;检查是否存在雷电模拟器
	msgbox, 雷电模拟器路径错误`n脚本将无法运行`n请于主控端设置正确路径`n当前脚本将退出。
	ExitApp
	return
}
return

查询可用主线账号数量:
loop, % ToFoPa "\1-主线\*.acc"
	noacgn := % A_Index
GuiControl, , ZXhaoS, % noacgn
loop, read, % a_workingdir "\" a_yyyy a_mm a_dd ".note"
	godone := % A_Index
if godone
	GuiControl, , toDayDone, % godone
return

删除临时账号文件:
Loop, % a_workingdir "\WorkAcc\*.acc", 1, 1
	Del_F(A_LoopFileLongPath)
return

关闭所有现行模拟器:	;  关闭四个雷电进程  
ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")
return

删除zx临时文件:
Del_F(a_workingdir "\ZX*.ahk")
return

删除多余日志文件:
today := % A_YYYY A_MM A_DD
loop, % A_WORKINGDIR "\*.note"
{
	godate := % delStrL(A_LoopFileName, 5)
	if godate != % today
		Del_F(A_LoopFileLongPath)
}
Del_F(A_WorkingDir "\NowgoZX*.log")	;登录临时文件
Cr_EmpFil(a_workingdir "\" today ".note")
return

完善窗口数列表:
if fileexist(a_workingdir "\GoZX.cho")
	Choosed := % getL(a_workingdir "\GoZX.cho")
loop 12 {
	IF A_INDEX = 1 
		GuiControl, , winNum, |1 
	else if A_INDEX = % Choosed
		GuiControl, , winNum, % A_Index "||"
	else
		GuiControl, , winNum, % A_Index
}
return

$NumLock::	;暂停脚本，关闭子脚本
gosub, NLMAKE
return

窗口调整:
if fileexist(a_workingdir "\note\" a_yyyy a_mm a_dd ".note")
{
	Loop, read, % a_workingdir "\note\" a_yyyy a_mm a_dd ".note" 
		godonenumaccc := % A_Index
	IF godonenumaccc
		GuiControl, , toDayDone, % godonenumaccc
}
else
	FileAppend, , % a_workingdir "\note\" a_yyyy a_mm a_dd ".note", UTF-8
loop, % ToFoPa "\1-主线\*.acc"
	dlaaaaa := % A_Index
if dlaaaaa
	GuiControl, ,ZXhaoS, % dlaaaaa
WinActivate, 幻剑主线脚本
winmove, ahk_class LDMultiPlayerMainFrame, , 966, 30
Loop 12
{
	if winexist("ZX" A_INDEX) {
		WinMove, % "ZX" A_INDEX, , % 2 + (gotthenum - 1) * 50, 10
		WinActivate, % "ZX" A_INDEX
		WinActivate, % "GoZX" A_INDEX "x"
		Sleep 1000
	}
}

return


NLMAKE:
settimer, 窗口调整, Off
WinClose, Ctrl助手
loop 12
	WinClose, % "DlZX" a_index
loop 12
	WinClose, % "GoZX" a_index
return

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     函数  
;删除文件直到区确定无该文件
Del_F(filLP) {
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}
}
;删除字符串后几位  
delStrL(inputvar,countx := 0) {
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
;获取文件首行字符串
getL(filLP, linenum := 1) {
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
;空白文本创建,若存在文件，不动作
Cr_EmpFil(filLP)
{
	IfNotExist, % filLP
	{
		FileAppend, , % filLP
		Loop
		{
			IfExist % filLP
				break
			sleep 20
		}
	}
}

;创建文件前删除该文件确认后写入首行文本，确认首行文本后完成
Cr_AfterDel(tex, filLP)
{
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
		{
			break
		}
	}	
	FileAppend, % tex, % filLP ,UTF-8
	Loop
	{
		IfNotExist, % filLP	
			Sleep 10
		Else 
		break
	}
	Loop
	{	
		FileReadLine, caa, % filLP, 1
		if caa = % tex
			break
	}
}	