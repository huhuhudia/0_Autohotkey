#noenv
#Persistent
WinClose, ahk_class Notepad
SLEEP 200
ifexist, % a_workingdir "\gg.txt"
{
	filedelete, % a_workingdir "\gg.txt"
	fileappend, , % a_workingdir "\gg.txt"
	sleep 200
	run, gg.txt
	loop
	{
		ifwinexist, gg.txt - 记事本
		{
			winset, AlwaysOnTop, On, gg.txt - 记事本
			winmove, gg.txt - 记事本, ,% a_screenwidth - 360,% A_ScreenHeight - 500, 350, 390
			break
		}
	}
}
else
{
	fileappend, , % a_workingdir "\gg.txt"
	sleep 200
	run, gg.txt
	loop
	{
		ifwinexist, gg.txt - 记事本
		{
			winset, AlwaysOnTop, On, gg.txt - 记事本
			winmove, gg.txt - 记事本, ,% a_screenwidth - 360,% A_ScreenHeight - 500, 350, 390
			break
		}
	}
}
TrayTip, , 脚本已启动`,键入insert开关, 5
return

insert::
got_xy := !got_xy
nowstatus_l := got_xy ? "启动":"关闭"
TrayTip, , 取点模式 %nowstatus_l%`n请按q`/w分别选取图片范围坐标, 5
return

#if got_xy
f1::
imageSearch, ll_X, ll_Y, 110, 162, 181, 220, % "*10 " a_workingdir "\picture\drag.png"
if !errorlevel
{
	mousemove, %ll_X%, %ll_Y%, 1
}
return
$w::
loop
{
	if not getkeystate("w", "P")
	{
		break
	}
	send, {lbutton down}
	Mousemove, 0, -2, 2, R 
}
send, {lbutton up}
return

$s::
loop
{
	if not getkeystate("s", "P")
	{
		break
	}
	send, {lbutton down}
	Mousemove, 0, 2, 2, R 
}
send, {lbutton up}
return

2::
mousegetpos, HK_X, HK_Y
hkx_1 := % HK_X
hkx_2 := % HK_Y
TrayTip, , x:%HK_X%`ny:%HK_Y%, 3
return
3::
mousegetpos, QK_X, QK_Y
qkx_1 := % QK_X
qkx_2 := % QK_Y
TrayTip, , x:%QK_X%`ny:%QK_Y%, 3
return

f4::
MouseClickDrag, L, %ll_X%, %ll_Y%, %HK_X%, %HK_Y%, 5
sleep 800
click %QK_X%, %QK_Y%
return

!1::
mousegetpos, get_x,get_y
SLEEP 200
MouseClickDrag, L, %HK_X%, %HK_Y%, 142, 162, 1
RETURN

#e::
inputbox, quhao_x, shuruquhao
Control, EditPaste, 滑坐标：`, %hkx_1%`, %hkx_2%`r`n区坐标：`, %qkx_1%`, %qkx_2%`r`nQH`:%quhao_x%`r`n, Edit1, gg.txt - 记事本
return