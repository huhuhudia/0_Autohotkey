
#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%



;------ ahk图片搜索相关 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
cliI(cx1, cy1, cx2, cy2, thePathi, slpt := 0) { ;图片点击函数  
	ImageSearch, xx, yy, %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	if errorlevel = 0
	{
		MouseClick, L, %xx%, %yy%, 1, 0
		Sleep, % slpt
	}
	else if errorlevel = 2
		msgbox, 错误`nCliI图片不存在
}
cliO(ox1, oy1, thepatho, ox2, oy2, ox3, oy3, slpt := 0) { ;点击它处函数  
	ImageSearch, , , %ox2%, %oy2%, %ox3%, %oy3%, % thepatho
	if (errorlevel = 0) {
		MouseClick, L, %ox1%, %oy1%, 1, 0
		Sleep, % slpt
	}
	else if (errorlevel = 2) {
		msgbox, 错误`nCliO图片不存在`n %thepatho%
	}
}
imaG(filpath, fin_x1, fin_y1, fin_x2, fin_y2, next_sub) { ;搜图至下一流程函数
	imagesearch, , , %fin_x1%, %fin_y1%, %fin_x2%, %fin_y2%, %filpath%
	if !errorlevel
		gosub, %next_sub%
}

picR(thePathi, cx1, cy1, cx2, cy2) { ;搜图判断函数，找到返回1，没找到返回0
	ImageSearch, , , %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
		if !errorlevel
			return 1
		else if errorlevel = 2
			msgbox, 错误`n判断图片路径错误`n%thePathi%
		else if errorlevel = 1
			return 0
}

conCli(lx, ly, tit, slpt := 0) { ;后台点击函数
	ControlClick, % "x" lx " y" ly, % tit, , L, 1
	Sleep, % slpt
}


;------ 信息提示相关 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
TTscreen(tex, x1 := 239, y1 := 883) { ;tooltip函数，位置一定
	CoordMode, tooltip, screen
	ToolTip, % "当前流程：`n" tex, % x1, % y1
}
TraytipS(tex, sec) {	;traytip函数
	TrayTip, , % tex, % sec
}



;文件创建写入删除相关 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
CrEpFi(filLP) { ;创建空白  文件  ,若存在文件，不动作
	IfNotExist, % filLP
	{
		FileAppend, , % filLP
		Loop {
			IfExist % filLP
				break
		}
	}
}
Cr_EmpFod(fodLP) { ;创建空白  文件夹  ，若存在文件夹，则不动作
	IfNotExist, % fodLP
	{
		FileCreateDir, % fodLP
		Loop {
			IfExist, % fodLP
				Break
		}
	}
}
Cr_AfterDel(tex, filLP) { ;创建文件前删除该文件确认后写入首行文本，确认首行文本后完成
	Loop {
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}	
	FileAppend, % tex, % filLP ,UTF-8
	Loop {
		IfNotExist, % filLP	
			Sleep 10
		Else 
			break
	}
	Loop {	
		FileReadLine, caa, % filLP, 1
		if caa = % tex
			break
	}
}	
Del_F(filLP) { ;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
			FileDelete, % filLP
		IfNotExist, % filLP
			break
	}
}
Ad_ToLL(filLP, tex) { ;写入文本到尾行，确认尾行文本后结束
	FileRead, ca, % filLP
	if (ca) {
		FileAppend, % "`n" tex, % filLP ,UTF-8
		Loop {
			loop, read, % filLP
				lastline := % A_LoopReadLine
			if lastline = % tex
				break
		}
	}
	else {
		FileAppend, % tex, % filLP ,UTF-8
		Loop {
			loop,read, % filLP
				lastline := % A_LoopReadLine
			if lastline = % tex
				break
		}
	}
}
getL(filLP, linenum := 1) { ;获取文件某行字符串，无返回0，默认首行
	IfExist, % filLP
	{
		Filereadline, caa, % filLP, % linenum
		if caa
			return % caa
		else
			return 0
	}
	else
		return 0
}
getLastL(filLP) { ;获取尾行字符串，无返回0
	IfExist, % filLP
	{
		loop, read, % filLP
			lastline := % A_LoopReadLine
		if lastline
			return % lastline
		else
			return 0
	}
	else
		return 0
}

gFLineN(filLP) {	;获取文件行数
	loop, read, % filLP
		linen := % A_Index
	return % linen
}

;时间有关函数 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

GADD(num, dw) {	;_____秒"S"____分钟"M"_____小时"H"_____天"D"______将当前时间戳加上某个时间值，返回计算后时间戳
	td := % A_Now
	EnvAdd, td, num, %dw%
	return % td 
}
gotNDT() {	;获取次日0时时间戳
	td := % A_Now
	EnvAdd, td, 1, Days
	StringTrimRight, td, td, 6
	return % td "000000"
}
GTSubN(td) {	;用一个时间戳减去当前时间的时间戳，返回单位为秒
	EnvSub, td, %A_Now%, Seconds
	return % td
}
GNSubT(td) {	;用当前时间戳减去给定时间戳，返回单位为秒
	toN := % A_Now
	EnvSub, toN, %td%, Seconds
	return % toN
}

TAddS(sec) {	;用当前时间戳加上秒数，返回为时间戳
	tn := % A_Now
	EnvAdd, tn, % sec, Seconds
	return % tn
}

TAddM(min) {	;用当前时间戳加上分钟数，返回为时间戳
	tn := % A_Now
	EnvAdd, tn, % min, Minutes
	return % tn
}


StoHMS(sec) {	;将秒数转换为时 分 秒形式
	if (sec >= 3600) {
		bl := % sec / 3600
		hourN := % Ceil(bl) - 1
		toMin := % Mod(sec, 3600)
		if (toMin < 60) {
			MinN := "0"
			SecondN := % toMin
		}
		else {	
			bl1 := % toMin / 60
			MinN := % Ceil(bl1) - 1
			SecondN := % Mod(toMin, 60)
		}
		return % hourN " 时 " MinN " 分 " SecondN " 秒"
	}
	else if ((sec >= 60) and (sec < 3600)) {
		bl2 := % sec / 60
		MinN := % Ceil(bl2) - 1
		SecondN := % Mod(sec, 60)
		got := % MinN " 分 " SecondN " 秒"
		return % got
	}
	else if (sec < 60) {
		SecondN := % sec
		GP := % SecondN " 秒"
		return % GP
	}
}




;------ 文件字符串匹配 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
SRT_AllL(filLP, tex) { ;某文件里所有行匹配
	loop, read, % filLP
	{
		caa := % A_LoopReadLine
		if (caa = %tex%) {
			gotit := 1
			break
		}
	}
	if (gotit) {
		gotit := 
		return 1
	}
	else
		return 0
}
SFF_AllF(fodP, sfix, tex) { ;某文件夹下所有文件所有行匹配
	gotit := 
	loop, % fodP "\*`." sfix
	{
		thisFN := % A_LoopFileName
		thisFL := %  A_LoopFileLongPath
		loop, read, % thisFL
		{
			thisL := % A_Index
			if (a_loopreadline = %tex%) {
				gotit := 1
				break
			}
		}
		if gotit
			break
	}
	if gotit
		return % thisFN "___" thisL
	else
		return 0
}
FENumG(fod, EndN) { ;输出某文件夹下某种格式后缀文件  数量
	loop, % fod "\*." EndN
		numgot := % A_Index
	return % numgot
}

;------ 进程相关 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
ProExit(proName) { ;关闭所有同名进程  
	loop {
		Process, Close, % proName
		sleep 100
		if !errorlevel
			break
	}
}

;------ 窗口相关 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
winacwait(title) { ;激活并等待激活窗口
	WinActivate, % title
	WinWaitActive, % title
}
ctrlGTex(ctrlName, winTitle) {	;获取窗口控件文本内容并输出
	ControlGetText, theText, % ctrlName, % winTitle
	return %theText%
}


;------ 字符串处理 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
delStr(inputvar, WZ := "R", countx := 0) { ;删除字符串后几位或前几位, 默认右起，不删除字符串
	rightx := "R"
	leftx := "L"
	if (WZ = rightx) {
		StringTrimRight, ca, inputvar, % Countx
		return % ca
	}
	else if (WZ = leftx) {
		StringTrimLeft, ca, inputvar, % Countx
		return % ca
	}
	else 
		return "None got"
}
gotStr(inputvar, WZ := "L", countx := 1) { ;提取字符串后几位或前几位,默认左起1位
	rightx := "R"
	leftx := "L"
	if (WZ = rightx) {
		StringRight, ca, inputvar, %countx%
		return % ca
	}
	else if (WZ = leftx) { 
		StringLeft, ca, inputvar, %countx%
		return % ca		
	}
	else
		return "None got"
}

;------ GUI相关 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
guiCGt(ByRef Gvar) {	;将GUI控件保存至唯一参数，即gui变量名
	GuiControlGet, Gvar, , Gvar
}

guiCGtRT(ByRef Gvar) {	;将GUI控件保存至唯一参数，返回该变量
	GuiControlGet, Gvar, , Gvar
	return, % Gvar
}


guiChan(newtex, ByRef gVar) { ;GUI改变文本函数，若为选择型控件，newText可为0或1
	GuiControl, , gVar, % newtex
}
