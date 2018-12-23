winMoveX(speed := 10, increment := 1.2) {
	;1.创建key列表，若参数错误报错	
	key := A_ThisHotkey
	keylist := {"right" : 1, "left" : 1, "up" : 1, "down" : 1}
	if !(keylist[key]) {
		for i in keylist
			tex := % tex i "`n"
		MsgBox, % "key值设定错误，参考以下key值：`n" tex
		return
	}
	;2.获取当前窗口ID
	WinGet, AwinID, ID, A
	AwinID := % "ahk_ID " AwinID
	;3.居中窗口
	WinGetPos, , , WW, WH, % AwinID
	WinMove, %  AwinID, , % (A_ScreenWidth - WW) / 2, % (A_ScreenHeight - WH) / 2
	;4.设定按键规则
	loop {
		if a_index < 30	
			speed += (A_Index * increment)
		
		if not getkeystate(key, "P")
			break
		
		WW := % (key == "right") ? (WW += speed) : WW
		WW := % (key == "left")  ? (WW -= speed) : WW
		WH := % (key == "up")    ? (WH += speed) : WH
		WH := % (key == "down")  ? (WH -= speed) : WH
		WW := % (WW <= 0) ? 0 : WW
		WH := % (WH <= 0) ? 0 : WH
		WW := % (WW >= A_ScreenWidth) ? A_ScreenWidth : WW
		WH := % (WH >= A_ScreenHeight) ? A_ScreenHeight : WH
		WX := % (A_ScreenWidth - WW) / 2		;窗口屏幕位置x
		WY := % (A_ScreenHeight - WH) / 2		;窗口屏幕位置y
		
		WinMove, % AwinID, , % WX, % WY, % WW, % WH
	}
}