#SingleInstance force
#Persistent

;* 一、将要修改的文件路径赋值黏贴到以下赋值符号后的双引号中
修改文件路径 := "C:\Users\UOLO\Desktop\csvKeyWriteV3\测试文件.txt" 

检测文件路径(修改文件路径)	;此函数路径写错将报错,不要删掉

;* 二、按键对应的字典，格式如下
keyDict := { "a" : ["AP=0", "AP=1"]
			,"b" : ["BP=0", "BP=1"]
			,"c" : ["CP=0", "CP=1"] }

return

F12::
	;F12开关，尽量不舍，不可调换位置
	TrayTip, , % "当前开关：" (开关 := !开关) ? ("开启") : ("关闭"), 1 
	return

#If (开关) ;>>> 此句不可删

;* 三.以下区间添加修改按键映射
;==========
a::
b::
c::
;==========
	nowKeyDict := A_ThisHotkey
	删除并写入列表到每行2(keyDict[nowKeyDict][1], keyDict[nowKeyDict][2], 修改文件路径)
	return


检测文件路径(fileLP) {
	if !FileExist(fileLP)
	{
		MsgBox, % fileLP "`n文件不存在请在代码行设置[修改文件路径]变量`n程序将退出"
		ExitApp
	}
}

删除并写入列表到每行2(检测的行, 替换的行, filLP) {
	临时列表 := []
	Loop, Read, % filLP
	{

		临时列表.insert(a_LOOPREADLINE)
		;MsgBox, % a_LOOPREADLINE " -- " StrLen(a_LOOPREADLINE) "`n" 检测的行 " -- " StrLen(检测的行)
		if (检测的行 = a_LOOPREADLINE)
			要替换的序列 := A_Index
	}
	if 要替换的序列 {
		临时列表[要替换的序列] := 替换的行
		Del_Fil(filLP)
		文件对象 := FileOpen(filLP, "w")
		for i in 临时列表 
		{
			文件对象.Write(临时列表[i] "`r`n")
		}
		文件对象.Close()
		loop {
			if fileexist(filLP)
				break
		}
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
