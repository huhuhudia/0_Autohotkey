#NoEnv
#SingleInstance FORCE
#Persistent
CoordMode, tooltip, screen

	testFileName = lineList.txt	;测试文件名称
	global cliplist := FlLiToList(A_ScriptDir "\" testFileName)	;创建粘粘列表
	global maxIlength := StrLen(cliplist.MaxIndex())	;列表极限数量字符长度
	global FocusLine := 1		;初始关注焦点
	global linenum := 5	;设定显示行数,决定焦点位置，可以更改
	global showway := % (!Mod(linenum, 2)) ? (Floor(linenum / 2)) : Ceil(linenum / 2)	;focusline显示位置
	
	infofresh := 80		;信息刷新时间间隔
	keyfocusgetsleep := 20	;按键切换功能休眠时间
return

MButton::
	if (show1 := !show1) {
		SetTimer, tooltip, % show1 ? infofresh : ("off")
		show2 := 1
	}
	else
		ToolTip
return

#if show1

;ctrl + 上键 焦点前移
WheelUp::
	FocusLine -= 1	;关注焦点上移，对应序号往前
	if (FocusLine <= 0)
		FocusLine := cliplist.MaxIndex() ;至底部
	
	
	
	
	cliptex := % cliplist[FocusLine]	;获取焦点文本，可将列表设置为文件名
	clip_change(cliptex)	;将焦点文本赋值于剪切板
	sleep % keyfocusgetsleep
return
	
;ctrl + 下键 焦点后移
WheelDown::

	FocusLine += 1	;关注焦点下移，对应序号往后
	if (FocusLine >= cliplist.MaxIndex())
		FocusLine := 1 ;至顶部
	
	cliptex := % cliplist[FocusLine]
	clip_change(cliptex)
	sleep % keyfocusgetsleep
return




;tooltip显示排版
tooltip:
	if (show2 != 1) {	;刚切换模式时
		tooltex := maketoollist()
		if (extext = tooltex) ;若上一次显示的内容与此次 相同，不显示ToolTip,解决闪屏
			return
	}
	show2 = 2
	if	cliplist.MaxIndex()	{ ;若列表不为空，显示排版
		;若上一次显示的内容与此次 相同，不显示ToolTip
		ToolTip, % tooltex, 1518, 50
		WinSet, TransColor, Color [N], WinTitle

		extext := tooltex
	}
	else
		ToolTip, [黏贴列表为空], 1518, 50
return

maketoollist() {	;设定tooltip排版
	rtTex := 0
	;1.列表小于linenum数时，列表不增不减，关注焦点为focusline
	if (cliplist.MaxIndex() <= linenum) { ;设定显示行数大于列表数量时，随focusline焦点
		for i in cliplist
		{
			foc := i
			if (i = 1) && (FocusLine = 1)
				rtTex := % preCHO(foc) cliplist[foc]
			else if (i != 1) && (FocusLine = 1)
				rtTex := % rtTex "`n" preBLK(foc) cliplist[foc]
			else if (i != 1) && (i = FocusLine)
				rtTex := % rtTex "`n" preCHO(foc) cliplist[foc]
		}
		
	}
	;2.showway以上或以下小于裁剪数量时，分别增量反方向的行数
	else if (FocusLine < showway) {	;focusline小于showway
			;Showway = 显示的位置
			;FocusLine = 在列表中的位置
			;linenum =总行数
			;rtTex =tooltip显示输出的文本
			upwaynum := % showway - FocusLine + 1	;显示于顶上的总行数
			upstartpoint := % cliplist.MaxIndex() - upwaynum + 1 ;顶上起始行数
			
		loop, % upwaynum + 1				;②.创建列表位置为1 前的行
		{
			foc := % upstartpoint + A_index
			if A_index = 1 
				rtTex := % preBLK(foc) cliplist[foc]
			else 
				rtTex := % rtTex "`n" preBLK(foc) cliplist[foc]
			if (foc =  cliplist.MaxIndex())	;复制至表尾最后一行
				break
		}
		
		loop % (linenum - upwaynum + 1)		;①.创建列表位置为1 后的行
		{
			foc := a_INDEX
			if a_INDEX = % FocusLine
				rtTex := % rtTex "`n" preCHO(foc) cliplist[foc]
			else
				rtTex := % rtTex "`n" preBLK(foc) cliplist[foc]
		}
	}
		


	else if (FocusLine > (!Mod(linenum, 2) ? (cliplist.MaxIndex() - showway) : (cliplist.MaxIndex() - showway))) {
		loop, % cliplist.MaxIndex() - FocusLine + showway
		{
			foc := % focusline - showway + A_Index
			if A_Index = 1
				rtTex := % preBLK(foc) cliplist[foc]
			else if ((foc) = FocusLine)
				rtTex := % rtTex "`n" preCHO(foc) cliplist[foc]
			else
				rtTex := % rtTex "`n" preBLK(foc) cliplist[foc]
			
			if (foc) = cliplist.MaxIndex()
				break
		}
		
		downtopnum := % linenum - (cliplist.MaxIndex() - (focusline - showway))
		Loop, % downtopnum
		{
			rtTex := % rtTex "`n" preBLK(A_Index) cliplist[A_Index]
		}
	}
	;3.正常显示方式，
	else {
		foc := % FocusLine - showway + 1
		loop % linenum
		{
			if a_INDEX = 1
				rtTex := %  (FocusLine = 1) ? preCHO(foc) : preBLK(foc) cliplist[foc]
			else 
				rtTex := % rtTex "`n" ((foc != FocusLine) ? preBLK(foc) : preCHO(foc)) cliplist[foc]
			
			foc += 1
		}
	}
	return % rtTex
}

;将字符串置入粘贴板
clip_change(to_clipboard)
{
	Clipboard :=
	Clipboard := % to_clipboard
	ClipWait
}

preCHO(inchar) {	;前置显示选中
	mid := % "> " 
	gotforlen := maxIlength - StrLen(inchar)
	Loop %gotforlen% 
		Bfor := % Bfor "0"
	return % Bfor inchar " |" mid 	
}

preBLK(inchar) {	;前置显示空白
	mid := % "       "
	gotforlen := maxIlength - StrLen(inchar)
	Loop %gotforlen% 
		Bfor := % Bfor "0"
	return % Bfor inchar " |" mid 	
}

FlLiToList(filelongpath) {	;将true每行内容写入列表，返回列表
	Array1 := []
	loop, read, % filelongpath
	{
		if A_LoopReadLine
			Array1.Insert(A_LoopReadLine)
	}
	if !Array1.MaxIndex()
		return 0
	else
		return % Array1
}



