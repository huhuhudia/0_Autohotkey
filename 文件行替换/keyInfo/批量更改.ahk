按键列表 := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"]
大写列表 := ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"]
中段 := "P="
for i in 按键列表
{
	行1 := 大写列表[i]
	删除并写入列表到每行([行1 中段 "0", 行1 中段 "1", ""], A_ScriptDir "\" 按键列表[i] ".key")
}
return


删除并写入列表到每行( theList,filLP) {
	Del_Fil(filLP)
	文件对象 := FileOpen(filLP, "w")
	文件对象.Write(theList[1] "`n" theList[2] "`n" theList[3])
	文件对象.Close()
	loop {
		if fileexist(filLP)
			break
	}
	return
}
	
Del_Fil(filLP) {
	;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
			FileDelete, % filLP
		IfNotExist, % filLP
			break
	}
}