#NoTrayIcon
#singleinstance force
;居中当前窗口
WinGet, idit,  id, A
winid := % "ahk_id " idit
WinGetPos, , , ww, wh, % winid
winmove, %winid%, , % (A_ScreenWidth - ww) / 2, % (A_ScreenHeight - wh) / 2
