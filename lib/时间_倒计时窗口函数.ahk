/*
以秒值为单位
CtDwGC(5) ; 唯一参数，等待秒数
*/


CtDwGC(__waitingSec) {
	__startTNow := A_Now
	__startTMSec := A_MSec
	__startT := [__startTNow, __startTMSec] 	;记录开始时间
	__startTNow += __waitingSec , s	
	__stopT := [__startTNow, __startTMSec]	;记录结束时间	
	__perMSecWide := 100 / __waitingSec	;每秒时间所占进度条长度
	__w := 150	;进度条长度
	__h := 8	;进度条高度
	__x := % (A_ScreenWidth - __w) / 2		;相对全屏正中央窗口位置
	__y := % (A_ScreenHeight - __h) / 2
	global __MycountdownProgress ;设定GUI初始样式
	GUI, __countdownGUI: new
	Gui, __countdownGUI: Add, Progress, x0 y0 w%__w% h%__h% c6f6c6d Backgroundfffdf0 v__MycountdownProgress
	GUI, __countdownGUI: -sysmenu +AlwaysOnTop -caption +Border
	GuiControl,, __MyProgress, 0
	Gui, __countdownGUI:show, x%__x% y%__y% w%__w% h%__h%
	loop {	;计算剩余时间并改变进度条长度
		__noww := [A_Now, A_MSec]
		__wide := Floor(__NMsecSubt(__noww, __startT) * __perMSecWide)
		if (__NMsecSubt(__noww, __stopT) < 0) 
			GuiControl, ,  __MycountdownProgress, % __wide
		else
			break
	}
	Gui, __countdownGUI: Destroy ;无剩余时间，销毁窗口
	return 0 	;省略段：将进度条置于百分百长度 GuiControl,, __MyProgress, 100
}

__NMsecSubt(tmlsA, tmlsB) {	;计算两时间点列表值的差
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % subSVar + ((tmlsA[2] - tmlsB[2]) / 1000)
	else
		return % (tmlsA[2] - tmlsB[2]) / 1000
}
/*
弃用代码：
	以两个独立窗口代替进度条控件的背景和进度条

CtDwGUI(waitingSec) {
	
	startTNow := A_Now
	startTMSec := A_MSec
	startT := [startTNow, startTMSec]
	;计算结束时间
	startTNow += waitingSec, s
	stopT := [startTNow, startTMSec]	;结束时间0	
	__w := 150
	__h := 15
	perMSecWide := % __w / waitingSec
	__x := % (A_ScreenWidth - 390) / 2
	__y := % (A_ScreenHeight - 24) / 2
	global __mytex
	global __MyProgress
	GUI, __ProgressGUI: new
	GUI, __countdownGUI: new
	
	
	GUI, __ProgressGUI: -sysmenu +AlwaysOnTop -caption +Border
	GUI, __countdownGUI: -sysmenu +AlwaysOnTop -caption +Border
	Gui, __countdownGUI:COLOR, d0d0d0
	Gui, __countdownGUI:show, x%__x% y%__y% w%__w% h%__h%
	Gui, __ProgressGUI:show, x%__x% y%__y% w0 h%__h%
	Gui, __ProgressGUI:+Hwnd__theHwnd

	loop {
		noww := [A_Now, A_MSec]
		__wide := Floor(NMsecSubt(noww, startT) * perMSecWide)
		___color := % Floor(( __wide / __w) * 255)
		if (NMsecSubt(noww, stopT) < 0) {
			Gui, __ProgressGUI:COLOR, % "FF" __to16(255 - ___color) "00"
			WinMove , % "ahk_id" __theHwnd, , , , % __wide
			ToolTip, % ___color __to16(255 - ___color)
		}
		else
			break
	}
	Gui, __ProgressGUI:Destroy
	Gui, __countdownGUI:Destroy
}

;0-255十进制数转16进制字符串
__to16(in10) {
	if (in10 > 255) or (in10 < 0) {
		MsgBox, 进制转换函数进参数错误，请取值0-255
		return 0
	}
	if in10 < 16
		return % "0" __fivtto16(in10)
	else {
		pos1 := __fivtto16(Mod(in10, 16))
		pos2 := __fivtto16(Floor(in10 / 16))
		return % pos2 pos1
	}
		
}
;0到15转16进制
__fivtto16(in10) {
	if in10 = 10
		return % "a"
	if in10 = 11
		return % "b"
	if in10 = 12
		return % "c"
	if in10 = 13
		return % "d"
	if in10 = 14
		return % "e"
	if in10 = 15
		return % "f"
	else
		return % in10
}
*/