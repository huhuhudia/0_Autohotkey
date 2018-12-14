#SingleInstance force

__FULLWIDTH := 300
__guipos_x := A_ScreenWidth - 300 - 150
__guipos_y := A_ScreenHeight - 300 - 50
global __theonlyedit
global __textPrintToLV
global __guitimerset := false
global __guitimersetcount := 0
global __guitimersettime := 0
global __guitimersetPriority := 0

global ttttt

GUI, __listviewdebug: new

GUI, __listviewdebug: add, listview, ReadOnly NoSort g__双击listview事件 R5 x0 y0 w%__FULLWIDTH% h150 Grid Count,name|value|data type|str length
GUI, __listviewdebug: add, edit, v__theonlyedit w%__FULLWIDTH%  readonly, tip: None
GUI, __listviewdebug: add, button, g__手动刷新变量_button w%__FULLWIDTH%  h25, 点击更新变量参数
GUI, __listviewdebug: +ToolWindow +AlwaysOnTop
GUI, __listviewdebug: show, x%__guipos_x% y%__guipos_y% w%__FULLWIDTH% ,variable debug 

debugLV(paramsNamestr_list*) {
	if !paramsNamestr_list.MaxIndex() {
		;无参数传入时，提示错误
		LV_Delete()	;删除所有行
		guicontrol, , __theonlyedit, 警告: 最后调用debugL()方法时无参数传入！			;改变编辑控件内容
		return
	}
	for index, __textPrintToLV in paramsNamestr_list
		; 递归变量字符串列表, __textPrintToLV为全局变量，保存当前
		gosub, __printVariableToLV
	gosub, __所有value值为空白符替换
	return
}

/*
renewLVST(turn_event := 1, timer_set := 300, lable_Prd := "min") {
	;更新开关
	if (turn_event == 0) {
		__guitimerset := false
		__guitimersetcount := 0
		SetTimer, __手动刷新变量_button, off
		guicontrol, , __theonlyedit, tip: None
	}
	else if (turn_event == 1) {
		if (lable_Prd == "max")
			lable_Prd := 2147483647 
		else if (lable_Prd == "min")
			lable_Prd := -2147483648
		__guitimersettime := timer_set
		__guitimersetPriority := lable_Prd
		__guitimerset := true
		ttttt := LV_GetCount()
		SetTimer, __手动刷新变量_button, % __guitimersettime, % __guitimersetPriority
	}
	return
}
*/



__双击listview事件:
	if (A_GuiEvent == "DoubleClick") {
		__当前行 := A_EventInfo
		gosub, __手动刷新变量_button
		LV_GetText(__textPrintToLV, __当前行, 1)
		MsgBox, , %__textPrintToLV%： , % %__textPrintToLV%
		return
	}

__所有value值为空白符替换:
	;更新变量值字符串，__notfirstnew3判断初次运行该程序不执行标签功能
	if (__notfirstnew) {
		ttttt := (LV_GetCount()) ? LV_GetCount() : ttttt
		
		Loop, % ttttt
		{
			LV_GetText(__newStr, A_Index, 2)
			StringReplace, __newStr, __newStr, % " " , [``s], 1
			StringReplace, __newStr, __newStr, % "`n", [``n], 1
			StringReplace, __newStr, __newStr, % "`r", [``r], 1
			StringReplace, __newStr, __newStr, % "`t", [``t], 1
			LV_Modify(A_Index, "Col2", __newStr)
		}
		return
	}

__printVariableToLV:
	;更新列表变量，__notfirstnew2判断初次运行该程序不执行标签功能
	if (__notfirstnew) {
		LV_Add("", __textPrintToLV, %__textPrintToLV%, __typeof(%__textPrintToLV%), StrLen(%__textPrintToLV%))
		__makeLVview()
		return
	}
	
__手动刷新变量_button:
	; 手动刷新当前列表，__notfirstnew判断初次运行该程序不执行标签功能
	if (__notfirstnew) {
		;获取listview中变量名
		__variableName_Ls := []
		ttttt := (LV_GetCount()) ? LV_GetCount() : ttttt
		Loop, % ttttt
		{
			LV_GetText(__onceUse, A_Index, 1)
			__variableName_Ls.Insert(__onceUse)
		}
		;根据变量名根性
		LV_Delete()
		for index in __variableName_Ls
		{
			__textPrintToLV := __variableName_Ls[index]
			LV_Add("", __textPrintToLV, %__textPrintToLV%, __typeof(%__textPrintToLV%), StrLen(%__textPrintToLV%))
		}
		gosub, __所有value值为空白符替换
		/*
		if (__guitimerset) {
			if !__guitimersetcount
				__guitimersetcount := 1
			else
				__guitimersetcount += 1
			guicontrol, , __theonlyedit, % "更新频率: " __guitimersettime "ms 优先级: " __guitimersetPriority " 实时次数: " __guitimersetcount
		}
		*/
		return	
	}
	
__notfirstnew := true

__makeLVview() {
	;将所有列调整宽度并居中
	Loop, % LV_GetCount("Col")
		LV_ModifyCol(A_Index, "AutoHdr Center")
}

__typeof(thevar) {
	;检测变量数据类型
	if ((!thevar) && (thevar!= 0))
		return % "None"
	else if thevar is integer
	{
		if thevar is time
			return % "int|Time|True"
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



AAA := 1
BBB := 33333333
CCC := "天`n啦噜"

debugLV("AAA", "BBB", "CCC", "A_Now")
;renewLVST(1)
return