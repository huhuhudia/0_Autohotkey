/*工作流程：
	1.手动运行激活记事本
	2.f1获取记事本信息，并置顶记事本
	3.取得需要发送控件并,在首要声明中赋值给controlS
	5.重点：编码^RButton ctrl+button 
		-- getSendText()	编码设定获取文本途径
		-- Cli_Return可酌情省略
*/


#SingleInstance force

	;首要声明
	TI := 						;激活窗口标题
	xx := 0 , yy := 0			;被激活窗口的坐标，用于tooltip
	controlS := % "Edit1"		;设定发送窗口的控件名称
	
	;创建循环提示
	SetTimer, TOOLTIPX, 100		;循环信息提示
	return


;设置待发送窗口，可作程序自动化
f1::	
	WinSet, ALWAYSONTOP, ON, a	;1置顶
	WinGetTitle, TI, A			;2获取窗口标题
	WinGetPos, xx, yy, , , a	;3获取窗口坐标
	return

;ctrl+右键为主要功能流程
^$RButton::
	getSendText()										;1获取文本途径
	
	ControlSend,  %controlS%, ^v`r, %TI%
	;ControlSendRaw,  %controlS%, %Clipboard%`r, %TI%	;2发送纯文本
	Cli_Return(1120, 617)								;3点击取消扭返回
	return


	
;获取文本途径	
getSendText() {
	Send, {rbutton} 
	sleep 50
	Send, {down 6}
	Send, {enter}
	Sleep 50
	clip_got()	
}


;点击相对全屏某处后返回
Cli_Return(cli_x, cli_y, click_count := 1) {
	CoordMode, mouse, screen
	MouseGetPos, xx, yy
	MouseClick, L, % cli_x, % cli_y, % click_count, 0
	MouseMove, % xx, % yy, 0
}


clip_got()	;发送ctrl+c赋值于全局变量clipboard
{
	Clipboard :=
	SendInput, ^c
	ClipWait
	return %Clipboard%
}



!esc::		;其他，alt+esc退出程序
	ExitApp
	
	
	
TOOLTIPX:	;信息提示于需要传送文本的控件
	if TI
	{
		CoordMode, tooltip, screen
		ToolTip, % "title:" TI "`npos:x" xx " y:" yy , %xx%, %yy%
	}
	else
		ToolTip, 传送窗口尚未设置
	return