#NoEnv
#Persistent
#SingleInstance force

yinhao = 

Gui, Add, Edit, ReadOnly vpicnamee x96 y185 w100 h20 , pictureName

Gui, Add, Text, x34 y157 w40 h20 , 路径：
Gui, Add, Text, x26 y187 w70 h20 , 图片名称：
Gui, Add, Text, x196 y187 w40 h20 , .png
Gui, Add, Text, x286 y187 w70 h20 , 色值浮动：
Gui, Add, Text, x6 y227 w70 h20 , 变量生成：
Gui, Add, Text, x36 y267 w70 h20 , 快捷键备注:
Gui, Add, Text, x106 y267 w340 h50 , #1-4键入坐标 #5下一流程名 #6图片2名称  F1.2粘粘图片/函数`n #z修改图片名  #c色值浮动    #a启动快捷输入

Gui, Add, Edit, ReadOnly vPICVARX x76 y225 w390 h20 , pictureName `:`= `% a_workingdir "\picture\pictureName.png"
Gui, Add, Edit, ReadOnly vcoloN x356 y185 w50 h20 , 10
Gui, Add, Edit, ReadOnly VPATHOP x76 y155 w390 h20 , `% a_workingdir "\picture\"
Gui, Add, Button, x6 y155 w20 h20 , v

Gui, Add, Tab, vtabx x6 y7 w460 h140 , 1.图片点击|2.点击它处|3.搜图至下一流程|4.循环点击判断|5.搜图判断

;---1.一号-------------------------------------------------------------------------------------
Gui, Tab, 1.图片点击
Gui, Add, Text, x16 y115 w40 h20 , 函数:
Gui, Add, Text, x36 y42 w30 h20 , win+1
Gui, Add, Text, x76 y42 w50 h20 , 左上：
Gui, Add, Text, x46 y67 w30 h20 , x:
Gui, Add, Text, x126 y67 w20 h20 , y:
Gui, Add, Text, x246 y42 w30 h20 , win+2
Gui, Add, Text, x286 y42 w50 h20 , 右下：
Gui, Add, Text, x256 y67 w20 h20 , x:
Gui, Add, Text, x336 y67 w20 h20 , y:


Gui, Add, Edit, ReadOnly vvar1 x56 y115 w400 h20 , cliI(thePathi`, cx1`, cy1`, cx2`, cy2)	;变化，点击图片函数
Gui, Add, Text, vw1x1 x66 y67 w50 h20 , 0		;#1改变点击图片函数左上x
Gui, Add, Text, vw1y1 x146 y67 w50 h20 , 0	;#1改变点击图片函数左上y

Gui, Add, Text, vw2x1 x276 y67 w50 h20 , 0	;#2改变点击图片函数右下x
Gui, Add, Text, vw2y1 x356 y67 w50 h20 , 0	;#2改变点击图片函数右下y

;---2.二号-------------------------------------------------------------------------------------
Gui, Tab, 2.点击它处
Gui, Add, Text, x16 y115 w40 h20 , 函数:
Gui, Add, Text, x26 y37 w50 h20 , 点击处:
Gui, Add, Text, x86 y37 w80 h20 , W+3点击坐标:
Gui, Add, Text, x176 y37 w20 h20 , x:
Gui, Add, Text, x266 y37 w20 h20 , y:
Gui, Add, Text, x26 y67 w40 h20 , 图片:
Gui, Add, Text, x76 y67 w50 h20 , W1左上:
Gui, Add, Text, x136 y67 w20 h20 , x:
Gui, Add, Text, x216 y67 w20 h20 , y:
Gui, Add, Text, x76 y87 w50 h20 , W2右下:
Gui, Add, Text, x136 y87 w20 h20 , x:
Gui, Add, Text, x216 y87 w20 h20 , y:

Gui, Add, Edit, ReadOnly vvar2 x56 y115 w400 h20 , cliO(ox1`, oy1`, thepatho`, ox2`, oy2`, ox3`, oy3)
Gui, Add, Text, vw3x1 x196 y37 w50 h20 , 0	;#3改变点击函数点击坐标x
Gui, Add, Text, vw3y1 x286 y37 w50 h20 , 0	;#3改变点击函数点击坐标y

Gui, Add, Text, vw1x2 x156 y67 w50 h20 , 0	;#1改变点击函数图片左上坐标x
Gui, Add, Text, vw1y2 x236 y67 w50 h20 , 0	;#1改变点击函数图片左上坐标y

Gui, Add, Text, vw2x2 x156 y87 w50 h20 , 0	;#2改变点击函数图片右下坐标x
Gui, Add, Text, vw2y2 x236 y87 w50 h20 , 0	;#2改变点击函数图片右下坐标y

;---3.三号-------------------------------------------------------------------------------------
Gui, Tab, 3.搜图至下一流程
Gui, Add, Text, x16 y115 w40 h20 , 函数:
Gui, Add, Text, x36 y37 w100 h20 , W5下一流程名称:
Gui, Add, Text, x36 y67 w40 h20 , 图片:
Gui, Add, Text, x86 y67 w50 h20 , W1左上:
Gui, Add, Text, x146 y67 w20 h20 , x:
Gui, Add, Text, x236 y67 w20 h20 , y:
Gui, Add, Text, x86 y87 w50 h20 , W2右下:
Gui, Add, Text, x146 y87 w20 h20 , x:
Gui, Add, Text, x236 y87 w20 h20 , y:


Gui, Add, Edit, ReadOnly vvar3 x56 y115 w400 h20 , imaG(filpath`, fin_x1`, fin_y1`, fin_x2`, fin_y2`, next_sub)
Gui, Add, Edit, ReadOnly vw5liucheng x136 y35 w200 h20 , 流程名	;流程名，中英文均可，
Gui, Add, Text, vw1x3 x166 y67 w50 h20 , 0	;#1改变搜图函数图片左上坐标x
Gui, Add, Text, vw1y3 x256 y67 w60 h20 , 0	;#1改变搜图函数图片左上坐标y

Gui, Add, Text, vw2x3 x166 y87 w50 h20 , 0	;#2改变搜图函数图片右下坐标x
Gui, Add, Text, vw2y3 x256 y87 w60 h20 , 0	;#2改变搜图函数图片右下坐标x

;---4.四号-------------------------------------------------------------------------------------
Gui, Tab, 4.循环点击判断
Gui, Add, Text, x16 y115 w40 h20 , 函数:
Gui, Add, Text, x16 y37 w50 h20 , 点击图:
Gui, Add, Text, x76 y37 w90 h20 , 底部图片名
Gui, Add, Text, x36 y57 w50 h20 , W1左上:
Gui, Add, Text, x96 y57 w20 h20 , x:
Gui, Add, Text, x36 y77 w50 h20 , W2右下:
Gui, Add, Text, x216 y37 w50 h20 , 判断图:
Gui, Add, Text, x266 y37 w50 h20 , 图片名:
Gui, Add, Text, x386 y37 w50 h20 , .png
Gui, Add, Text, x236 y57 w50 h20 , W3左上:
Gui, Add, Text, x96 y77 w20 h20 , x:
Gui, Add, Text, x166 y57 w20 h20 , y:
Gui, Add, Text, x166 y77 w20 h20 , y:
Gui, Add, Text, x296 y57 w20 h20 , x:
Gui, Add, Text, x366 y57 w20 h20 , y:
Gui, Add, Text, x236 y77 w50 h20 , W4右下:
Gui, Add, Text, x296 y77 w20 h20 , x:
Gui, Add, Text, x366 y77 w20 h20 , y:

Gui, Add, Edit, ReadOnly vvar4 x56 y112 w400 h20 , cliA(thpatha`, x1`, y1`, x2`, y2`, thepathb`, x1`, y1`, x2`, y2)

Gui, Add, Text, vw1x4 x116 y57 w40 h20 , 0	;#1改变搜图函数图片左上坐标x
Gui, Add, Text, vw1y4 x186 y57 w40 h20 , 0	;#1改变搜图函数图片左上坐标y

Gui, Add, Text, vw2x4 x116 y77 w40 h20 , 0	;#2改变搜图函数图片右下坐标x
Gui, Add, Text, vw2y4 x186 y77 w40 h20 , 0	;#2改变搜图函数图片右下坐标y

Gui, Add, Text, vw3x2 x316 y57 w40 h20 , 0	;#3改变搜图函数图片左上坐标x
Gui, Add, Text, vw3y2 x386 y57 w40 h20 , 0	;#3改变搜图函数图片左上坐标y

Gui, Add, Text, vw4x1 x316 y77 w40 h20 , 0	;#4改变搜图函数图片左上坐标x
Gui, Add, Text, vw4y1 x386 y77 w40 h20 , 0	;#4改变搜图函数图片左上坐标y
Gui, Add, Edit, ReadOnly vpicname2 x316 y37 w70 h20 , pic2	;#6判断图的图片名

Gui, Tab, 5.搜图判断

Gui, Add, Text, x16 y115 w40 h20 , 函数:
Gui, Add, Text, x36 y42 w30 h20 , win+1
Gui, Add, Text, x76 y42 w50 h20 , 左上：
Gui, Add, Text, x46 y67 w30 h20 , x:
Gui, Add, Text, x126 y67 w20 h20 , y:
Gui, Add, Text, x246 y42 w30 h20 , win+2
Gui, Add, Text, x286 y42 w50 h20 , 右下：
Gui, Add, Text, x256 y67 w20 h20 , x:
Gui, Add, Text, x336 y67 w20 h20 , y:


Gui, Add, Edit, ReadOnly vvar5 x56 y115 w400 h20 , picR(thePathi`, cx1`, cy1`, cx2`, cy2)	;变化，点击图片函数
Gui, Add, Text, vw1x5 x66 y67 w50 h20 , 0		;#1改变点击图片函数左上x
Gui, Add, Text, vw1y5 x146 y67 w50 h20 , 0	;#1改变点击图片函数左上y

Gui, Add, Text, vw2x5 x276 y67 w50 h20 , 0	;#2改变点击图片函数右下x
Gui, Add, Text, vw2y5 x356 y67 w50 h20 , 0	;#2改变点击图片函数右下y

Return

改变函数:
{
;---1.图片点击函数函数改变
GuiControlGet, PICNAME, , picnamee	;图片1名及变量
GuiControlGet, l1x1, , w1x1	;图片点击函数坐标
GuiControlGet, l1y1, , w1y1	;图片点击函数坐标
GuiControlGet, l1x2, , w2x1	;图片点击函数坐标
GuiControlGet, l1y2, , w2y1	;图片点击函数坐标
GuiControl, , var1, % "cliI`(" PICNAME "`, " l1x1 "`, " l1y1 "`, " l1x2 "`, " l1y2 "`)"

;---2.点击它处函数函数名改变
GuiControlGet, l2x1, , w1x2	;图片点击函数坐标
GuiControlGet, l2y1, , w1y2	;图片点击函数坐标
GuiControlGet, l2x2, , w2x2	;图片点击函数坐标
GuiControlGet, l2y2, , w2y2	;图片点击函数坐标
GuiControlGet, l2x3, , w3x1	;图片点击函数坐标
GuiControlGet, l2y3, , w3y1	;图片点击函数坐标
GuiControl, , var2, % "cliO`(" l2x3 "`, " l2y3 "`, " PICNAME "`, " l1x1 "`, " l1y1 "`, " l1x2 "`, " l1y2 "`)"

;---3.搜图至下一流程函数函数名改变
GuiControlGet, l3x1, , w1x3	;图片点击函数坐标
GuiControlGet, l3y1, , w1y3	;图片点击函数坐标
GuiControlGet, l3x2, , w2x3	;图片点击函数坐标
GuiControlGet, l3y2, , w2y3	;图片点击函数坐标
GuiControlGet, subname, , w5liucheng	;图片点击函数坐标

GuiControl, , var3, % "imaG`(" PICNAME "`, " l3x1 "`, " l3y1 "`, " l3x2 "`, " l3y2 "`, " yinhao subname yinhao "`)"

;---4.循环判断点击函数
GuiControlGet, l4x1, , w1x4	;图片点击函数坐标
GuiControlGet, l4y1, , w1y4	;图片点击函数坐标
GuiControlGet, l4x2, , w2x4	;图片点击函数坐标
GuiControlGet, l4y2, , w2y4	;图片点击函数坐标
GuiControlGet, l4x3, , w3x2	;图片点击函数坐标
GuiControlGet, l4y3, , w3y2	;图片点击函数坐标
GuiControlGet, l4x4, , w4x1	;图片点击函数坐标
GuiControlGet, l4y4, , w4y1	;图片点击函数坐标

GuiControlGet, pic2n, , picname2	;图片点击函数坐标
GuiControl, , var4, % "cliA(`(" PICNAME "`, " l4x1 "`, " l4y1 "`, " l4x2 "`, " l4y2 "`, " pic2n "`, " l4x3 "`, " l4y3 "`, " l4x4 "`, " l4y4 "`)"
;---5.搜图判断函数
GuiControlGet, l5x1, , w1x5	;图片点击函数坐标
GuiControlGet, l5y1, , w1y5	;图片点击函数坐标
GuiControlGet, l5x2, , w2x5	;图片点击函数坐标
GuiControlGet, l5y2, , w2y5	;图片点击函数坐标
GuiControl, , var5, % "picR`(" PICNAME "`, " l5x1 "`, " l5y1 "`, " l5x2 "`, " l5y2 "`)"
}
return

GuiClose:
ExitApp

!a::
daa := !daa
if daa
{
	CoordMode, tooltip, screen
	ToolTip, 快捷输入启动, 1500,	360
}
else
{
	tooltip
}
return

insert::
claaa := !claaa
if claaa
{
	Gui, Show, x1330 y10 h305 w479, 函数及图片变量生成工具
	winwait, 函数及图片变量生成工具
	sleep 500
	WinSet, AlwaysOnTop, on, 函数及图片变量生成工具
}
else
{
	Gui, Cancel
	ToolTip
}
return

#if daa
f1::
Clipboard :=
GuiControlGet, xxx, , PICVARX
Clipboard := % xxx
ClipWait
send, ^v
return

f2::
Clipboard :=

GuiControlGet, sss, , tabx
tabtov( "1.图片点击", var1, sss)
tabtov( "2.点击它处", var2, sss)
tabtov( "3.搜图至下一流程", var3, sss)
tabtov( "4.循环点击判断", var4, sss)
tabtov( "5.搜图判断", var5, sss)
return


tabtov(titleoftab, ByRef guitabvar,ByRef ti)	;ti = sss
{
	qq := % titleoftab
	if ti = % qq
	{
		GuiControlGet, vx, , guitabvar
		Clipboard := % vx
		ClipWait
		send, ^v
	}
}

#if claaa

!c::	;色值浮动值，数字不大于255
InputBox, colorN, 请输入色值浮动值, 0-255
GuiControl, , coloN, % colorN
gosub, 改变图片变量名
return

!z::
InputBox, gga, 修改图片1名, 英文为佳
GuiControL, , picnamee, % gga
gosub, 改变图片变量名
gosub, 改变函数
return

改变图片变量名:
;得到路径、图片名、色值
yinhao = "
GuiControlGet, PICN, , picnamee
GuiControlGet, CLON, , coloN
GuiControlGet, POP, , PATHOP
StringLen, LENGHOP, POP
StringLeft, GOTPATH, POP, % LENGHOP - 1
StringLen, LENGHOP2, GOTPATH
StringRight, GOTPATH2, GOTPATH, % LENGHOP2 - 2
GuiControl, , PICVARX, % PICN " `:= `% " yinhao "`*" CLON "` " yinhao " " GOTPATH2 PICN ".png" yinhao

return

!esc::
reload
return






!6::	;第二个图片名称
InputBox, picN, 请输入判断流程图片的图片名称, 英文为佳
GuiControl, , picname2, % picN
gosub, 改变函数
return

!5::	;下一流程函数流程名
InputBox, liucheng, 请输入搜图转至下一流程流程名, 中英文均可
GuiControl, , w5liucheng, % liucheng
gosub, 改变函数
return

!1::
InputBox, xy, 请输入w1坐标, 格式为999`+999
StringGetPos, midpos, xy, +
StringLen, lenghxy, xy
StringLeft, GOTX, xy, % midpos
StringRight, GOTY, xy, % lenghxy - midpos - 1
GuiControl, , w1x1, % GOTX
GuiControl, , w1x2, % GOTX
GuiControl, , w1x3, % GOTX
GuiControl, , w1x4, % GOTX
GuiControl, , w1x5, % GOTX

GuiControl, , w1y1, % GOTY
GuiControl, , w1y2, % GOTY
GuiControl, , w1y3, % GOTY
GuiControl, , w1y4, % GOTY
GuiControl, , w1y5, % GOTY
gosub, 改变函数
return

!2::
InputBox, xy, 请输入w2坐标, 格式为999`+999
StringGetPos, midpos, xy, +
StringLen, lenghxy, xy
StringLeft, GOTX, xy, % midpos
StringRight, GOTY, xy, % lenghxy - midpos - 1
GuiControl, , w2x1, % GOTX
GuiControl, , w2x2, % GOTX
GuiControl, , w2x3, % GOTX
GuiControl, , w2x4, % GOTX
GuiControl, , w2x5, % GOTX

GuiControl, , w2y1, % GOTY
GuiControl, , w2y2, % GOTY
GuiControl, , w2y3, % GOTY
GuiControl, , w2y4, % GOTY
GuiControl, , w2y5, % GOTY
gosub, 改变函数
return

!3::
InputBox, xy, 请输入w2坐标, 格式为999`+999
StringGetPos, midpos, xy, +
StringLen, lenghxy, xy
StringLeft, GOTX, xy, % midpos
StringRight, GOTY, xy, % lenghxy - midpos - 1
GuiControl, , w3x1, % GOTX
GuiControl, , w3x2, % GOTX
GuiControl, , w3y1, % GOTY
GuiControl, , w3y2, % GOTY
gosub, 改变函数
return

!4::
InputBox, xy, 请输入w2坐标, 格式为999`+999
StringGetPos, midpos, xy, +
StringLen, lenghxy, xy
StringLeft, GOTX, xy, % midpos
StringRight, GOTY, xy, % lenghxy - midpos - 1
GuiControl, , w4x1, % GOTX
GuiControl, , w4y1, % GOTY
gosub, 改变函数
return

#IfWinActive, ahk_class Photoshop
NumLock::

CoordMode, mouse, screen
MouseClickDrag, L, 52, 305, 602, 305, 1
sleep 300
MouseClickDrag, L, 973, 99, 973, 500, 1
sleep 300
MouseClickDrag, L, 52, 305, 800, 305, 1
sleep 300
MouseClickDrag, L, 973, 99, 973, 700, 1
return

^w::
CoordMode, mouse, screen
MouseGetPos, cx, cy
MouseClickDrag, L, 973, 99, % cx, % cy, 1
return

^f::
CoordMode, mouse, screen
MouseGetPos, cx, cy
MouseClickDrag, L, 52, 305, % cx, % cy, 1
return

;函数集合

;---1.图片点击函数
cliI(thePathi, cx1, cy1, cx2, cy2)
{
	ImageSearch, xx, yy, %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	if errorlevel = 0
	{
		MouseClick, L, %xx%, %yy%, 1, 0
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliI图片不存在
	}
}
;---2.点击它处函数
cliO(ox1, oy1, thepatho, ox2, oy2, ox3, oy3)
{
	ImageSearch, , , %ox2%, %oy2%, %ox3%, %oy3%, % thePathi
	if errorlevel = 0
	{
		MouseClick, L, %ox1%, %oy1%, 1, 0
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliO图片不存在		
	}
}
;---3.搜图至下一流程函数
imaG(filpath, fin_x1, fin_y1, fin_x2, fin_y2, next_sub)
{
	imagesearch, , , %fin_x1%, %fin_y1%, %fin_x2%, %fin_y2%, %filpath%
	if !errorlevel
	{
		gosub, %next_sub%
	}
}

;---4.循环点击判断
cliA(thpatha, ax1, ay1, ax2, ay2, thepathb, bx1, by1, bx2, by2)
{
	Loop
	{
		ImageSearch, lx, ly, %ax1%, %ay1%, %ax2%, %ay2%, % thpatha
		if errorlevel = 0
		{
			MouseClick, L, %lx%, %ly%, 1, 0
		}
		else if errorlevel = 2
		{
			MsgBox, 错误`nCliA点击图片不存在
		}
		ImageSearch, , , %bx1%, %by1%, %bx2%, %by2%, % thepathb
		if errorlevel = 0
		{
			break
		}
		else if errorlevel = 2
		{
			MsgBox, 错误`nCliA判断图片不存在
		}
		if a_index = 300
		{
			TrayTip, 超时警告, 超过1分钟未达到指定状态`n当前任务将结束
			break
		}
		IfWinNotExist, 天帝宝库
		{
			ExitApp
		}
		sleep 200
	}
}

;---5.搜图判断函数，找到返回1，没找到返回0
cliR(thePathi, cx1, cy1, cx2, cy2)
{
	ImageSearch, , , %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	{
		if !errorlevel
		{
			return 1
		}
		if errorlevel = 2
		{
			msgbox, 错误`n判断图片路径错误
		}
		if errorlevel = 1
		{
			return 0
		}
	}
}