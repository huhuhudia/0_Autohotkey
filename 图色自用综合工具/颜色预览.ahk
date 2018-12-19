#Persistent
#SingleInstance force
if !winexist("ahk_exe zoom.exe")
{
	run, zoom.exe
	winwait, ahk_exe zoom.exe
	WinMove, ahk_exe zoom.exe, , , ,202, 200
}
else
	WinMove, ahk_exe zoom.exe, , , ,202, 200
CoordMode, pixel, screen
CoordMode, mouse, screen
尺寸 := 200
字号 := 11
gui,font, s%字号% cffffff, consolas
Gui, +AlwaysOnTop +ToolWindow -caption +hwndidit +Border
gui,add, Text,   w%尺寸% v色值 ReadOnly, 000000
gui,font, s%字号% c000000, consolas
gui,add, Text,  w%尺寸% v色值2 ReadOnly, 000000
Gui, Show, NoActivate y0 W%尺寸% H90 , COLORSHOWINGUI
gosub,color
return

!P::
	固定 := !固定
	return

color:
	loop {
		MouseGetPos, x, y
		if !固定 {
			if (x > (A_SCREENWIDTH / 2 + 200)) {
				WinMove, ahk_id %idit%, , 60, 235
				WinMove, ahk_exe zoom.exe, , 60, 30
			}
			else if (x < (A_SCREENWIDTH / 2 - 200)) {
				WinMove, ahk_id %idit%, , % (A_SCREENWIDTH - 尺寸 - 350), 235
				WinMove, ahk_exe zoom.exe, , % (A_SCREENWIDTH - 尺寸 - 350), 30
			}
		}
		PixelGetColor, c, %x%, %y%, RGB
		GuiControl, , 色值, % c
		GuiControl, , 色值2, % c
		Gui, color, %c%, ffffff
		SLEEP,200
	}
	return
	
#c::
	Clipboard :=
	GuiControlGet, 色值,, 色值
	Clipboard := 色值
	ClipWait, 1
	return
	
#v::
	GuiControlGet, 色值,, 色值
	Send, % 色值
	return