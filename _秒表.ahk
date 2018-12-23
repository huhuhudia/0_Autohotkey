#include %a_SCRIPTDIR%\lib\时间_时间戳计算.ahk
#SingleInstance force
当前计时 := 0
计时时间 := []
宽度 := 150
gui, +toolwindow +alwaysontop


gui,font, s20, consolas
gui,add, Edit, ReadOnly v当前计时 w%宽度%, % 当前计时
gui,font, s11, consolas

gui,add, text, w%宽度% , space:on/off
gui,add, text, w%宽度% , esc:renew
GUI, show, , 虚荣的秒表


return

#IfWinActive 虚荣的秒表

space::
	GuiControlGet, 临时寄存时间, , 当前计时
	KeyWait,space
	if ((!当前时间.MaxIndex()) or (当前计时 != 0))
		计时时间 := [A_Now, A_MSec]
	Loop {
		当前计时 := 临时寄存时间 + NSecSubt([A_Now, A_MSec], 计时时间)
		StringTrimRight, 当前计时, 当前计时, 3
		guicontrol, ,当前计时, % 当前计时
		if getkeystate("space", "p")
			break
		if getkeystate("ESC", "p") {
			guicontrol, ,当前计时, 0
			break
			}
		}
	keywait, space
	keywait, Esc
	return
	
Esc::
	guicontrol, ,当前计时, 0
	当前计时 := 0
	return

