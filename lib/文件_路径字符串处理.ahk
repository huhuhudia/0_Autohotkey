/*
唯一参数为文件完整长路径
------------------------------------
	1-->获取文件名
str := strFileName(STRIN) 
------------------------------------
	2-->获取盘符
str := strDrive(STRIN)
------------------------------------
	3-->获取上一层目录名称
str := strForDir(STRIN)
------------------------------------
	4.获取完全路径，不包含文件名,末尾无反斜线
str := strFulltDir(STRIN)

*/

;获取文件名
strFileName(STRIN) {
	Loop, Parse, % STRIN, `\
		NAME := A_LoopField
	return % NAME
}

;获取盘符，如返回C:,不带反斜杠
strPF(STRIN) {
	Loop, Parse, % STRIN, `\
		return % A_LoopField
}

;获取上一层目录名称
strForDir(STRIN) {
	FL := []
	Loop, Parse, % STRIN, `\
		FL.Insert(A_LoopField)
	return % FL[FL.MaxIndex() - 1]
}

;获取完全路径，不包含文件名,末尾无反斜线
strFulltDir(STRIN) {
	FL := []
	Loop, Parse, % STRIN, `\
		FL.Insert(A_LoopField)
	FL.Remove(FL.MaxIndex())
	for I in FL
	{
		if A_Index = 1
			Dir := % FL[A_Index]
		else
			Dir := % Dir "\" FL[A_Index]
	}
	return % Dir
}