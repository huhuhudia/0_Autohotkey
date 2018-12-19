global dm := ComObjCreate( "dm.dmsoft" )

setdmdir() {
	
}


;大漠综合工具的文本信息获取
gdmWHD() {	;获取大漠的窗口句柄控件文本
	ControlGetText, dmedithd, Edit45, ahk_exe 大漠综合工具.exe
	return % dmedithd
}
gdmCRgLs() {	;获取大漠窗口选择范围的包括宽高的6位坐标参数列表
	dh = ,
	kh = (
	kh2 = )
	HL := []
	ControlGetText, chosrg, Edit47, ahk_exe 大漠综合工具.exe
	if !chosrg	;为空时返回0
		return 0
	StringReplace, chosrg, chosrg, % dh , o, 1
	StringReplace, chosrg, chosrg, % kh , % "", 1
	StringReplace, chosrg, chosrg, % kh2 , % "", 1
	StringReplace, chosrg, chosrg, 宽高 , % "", 1
	MsgBox, % chosrg
	Loop, Parse, chosrg, o
		HL.Insert(A_LoopField)	
	return % HL
}
