


filesize_rtInt(fileLongPath)  {
	FileGetSize, byteit , %fileLongPath%
	return byteit
}

dirsize_rtLs(dirorfilelongPath, showTT := 1){
	;返回1.尺寸2.文件数量3.占据磁盘比率列表
	DriveGet, DriveSize_int,Cap, % dirorfilelongPath
	if (byteit := filesize_rtInt(dirorfilelongPath) )
		return [byteit, 1, afile / (DriveSize_int *  1024 * 1024)]
	else {
		loop, % nowget "\*", 0, 1
		{
			lenth_int := A_Index
			lsbyte_int := filesize_rtInt(A_LoopFileLongPath)  
			byteit += lsbyte_int
			if showTT
				ToolTip, % "文件个数：" lenth "`n实际尺寸：" byteit "byte"
		}
	}
	tooltip
	return [byteit, lenth_int, byteit / (DriveSize_int *  1024 * 1024)]
}

fileSize() {
	;返回1.尺寸2.文件数量3.占据磁盘总量 列表
	DriveGet, size,Cap, % nowget
	FileGetSize, byteit , %nowget%
	if (!byteit) {
		;ToolTip, % lsbyte
		
		loop, % nowget "\*", 0, 1
		{
			lenth := A_Index
			FileGetSize, lsbyte , % A_LoopFileLongPath
			byteit += lsbyte
			ToolTip, % "文件个数：" lenth "`n实际尺寸：" byteit "byte"
		}
	}
	return []
}

递归移动文件(fromdir, todir) {
	;将一个文件夹下的所有文件(递归)，移动到另一个文件夹
	Loop, % fromdir . "\*", , 1
		{
			FileMove, % A_LOOPFILELONGPATH , % todir . "\" . A_Index . "-" . A_LoopFileName
		}
	}

;文件创建 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Cre_EpFi(filLP) {
	;创建空白  文件  ,若存在文件，不动作
	IfNotExist, % filLP
	{
		FileAppend, , % filLP, UTF-8
		Loop {
			IfExist % filLP
				break
		}
	}
}

Cre_EpFd(fodLP) {
	;创建空白  文件夹  ，若存在文件夹，则不动作
	IfNotExist, % fodLP
		{
		FileCreateDir, % fodLP
		Loop {
			IfExist, % fodLP
				Break
			}
		}
}
Cre_AftDel(filLP) {	;创建文件前删除文件
	Del_Fil(filLP)
	Cre_EpFi(filLP)
}

;文件写入 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Add_LiToFl(tex, filLP) { ;写入文本到尾行,若不存在文件，则创建文件并写入首行
	FileRead, ca, % filLP
	if ca
		FileAppend, % "`n" tex, % filLP ,UTF-8
	else 
		FileAppend, % tex, % filLP ,UTF-8
}

Write_AfrDel(oneLine, filLP) {	;写入前删除文件，确认该行后结束
	Del_Fil(filLP)
	FileAppend, % oneLine, % filLP ,UTF-8
	loop {
		if fileexist(filLP)
			break
	}
	loop {
		FileRead, line1, % filLP
		if (line1 = oneLine)
			break
	}
}


;文件删除 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Del_Fil(filLP) { ;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
			FileDelete, % filLP
		IfNotExist, % filLP
			break
	}
}

;文件读取 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

GetLi(filLP, linenum := 1) { ;获取文件某行字符串，无返回0，默认首行
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

FlLiToList(ByRef array_read, filelongpath) {	;将true行数内容写入列表，返回
	arraylenght := 0
	loop, read, % filelongpath
	{
		if A_LoopReadLine
		{
			if !arraylenght
			{
				arraylenght := 1
				array_read := []
			}
			else
				arraylenght += 1
			array_read[arraylenght - 1] := A_LoopReadLine
		}
		
		
	}
	return %arraylenght%
}