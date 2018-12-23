#SingleInstance force
CoordMode, mouse, screen
CoordMode, ToolTip, screen
gui, +AlwaysOnTop -SysMenu -Caption +Border +HwndPiccatch
colorw := ["000000", "FFFFFF" ,"00FFFF", "FF00FF", "FFFF00", "FF0000", "00FF00", "FFFF00"]
cl := 1
Gui, Color , % colorw[1]
HH := 80 
WW := 80
gui,SHOW, H%HH% W%WW%, Piccatch
WinWait, ahk_id %Piccatch%
TP := 100
WinSet, Transparent, %TP%, ahk_id %Piccatch%
WinSet, ExStyle, +0x20,A
settimer, moveto, 1
return

+tab::
AAA := !AAA
gui, % AAA ? "hide" : "show"
SetTimer, moveto, % AAA ? "Off" : "on"
return


#if (!AAA)

^=::
HH += 1
WW += 1
MouseGetPos, xx, yy
WinMove, ahk_id %Piccatch%, , % xx, % yy, % (WW += 2), % (HH += 2)
Loop {
	if !getkeystate("ctrl", "P")
		break
	MouseGetPos, xx, yy
	WinMove, ahk_id %Piccatch%, , % xx, % yy, % (WW += 1), % (HH += 1)
}
return

^-::
MouseGetPos, xx, yy
WinMove, ahk_id %Piccatch%, , % xx, % yy, % (WW -= 2), % (HH -= 2)
Loop {
	if !getkeystate("-", "P")
		break
	MouseGetPos, xx, yy
	WinMove, ahk_id %Piccatch%, , % xx, % yy, % (WW -= 1), % (HH -= 1)
}
return
+c::
	bc := % (cl = 1) ?  1 : bc
	bc := % (cl = 8) ? -1 : bc
	Gui, Color , % colorw[cl += bc]
	return

+WheelUp::
WinSet, Transparent, % (TP += 2), ahk_id %Piccatch%
return

+WheelDown::
WinSet, Transparent, % (TP -= 2), ahk_id %Piccatch%
return

^right::
dl := 1
loop {
	if not getkeystate("right", "P")
		break
	WinMove, ahk_id %Piccatch%, , , , % (WW += (dl += 1)), % HH
}
dl := 1
return

^Left::
dl := 1
loop {
	if not getkeystate("Left", "P")
		break
	WinMove, ahk_id %Piccatch%, , , , % (WW -= (dl += 1)), % HH
}
dl := 1
return

^Up::

dl := 1
loop {
	if not getkeystate("Up", "P")
		break
	WinMove, ahk_id %Piccatch%, , , , % WW, % (HH -= (dl += 1))
}
dl := 1
return

^Down::
dl := 1
loop {
	if not getkeystate("down", "P")
		break
	WinMove, ahk_id %Piccatch%, , , , % WW, % (HH += (dl += 1))
}
dl := 1
return

moveto:
MouseGetPos, oox, ooy
winmove, ahk_id %Piccatch%, , %oox%, %ooy%
;ToolTip, %  oox ", " ooy "`n" (oox + WW) "," (ooy + HH), % oox, % ooy - 50
ToolTip, %  oox ", " ooy "`n" (oox + WW) "," (ooy + HH), 0, 0
return




