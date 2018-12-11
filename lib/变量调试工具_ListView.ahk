
#SingleInstance force
GUI, listviewdebug: new
GUI, add, listview, R5 x0 y0 w300 h200 Grid Count, 变量名称|值|type|bool
GUI,  -Caption +AlwaysOnTop
GUI, listviewdebug: show, x10 y10 w300 h200 , variable debug 

return
printLV(paramsNamestr_list*) {
	if !paramsNamestr_list.MaxIndex() {
		oSciTE.Output("* Warning! None params in function print()! `n* printLV()函数无参数传入！`n")	
}
}
!esc::
	ExitApp