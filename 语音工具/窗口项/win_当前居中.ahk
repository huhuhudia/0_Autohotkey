#singleinstance force
;���е�ǰ����
WinGet, idit,  id, A
winid := % "ahk_id " idit
WinGetPos, , , ww, wh, % winid
winmove, %winid%, , % (A_ScreenWidth - ww) / 2, % (A_ScreenHeight - wh) / 2
