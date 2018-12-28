#SingleInstance force
whileList_list := ["ahk_Class Progman"	;~ 此为桌面
,"ahk_Class WindowsForms10.Window.8.app.0.3b93019_r13_ad1"	;~ 此为voiceattack
,"ahk_Class Shell_TrayWnd"]	;~ 此为菜单
for i in whileList_list
{
	IfWinActive, % whileList_list[i]
	{
		ToolTip, 当前窗口受保护
		sleep 800
		ExitApp
	}
}
WinClose, A