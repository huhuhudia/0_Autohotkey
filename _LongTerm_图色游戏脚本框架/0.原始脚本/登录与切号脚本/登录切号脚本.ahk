/*
2018年05月29日
*/
#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%
topDir := % delStrL(a_workingdir, 8)	;顶部路径

yh = "

Gui, Add, Text, x6 y7 w60 h16 , 成品号数：
Gui, Add, Text, x6 y71 w60 h18 , 变身号数：

Gui, Add, Text, x6 y27 w60 h16 , 累计切号：

Gui, Add, Text, vljqh x66 y27 w50 h16 , 0	;累计切号
Gui, Add, Text, vCOUD x66 y7 w50 h16 , 0	;可用账号


Gui, Add, Text, vBSHS x66 y71 w50 h18 , 0		;变身号数


Gui, Add, CheckBox, vXQBF x6 y105 w110 h30 , 仅到达选区部分

Gui, Add, CheckBox, g变身账号选择 vBSZHXZ x6 y87 w110 h20 , 引用变身账号

Gui, Add, CheckBox,  vYBQ x6 y135 w110 h16 , 元宝低于2600切


Gui, Add, Button, gROE x6 y47 w50 h20 , 启 动
Gui, Add, Button, gQHN x66 y47 w50 h20 , 切 号

Gui, +AlwaysOnTop
gosub, 删除临时账号
gosub, 关闭雷电模拟器及脚本
gosub, 查询账号
gosub, 检查雷电路径
gosub, 创建临时工作文件夹


Gui, Show, x1580 y505 h160 w124, 登录切号
Return

变身账号选择:
GuiControlGet, BSZHXZ, , BSZHXZ
if (BSZHXZ) {
	if !fileexist(topDir "\8-变身\*.acc") {
		msgbox, 当前不存在变身账号`n该选项无法选择
		GuiControl, ,BSZHXZ, 0
	}
}
else {
	if !fileexist(topDir "\3-成号\*.acc") {
		msgbox, 当前不存在成号`n该选项无法选择
		GuiControl, ,BSZHXZ, 1
	}
}
return

GuiClose:
ExitApp

删除临时账号:
loop, % A_WorkingDir "\Acc\*.acc", 0, 1
	Del_F(A_LoopFileLongPath)
Del_F(A_WorkingDir "\QH*.ahk")
return

转移成号至临时文件夹:
guicontrolget, BSZHXZ, , BSZHXZ
if !BSZHXZ
{
	Loop, % topDir "\3-成号\*.acc"
	{	
		yuShu := % Mod(a_index, 6)
		if yuShu
			FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\Acc\" yuShu "\*.*", 1
		else
			FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\Acc\6\*.*", 1
	}
}
else
{
	Loop, % topDir "\8-变身\*.acc"
	{	
		yuShu := % Mod(a_index, 6)
		if yuShu
			FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\Acc\" yuShu "\*.*", 1
		else
			FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\Acc\6\*.*", 1
	}	
}

toDay := % A_YYYY A_MM A_DD
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

ROE:
if !daa
{
	GuiControlGet, YBQ, , YBQ
	if YBQ
		FileAppend, , % A_workingdir "\ybq.ddd"
	else
		FileDelete, % A_workingdir "\ybq.ddd"
	GuiControlGet, XQBF, , XQBF
	gosub, 转移成号至临时文件夹
	
	
	daa := 1
	FileRead, Smain, % A_WorkingDir "\GoQH.ahk"
	loop 6
		FileAppend, % "sNum := " A_Index "`nwName := % " yh "QH" yh " sNum`ntName := % " yh "GoQH" yh " sNum`nXQBF := " XQBF "`n`n"Smain, % A_WorkingDir "\QH" A_Index ".ahk", UTF-8
	sleep 1000
	loop 6 {
		ggg := % A_Index 
		run, % a_workingdir "\QH" ggg ".ahk"
		sleep 800
		loop {
			if !winexist("GoQH" ggg)
				break
		}
	}
}
else
	TrayTip, , 脚本已运行`n请勿重复启动脚本
return

QHN:
GuiControlGet, YBQ, , YBQ
if !YBQ
	FileDelete, % A_workingdir "\ybq.ddd"
QDD := 
loop, READ, % A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note"
	QDD := % A_Index
GuiControl, , ljqh, % QDD
loop 6
{
	if !winexist("GoQH" a_index)
		run, % a_workingdir "\QH" A_Index ".ahk"
	sleep 500
}
return

创建临时工作文件夹:
IfNotExist, % a_workingdir "\Acc"
	FileCreateDir, % a_workingdir "\Acc"
loop {
	IfExist, % a_workingdir "\Acc"
		break
}
loop 6 {
	IfNotExist, % a_workingdir "\Acc\" A_Index
		FileCreateDir, % a_workingdir "\Acc\" A_Index
}
IfNotExist, % a_workingdir "\note"
	FileCreateDir, % a_workingdir "\note"
IfNotExist, % a_workingdir "\note\" A_YYYY A_MM A_DD ".note"
	FileAppend, , % a_workingdir "\note\" A_YYYY A_MM A_DD ".note"
sleep 200
return

关闭雷电模拟器及脚本:
Loop 6 ;关闭所有脚本
	winclose, % "GOQH" A_Index
ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")
return

查询账号:
loop, % topDir "\3-成号\*.acc"
	cl := % A_Index
if !cl
{
	if !fileexist(topDir "\8-变身\*.acc")
	{
		msgbox, 错误！`n当前不存在成号和变身号`n脚本将退出
		ExitApp
	}
	else {
		loop, % topDir "\8-变身\*.acc"
			cll := % A_Index
		GuiControl, , BSHS, % cll
		GuiControl, , BSZHXZ, 1
	}
		
}

else {
	GuiControl, , COUD, % cl
	loop, % topDir "\8-变身\*.acc"
		cll := % A_Index
	if cll
		GuiControl, , BSHS, % cll
}
bl := 
loop, read, % a_workingdir "\note\" a_yyyy a_mm a_dd ".note"
	bl := % A_Index
if bl
	GuiControl, , ljqh, % bl
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