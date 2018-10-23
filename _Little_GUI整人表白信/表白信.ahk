#NoTrayIcon
#SingleInstance ignore

Gui, Add, Picture, vMpic x32 y100 w300 h-1, % A_ScriptDir "\mainfile\xx1.clg"
Gui, +AlwaysOnTop

Gui, Font , S23 W700

Gui, Add, Text, vb1 x200 y50 w120 h40 , 表白信
Gui, Add, Button, g我同意 vagreex x22 y310 w180 h60 , 我同意
Gui, Font , S15 W500
Gui, Add, Text, vb2 x250 y100 w210 h30 , 做我女朋友好吗？

vx := % A_ScreenWidth /2 - 300
vy := % A_ScreenHeight /2 - 190
vh := % " h380"
vw := % " w600"

Gui, Font , S9 W500
Gui, Add, Button, g不同意 vdisagreex x250 y340 w50 h30 , 不同意

Gui, Show, % "x" vx " y" vy vh vw, 这里有我的爱意
Settimer, 检查窗口活动, 800
Return

!^+0::
ExitApp

GuiClose:
WinMinimize, 这里有我的爱意
MsgBox, , 不可以, 不许关掉！
WinActivate, 这里有我的爱意
return

我同意:
SetTimer, 检查窗口活动, Off
GuiControl, hide, b1 
GuiControl, hide, b2
GuiControl, hide, agreex 
GuiControl, hide, disagreex
GuiControl,, Mpic, *w300 *h-1 %A_ScriptDir%\mainfile\xx2.clg
GuiControl, Move, Mpic, x150 y50
Gui, Font , S20 W700
Gui, Add, Text, vb3 x200 y230 w160 h40 , 谢谢媳妇儿~
Gui, Add, Button, g我的荣幸 vRX x210 y280 w180 h60 , 我的荣幸
return

不同意:
ll := !ll
if ll
Random, xxx, 1, 200
else
Random, xxx, 300, 500

Random, yyy, 1, 280

GuiControl, Move, disagreex, % "x" xxx " y" yyy " w100 h30"
return

我的荣幸:
Gui, -AlwaysOnTop
WinMinimize, 这里有我的爱意
msgbox, , 么么哒, 我也是~
ExitApp
return

检查窗口活动:
WinClose, ahk_exe taskmgr.exe
if winexist("不可以")
{
Gui, -AlwaysOnTop
WinMove, 这里有我的爱意, , % vx, % vy
WinActivate, 这里有我的爱意
WinMove, 不可以, , % vx, % vy - 188
WinActivate, 不可以
}
else
{
winactivate, 这里有我的爱意
WinMove, 这里有我的爱意, , % vx, % vy
Gui, +AlwaysOnTop
}
return

!F4::
!^Delete::
+^Esc::
return