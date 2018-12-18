#SingleInstance force

键信息文件路径 := % A_ScriptDir "\keyInfo"
创建空文件夹(键信息文件路径)

按键列表 := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"]
键功能字典 := {}
按列表名称创建键文件(键信息文件路径, 按键列表)


横坐标 := A_ScreenWidth - 500
纵坐标 := 100

宽度 := 350

gui, Add, listview, x0 w%宽度% HScroll800 VScroll800 glistview双击事件  r20 NoSort Grid Count , 按键|检测行|替补行|待修改csv文件路径

gui, Add, text, , 双击更改输出字符串或修改文件路径
gui, Add, Button, g更改待检测csv文件路径, 更改待检测csv文件路径
Gui, Add, Checkbox, g按键列表启用_标签 v按键列表启用_变量 h25 center, F12启用/禁用按键列表
gui, +ToolWindow +AlwaysOnTop
gui, show, x%横坐标% y%纵坐标% w%宽度%
gosub, 更新按键列表
return

更新按键列表:
	for i in 按键列表
	{
		键功能字典[按键列表[i]] := { "检测行" : 读取文件行(A_ScriptDir "\keyInfo\" 按键列表[i] ".key", 1)
								, "替补行" : 读取文件行(A_ScriptDir "\keyInfo\" 按键列表[i] ".key", 2)
								, "长路径" : 读取文件行(A_ScriptDir "\keyInfo\" 按键列表[i] ".key", 3)}
	}
	LV_Delete()
	for 键位名 in 键功能字典
	{
		LV_Add("", 键位名, 键功能字典[键位名]["检测行"], 键功能字典[键位名]["替补行"], strFileName(键功能字典[键位名]["长路径"]))
	}
	Sleep 200
	总列数 := LV_GetCount("C")
	Loop, 4
	{
		LV_ModifyCol(A_Index, "Center")
	}
	return
/*
!f1::

	for i in 按键列表
	{
		Send, % 按键列表[i] "::{ENTER}" 
		
	}
	return
*/

更改待检测csv文件路径:
	FileSelectFile, 选择文件长路径, 1
	if 选择文件长路径 {
		for key in 键功能字典
		{
			键功能字典[key]["长路径"] := 选择文件长路径
			删除并写入列表到每行( [键功能字典[key]["检测行"], 键功能字典[key]["替补行"], 键功能字典[key]["长路径"]], 键信息文件路径 "\"  key ".key")
		}
	}
	return
	
	
listview双击事件:
	键位名_列 := 1
	检测行_列 := 2
	替换行_列 := 3
	全路径_列 := 4
	if (A_GuiEvent == "DoubleClick")
	{
		双击行位置 := LV_GetNext(双击行位置, "Focused")
		;待修改文件名
		LV_GetText(当前双击键名, 双击行位置, 键位名_列)
		修改文件名 := 键功能字典[键位名_列][全路径_列]
		gosub, 修改字典
		
	}
	return
	
修改字典:

	InputBox, 检测text, 检测行修改, 不输入参数保持不变`n输入"-"留空`n正常输入修改
	if (typeof(检测text) == "None")
		键功能字典[当前双击键名]["检测行"] := 
	else if ((检测text) or (typeof(检测text) == "int|False"))
		键功能字典[当前双击键名]["检测行"] := 检测text
	
	InputBox, 替补text, 替补行修改, 不输入参数保持不变`n输入"-"留空`n正常输入修改`n完成后将打开文件选择
	if (typeof(替补text) == "None")
		键功能字典[当前双击键名]["替补行"] := 
	else if ((替补text) or (typeof(替补text) == "int|False"))
		键功能字典[当前双击键名]["替补行"] := 替补text
	
	删除并写入列表到每行( [键功能字典[当前双击键名]["检测行"], 键功能字典[当前双击键名]["替补行"], 键功能字典[当前双击键名]["长路径"]], 键信息文件路径 "\"  当前双击键名 ".key")
	gosub, 更新按键列表
	return

f12::
f12标签:
	;该按键为模拟选择启用事件
	GuiControlGet, 按键列表启用_变量, , 按键列表启用_变量 
	guicontrol, , 按键列表启用_变量, % (!按键列表启用_变量)
	gosub, 按键列表启用_标签
	return
	
按键列表启用_标签:
	;该标签为选择启用事件
	GuiControlGet, 按键列表启用_变量, , 按键列表启用_变量 
	if 按键列表启用_变量
		gui, hide
	else
		gui, show
	TrayTip, , % "当前按键功能 " ((按键列表启用_变量) ? ("启用") : ("禁用")), 0.2
	return



#if 按键列表启用_变量

a::
b::
c::
d::
e::
f::
g::
h::
i::
j::
k::
l::
	当前启用按键名称 := A_ThisHotkey
	keywait, % 当前启用按键名称
	if (!fileexist(键功能字典[当前启用按键名称]["长路径"]) or !键功能字典[当前启用按键名称]["长路径"]) {
		MsgBox, 未指定要修改的文件路径或指定路径不存在`n请设置路径后执行按键功能
		gosub, f12标签
		return
	}
	删除并写入列表到每行2(键功能字典[当前启用按键名称]["检测行"], 键功能字典[当前启用按键名称]["替补行"], 键功能字典[当前启用按键名称]["长路径"])
	检 := 键功能字典[当前启用按键名称]["检测行"]
	替 := 键功能字典[当前启用按键名称]["替补行"]
	
	return
	
strFileName(STRIN) {
	;获取文件名
	Loop, Parse, % STRIN, `\
		NAME := A_LoopField
	return % NAME
}	
	
typeof(thevar) {
	if ((!thevar) && (thevar!= 0))
		return % "None"
	else if thevar is integer
	{
		if thevar is time
			return % "int|True|Time"
		if thevar
			return % "int|True"
		else
			return % "int|False"
	}

	else if thevar is Float
	{
		if thevar
			return % "float|True"
		else
			return % "float|False"
	}
	else
	{
		if thevar is space
			return % "str_SpaceOnly|True"
		else 
			return % "str|True"
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
	
Write_AfrDel(oneLine, filLP) {
	;写入前删除文件
	Del_Fil(filLP)
	FileAppend, % oneLine, % filLP
	loop {
		if fileexist(filLP)
			break
	}
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

按列表名称创建键文件(所在文件夹路径, 列表) {
	for i in 列表
	{
		文件名 := 列表[i]
		Loop {
			if !fileexist(所在文件夹路径 "\" 文件名 ".key")
				FileAppend, , % 所在文件夹路径 "\" 文件名 ".key"
			else
				break
		}
	}
}

读取文件行(文件完整路径, 行数) {
	FileReadLine, 输出的行内容, % 文件完整路径, % 行数
	return 输出的行内容
}
	
创建空文件夹(文件夹完整路径) {
	loop {
		IfNotExist, % 文件夹完整路径
			FileCreateDir, % 文件夹完整路径
		else
			break
	}
}