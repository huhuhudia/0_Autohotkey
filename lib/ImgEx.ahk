
/*

-----------------------------------------------------------------
原始命令：
	ImageSearch, [1] OutputVarX, [2] OutputVarY, [3] X1, [3] Y1, [4] X2, [5] Y2, [6] ImageFile
-----------------------------------------------------------------
整型数：[1][2][3][4][5]
字符串：[6]

①. OutputVarX/Y -> 
	1.相对窗口或左上
	2.有无找到都被置空。保存图像的左上角像素的 X 和 Y 坐标的变量名 (如果没有找到匹配, 则这两个变量被置空)..，

②X1, ③Y1 -> 左上
④X2, ⑤Y2 -> 右下
	0.搜索矩形区域范围

⑥imageFile，图片文件
	1.建议以png格式图片查找
	2.*n 色值渐变模糊匹配
	  *10
	3.*Trans+色值
	  *TransWhite  -> 忽略FFFFFF
	  *TransFFFFAA
*/

/*-----------------------------------------------------------------------------
---> 基本搜图函数，找到图片返回坐标列表，未找到返回0，picPosList := % imgRtList("IMG.png")
-------------------------------------------------------------------------------
*/
imgRtList(x1, y1, x2, y2, imgLP) {	
	if ((x1 >= x2) || (y1 >= y2))	;错误的坐标范围时
		msgbox, ,% "Wrong Searching Pos！", % "imgRtList`[" imgLP  "`]got wrong searching pos！"
	ImageSearch, pos_X, pos_Y, % x1, % y1, % x2, % y2, % imgLP
	if !errorlevel {
		posList := [pos_X, pos_Y]
		return % posList
	}
	else if errorlevel = 1
		return 0
	else
		msgbox, , % "Wrong File Path！", % "file path：`n" imgLP "`nnot exist！" 
	}


/*-----------------------------------------------------------------------------
---> 全屏图色函数
-------------------------------------------------------------------------------
*/

;相对全屏的鼠标移动
MMv_Scr(pos_x, pos_y) {	
	CoordMode, mouse, screen
	MouseMove, %pos_x%, %pos_y%, 0
	}

;相对全屏的鼠标点击
MCli_Scr(pos_x, pos_y, sleept := 0) {				
	CoordMode, mouse, screen
	MouseClick, L, %pos_x%, %pos_y%, 1, 0
	sleep, % sleept
	}

;全屏找图，找到返回坐标列表，未找到返回0，picPosList := % imgScrRL("IMG.png")
imgScrRL(imgFileName, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	CoordMode, Pixel, Screen			;
	if (!x2 && !y2) {					;若皆未赋值，取整个屏幕范围
		x2 := % A_ScreenWidth
		y2 := % A_ScreenHeight
		}
	if ((x1 >= x2) || (y1 >= y2))		;错误的坐标范围时
		msgbox, ,% "Wrong Searching Pos！", % "ImgScreenFunc`[" imgFileName  "`]got wrong searching pos！"
	workingDir := % workingDir ?  (workingDir)   : (A_WorkingDir)
	searchEx   := % searchEx   ?  (searchEx " ") : ("")
	result := % imgRtList(x1, y1, x2, y2, searchEx workingDir "\" imgFileName)
	return % (result ? result : 0)		;找到图片返回列表，未找到图片返回0
	}

;全屏找图，找到点击图片坐标，未找到不行为，picPosList := % imgScrRL("IMG.png")
imgScrCli(imgFileName, slept := 0, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	result := % imgScrRL(imgFileName, workingDir, x1, y1,x2, y2, searchEx)
	if result
		MCli_Scr(result[1], result[2], slept)
	}



/*-----------------------------------------------------------------------------
---> 窗口图色函数
----------------------------------------------------------------------------- 
*/

;相对窗口的鼠标移动
MMv_Win(pos_x, pos_y) {
	CoordMode, mouse, window
	MouseMove, %pos_x%, %pos_y%, 0
	}

;相对窗口的鼠标点击
MCli_Win(pos_x, pos_y, sleept := 0) {
	CoordMode, mouse, window
	MouseClick, L, %pos_x%, %pos_y%, 1, 0
	sleep, % sleept
	}

;窗口找图，找到返回坐标列表，未找到返回0，picPosList := % imgScrRL("IMG.png")
imgWinRL(imgFileName, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	CoordMode, Pixel, window
	if (!x2 && !y2) {				;若皆未赋值，取整个窗口长宽范围
		WinGetPos, , , A_WinWidth, A_Winheight, A	;仅获取当前窗口
		x2 := % A_WinWidth
		y2 := % A_Winheight
		}
	if ((x1 >= x2) || (y1 >= y2))	;错误的坐标范围时
		msgbox, ,% "Wrong Searching Pos！", % "imgWinRL`[" imgFileName  "`]got wrong searching pos！"
	workingDir := % workingDir ?  (workingDir)   : (A_WorkingDir)
	searchEx   := % searchEx   ?  (searchEx " ") : ("")
	result := % imgRtList(x1, y1, x2, y2,  searchEx workingDir "\" imgFileName)
	return % (result ? result : 0)	
	}



imgWinCli(imgFileName, slept := 0, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	result := % imgWinRL(imgFileName, workingDir, x1, y1,x2, y2, searchEx)
	if result
		MCli_Win(result[1], result[2], slept)	
	}


