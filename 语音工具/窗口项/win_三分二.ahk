#singleinstance force
FileReadLine, MENUID, % a_scriptdir "\win_ini\" winmenu.txt, 1	
MENUID := "ahk_Class Shell_TrayWnd"	
;����ǰ�����ƶ�����������һ��࣬���Ϊ����һ
WinGetPos, menuX, menuY, menuW, menuH, %MENUID%	;��Ϊ�˵���������Ϣ
if ((menuX = 0) && (menuY = 0) && (menuW = A_ScreenWidth))		;����
	SW := A_ScreenWidth, SH := A_ScreenHeight - menuH, WX := 0, WY := A_ScreenHeight - menuH
else if ((menuX = 0) && (menuY = 0) && (menuH = A_ScreenHeight))	;���
	SW := A_ScreenWidth - menuW, SH := A_ScreenHeight , WX := A_ScreenWidth - menuW, WY := A_ScreenHeight
else if ((menuX = 0) && (menuY != 0) && (menuW = A_ScreenWidth))	;�ײ�
	SW := A_ScreenWidth, SH := A_ScreenHeight - menuH, WX := 0, WY := 0
else if  ((menuX != 0) && (menuY = 0)  && (menuH = A_ScreenHeight))		;�Ҳ�
	SW := A_ScreenWidth - menuW, SH := A_ScreenHeight , WX := 0, WY := 0
else
	SW := A_ScreenWidth, SH := A_ScreenHeight , WX := 0, WY := 0

WH := SH
WX := SW / 3
winmove, A, , %WX%, %WY%, % SW / 3, %SH%