
#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%

yh = "
mren := "默认"
Gui, -Caption -SysMenu +AlwaysOnTop
gui, font, ceaedcd, 微软雅黑		;字体与颜色
Gui, Color, 1e2026				;窗口颜色

Gui, Add, Text, x26 y37 w70 h16 , 图片名称：
Gui, Add, Text, x56 y57 w65 h16 , 左上坐标：
Gui, Add, Text, x56 y77 w65 h16 , 右下坐标：
Gui, Add, Text, x26 y107 w70 h16 , 生成函数：
Gui, Add, Text, x376 y57 w60 h16 , 默认080808
Gui, Add, Text, x376 y77 w60 h16 , 默认0.9
Gui, Add, Text, x236 y37 w65 h16 , 点击它处：
Gui, Add, Text, x236 y57 w60 h16 , 颜色抖动：
Gui, Add, Text, x236 y77 w60 h16 , 模糊匹配：
Gui, Add, Text, x296 y10 w62 h16 , 点击等待：


Gui, Add, Radio, vfunc1 x16 y10 w70 h20 , 点击图片		;alt + 1
Gui, Add, Radio, vfunc2 x106 y10 w70 h20 , 点击它处		;alt + 2
Gui, Add, Radio, vfunc3 x186 y10 w80 h20 , 仅图片查找	;alt + 3


Gui, Add, Text, vpicNC x96 y37 w70 h16 , picName	;图片名称 alt + w

Gui, Add, Text, v_2x x126 y57 w30 h16 , 0	;左上x坐标，alt + s
Gui, Add, Text, v_3y x159 y57 w30 h16 , 0	;左上y坐标，alt + s

Gui, Add, Text, v_4x x126 y77 w30 h16 , 1920	;右下x坐标，alt + x
Gui, Add, Text, v_5y x159 y77 w30 h16 , 1080	;右下y坐标，alt + x

Gui, Add, Text, v_9djx x306 y37 w30 h16 , 0	;点击坐标x，alt + e
Gui, Add, Text, v_10djy x339 y37 w30 h16 , 0	;点击坐标y，alt + e

Gui, Add, Text, v_6s x356 y10 w60 h16 , 0	;点击等待

Gui, Add, Edit, vFuncedit readonly x96 y105 w380 h18 , DmCliI(`"picName`.bmp`"`, dm`, 0`, 0`, 0`, 960`, 540)
;生成函数
Gui, Add, Text, v_7ysdd x306 y57 w60 h16 , 默认	;颜色抖动默认为"030303",颜色抖动
Gui, Add, Text, v_8mhpp x306 y77 w60 h16 , 默认	;模糊匹配程度默认为0.9，即不改变函数

gosub, 函数类型默认
Return

!Esc::
ExitApp

F12::
Reload

Insert::
gowork := !gowork
if gowork
	Gui, Show, x1350 y880 h138 w490
else
	GUI, CANCEL
return

函数类型默认:
guicontrol, , func1, 1
gosub, 生成函数
return

生成函数:
GuiControlGet, gg1, , func1
GuiControlGet, gg2, , func2
GuiControlGet, gg3, , func3

GuiControlGet, _1picname, , picNC	;图片名
GuiControlGet, _2x, , _2x	;左上x坐标
GuiControlGet, _3y, , _3y	;左上y坐标
GuiControlGet, _4x, , _4x	;右下x坐标
GuiControlGet, _5y, , _5y	;右下x坐标
GuiControlGet, _6s, , _6s	;点击等待时间
GuiControlGet, _9djx, , _9djx	;点击它处x
GuiControlGet, _10djy, , _10djy	;点击它处y
GuiControlGet, _7ysdd, , _7ysdd	;颜色抖动，字符串
GuiControlGet, _8mhpp, , _8mhpp	;模糊匹配，字符串
/*
一、头文字DmcliI,

若有该参数与模糊匹配，都写上，
若有该参数无模糊匹配，只写这个，
若无该参数有模糊匹配，都写上

DmcliI(picName, ByRef dmF, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9)
*/
if (gg1) {	;图片点击函数
	if (_8mhpp = mren) {	;最末参数模糊匹配为默认
		if (_7ysdd = mren) {	;倒二为默认，两者皆省略
			fgfunc := % "DmcliI(" yh _1picname ".bmp" yh "`, dm`, " _6s ", " _2x "`, " _3y "`, " _4x "`, " _5y "`)"
			GuiControl, , Funcedit, % fgfunc
		}
		else {	;倒二不为默认
			fgfunc := % "DmcliI(" yh _1picname ".bmp" yh "`, dm`, " _6s ", " _2x "`, " _3y "`, " _4x "`, " _5y "`, " yh _7ysdd yh "`)"
			GuiControl, , Funcedit, % fgfunc
		}
	}
	else {
		if (_7ysdd = mren) {	;倒二为默认
			fgfunc := % "DmcliI(" yh _1picname ".bmp" yh "`, dm`, " _6s ", " _2x "`, " _3y "`, " _4x "`, " _5y "`, " yh "080808" yh "`, " yh _8mhpp yh "`)"
			GuiControl, , Funcedit, % fgfunc
		}
		else
			fgfunc := % "DmcliI(" yh _1picname ".bmp" yh "`, dm`, " _6s ", " _2x "`, " _3y "`, " _4x "`, " _5y "`, " yh _7ysdd yh "`, " yh _8mhpp yh "`)"
			GuiControl, , Funcedit, % fgfunc			
	}
}
/*
二、头文字DmcliO,
参数 :
1.它处x
2.它处y
3.图片名 带引号 尾数.bmp
4.dm 不变 
5.点击等待sleep   
x1   
y1 
x2 
y2 
RGBm 
MH 模糊匹配
*/
else if (gg2) {	;图片点击它处函数
	if (_8mhpp = mren) {	;最末参数模糊匹配为默认
		if (_7ysdd = mren) {	;倒二为默认，两者皆省略
			fgfunc := % "DmcliO(" _9djx "`, " _10djy "`, "  yh _1picname ".bmp" yh "`, dm`, " _6s "`, "  _2x "`, " _3y "`, " _4x "`, " _5y "`)"
			GuiControl, , Funcedit, % fgfunc	
		}
		else {	;倒二不为默认
			fgfunc := % "DmcliO(" _9djx "`, " _10djy "`, "  yh _1picname ".bmp" yh "`, dm`, " _6s "`, "  _2x "`, " _3y "`, " _4x "`, " _5y  "`, " yh _7ysdd yh "`)"
			GuiControl, , Funcedit, % fgfunc	
		}
	}
	else {
		if (_7ysdd = mren) {	;倒二为默认
			fgfunc := % "DmcliO(" _9djx "`, " _10djy "`, "  yh _1picname ".bmp" yh "`, dm`, " _6s "`, "  _2x "`, " _3y "`, " _4x "`, " _5y "`, " yh "080808" yh "`, " yh _8mhpp yh "`)"
			GuiControl, , Funcedit, % fgfunc	
		}
		else {
			fgfunc := % "DmcliO(" _9djx "`, " _10djy "`, "  yh _1picname ".bmp" yh "`, dm`, " _6s "`, "  _2x "`, " _3y "`, " _4x "`, " _5y "`, "  yh _7ysdd yh "`, " yh _8mhpp yh "`)"
			GuiControl, , Funcedit, % fgfunc	
		}
	}
}
/*
二、头文字DmPicR,
参数 :
1.图片名
2.dm 不变
3.x1
4.y1
5.x2
6.y2
7.RGB参数
8.模糊匹配

DmPicR(picName, ByRef dmF, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9)
*/
else IF (gg3) {	;图片查找返回函数
	if (_8mhpp = mren) {	;最末参数模糊匹配为默认
		if (_7ysdd = mren) {	;倒二为默认，两者皆省略
			fgfunc := % "DmPicR(" yh _1picname ".bmp" yh "`, dm`, " _2x "`, " _3y "`, " _4x "`, " _5y ")"
			GuiControl, , Funcedit, % fgfunc	
		}
		else {
			fgfunc := % "DmPicR(" yh _1picname ".bmp" yh "`, dm`, " _2x "`, " _3y "`, " _4x "`, " _5y "`, " yh _7ysdd yh ")"
			GuiControl, , Funcedit, % fgfunc	
		}
	}
	else {
		if (_7ysdd = mren) {	;倒二为默认
			fgfunc := % "DmPicR(" yh _1picname ".bmp" yh "`, dm`, " _2x "`, " _3y "`, " _4x "`, " _5y "`, " yh "080808" yh "`, " yh _8mhpp yh "`)"
			GuiControl, , Funcedit, % fgfunc	
		}
		else {
			fgfunc := % "DmPicR(" yh _1picname ".bmp" yh "`, dm`, " _2x "`, " _3y "`, " _4x "`, " _5y "`, " yh _7ysdd yh "`, " yh _8mhpp yh "`)"
			GuiControl, , Funcedit, % fgfunc			
		}
	}
}
return

#If gowork
!w::	;改变图片名称，后缀为bmp
InputBox, PICNAMEG, 请输入图片名
guicontrol, , picNC, % PICNAMEG
gosub, 生成函数
return

!d::
InputBox, ysddx, 输入颜色抖动，6位
guicontrol, , _7ysdd, % ysddx
gosub, 生成函数
return

!c::
InputBox, ysddx, 输入模糊匹配值，0`.1 `- 1
guicontrol, , _8mhpp, % ysddx
gosub, 生成函数
return

!r::
InputBox, ysddx, 输入点击等待时间
guicontrol, , _6s, % ysddx
gosub, 生成函数
return

!s::
InputBox, xy, 请输入左上坐标, 格式为999`,999
StringGetPos, midpos, xy, `,
StringLen, lenghxy, xy
StringLeft, GOTX, xy, % midpos
StringRight, GOTY, xy, % lenghxy - midpos - 1
guicontrol, , _2x, % GOTX
guicontrol, , _3y, % GOTY
gosub, 生成函数
return

!x::
InputBox, xy, 请输入右下坐标, 格式为999`,999
StringGetPos, midpos, xy, `,
StringLen, lenghxy, xy
StringLeft, GOTX, xy, % midpos
StringRight, GOTY, xy, % lenghxy - midpos - 1
guicontrol, , _4x, % GOTX
guicontrol, , _5y, % GOTY
gosub, 生成函数
return

!e::
InputBox, xy, 请输入右下坐标, 格式为999`,999
StringGetPos, midpos, xy, `,
StringLen, lenghxy, xy
StringLeft, GOTX, xy, % midpos
StringRight, GOTY, xy, % lenghxy - midpos - 1
guicontrol, , _9djx, % GOTX
guicontrol, , _10djy, % GOTY
gosub, 生成函数
return

!1::
guicontrol, , func1, 1
gosub, 生成函数
return

!2::
guicontrol, , func2, 1
gosub, 生成函数
return

!3::
guicontrol, , func3, 1
gosub, 生成函数
return

F1::
Clipboard := 
GuiControlGet, cl, , Funcedit
sleep 200
Clipboard := % cl
ClipWait
TrayTip, , 函数已发送至剪切板, 5
return