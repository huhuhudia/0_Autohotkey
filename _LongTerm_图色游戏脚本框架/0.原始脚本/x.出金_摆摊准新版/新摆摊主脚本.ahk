/*
2018年05月13日

*/

#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%
yh = "
topDir := % delStrL(a_workingdir, 11)	;顶部路径
toDay := % A_YYYY A_MM A_DD

Gui, Add, Text, x16 y7 w60 h20 , 可用账号：
Gui, Add, Text, x16 y30 w60 h20 , 今日完成：
Gui, Add, Text, x16 y85 w60 h20 , 模式选择：
Gui, Add, Text, x16 y57 w60 h20 , 窗口数目：

;》》》》》》》 主要控件
Gui, Add, Text, vKYZ x76 y7 w50 h20 , 0	;可用账号，即成号	
Gui, Add, Text, vTDD x76 y30 w50 h20 , 0	;今日完成，note行数
Gui, Add, DropDownList, R9 vSMode x76 y82 w100 h20 , DropDownList		;模式选择
Gui, Add, DropDownList, R6 vwinO x76 y54 w53 h20 , DropDownList		;窗口数目
Gui, Add, Button, gROE x126 y6 w50 h39 , 启 动

Gui, +AlwaysOnTop

gosub, 关闭雷电模拟器及脚本	
gosub, 检查雷电路径
gosub, 临时文件删除创建
gosub, 完善诸控件
Gui, Show, x1580 y506 h112 w190, 幻剑摆摊新版

return

ROE:
roo := !roo
if roo {
	gosub, 关闭雷电模拟器及脚本	
	Del_F(A_WorkingDir "\BT*.ahk")	;删除残留临时子脚本
	;gui控件读取保存,窗口数目与精华
	Del_F(A_WorkingDir "\Go.cho")
	guiCGt(SMode)	;模式
	guiCGt(winO)	;窗口数目
	FileAppend, % SMode "`n" winO, % A_WorkingDir "\Go.cho", UTF-8
	FileRead, Smain, % a_workingdir "\GoBTx.ahk"	;读取主脚本内容
	gosub, 复制成号
	
	loop, %winO%
	{
		Snum := % A_Index
		FileAppend, % "SMode := % " yh SMode yh "`nSnum := " Snum "`nWkiWin := % " yh "BT" Snum yh "`nTisWin := % " yh "GoBT" Snum yh "`n" Smain, % A_WorkingDir "\BT" A_Index ".ahk", UTF-8 
	}
	Sleep 300
	Loop, %winO%
	{
		aind := % A_Index
		Run, % A_WorkingDir "\BT" A_Index ".ahk"
		WinWait, % "GoBT" aind
		Loop {
			if !WinExist("GoBT" aind)
				break
		}
	}
	SetTimer, 检查所有窗口, -5000
}
return

复制成号:

Loop, % topDir "\3-成号\*.acc"
{	
	yuShu := % Mod(a_index, winO)
	if yuShu
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\Acc\" yuShu "\*.*", 1
	else
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\Acc\" winO "\*.*", 1
}
loop, read, % A_WORKINGDIR "\note\" toDay ".note"
{
	Alprdl := % A_LoopReadLine
	Loop, % a_workingdir "\Acc\*.acc", 0, 1
	{
		if Alprdl = % A_LoopFileName
			Del_F(A_LoopFileLongPath)
	}
}
return


检查所有窗口:
loop 4 {
	if winexist("BT" A_Index) {
		WinActivate, % "BT" A_Index
		if a_index = 1
			WinMove, % "BT" A_Index, , 1, 1
		else if a_index = 2
			WinMove, % "BT" A_Index, , 550, 1
		else if a_index = 3	
			WinMove, % "BT" A_Index, , 1, 455
		else if a_index = 4
			WinMove, % "BT" A_Index, , 550, 455
	}
}
gl := % gFLineN(a_workingdir "\note\" A_YYYY A_MM A_DD ".note")	;检测文件所有行数
if gl >= 2 
	GuiControl, , TDD, % gl - 1
SetTimer, 检查所有窗口, -10000
return




完善诸控件:
if !fileexist(A_WorkingDir "\Go.cho") {
	GuiControl, , SMode, |小精华||猎手|小檀|后羿|牛魔|嫦娥|无差别	;此处为模式选择
	GuiControl, , winO,	|1|2|3||4| ;此处为窗口数目
}
else {
	GMod := % getL(A_WorkingDir "\Go.cho")
	GWin := % getL(A_WorkingDir "\Go.cho", 2)
	GuiControl, , SMode, |小精华|猎手|小檀|后羿|牛魔|嫦娥|无差别  
	GuiControl, , SMode, % GMod "||"
	GuiControl, , winO,	|1|2|3|4  ;此处为窗口数目
	GuiControl, , winO, % GWin "||"
	
}
if !FILEEXIST(topDir "\3-成号\*.acc") {
	msgbox, 当前不存在成号`n脚本将退出
	ExitApp
}
else {
	loop, % topDir "\3-成号\*.acc"
		NOAcc := % A_Index
	GuiControl, , KYZ, % NOAcc
}
if fileexist(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note") {
	loop, read, % A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note"
		LOI := % A_Index - 1
	if LOI
		GuiControl, , TDD, % LOI ;此为今日完成
}
return

关闭雷电模拟器及脚本:
Loop 4 ;关闭所有脚本
	winclose, % "GoBT" A_Index
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

临时文件删除创建:
Del_F(A_WorkingDir "\BT*.ahk")	;删除残留临时子脚本

Cr_EmpFod(a_workingdir "\note")
Cr_EmpFod(a_workingdir "\Acc")
loop 4 
	Cr_EmpFod(a_workingdir "\Acc\" A_Index)

Loop, % a_workingdir "\note\*.note"	;删除过期日志文件
{
	if a_loopfilename = % a_yyyy a_mm a_dd ".note"
		Del_F(a_loopfilename)
}
if !fileexist(a_workingdir "\note\" a_yyyy a_mm a_dd ".note")	;创建临时日志文件
	Cr_EmpFil(A_WorkingDir "\note\" a_yyyy a_mm a_dd ".note")
loop, % a_workingdir "\Acc\*.acc", 0, 1
	Del_F(A_LoopFileLongPath)
return



;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     必要函数
delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}

Cr_EmpFod(fodLP) { ;创建空白  文件夹  ，若存在文件夹，则不动作
	IfNotExist, % fodLP
	{
		FileCreateDir, % fodLP
		Loop {
			IfExist, % fodLP
				Break
			Else
				Sleep 10
		}
	}
}

ProExit(proName) { ;关闭所有同名进程  
	loop {
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

guiCGt(ByRef Gvar) {	;将GUI控件保存至唯一参数，即gui变量名
	GuiControlGet, Gvar, , Gvar
}


Cr_EmpFil(filLP) { ;创建空白  文件  ,若存在文件，不动作
	IfNotExist, % filLP
	{
		FileAppend, , % filLP
		Loop {
			IfExist % filLP
				break
			sleep 20
		}
	}
}

gFLineN(filLP) {	;获取文件行数
	loop, read, % filLP
		linen := % A_Index
	return % linen
}
