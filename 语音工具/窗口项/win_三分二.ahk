#singleinstance force
FileReadLine, MENUID, % a_scriptdir "\win_ini\" winmenu.txt, 1	
MENUID := "ahk_Class Shell_TrayWnd"	
;将当前窗口移动至窗口三分一左侧，宽度为三分一
WinGetPos, menuX, menuY, menuW, menuH, %MENUID%	;此为菜单栏坐标信息
if ((menuX = 0) && (menuY = 0) && (menuW = A_ScreenWidth))		;顶部
	SW := A_ScreenWidth, SH := A_ScreenHeight - menuH, WX := 0, WY := A_ScreenHeight - menuH
else if ((menuX = 0) && (menuY = 0) && (menuH = A_ScreenHeight))	;左侧
	SW := A_ScreenWidth - menuW, SH := A_ScreenHeight , WX := A_ScreenWidth - menuW, WY := A_ScreenHeight
else if ((menuX = 0) && (menuY != 0) && (menuW = A_ScreenWidth))	;底部
	SW := A_ScreenWidth, SH := A_ScreenHeight - menuH, WX := 0, WY := 0
else if  ((menuX != 0) && (menuY = 0)  && (menuH = A_ScreenHeight))		;右侧
	SW := A_ScreenWidth - menuW, SH := A_ScreenHeight , WX := 0, WY := 0
else
	SW := A_ScreenWidth, SH := A_ScreenHeight , WX := 0, WY := 0

WH := SH
WX := SW / 3
winmove, A, , %WX%, %WY%, % SW / 3, %SH%