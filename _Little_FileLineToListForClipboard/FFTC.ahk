﻿#NoEnv
#SingleInstance FORCE
#Persistent
CoordMode, tooltip, screen

	global cliplist := FlLiToList(A_ScriptDir "\lineList.txt")	;创建粘粘列表
	
	global BLK := % "      "	;未选中的前置字符串
	global CHO := % "> "		;选中的前置字符串
	;~ global toolList				;所生成toolist内容
	
	global FocusLine := 1		;初始关注焦点
	global linenum := 3	;设定显示行数,决定焦点位置
	global showway := % (!Mod(linenum, 2)) ? (Floor(linenum / 2)) : Ceil(linenum / 2)
	SetTimer, tooltip, 200
return

;将true每行内容写入列表，返回列表
FlLiToList(filelongpath) {	
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


;显示排版
tooltip:
	if	(cliplist.MaxIndex()) {
		ToolTip, % maketoollist(), 1518, 50
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
			if (i = 1) && (FocusLine = 1)
				rtTex := % CHO cliplist[i]
			else if (i != 1) && (FocusLine = 1)
				rtTex := % rtTex "`n" BLK cliplist[i]
			else if (i != 1) && (i = FocusLine)
				rtTex := % rtTex "`n" CHO cliplist[i]
		}
		
	}
	;2.showway以上或以下小于裁剪数量时，分别增量反方向的行数
	else if (FocusLine < showway) {	;focusline小于showway
			Fulllist := []
			upwaynum := % showway - FocusLine	;显示于顶上的总行数
			upstartpoint := % cliplist.MaxIndex() + 1  ;顶上起始行数
			loop %upstartpoint% {
				if A_index = 1 
					rtTex := % BLK cliplist[upstartpoint]
				else 
					rtTex := % rtTex "`n" BLK cliplist[upstartpoint]
				if ((upstartpoint + A_index) =  cliplist.MaxIndex())
					break
			}
			
			
	}
		


	else if (FocusLine > (!Mod(linenum, 2) ? (cliplist.MaxIndex() - showway) : (cliplist.MaxIndex() - showway - 1))) {
		
		return % "未了"
	}
	;3.正常显示方式，
	else {
		startpoint := % FocusLine - showway + 1
		loop % linenum
		{
			if a_INDEX = 1
				rtTex := % BLK cliplist[startpoint]
			else 
				rtTex := % rtTex "`n" ((startpoint != FocusLine) ? BLK : CHO) cliplist[startpoint]
			startpoint += 1
		}
	}
	return % rtTex
}
	
/*
此为未完成功能，类似c语言中数字printf函数中%3d
1.总字符数长度
2.% (总字符数长度 - 当前字符数长度 )  *  _ 当前字符
*/


^Up::
	FocusLine -= 1	;关注焦点上移，对应序号往前
	if (FocusLine = 0)
		FocusLine := cliplist.MaxIndex() ;至底部
	
	cliptex := % cliplist[FocusLine]
	clip_change(cliptex)
	sleep 50
	return

^Down::

	FocusLine += 1	;关注焦点下移，对应序号往后
	if (FocusLine = cliplist.MaxIndex())
		FocusLine := 1 ;至顶部
	
	cliptex := % cliplist[FocusLine]
	clip_change(cliptex)
	sleep 50
	return

;将字符串置入粘贴板
clip_change(to_clipboard)
{
	Clipboard :=
	Clipboard := % to_clipboard
	ClipWait
}