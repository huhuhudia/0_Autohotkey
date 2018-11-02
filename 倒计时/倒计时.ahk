	GUI, -sysmenu +AlwaysOnTop -caption +Border
	gui,font, cf6f8da s12, Consolas
	Gui, Add, text, x305 y2 w300 h25 vmytex, :0
	Gui, Add, Progress, x-1 y-1 w300 h27 c293d3f Backgroundf6f8da vMyProgress
	GuiControl,, MyProgress, 0
	;获取倒计时间隔秒数
	inputbox, waitingSec, 输入等待时间`,单位为秒
	;每秒所占的像素单位长度
	perMSecWide := 100 / waitingSec / 1000
	;记录开始时间
	startTNow := A_Now
	startTMSec := A_MSec
	startT := [startTNow, startTMSec]
	;计算结束时间
	startTNow += waitingSec, s
	stopT := [startTNow, startTMSec]	;结束时间0
	;显示进度条
	gui, COLOR, 293d3f
	gui, show, x100 y20 w390 h25
	;计算改变进度条
	loop {
		noww := [A_Now, A_MSec]
		wide := Floor(NMsecSubt(noww, startT) * 1000 * perMSecWide)
		if (NMsecSubt(noww, stopT) < 0) {
			GuiControl, ,  MyProgress, % wide
			ttttt := % NMsecSubt(stopT, noww)
			StringTrimRight, ttttt, ttttt, 3
			GuiControl, ,  mytex, % ":" ttttt
		}
		else
			break
	}
	GuiControl,, MyProgress, 100
ExitApp

NMsecSubt(tmlsA, tmlsB) {	;计算两时间点列表值的差
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % subSVar + ((tmlsA[2] - tmlsB[2]) / 1000)
	else
		return % (tmlsA[2] - tmlsB[2]) / 1000
}







