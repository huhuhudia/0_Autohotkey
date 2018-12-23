#SingleInstance force
;将窗口设置为屏幕宽高一半并居中当前窗口
WinGet, idit,  id, A
winid := % "ahk_id " idit

ww := % A_ScreenWidth / 2
wh := % A_ScreenHeight / 2
wx := % (A_ScreenWidth - ww) / 2
wy := % (A_ScreenHeight - wh) / 2
winmove, %winid%, , % wx, % wy, % ww, % wh
