/*


*/
GUI, -sysmenu +AlwaysOnTop -caption
Gui, Add, Progress, x0 y0 w300 h25 cBlue vMyProgress
GuiControl,, MyProgress, 0

inputbox, waitingSec, 输入等待时间`,单位为秒
startimeMsec := A_Sec
startime := A_Now
stoptime += waitingSec, s

lastlenght := % (waitingSec - 1) / waitingSec * 100

gui, show, x100 y20 w300 h25

Msecwide := 100 / waitingSec / 1000
loop {
	gotwaittime -= startime, s		;已等待时间
	if (THISTIME(stoptime) = 0) {
		if % (A_Sec >= startimeMsec)
			break
		else
			GuiControl,, MyProgress, % lastlenght + (Msecwide * (startimeMsec - A_MSec))
	}
	else if (THISTIME(stoptime) > 0)
		break
	else if (THISTIME(stoptime) < 0)
		GuiControl,, MyProgress, % gotwaittime / waitingSec * 100 + (Msecwide * A_MSec)
}
GuiControl,, MyProgress, 100
MsgBox, 时间到
return

THISTIME(ST) {
	TT -= ST, s
	return % TT
}


/*
总等待时间进度条0
当前进度条：已等待时间/总等待时间*100
总等待时间：waitingSec
已等待时间：a_now - 起始时间
文本位置：
*/