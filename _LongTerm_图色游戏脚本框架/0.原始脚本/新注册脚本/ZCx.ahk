/*
2018年04月24日
*/

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先声明  
#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%
dm := ComObjCreate( "dm.dmsoft")
dm.SetPath(A_WorkingDir "\dmpic\")
ToFoPa := % delStrL(a_workingdir, 6)	;设置顶上主文件夹下路径
Del_F(a_workingdir "\go.go")	;删除临时文件
ACC_Arrayx := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]	;创建随机字母数组
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     GUI创建  

Gui, Add, Text, x12 y10 w40 h20 , 状态：
Gui, Add, Text, x32 y70 w110 h20 , 当前累计创建数目：
Gui, Add, Text, x32 y40 w60 h20 , 注册区号：
Gui, Add, Text, x16 y137 w80 h20 , 当前流程：


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     主要控件  

Gui, Add, Text, vStatusx x52 y10 w50 h20 , 待命	;状态
Gui, Add, Text, vACCrN x142 y70 w30 h10 , 0
Gui, Add, DropDownList, vDropQH R20 x92 y35 w90 h20 , empty
Gui, Add, Button, gRunZC x42 y100 w120 h30 , 启动/退出
Gui, Add, Text, vstatusN x16 y157 w170 h40 , Waiting For Command .	;进程相关

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先启动  
gosub, 检查雷电模拟器
gosub, 关闭所有现行模拟器
gosub, 图片路径定义
gosub, 完善区号列表
Gui, Show, x1570 y388 h202 w200, 幻剑创建账号脚本
return

完善区号列表:
GuiControl, , DropQH, |
GuiControl, , DropQH, C8||
GuiControl, , DropQH, C145
GuiControl, , DropQH, C215
GuiControl, , DropQH, C330
GuiControl, , DropQH, C345
GuiControl, , DropQH, C375

GuiControl, , DropQH, C599

GuiControl, , DropQH, C655
GuiControl, , DropQH, C674
GuiControl, , DropQH, C691
GuiControl, , DropQH, C715
GuiControl, , DropQH, C734
GuiControl, , DropQH, C840
GuiControl, , DropQH, C990
GuiControl, , DropQH, C1140
GuiControl, , DropQH, C1170
GuiControl, , DropQH, C1200
GuiControl, , DropQH, C1220
GuiControl, , DropQH, C1343

GuiControl, , DropQH, C1366
GuiControl, , DropQH, B189
GuiControl, , DropQH, B397
GuiControl, , DropQH, B400

GuiControl, , DropQH, A81
GuiControl, , DropQH, A86
;如果存在选择文件，则设定选择文件为默认下拉菜单选项 
if (FileExist(A_WorkingDir "\QHN.cho")) {	
	lastCho := getL(A_WorkingDir "\QHN.cho")
	GuiControl, , DropQH, % lastCho "||"
}
return

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     主要按钮  


RunZC:
roe := !roe
if (roe) {	;初次启动
	run, % a_workingdir "\ZCWinAc.ahk"
	Cr_EmpFil(a_workingdir "\go.go")
	gosub, 关闭所有现行模拟器
	GuiControl, , Statusx, 启动
	GuiControlGet, DropQH, , DropQH
	Cr_AfterDel(DropQH, a_workingdir "\QHN.cho")
	settimer, 注册流程, 20
}
if (!roe) {	;暂停脚本
	Del_F(a_workingdir "\go.go")
	GuiControl, , Statusx, 暂停
	settimer, 注册流程, Off
}
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     运行脚本  


注册流程:
;1. 启动雷电模拟器
if (!unrun) {
	guiChan("启动雷电模拟器", statusN)
	run, % LdPath "\dnplayer.exe"	;1.启动雷电模拟器
	winwait, ahk_class LDPlayerMainFrame	;2.等待窗口出现
	WinSetTitle, ahk_class LDPlayerMainFrame, , ZCX	;3.设置窗口名称
}
else
	unrun := 
sleep 200
;2. 点击幻剑图标 
guiChan("点击幻剑图标", statusN)
Loop {
	dmCoCli("hjicon.bmp", dm, 200)	;点击幻剑图标
	if dmCoPicR("mfzc.bmp", dm)	;找到单词免费注册
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}
}
;3. 点击免费注册 
guiChan("点击免费注册", statusN)
loop {
	dmCoCli("mfzc.bmp", dm, 200)	;点击免费注册
	if dmCoPicR("ptzc.bmp", dm)	;找到普通注册
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}	
}
;4. 点击普通注册
guiChan("点击普通注册", statusN)
Loop {
	if dmCoPicR("ptzc.bmp", dm) {	;找到灰色普通注册
		ControlClick,x555 y199, ZCX, , L, 1	;点击灰色普通注册
		sleep 1200
	}
	if (dmCoPicR("ypt.bmp", dm) and picR("*10 " A_WorkingDir "\picture\ptzc.png", 505, 184, 550, 232)) {	;普通注册变黄
		sleep 500
		break	
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}		
}
;5. 删除账号密码 
guiChan("清空账号密码", statusN)
Loop {
	wIDF := dm.FindWindow("","ZCX") ;父窗口ID
	wIDz := dm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
	dm.BindWindow(wIDz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
	if dmCoPicR("ptzc.bmp", dm) {	;找到灰色普通注册
		ControlClick,x555 y199, ZCX, , L, 1	;点击灰色普通注册
		sleep 1000
	}
	ControlClick,x486 y252, ZCX, , L, 1	
	sleep 200
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	ControlClick,x508 y300, ZCX, , L, 1	
	sleep 200
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if (dmCoPicR("qkzm.bmp", dm) and dmCoPicR("ypt.bmp", dm) and picR("*10 " A_WorkingDir "\picture\ptzc.png", 505, 184, 550, 232))
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}		
}
;6. 随机获取账号密码 
guiChan("获取账号密码", statusN)
random, acc_num_x0, 7, 13
loop %acc_num_x0% {
	if A_Index = 1
	{
		random, fir_acc_n, 1, 26
		fir_accx := ACC_Arrayx[fir_acc_n]
		ACC_Now_Get := % fir_accx
	}
	else
	{
		random, letter_O_num, 1, 2
		if letter_O_num = 1
		{
			random, acc_num_n, 1, 9
			ACC_Now_Get := % ACC_Now_Get acc_num_n
		}
		else if letter_O_num = 2
		{
			random, fir_acc_n, 1, 26
			fir_accx := ACC_Arrayx[fir_acc_n]
			ACC_Now_Get := % ACC_Now_Get fir_accx
		}
	}
	sleep 6
}
random, acc_num_p0, 6, 10
loop %acc_num_p0% {
	if A_Index = 1
	{
		random, fir_acc_n, 1, 26
		fir_accx := ACC_Arrayx[fir_acc_n]
		Pas_Now_Get := % fir_accx
	}
	else
	{
		random, letter_O_num, 1, 2
		if letter_O_num = 1
		{
			random, acc_num_n, 1, 9
			Pas_Now_Get := % Pas_Now_Get acc_num_n
		}
		else if letter_O_num = 2
		{
			random, fir_acc_n, 1, 26
			fir_accx := ACC_Arrayx[fir_acc_n]
			Pas_Now_Get := % Pas_Now_Get fir_accx
		}
	}
	sleep 6
}
acn := % ACC_Now_Get
psn := % Pas_Now_Get
;7. 输入账号密码 
{
guiChan("输入生成的账号密码", statusN) 
Clipboard :=
loop 3 {
	ControlClick,x486 y252, ZCX, , L, 1		
	sleep 100
}
sleep 200
Clipboard := % acn
ClipWait
send, {ctrl down}
sleep 50
dm.KeyDown(86)
sleep 50
dm.KeyUp(86)
sleep 50
send, {ctrl up}
sleep 100
Clipboard :=
loop 3 {
ControlClick,x508 y300, ZCX, , L, 1	
	sleep 100
}
sleep 200
Clipboard := % psn
ClipWait
send, {ctrl down}
sleep 50
dm.KeyDown(86)
sleep 50
dm.KeyUp(86)
sleep 50
send, {ctrl up}
sleep 500
}
;8. 点击注册 
guiChan("点击注册红钮", statusN)
Loop {
	if picR("*10 " A_WorkingDir "\picture\yzm.png", 584, 329, 623, 364)
		gosub, 尝试重新输入账号密码
	dmCoCli("zchn.bmp", dm, 300)	;点击注册红钮
	dmCoCli("qxjt.bmp", dm, 300)	;点击取消截图
	if dmCoPicR("dlhn.bmp", dm)	;找到登陆黄钮
		break	
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}			
}
;9. 返回主页 
guiChan("返回主页", statusN)
loop {
	ControlClick,x977 y469, ZCX, , L, 1	
	sleep 1200
	dmCoCli("tcqd.bmp", dm, 300)
	if dmCoPicR("hjicon.bmp", dm)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}	
}
;10. 点击幻剑图标 
guiChan("再次点击幻剑图标", statusN)
Loop {
	dmCoCli("hjicon.bmp", dm, 200)	;点击幻剑图标
	if dmCoPicR("mfzc.bmp", dm)	;找到单词免费注册
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}
}
;11. 点击登录 
guiChan("点击登录红钮", statusN)
loop {
	dmCoCli("dlrn.bmp", dm, 200)
	if (dmCoPicR("dlhn.bmp", dm)) {	;发现登录黄钮，点击区
		ControlClick,x569 y373, ZCX, , L, 1	
		sleep 500
	}
	if (dmCoPicR("xzfw.bmp", dm)) {	;发现选择服务器，中断循环
		break
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}	
}

;12. 选择区号（拉条等）
GuiControlGet, DropQH, , DropQH
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>此处为区号图片变量定义

C8 := % "*10 " a_workingdir "\picture\C8.png"
C145 := % "*10 " a_workingdir "\picture\C145.png"
C215 := % "*10 " a_workingdir "\picture\C215.png"
C330 := % "*10 " a_workingdir "\picture\C330.png"

C345 := % "*10 " a_workingdir "\picture\C345.png"

C375 := % "*10 " a_workingdir "\picture\C375.png"
C599 := % "*10 " a_workingdir "\picture\C599.png"

C655 := % "*10 " a_workingdir "\picture\C655.png"
C674 := % "*10 " a_workingdir "\picture\C674.png"
C691 := % "*10 " a_workingdir "\picture\C691.png"
C715 := % "*10 " a_workingdir "\picture\C715.png"
C734 := % "*10 " a_workingdir "\picture\C734.png"

C840 := % "*10 " a_workingdir "\picture\C840.png"

C990 := % "*10 " a_workingdir "\picture\C990.png"
C1140 := % "*10 " a_workingdir "\picture\C1140.png"
C1170 := % "*10 " a_workingdir "\picture\C1170.png"

C1200 := % "*10 " a_workingdir "\picture\C1200.png"


C1220 := % "*10 " a_workingdir "\picture\C1220.png"

C1343 := % "*10 " a_workingdir "\picture\C1343.png"
C1366 := % "*10 " a_workingdir "\picture\C1366.png"

B189 := % "*10 " a_workingdir "\picture\B189.png"
B397 := % "*10 " a_workingdir "\picture\B397.png"
B400 := % "*10 " a_workingdir "\picture\B400.png"

A81 := % "*10 " a_workingdir "\picture\A81.png"
A86 := % "*10 " a_workingdir "\picture\A86.png"

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>此处为区号图片变量定义
guiChan("选择区号：" DropQH, statusN)
Loop {

	if (dmCoPicR("xzfw.bmp", dm)) {	;发现选择服务器
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>此处为区号函数

		DForQu(150, 345, "C8", 252, 339, C8, 416, 256, 464, 280, DropQH)
		DForQu(150, 329, "C145", 257, 364, C145, 651, 310, 700, 337, DropQH)
		DForQu(150, 321, "C215", 254, 364, C215, 655, 312, 695, 335, DropQH)
		DForQu(150, 311, "C330", 261, 275, C330, 433, 201, 475, 223, DropQH)
		DForQu(150, 309, "C345", 262, 251, C345, 653, 310, 701, 336, DropQH)
		DForQu(150, 305, "C375", 251, 281, C375, 651, 311, 703, 336, DropQH)
		
		DForQu(150, 281, "C599", 250, 346, C599, 655, 201, 703, 226, DropQH)		
		
		DForQu(150, 273, "C655", 258, 336, C655, 656, 309, 701, 339, DropQH)
		DForQu(151, 271, "C674", 249, 314, C674, 429, 366, 476, 391, DropQH)
		DForQu(150, 269, "C691", 258, 314, C691, 656, 422, 699, 447, DropQH)	
		DForQu(150, 267, "C715", 259, 309, C715, 653, 310, 700, 338, DropQH)
		DForQu(151, 263, "C734", 253, 381, C734, 425, 366, 472, 392, DropQH)
		
		
		DForQu(150, 253, "C840", 248, 363, C840, 429, 202, 475, 226, DropQH)



		DForQu(150, 237, "C990", 250, 288, C990, 432, 201, 474, 225, DropQH)
		DForQu(150, 219, "C1140", 264, 410, C1140, 443, 201, 486, 226, DropQH)
		DForQu(150, 217, "C1170", 260, 348, C1170, 461, 203, 502, 227, DropQH)
		DForQu(150, 215, "C1200", 267, 298, C1200, 442, 202, 484, 226, DropQH)	

		DForQu(150, 213, "C1220", 258, 287, C1220, 439, 202, 484, 226, DropQH)	



		DForQu(150, 193, "C1343", 253, 314, C1343, 442, 257, 485, 285, DropQH)	
		
		DForQu(135, 165, "C1366", 257, 319, C1366, 654, 201, 718, 228, DropQH)
		
		DForQu(150, 371, "B189", 239, 276, B189, 652, 201, 705, 226, DropQH)
		DForQu(150, 347, "B397", 256, 303, B397, 651, 256, 700, 283, DropQH)
		DForQu(150, 347, "B400", 256, 303, B400, 426, 200, 477, 226, DropQH)
		
		DForQu(150, 391, "A81", 255, 319, A81, 646, 309, 690, 337, DropQH)
		
		DForQu(150, 391, "A86", 255, 319, A86, 423, 203, 461, 226, DropQH)		
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>此处为区号函数
	}
	if (dmCoPicR("dlhn.bmp", dm) and !dmCoPicR("xfwq.bmp", dm))	;发现登陆按钮且非新服时
		dmCoCli("dlhn.bmp", dm, 1000)	;点击登陆黄钮
	else if (dmCoPicR("dlhn.bmp", dm) and dmCoPicR("xfwq.bmp", dm)) {
		ControlClick, x553 y376, ZCX
		sleep 500
	}
	if dmCoPicR("cjjs.bmp", dm) ;发现选择角色页面，break
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 10) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}		
}
mousemove, 999, 579, 0
;13. 选择人物 
guiChan("创建角色", statusN)
Loop {
	if (dmCoPicR("cjjs.bmp", dm)) {	;在创建角色界面时
		if (!dmCoPicR("th.bmp", dm)) {
			ControlClick, x75 y322, ZCX
			sleep 500
		}
		else if (dmCoPicR("th.bmp", dm)) {
			ControlClick, x855 y500, ZCX
			sleep 500
		}
	}
	else	;若不在创建角色界面，检查是否有登录按钮可以点击
		dmCoCli("dlhn.bmp", dm, 500)
	if (picR("*10 " A_WorkingDir "\picture\dt.png", 140, 524, 174, 554)	or dmCoPicR("dt.bmp", dm, 10, 300, 500, 540)) ;检查到正在读条
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 15) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}	
}
	
;14. 进入游戏 
guiChan("等待读条结束", statusN)
Loop
{
	if (picR("*10 " A_WorkingDir "\picture\dt.png", 140, 524, 174, 554)	or dmCoPicR("dt.bmp", dm, 10, 300, 500, 540)) ;检查到正在读条	
		sleep 200
	st1 := % picR("*5 " A_WorkingDir "\picture\bb.png", 913, 263, 935, 286)	;背包
	st2 := % picR("*5 " A_WorkingDir "\picture\wy.png", 259, 124, 287, 152) ;屋檐
	st3 := % dmCoPicR("vp.bmp", dm) ;》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》》vip0 
	st5 := % picR("*5 " A_WorkingDir "\picture\zd.png", 497, 408, 529, 437)	;砸蛋开局

	if (st1 or st2 or st3 or st5)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 150) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return
	}
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
	if getkeystate("numlock", "P") {
		Del_F(a_workingdir "\go.go")
		GuiControl, , Statusx, 暂停
		settimer, 注册流程, Off
		return
	}		
}
;15. 完成注册 （记录账号密码）改变GUI注册数量
guiChan("完成注册", statusN)
FileAppend, % acn "`n" psn, % ToFoPa "\1-主线\" DropQH "_" acn ".acc"
GuiControlGet, ACCrN, , ACCrN
if !ACCrN
	GuiControl, , ACCrN, 1
else {
	ACCrN := % ACCrN + 1
	GuiControl, , ACCrN, % ACCrN
}
GuiControlGet, ACCrN, , ACCrN
GOTTn := % Mod(ACCrN, 3)
if (GOTTn) {	;有余数，无法被3整除，返回主界面
	unrun := 1
	loop {
		ControlClick,x977 y469, ZCX, , L, 1	
		sleep 1200
		dmCoCli("tcqd2.bmp", dm, 300)
		if dmCoPicR("hjicon.bmp", dm)
			return
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
		sleep 300
		if (a_index >= 60) {
			run, ZCReload.ahk
			sleep 1000
			ExitApp
			return
		}
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环必须声明  
		if getkeystate("numlock", "P") {
			Del_F(a_workingdir "\go.go")
			GuiControl, , Statusx, 暂停
			settimer, 注册流程, Off
			return
		}	
	}	
}
else {
	gosub, 关闭所有现行模拟器
	sleep 300
	;设置全屏找图
	CoordMode, mouse, screen
	dm.EnableBind(0)
	dm.UnBindWindow() 
	;清空底部多余图标
	MouseMove, 850, 1050, 0
	SLEEP 100
	MouseMove, 1870, 1050, 15
	sleep 500
	intX := ComVar(), intY := ComVar()
	;重新连接网络
	Loop {
		dm.FindPic(500, 700, 1920, 1080, "wl.bmp","090909",0.7,0, intX.ref, intY.ref)
		dm.moveto(intX[], intY[])
		sleep 300
		send, {click}
		sleep 700
		goterrorlevel := dm.FindPic(500, 700, 1920, 1080, "ylj.bmp","090909",0.7,0, intX.ref, intY.ref)	;找到已连接，点击
		goterrorlevel := % goterrorlevel + 1
		if (goterrorlevel) {
			dm.moveto(intX[], intY[])
			sleep 300
			send, {click}
			sleep 700			
		}
		goterrorlevel := dm.FindPic(500, 700, 1920, 1080, "dk.bmp","090909",0.7,0, intX.ref, intY.ref)	;找到已断开，点击
		goterrorlevel := % goterrorlevel + 1
		if (goterrorlevel) {
			dm.moveto(intX[], intY[])
			sleep 300
			send, {click}
			sleep 300			
		}
		dd1 := % dm.FindPic(500, 700, 1920, 1080, "dd1.bmp","090909",0.7,0, intX.ref, intY.ref) + 1	;等待连接状态1
		dd2 := % dm.FindPic(500, 700, 1920, 1080, "dd2.bmp","090909",0.7,0, intX.ref, intY.ref) + 1	;等待连接状态2
		if (dd1 or dd2) {
			loop {
				dd3 := % dm.FindPic(500, 700, 1920, 1080, "dd3.bmp","090909",0.7,0, intX.ref, intY.ref) + 1 	;已连接
				if (dd3) {
					CoordMode, mouse, window
					return
				}
			}
		}
	}
}	
return

;一次性函数，区域选择函数
DForQu(dxx, dyy, quN, qxx, qyy, picF, x1, y1, x2, y2, ByRef DropQ) {
	if (DropQ = quN) {
		ImageSearch, dx, dy, 127, 172, 190, 238, % "*10 " A_WorkingDir "/picture/drag.png"
		if (!errorlevel) {
			MouseClickDrag, L, %dx%, %dy%, %dxx%, %dyy%, 5
			sleep 800
			MouseClick, L, %qxx%, %qyy%, 1, 0
			sleep 2000
		}
		ImageSearch, lx, ly, x1, y1, x2, y2, % picF
		if (!errorlevel) {
			MouseClick, L, %lx%, %ly%, 1, 0
			sleep 1000
		}
		else if (errorlevel = 1) {
			ControlClick, x825 y136, ZCX
			sleep 500
		}
		else
			msgbox, % "错误，区号" DropQ "图片不存在"
	}
}

尝试重新输入账号密码:
guiChan("尝试重新输入账号密码", statusN)
Loop 3 {
	if (a_index = 3) {
		run, ZCReload.ahk
		sleep 1000
		ExitApp
		return		
	}
	Loop {	;点击灰色注册
		if dmCoPicR("ptzc.bmp", dm) {	;找到灰色普通注册
			ControlClick,x555 y199, ZCX, , L, 1	;点击灰色普通注册
			sleep 1200
		}
		if (dmCoPicR("ypt.bmp", dm) and picR("*10 " A_WorkingDir "\picture\ptzc.png", 505, 184, 550, 232)) {	;普通注册变黄
			sleep 500
			break	
		}	
	}
	Loop {	;清空账号密码
		wIDF := dm.FindWindow("","ZCX") ;父窗口ID
		wIDz := dm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
		dm.BindWindow(wIDz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
		if dmCoPicR("ptzc.bmp", dm) {	;找到灰色普通注册
			ControlClick,x555 y199, ZCX, , L, 1	;点击灰色普通注册
			sleep 1000
		}
		ControlClick,x486 y252, ZCX, , L, 1	
		sleep 200
		loop 15 {	;删除账号
			dm.KeyDown(8)
			sleep 20
			dm.KeyUp(8)
			sleep 20
		}
		sleep 500
		ControlClick,x508 y300, ZCX, , L, 1	
		sleep 200
		loop 15 {	;删除密码
			dm.KeyDown(8)
			sleep 20
			dm.KeyUp(8)
			sleep 20
		}
		sleep 500
		if (dmCoPicR("qkzm.bmp", dm) and dmCoPicR("ypt.bmp", dm) and picR("*10 " A_WorkingDir "\picture\ptzc.png", 505, 184, 550, 232))
			break		
	}
	Clipboard :=
	loop 3 {
		ControlClick,x486 y252, ZCX, , L, 1		
		sleep 100
	}
	sleep 200
	Clipboard := % acn
	ClipWait
	send, {ctrl down}
	sleep 50
	dm.KeyDown(86)
	sleep 50
	dm.KeyUp(86)
	sleep 50
	send, {ctrl up}
	sleep 100
	Clipboard :=
	loop 3 {
	ControlClick,x508 y300, ZCX, , L, 1	
		sleep 100
	}
	sleep 200
	Clipboard := % psn
	ClipWait
	send, {ctrl down}
	sleep 50
	dm.KeyDown(86)
	sleep 50
	dm.KeyUp(86)
	sleep 50
	send, {ctrl up}
	sleep 500
	if !picR("*10 " A_WorkingDir "\picture\yzm.png", 584, 329, 623, 364)	;没有发现验证码
		return
}
return




;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     功能按钮及首先启动>续  


检查雷电模拟器:
if (!FileExist(ToFoPa "\PathOfLD_x.path")) {	;检查是否存在雷电模拟器路径文件
	msgbox, 雷电模拟器路径不存在`n请于主控端设置路径`n当前脚本将退出
	ExitApp
	return
}
LdPath := getL(ToFoPa "\PathOfLD_x.path")	;获取雷电模拟器路径
if (!FileExist(LdPath "\dnplayer.exe")) {	;检查是否存在雷电模拟器
	msgbox, 雷电模拟器路径错误`n脚本将无法运行`n请于主控端设置正确路径`n当前脚本将退出。
	ExitApp
	return
}
return


关闭所有现行模拟器:	;  关闭四个雷电进程  
ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")
return


!1::	;alt + 1 为启动模拟器
roe :=
gosub, RunZC
return

NumLock::	;NumLock 为暂停脚本
Del_F(a_workingdir "\go.go")
roe :=
GuiControl, , Statusx, 暂停
SetTimer, 注册流程, Off
return

GuiClose:
Del_F(a_workingdir "\go.go")
ExitApp
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     函数  
;关闭所有同名进程  
ProExit(proName) {
	loop
	{
		Process, Close, % proName
		sleep 100
		if !errorlevel
			break
	}
}
;删除字符串后几位  
delStrL(inputvar,countx := 0) {
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}
;创建文件前删除该文件并写入首行字符串  
Cr_AfterDel(tex, filLP) {
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
		{
			break
		}
	}	
	FileAppend, % tex, % filLP ,UTF-8
	Loop
	{
		IfNotExist, % filLP	
			Sleep 10
		Else 
		break
	}
	Loop
	{	
		FileReadLine, caa, % filLP, 1
		if caa = % tex
			break
	}
}	
;获取文件某行字符串  
getL(filLP, linenum := 1) {
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
;创建空白文件 
Cr_EmpFil(filLP) {
	IfNotExist, % filLP
	{
		FileAppend, , % filLP
		Loop
		{
			IfExist % filLP
				break
			sleep 20
		}
	}
}
;删除文件直到区确定无该文件
Del_F(filLP) {
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}
}
;改变gui文本
guiChan(newtex, ByRef gVar) {
	GuiControl, , gVar, % newtex
}

picR(thePathi, cx1, cy1, cx2, cy2)
{
	ImageSearch, , , %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	{
		if !errorlevel
		{
			return 1
		}
		if errorlevel = 2
		{
			msgbox, 错误`n判断图片路径错误`n%thePathi%
		}
		if errorlevel = 1
		{
			return 0
		}
	}
}

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     大漠函数 
ComVar(Type=0xC) {
    static base := { __Get: "ComVarGet", __Set: "ComVarSet", __Delete: "ComVarDel" }
    ; 创建含 1 个 VARIANT 类型变量的数组.  此方法可以让内部代码处理
    ; 在 VARIANT 和 AutoHotkey 内部类型之间的所有转换.
    arr := ComObjArray(Type, 1)
    ; 锁定数组并检索到 VARIANT 的指针.
    DllCall("oleaut32\SafeArrayAccessData", "ptr", ComObjValue(arr), "ptr*", arr_data)
    ; 保存可用于传递 VARIANT ByRef 的数组和对象.
    return { ref: ComObjParameter(0x4000|Type, arr_data), _: arr, base: base }
}
ComVarGet(cv, p*) { ; 当脚本访问未知字段时调用.
    if p.MaxIndex() = "" ; 没有名称/参数, 即 cv[]
        return cv._[0]
}
ComVarSet(cv, v, p*) { ; 当脚本设置未知字段时调用.
    if p.MaxIndex() = "" ; 没有名称/参数, 即 cv[]:=v
        return cv._[0] := v
}
ComVarDel(cv) { ; 当对象被释放时调用.
    ;必须进行这样的处理以释放内部数组.
    DllCall("oleaut32\SafeArrayUnaccessData", "ptr", ComObjValue(cv._))
}

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     大漠自制函数  
;后台点击函数 
dmCoCli(picname, ByRef dmm, slpt1 := 0, slpt2 := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540)
{
	wIDF := dmm.FindWindow("","ZCX") ;父窗口ID
	wIDz := dmm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
	dmm.BindWindow(wIDz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
	x := ComVar(), y := ComVar()
	gErrorL := dmm.FindPic(x1, y1, x2, y2, picname,"030303",0.9,0, x.ref, y.ref)
	gErrorL := % gErrorL + 1
	if (gErrorL) {	;若找到图
		nx := % x[] - 1
		ny := % y[] + 36
		ControlClick, % "x" nx " y" ny, ZCX, , L, 1
		sleep, % slpt1
		return
	}
	else if (!gErrorL) {	;若未找到图
		Sleep, % slpt2
		return
	}
}
;后台图片确认函数 
dmCoPicR(picname, ByRef dmm, x1 := 0, y1 := 0, x2 := 960, y2 := 540) {
	wIDF := dmm.FindWindow("","ZCX") ;父窗口ID
	wIDz := dmm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
	dmm.BindWindow(wIDz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
	gErrorL := dmm.FindPic(x1, y1, x2, y2, picname,"030303",0.9,0, x, y)
	gErrorL := % gErrorL + 1
	if gErrorL
		return 1
	else
		return 0
}

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     图片路径定义  

图片路径定义: 
{



}
return