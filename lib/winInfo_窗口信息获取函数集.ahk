

/*

。。。基于标题的获取

wgExist(title)		窗口存在返回1		不存在返回0

		====================================================================
		----> 窗口参数获取单项返回值，可作为【窗口标题定位】的类型函数
		====================================================================
			参一、定位条件 	参二、排除条件	返回字符串

wgTitle		(title,    		ECT := "")		【title】							不存在返回0
wgID		(title,    		ECT := "")		【"ahk_ID "		返回值】			~
wgClass		(title,    		ECT := "")		【"ahk_Class " 	返回值】			~	
wgEXE		(title,			ECT := "")		【"ahk_exe " 	返回值】			~
wgPID		(title,			ECT := "")		【"ahk_PID "		返回值】			~

wgToTal		(title,			ECT := "")		【返回所有属性文本值】
		====================================================================
		----> 窗口参数获取列表，可作为【窗口标题定位】的类型函数
		====================================================================

			参一、定位条件 	参二、排除条件	返回列表

allwIDls() 	无				无				【所有系统当前"ahk_ID " 字符串列表】
wIDls		(title,			ECT := "")		【所有符合条件"ahk_ID " 字符串列表】

		====================================================================
		----> 窗口参数获取，可作为【程序定位】的类型函数
		====================================================================

			参一、定位条件 	参二、排除条件	返回字符串

wgPName		(,			ECT := "")		【程序名称】
wgLP		(title,			ECT := "")		【程序对应长路径】

		====================================================================
		----> 窗口标题及组设置
		====================================================================
wsetT(title, newT, ETC := "" )	;设置新窗口标题，成功返回新窗口标题
wadGroup(title, groupName,  ETC := "" )	;将标题加入窗口组
WTSTAG(title, groupName, newPerT := "new", ETC := "", msgGroupInfo := 0)	;将所有符合窗口标题的窗口改变标题名称加入到组中
wgGroupList(AHKgroupname)	;返回窗口组所有成员ID列表


。。。基于鼠标悬停位置的获取

msID()		返回ahk_id 
msTitle()	
msClass()	
msEXE()
msPID()
msPName()
msFLP()
mswinToTal()
=================================================================================
*/


wgToTal(title, ECT := "") {
	if !(wExist(title))
		return 0	
	returnlist := {}
	returnlist["id"] := wgID(title, ECT)
	returnlist["title"] := wgTitle(returnlist["id"])
	returnlist["class"] := wgClass(returnlist["id"])
	returnlist["exe"] := wgEXE(returnlist["id"])
	returnlist["pid"] := wgPID(returnlist["id"])
	returnlist["pname"] := wgPName(returnlist["id"])
	returnlist["path"] := wgLP(returnlist["id"])

	lsssss := [ "win title：" returnlist["title"]
			   , returnlist["id"]
			   , returnlist["class"]
			   , returnlist["pid"]
			   , returnlist["exe"] "`n"
			   , "process name：" returnlist["pname"]
			   , "process path：" returnlist["path"]]
	for i in lsssss
		ddddd := % ddddd "`n" lsssss[i]			   
	return % ddddd
}

mswinToTal() {
	return % wgToTal(mgID())
}

;--> .鼠标获取ahk_id
mgID() {
	MouseGetPos, , , winid
	return % "ahk_id " winid
}
;--> .鼠标获取标题文本
msTitle() {
	return % wgTitle(mgID())
}
;--> .鼠标获取ahk_Class
msClass() {
	return % wgClass(mgID())
}
;--> .鼠标获取ahk_exe
msEXE() {
	return % wgEXE(mgID())
}
;--> .鼠标获取ahk_PID
msPID() {
	return % wgPID(mgID())
}
msPName() {
	return % wgPName(mgID())
}
msFLP() {
	return % wgLP(mgID())
}

wgGroupList(AHKgroupname) {
	LS := wIDls(AHKgroupname)
	if !LS.MaxIndex()
		return 0
	else
		return % LS
}

WTSTAG(title, groupName, newPerT := "new", ETC := "", msgGroupInfo := 0) {
	if !(wExist(title, ECT))
		return 0
	loop {
		if !(wExist(title, ECT))
			break
		wadGroup(title, groupName, newPerT)
	}
	return % "ahk_group " groupName
}

wadGroup(title, groupName,  ETC := "" ) {
	if !(wExist(title, ECT))
		return 0
	GroupAdd, % groupName, % title, , , % ETC
	return % "ahk_group " groupName
}

wsetT(title, newT, ECT := "") {
	if !(wExist(title, ECT))
		return 0
	WinSetTitle, % title, , % newT, % ECT
	return % newT
}

;--> .根据特定标题参数 【确认窗口是否存在】
wExist(title, ECT := "") {
	if WinExist(title, ECT)
		return 1
	return 0
}
;--> .根据特定标题参数 【获取title字符串】
wgTitle(title, ECT := "") {
	if !(wExist(title, ECT))
		return 0
	WinGetTitle, out,  % title, , % ECT
	return % out
}
;--> .根据特定标题参数 【获取ahk_ID】
wgID(title, ECT := "") {
	if !(wExist(title, ECT))
		return 0
	WinGet, ahkID, ID, % title, ,% ECT
	return % "ahk_ID " ahkID
}
;--> .根据特定标题参数 【获取ahk_Class】
wgClass(title, ECT := "") {
	if !(wExist(title, ECT))
		return 0
	WinGetClass, aa, % title, , % ECT
	return % "ahk_Class " aa
}
;--> .根据特定标题参数 【获取ahk_PID】
wgPID(title, ECT := "") {
	if !(wExist(title, ECT))
		return 0
	WinGet, ahkPID, PID, % this.SL, ,% this.SLEC
	return % "ahk_PID " ahkPID	
}
;--> .根据特定标题参数 【获取ahk_exe】
wgEXE(title, ECT := "") {
	return % "ahk_exe " wgPName(title, ECT)
}



;--> .根据特定标题参数 【获取窗口对应程序名称】
wgPName(title, ECT := "") {
	if !(wExist(title, ECT))
		return 0
	WinGet, name, ProcessName, % title, ,% ECT
	return % name		
}
;--> .根据特定标题参数 【获取窗口对应程序完整路径】
wgLP(title, ECT := "") {
	if !(wExist(title, ECT))
		return 0
	WinGet, pathx, ProcessPath , % title, ,% ECT
	return % pathx		
}

/*======================================
列表型标题返回值
========================================
*/
allwIDls() {	;返回所有系统当前存在的窗口ID列表
	IDls := []
	WinGet, out, List
	loop % out
		IDls.Insert("ahk_ID " out%A_Index%)
	return % IDls
}


wIDls(title, ECT := "") {	;返回符合标题类型判定参数的窗口id列表
	if !(wExist(title, ECT))
		return 0
	IDls := []
	WinGet, out, List, % title, ,% ECT
	loop % out
		IDls.Insert("ahk_ID " out%A_Index%)
	return % IDls
}