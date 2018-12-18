/*
2018年05月30日
*/


#NoEnv
#Persistent
#SingleInstance force

setworkingdir %a_scriptdir%
yh = "
topDir := % delStrL(a_workingdir, 7)	;顶部路径
Gui, +AlwaysOnTop


Gui, Add, Text, x6 y7 w120 h20 , 七盟主角色名称：
Gui, Add, Text, x6 y30 w10 h20 , 1.
Gui, Add, Text, x116 y30 w10 h20 , 2.
Gui, Add, Text, x6 y53 w10 h20 , 3.
Gui, Add, Text, x116 y53 w10 h20 , 4.
Gui, Add, Text, x6 y74 w10 h20 , 5.
Gui, Add, Text, x116 y74 w10 h20 , 6.
Gui, Add, Text, x6 y95 w10 h20 , 7.

Gui, Add, Edit, vMZ1 readonly x16 y27 w70 h18 , None	;1号
Gui, Add, Button, gMZ1 x87 y27 w18 h18 , +	;1号

Gui, Add, Edit, vMZ2 readonly x126 y27 w70 h18 , None	;2号
Gui, Add, Button, gMZ2 x197 y27 w18 h18 , +	;2号

Gui, Add, Edit, vMZ3 readonly x16 y49 w70 h18 , None	;3号
Gui, Add, Button, gMZ3 x87 y49 w18 h18 , +	;3号

Gui, Add, Edit, vMZ4 readonly x126 y49 w70 h18 , None	;4号
Gui, Add, Button, gMZ4 x197 y49 w18 h18 , +	;4号

Gui, Add, Edit, vMZ5 readonly x16 y71 w70 h18 , None	;5号
Gui, Add, Button, gMZ5 x87 y71 w18 h18 , +	;5号

Gui, Add, Edit, vMZ6 readonly x126 y71 w70 h18 , None	;6号
Gui, Add, Button, gMZ6 x197 y71 w18 h18 , +	;6号

Gui, Add, Edit, vMZ7 readonly x16 y93 w70 h18 , None	;7号
Gui, Add, Button, gMZ7 x87 y93 w18 h18 , +	;7号

Gui, Add, Button, gRefre x116 y93 w98 h18 , Refresh	;刷新按钮g标签


Gui, Add, Text, x110 y7 w30 h20 , 区号:
Gui, Add, Edit, ReadOnly vMZ8 x139 y6 w51 h16 , None
Gui, Add, Button, gMZ8 x191 y6 w18 h17 , +	;7号

gosub, 完善诸控件


Gui, Show, x1580 y180 h119 w224, 飞升日常
Return

GuiClose:
ExitApp



MZ1:
MZ2:
MZ3:
MZ4:
MZ5:
MZ6:
MZ7:
MZ8:
IF A_ThisLabel != % "MZ8"
	InputBox, ti, 请输入%A_ThisLabel%号盟主名称, 顺序无差别，操作错误请按x。
else
	InputBox, ti, 请输入区号
if ti {
	guicontrol, , %A_ThisLabel%, % ti
	gui, submit, nohide
	Del_F(A_WorkingDir "\MZN.ned")
	loop 8
		FileAppend, % MZ%a_index% "`n", % a_workingdir "\MZN.ned", UTF-8
}
return






Refre:
完善诸控件:
if (!fileexist(a_workingdir "\WN.cho")) {	;此为窗口数目选择
	Loop 7 
	{
		if a_index = 1
			GuiControl, , WN, % "|" A_Index 
		else if a_index = 7
			guicontrol, , WN, % a_index "||"
		else
			GuiControl, , WN, % A_Index
	}
}
else {	;此为选项记录下窗口数目选择
	l1 := % getL(A_WorkingDir "\WN.cho")
	if l1 {
			GuiControl, , WN, |
		loop 7 
			GuiControl, , WN, % A_Index
		GuiControl, , WN, % l1 "||"
	}
	else {
		Loop 7 
		{
			if a_index = 1
				GuiControl, , WN, % "|" A_Index 
			else if a_index = 7
				guicontrol, , WN, % a_index "||"
			else
				GuiControl, , WN, % A_Index
		}		
	}
}
if FileExist(A_WorkingDir "\MZN.ned") {
	loop, read, % A_WORKINGDIR "\MZN.ned"
	{
		if a_index > 8
			break
		if A_LOOPREADLINE 
			GuiControl, , MZ%a_index%, % A_LOOPREADLINE
	}
}
return


Cr_AfterDel(tex, filLP) { ;创建文件前删除该文件确认后写入首行文本，确认首行文本后完成
	Loop {
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}	
	FileAppend, % tex, % filLP ,UTF-8
	Loop {
		IfNotExist, % filLP	
			Sleep 10
		Else 
			break
	}
	Loop {	
		FileReadLine, caa, % filLP, 1
		if caa = % tex
			break
	}
}	

Cr_EmpFil(filLP) { ;创建空白  文件  ,若存在文件，不动作
	IfNotExist, % filLP
	{
		FileAppend, , % filLP
		Loop {
			IfExist % filLP
				break
		}
	}
}
Cr_EmpFod(fodLP) { ;创建空白  文件夹  ，若存在文件夹，则不动作
	IfNotExist, % fodLP
	{
		FileCreateDir, % fodLP
		Loop {
			IfExist, % fodLP
				Break
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