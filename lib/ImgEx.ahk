
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

setPosAll(mode := 0) {
	if !mode
		mode := % "window"
	inMode := {"screen" : 1, "window" : 1,  "client" : 1, "relative" : 1}
	if !(ll := inMode[mode])
	{
		for i in inMode
			MsgText := % MsgText A_Index " : "  i  "`n"
		MsgBox, , % "setPosAll`(`) Warning!", % "please choose one of the text in this Function:`n---------------`n" MsgText "---------------`nor the script wont run~"
		return 0
	}
	CoordMode, ToolTip, % mode
	CoordMode, Mouse, % mode
	CoordMode, Pixel, % mode
	CoordMode, Caret, % mode
	CoordMode, Menu, % mode
	return 1
}

/*-----------------------------------------------------------------------------
---> 简易找图函数
-------------------------------------------------------------------------------
*/
;点击函数
MCliForIMG(pos_x, pos_y, sleept := 0) {				
	MouseClick, L, %pos_x%, %pos_y%, 1, 0
	sleep, % sleept
	}
;搜图返回List列表函数
imgRL(imgFileName, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	if (!x2 && !y2) {					;若皆未赋值，取整个屏幕范围
		x2 := % A_ScreenWidth
		y2 := % A_ScreenHeight
		}
	if ((x1 >= x2) || (y1 >= y2))		;错误的坐标范围时
		msgbox, ,% "Wrong Searching Pos！", % "imgRL Func`[" imgFileName  "`]got wrong searching pos！"	
	
	workingDir := % workingDir ?  (workingDir)   : (A_WorkingDir)
	searchEx   := % searchEx   ?  (searchEx " ") : ("")
	
	ImageSearch, pos_X, pos_Y, % x1, % y1, % x2, % y2, % searchEx workingDir "\" imgFileName
		if !errorlevel 
			posList := [pos_X, pos_Y]
		else if errorlevel = 2
			msgbox, , % "Func imgRL() warning!", % " file path：`n`[" workingDir imgFileName "`]`nnot exist！`n" 
		
	return % posList		;找到图片返回列表，未找到图片返回空值	
}



;搜图点击，返回1，未找到不作为，返回空
imgCli(imgFileName, slept := 0, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	if (result := imgRL(imgFileName, workingDir, x1, y1,x2, y2, searchEx)) {
		MCliForIMG(result[1], result[2], slept)
		return 1
	}
}
;搜图点击它处，返回1，未找到不作为，返回空
imgCOr(otherPos_x, otherPos_y,imgFileName, slept := 0, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	if (imgRL(imgFileName, workingDir, x1, y1,x2, y2, searchEx)) {
		MCliForIMG(otherPos_x, otherPos_y, slept)
		return 1
	}
}



/*-----------------------------------------------------------------------------
---> 全屏图色函数
-------------------------------------------------------------------------------
*/

;相对全屏的鼠标点击
MCli_ScrForIMG(pos_x, pos_y, sleept := 0) {				
	CoordMode, mouse, screen
	MouseClick, L, %pos_x%, %pos_y%, 1, 0
	sleep, % sleept
	}

;全屏找图，找到返回坐标列表，未找到返回0，picPosList := % imgScrRL("IMG.png")
imgScrRL(imgFileName, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	CoordMode, pixel, screen
	if (!x2 && !y2) {					;若皆未赋值，取整个屏幕范围
		x2 := % A_ScreenWidth
		y2 := % A_ScreenHeight
		}
	if ((x1 >= x2) || (y1 >= y2))		;错误的坐标范围时
		msgbox, ,% "Wrong Searching Pos！", % "imgScrRL Func`[" imgFileName  "`]got wrong searching pos！"	
	
	workingDir := % workingDir ?  (workingDir)   : (A_WorkingDir)
	searchEx   := % searchEx   ?  (searchEx " ") : ("")
	
	ImageSearch, pos_X, pos_Y, % x1, % y1, % x2, % y2, % searchEx workingDir "\" imgFileName
		if !errorlevel 
			posList := [pos_X, pos_Y]
		else if errorlevel = 2
			msgbox, , % "Func imgScrRL() warning!", % " file path：`n`[" workingDir imgFileName "`]`nnot exist！`n" 
	return % posList
}

;全屏找图，找到点击图片坐标，未找到不行为，picPosList := % imgScrRL("IMG.png")
imgScrCli(imgFileName, slept := 0, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	if (result := imgScrRL(imgFileName, workingDir, x1, y1,x2, y2, searchEx)) {
		MCli_ScrForIMG(result[1], result[2], slept)
		return 1
	}
}

imgScrCOr(otherPos_x, otherPos_y,imgFileName, slept := 0, workingDir := 0, x1 := 0, y1 := 0, x2 := 0 , y2 := 0, searchEx := 0) {
	if (imgScrRL(imgFileName, workingDir, x1, y1,x2, y2, searchEx)) {
		MCli_ScrForIMG(otherPos_x, otherPos_y, slept)
		return 1
	}
	
}


