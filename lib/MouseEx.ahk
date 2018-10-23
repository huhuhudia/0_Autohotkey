;点击全屏屏幕某处，点击后返回原来坐标，CoordMode命令在函数以外不发生作用，无需在函数外声明CoordMode, mouse, window
Cli_Return(cli_x, cli_y, click_count := 1) {
	CoordMode, mouse, screen
	MouseGetPos, xx, yy
	MouseClick, L, % cli_x, % cli_y, % click_count, 0
	MouseMove, % xx, % yy, 0
}