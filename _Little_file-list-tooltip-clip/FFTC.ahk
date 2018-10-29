#Include %A_ScriptDir%\lib\FileProcessing.ahk

	global cliplist
	FlLiToList(cliplist, A_ScriptDir "\lineList.txt")	;创建粘粘列表
	
	global BLK := % "      "
	global CHO := % "> "
	
	global listlenth := LSL(cliplist)	;列表长度
	global toolList						;所生成toolist内容
	global FocusLine := 0				;关注焦点
	
	CoordMode, tooltip, screen
	SetTimer, tooltip, 100
	
	return
	
LSL(LISTNAME) {		;列表长度
	for i in LISTNAME
		ll := % i
	return %i%
}


^Up::

	if FocusLine > 0
		FocusLine -= 1
	cliptex := % cliplist[FocusLine]
	clip_change(cliptex)
	return

^Down::
	IF FocusLine < % listlenth
		FocusLine += 1

	cliptex := % cliplist[FocusLine]
	clip_change(cliptex)
	return

;
clip_change(to_clipboard)
{
	Clipboard :=
	Clipboard := % to_clipboard
	ClipWait
}

;显示排版
tooltip:
	if	(listlenth) {
		maketoollist(toolList)		;创建
		ToolTip, % toolList, 1518, 50
	}
	else
		ToolTip, [文件列表为空], 1518, 50
	return

maketoollist(ByRef DDD) {	;设定tooltip排版
	;A.首先声明
	
	DDD := 
	
	;B.总列表小于等于5时
	if (listlenth <= 5) {
		loop %listlenth%
		{
			it := % A_Index - 1
			if A_Index = % FocusLine
			{	
				if FocusLine = listlenth
					DDD := % DDD CHO cliplist[it]
				else
					DDD := % DDD CHO cliplist[it] "`n"
			}
				
			else if a_INDEX != % listlenth 
				DDD := % DDD BLK cliplist[it] "`n"
			else 
				DDD := % DDD BLK cliplist[it]
		}
		
	return
	}
	
	;C.总列表大于5时	
	else
	{
		
		;1.在前两位时
		if (FocusLine <= 1) {
			if !FocusLine
			{
				DDD := % CHO cliplist[%FocusLine%]
				loop 4
					DDD := % DDD "`n" BLK cliplist[FocusLine + A_Index]
				return
			}
			if FocusLine = 1
			{
				DDD := % BLK cliplist[0] "`n"
				DDD := % DDD CHO cliplist[FocusLine]
				loop 3
					DDD := % DDD "`n" BLK cliplist[FocusLine + A_Index]
				return
			}
			
		}
			
			
			
		;1.在后两位时
		else if (FocusLine >= %listlenth% - 1) {
			if FocusLine = % listlenth - 1
			{
				DDD := % BLK cliplist[FocusLine - 3] "`n"
				DDD := % DDD BLK cliplist[FocusLine - 2] "`n"
				DDD := % DDD BLK cliplist[FocusLine - 1] "`n"
				DDD := % DDD CHO cliplist[FocusLine]  "`n"
				DDD := % DDD BLK cliplist[FocusLine + 1]
				return
			}
			if FocusLine = % listlenth
			{
				DDD := % BLK cliplist[FocusLine - 4] "`n"
				loop 3
					DDD := % DDD BLK cliplist[FocusLine - 4 + A_Index] "`n"
				DDD := % DDD CHO cliplist[FocusLine]
				return
			}
			
		
		}

		;3.正常排版
		line1 := % BLK cliplist[FocusLine - 2] "`n"
		line2 := % BLK cliplist[FocusLine - 1] "`n"
		line3 := % CHO cliplist[FocusLine] "`n"
		line4 := % BLK cliplist[FocusLine + 1] "`n"
		line5 := % BLK cliplist[FocusLine + 2]
		DDD := % line1 line2 line3 line4 line5
		return
	}
}