
#SingleInstance force
FULLWIDTH := 300
GUI, listviewdebug: new

GUI, listviewdebug: add, listview, ReadOnly R5 x0 y0 w%FULLWIDTH% h150 Grid Count,name|value|data type|str length
GUI, listviewdebug: add, edit, v__theonlyedit w%FULLWIDTH%  readonly, --> 提示:暂空
GUI, listviewdebug: add, button, v手动刷新变量 w%FULLWIDTH%  h25, 刷新变量
GUI, listviewdebug: +ToolWindow +AlwaysOnTop
GUI, listviewdebug: show, x100 y100 w%FULLWIDTH% ,variable debug 
global __theonlyedit
global __textPrintToLV
global __theMaxIndexOfFuncPrintLV := false

AAA := 1
BBB := 33333333

CCC := "天`n啦噜"
debugL("AAA", "BBB", "CCC", "a_now")
return


手动刷新变量:
	if (notfirstnew) {
		
		return	
	}
	notfirstnew := true
	

debugL(paramsNamestr_list*) {
	;
	LV_Delete()	;删除所有行
	if !paramsNamestr_list.MaxIndex() {
		guicontrol, , __theonlyedit, --> 警告: 无参数传入！			;改变编辑控件内容
		return
	}
	for index, __textPrintToLV in paramsNamestr_list
	{
		__theMaxIndexOfFuncPrintLV := True
		gosub, __printVariableToLV
		__theMaxIndexOfFuncPrintLV := false
	}
	return
}

__printVariableToLV:
	if __theMaxIndexOfFuncPrintLV
	{
		LV_Add("", __textPrintToLV, %__textPrintToLV%, typeof(%__textPrintToLV%), StrLen(%__textPrintToLV%))
		LV_ModifyCol(1, "AutoHdr Center")
		LV_ModifyCol(2, "AutoHdr Center")
		LV_ModifyCol(3, "AutoHdr Center")
		LV_ModifyCol(4, "AutoHdr Center")
		return
	}


typeof(thevar) {
	;检测变量数据类型
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