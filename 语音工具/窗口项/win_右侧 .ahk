#NoTrayIcon
#singleinstance force
if (!(themenugot_list := getMenuPos_rtDict()))	;~ 若菜单不存在，以全屏坐标为基础
	themenugot_list := [0, 0, 0, A_ScreenWidth, A_ScreenHeight]


WinGet, theid, id, a
theid := % "ahk_id " theid
WinGetPos, , , winwei_int, , % theid

x_int := themenugot_list[4] - winwei_int


WinMove, a, , %x_int%, %y_int%, %w_int%, %h_int%


getMenuPos_rtDict() 
{
	;~ 获取菜单窗口位置信息，范围可用区域起终范围坐标尺寸信息
	FileReadLine, MENUID_str, % a_scriptdir "\Win_ini\winmenu.txt" ,1		;此为读取识别窗口ID
	WinGetPos, menuX, menuY, menuW, menuH, %MENUID_str%						;此为菜单栏坐标信息
	if (menuX = 0) 
	{
		if (menuH = A_ScreenHeight)
			return [1, menuW, 0, A_ScreenWidth - menuW, A_ScreenHeight]	;~ 返回1 菜单在左侧
		if (menuW = A_ScreenWidth)
			return [2, 0, 0, A_ScreenWidth, A_ScreenHeight - menuH]	;~ 返回2 菜单在底部
	}
	if (menuY = 0)
	{
		if (menuH = A_ScreenHeight) 
			return [3, 0, 0, A_ScreenWidth - menuW, A_ScreenHeight]	;~ 返回3 菜单在右侧
		if (menuW = A_ScreenWidth)
			return [4, 0, A_ScreenHeight - menuH, A_ScreenWidth, A_ScreenHeight - menuH]	;~ 返回4 菜单在顶部
	}
	return false
}