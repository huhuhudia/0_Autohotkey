
;��͸�����������ʾ��ǰ���ڷ�Χ
try {
#SingleInstance force
alphawin = BABA					;�Ӵ�������
COLORWIN := % "ff0000"		;������ɫ
KILLTIME := 1000					;��ʾʱ�䣬����
alphaNum := 50						;͸���ȣ�Խ��Խ͸��
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