#NoTrayIcon

;用透明不激活窗口显示当前窗口范围
try {
#SingleInstance force
alphawin = BABA					;子窗口名称
COLORWIN := % "ff0000"		;窗口颜色
KILLTIME := 1000					;显示时间，毫秒
alphaNum := 50						;透明度，越低越透明
wingetpos, xx, yy, ww, hh, A
gui, %alphawin% : new
gui, %alphawin% : +AlwaysOnTop -SysMenu -Caption +Border +HwndPiccatch
gui, %alphawin% : show, x%xx% y%yy% w%ww% h%hh% NA, % alphawin
Gui, %alphawin% : Color , %COLORWIN%
winwait, ahk_id %Piccatch%
WinSet, ExStyle, +0x20, ahk_id %Piccatch%
WinSet, Transparent, %alphaNum%, ahk_id %Piccatch%
Sleep %KILLTIME%
}
ExitApp