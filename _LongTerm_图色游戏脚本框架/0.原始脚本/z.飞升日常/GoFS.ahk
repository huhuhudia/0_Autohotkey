

/*
sNum := 7
wName := % "FS" sNum
tName := % "GoFS" sNum 
魂兽飞升转换
优惠活动转换
有飞升战斗
无飞升切号


*/

#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
setworkingdir %a_scriptdir%

topDir := % delStrL(a_workingdir, 7)	;顶部路径

global dm := ComObjCreate( "dm.dmsoft" )	;创建大漠对象
global x := ComVar(), global y := ComVar()

dm.SetPath(A_WorkingDir "\dmpic\")	;设定大漠工作路径
dm.SetDict(1, A_WorkingDir "\dmpic\yao.txt")	;设定大漠字典
dm.UseDict(1)		;设定引用字典，引用前需声明字典文件

LdPath := getL(topDir "\PathOfLD_x.path")	;获取雷电模拟器路径
LdCtrlLP := % LdPath "\dnconsole.exe"	;雷电中控路径

gui, font, ceaedcd, 微软雅黑		;字体与颜色
Gui, Color, 161a17				;窗口颜色
Gui, -Caption -SysMenu +AlwaysOnTop

Gui, Add, Text, x6 y2 w30 h16 , %wName%
Gui, Add, Text, x46 y2 w40 h16 , 状态：
Gui, Add, Text, vStatusx x86 y2 w210 h16 , Waiting for command...

yg := % 850 + (sNum - 1) * 25
Gui, Show, x150 y%yg% h22 w306, %tName%

if (winexist(wName)) {
	guiChan("关闭模拟器重启", Statusx)
	nnn := % sNum - 1
	RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
	Sleep 3000
}
global Statusx
SetTimer, 首先启动游戏, -100
Return

GuiClose:
ExitApp
return

首先启动游戏:
guiChan("启动模拟器", Statusx)
nnn := % sNum - 1
RunWait, % "cmd.exe /c " LdCtrlLP " launch --index " nnn, , Hide
if (sNum = 1) {	;启动模拟器
	WinWait, 雷电模拟器
	Sleep 700
	WinSetTitle, 雷电模拟器, , % wName, % "雷电模拟器-"
}
else {
	WinWait, % "雷电模拟器-" nnn
	Sleep 700
	WinSetTitle, % "雷电模拟器-" nnn, , % wName
}
sleep 200
winIDF := dm.FindWindow("LDPlayerMainFrame", wName) ;父窗口ID
winIDS := dm.EnumWindow(winIDF, "TheRender","",1)	;子窗口ID 
dm.BindWindow(winIDS,"gdi","windows","windows",0)	;设定所有坐标相对窗口绑定 
if sNum = 1
	WinMove, % wName, , 5, 5
else
	WinMove, % wName, , % 5 + (sNum - 1) * 60, % 5 + (sNum - 1) * 15
guiChan("点击幻剑图标", Statusx)
Loop {
	DmcliI("icon.bmp", 500, 438, 29, 523, 112, "080808", 0.9)
	if DmPicR("dltb.bmp", 500,317,608,387, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 40) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload	
	}
}
guiChan("清空账号密码", Statusx)
loop {
	DmMsCli( 492, 205, 500)
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	DmMsCli(516, 247, 500)
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if DmPicR("qksj.bmp", 311, 157, 434, 297, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	if (a_index >= 10) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload	
	}
}
guiChan("获取账号密码", Statusx)
if (fileexist(a_workingdir "\Acc\" sNum "\*.acc")) {
	loop, % a_workingdir "\Acc\" sNum "\*.acc"
	{
		if (a_index = 1) {
			nGAPfZX := % A_LoopFileLongPath	;临时文件长路径，完成时删除
			nGANfZX := % A_LoopFileName	;账号名，在1-主线中另有存档，完成时移动文件到2-日常
			gac := % getL(nGAPfZX)	;获取账号名
			gps := % getL(nGAPfZX, 2)	;获取密码
		}
		break
	}
}
else {
	guiChan("该脚本结束,查询邻近文件夹", Statusx)
	if Mod(sNum, 2)
		findAnother := % sNum + 1
	else
		findAnother := % sNum - 1
	loop, % a_workingdir "\Acc\" findAnother "\*.acc"
		dlxxx := % A_Index
	if (dlxxx >= 3) {
		clxxx := % dlxxx - 1
		loop, % a_workingdir "\Acc\" findAnother "\*.acc"
		{
			if (a_index = clxxx) {
				nGAPfZX := % A_LoopFileLongPath	;临时文件长路径，完成时删除
				nGANfZX := % A_LoopFileName	;账号名，在1-主线中另有存档，完成时移动文件到2-日常
				gac := % getL(nGAPfZX)	;获取账号名
				gps := % getL(nGAPfZX, 2)	;获取密码
				FileMove, % nGAPfZX, % A_WorkingDir "\WorkAcc\" sNum "\" nGANfZX, 1
				break
			}
		}
	}
	else {
		Gui, Cancel
		Sleep 1000
		Gui, Show
		guiChan("该脚本任务结束", Statusx)
		return
	}
}
guiChan("输入账号密码", Statusx)
dm.SetKeypadDelay("windows", 20)
Loop {
	DmMsCli(492, 205, 700)	;账号位置
	dm.SendString(winIDS, gac) ;输入账号
	sleep 1500
	DmMsCli(516, 247, 700)	;密码位置
	dm.SendString(winIDS, gps)
	sleep 1500
	if (!DmPicR("zhem.bmp", 310,161,461,231) and !DmPicR("mmem.bmp", 332,222,461,287))
		break
	else
		gosub, 清除账号密码
	if (a_index >= 6) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload
	}
}
guiChan("点击登录红钮", Statusx)
Loop {
	DmcliI("dltb.bmp", 500, 500, 317, 608, 387)
	if DmPicR("dlyx.bmp", 474, 421, 561, 475) and !DmPicR("xfwq.bmp", 487, 292, 548, 373)	;找到登录黄钮且无新服务器显示时
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 20) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload
	}
}
guiChan("点击登录黄钮", Statusx)
Loop {
	DmcliI("dlyx.bmp", 800, 474, 421, 561, 475)
	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
	if DmPicR("dtz.bmp", 127,470,187,525) 	;正在读条
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 200
	if (a_index >= 50) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
}
guiChan("等待读条结束", Statusx)
Loop {
	if DmPicR("dtz.bmp", 127,470,187,525)	;读条中
		sleep 500	
	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
	if (!DmPicR("wlcw111.bmp") and !DmPicR("dtz.bmp", 127,470,187,525))
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 80) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
}
Gui, Cancel
Sleep 800
Gui, Show
settimer, 飞升日常流程, -100
return

清除账号密码:
guiChan("清除账号密码", Statusx)
loop {
	DmMsCli(492, 205, 500)
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	DmMsCli(516,247, 500)
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if DmPicR("qksj.bmp", 311, 157, 434, 297, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	if (a_index >= 10) 
		Reload	
}
return

飞升日常流程:
liuCheng("查询是否有好友")
return

查询是否有好友:

return

liuCheng(ByRef NowPro) {	;一次性流程函数
	guiChan(NowPro, Statusx)
	gosub, 关闭所有无用界面
	gosub, % NowPro
	
}

关闭所有无用界面:

return

切号:

return


delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}

getL(filLP, linenum := 1) { ;获取某行字符串，无返回0
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

guiChan(newtex, ByRef gVar) { ;GUI改变函数
	GuiControl, , gVar, % newtex
}

DmSendW(tex, hwndx, slpt := 0) {	;发送文本到窗口,成功发送将延迟
	dm.SetKeypadDelay("windows", 50)
	cl := dm.SendString(hwndx, tex)
	if cl
		Sleep, % slpt
}

DmMsCli(x, y, slpt := 0) {	;大漠点击函数
	dm.MoveTo(x, y)
	sleep 50
	dm.LeftDown()
	sleep 50
	dm.LeftUp()
	Sleep, % slpt
}

DmMsDrag(x1, y1, x2, y2, slpt := 0) {	;大漠鼠标点击拖行
	dm.MoveTo(x1, y1)
	sleep 100
	dm.LeftDown()
	sleep 100
	dm.MoveTo(x2, y2)
	sleep 300
	dm.LeftUp()
	Sleep, % slpt
}


DmPieCli(x1, y1, x2, y2, ColorX, slpt := 0,MH := 1) {	;搜色点击，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		Sleep, % slpt
		DmMsCli(x[], y[])
	}
}

DmPieClO(x1, y1, x2, y2, ColorX, xx, yy, slpt := 0,MH := 1) {	;搜色点击它处，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(xx, yy)
		Sleep, % slpt
	}
	else
		Sleep 5
}

DmPieR(x1, y1, x2, y2, ColorX,MH := 1) {	;搜色判断，模糊匹配默认为1,从左到右从上下
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x, y)
	return % cl
}

;大漠点击图片函数, 为大漠坐标
DmcliI(picName, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(x[], y[])
		Sleep, % slept
	}
}

;大漠点击它处函数，为大漠坐标
DmcliO(xx, yy, picName, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(xx, yy)
		Sleep, % slept
	}
}

;大漠图片查找函数，找到返回1，无返回0
DmPicR(picName, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
	gotEL := % gotEL + 1
	if gotEL 
		return 1
	else
		return 0
}



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

