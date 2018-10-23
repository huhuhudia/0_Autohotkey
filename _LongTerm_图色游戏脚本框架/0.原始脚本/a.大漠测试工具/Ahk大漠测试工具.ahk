#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %a_scriptdir%
DMW := "DMwindow"
ToFoPa := % delStrL(a_workingdir, 9)
dm := ComObjCreate( "dm.dmsoft")
dm.SetPath(A_WorkingDir)


gui, font, ceaedcd, 微软雅黑		;字体与颜色
Gui, Color, 161a17				;窗口颜色

Gui, Add, Text, x340 y12 w60 h20 , alt+0启动

Gui, Add, Text, x14 y12 w60 h16 , 大漠路径：

Gui, Add, Edit, vpathOfDM ReadOnly x76 y10 w260 h20 , % ToFoPa "\0.大漠\大漠综合工具.exe"


Gui, Add, Text, x36 y37 w170 h20 , F12__获取绑定测试窗口句柄：
Gui, Add, Text, vwWinID x206 y37 w120 h20 , 000000

Gui, +AlwaysOnTop
ProExit("大漠综合工具.exe")
Gui, Show, x-839 y173 h131 w408, AHK大漠测试工具
Return

GuiClose:
ExitApp

/* 此处为大漠窗口控件编号注释
大漠控件编号备注：
Edit44	<<<<色彩描述
Edit45	<<<<窗口句柄
Edit47	<<<<选择范围，坐标，包括宽高

色值坐标编号备注：
Edit46	<<<< 位1
Edit48	<<<< 位2
Edit49	<<<< 位3
Edit50	<<<< 位4
Edit51	<<<< 位5
Edit52	<<<< 位6
Edit53	<<<< 位7
Edit54	<<<< 位8
Edit55	<<<< 位9
Edit56	<<<< 位10
*/

!0::
guiCGt(pathOfDM)
Run, % pathOfDM
winwait, ahk_exe 大漠综合工具.exe
WinMove, ahk_exe 大漠综合工具.exe, , -1003, 511
WinSetTitle, ahk_exe 大漠综合工具.exe, , % DMW
WinSet, ALWAYSONTOP, ON, % DMW
return

^2::	;大漠中获取窗口句柄按钮
WinActivate, % DMW
CoordMode, mouse, screen
MouseGetPos, Xmo, Ymo
WinWaitActive, % DMW
CoordMode, mouse, window
MouseMove, 724, 188, 0
sleep 200
send, {lbutton down}
CoordMode, mouse, screen
Sleep 300
MouseMove, % Xmo, % Ymo
CoordMode, mouse, window
return

^3::	;点击绑定窗口
ControlClick, x615 y185, % DMW
sleep 200
theTextID := CtrlGTex("Edit45", DMW)
IF (theTextID) {
	guiChan(theTextID, wWinID)
	dm.BindWindow(theTextID, "gdi2", "normal", "normal", 0)
}
return




guiCGt(ByRef Gvar) {	;将GUI控件保存至唯一参数，即gui变量名
	GuiControlGet, Gvar, , Gvar
}

CtrlGTex(ctrlName, winTitle) {	;获取窗口控件文本内容并输出
	ControlGetText, theText, % ctrlName, % winTitle
	return %theText%
}

guiChan(newtex, ByRef gVar) { ;GUI改变函数
	GuiControl, , gVar, % newtex
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
