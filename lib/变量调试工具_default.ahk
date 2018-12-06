/*
用法：
	格式：printDE("变量名称1", "变量名称2")
	参数：传入 若干（>=1个）字符串，字符串内容为变量名称
	不支持函数中局部调试

三个全局变量：
	1.oSciTE scite编辑器的COM对象，调用.Output()内置方法在调试窗口输出
	2.__textPrintToScite4
	3.__theMaxIndexOfFuncPrint
*/

global __textPrintToDebug
global __theMaxIndexOfFuncPrintDE := false

printDE(paramsNamestr_list*) {
	;无参数传入时
	if !paramsNamestr_list.MaxIndex() {
		OutputDebug, % "* Warning! None params in function printDE()! `n* printDE()函数无参数传入！`n"
		return
	}
	
	for __theMaxIndexOfFuncPrint, __textPrintToDebug in paramsNamestr_list
		gosub, __sendTheTextToDebugWindow
	__theMaxIndexOfFuncPrintDE := false
}

__sendTheTextToDebugWindow:
	if __theMaxIndexOfFuncPrint {
		OutputDebug, % __textPrintToDebug " -- (" %__textPrintToDebug% ")`n"
		return
	}