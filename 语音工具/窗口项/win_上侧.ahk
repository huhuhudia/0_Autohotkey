#singleinstance force

WinGet, NowWinID, ID, A
NowWinID := % "ahk_ID " NowWinID

FileReadLine, MENUID, % a_scriptdir "\win_ini\winmenu.txt" , 1		;��Ϊ��ȡʶ�𴰿�ID
WinGetPos, , menuY, menuW, menuH, %MENUID%	;��Ϊ�˵���������Ϣ

if ((menuY = 0 ) && (menuW = A_ScreenWidth))
	menuOnTop := 1

if menuOnTop
	WinMove,%NowWinID%, , , % menuH
else
	WinMove,%NowWinID%, , , 0