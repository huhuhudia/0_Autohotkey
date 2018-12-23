#singleinstance force

WinGet, NowWinID, ID, A
NowWinID := % "ahk_ID " NowWinID
WinGetPos, , , , WH, %NowWinID%

FileReadLine, MENUID, % a_scriptdir "\win_ini\winmenu.txt" , 1		;此为读取识别窗口ID
WinGetPos, , menuY, menuW, menuH, %MENUID%	;此为菜单栏坐标信息


if ((menuY != 0 ) && (menuW = A_ScreenWidth))
	menuOnDown := 1

if menuOnDown
	WinMove,%NowWinID%, , , % A_ScreenHeight - WH - menuH
else
	WinMove,%NowWinID%, , , % A_ScreenHeight - WH