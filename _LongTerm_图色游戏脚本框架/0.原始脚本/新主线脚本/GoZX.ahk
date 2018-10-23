

/*
gotthenum := 1	此为脚本编号
winName := % "ZX" gotthenum		此为窗口名
*/

winpos(x1, y1, winName)
#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
CoordMode, tooltip, screen

dm := ComObjCreate( "dm.dmsoft")
dm.SetPath(A_WorkingDir "\dmpic\")
dm.SetDict( 0, "djtu1.txt")	;等级查询
dm.SetDict( 1, "hdzj2.txt")	;滑动坐骑
dm.SetDict( 2, "tsdj3.txt")	;任务为提升等级
dm.SetDict( 3, "ybsl5.txt")	;绑定元宝
dm.SetDict( 5, "wbsg6.txt")	;五倍杀怪
dm.SetDict( 6, "dhms7.txt")	;五倍杀怪
tsdjhz := "提升等级"
dhms := "夺魂魔使"
ToFoPa := % delStrL(a_workingdir, 6)
Loop
{
	if winexist("ZX" gotthenum) {
		WinClose, % "ZX" gotthenum
		SLEEP 5000
	}
	else
		break
}
Gui, Add, Text, x6 y7 w150 h20 , > > > 当前状态 < < <
Gui, Add, Text, vstatusx x6 y27 w150 h40 , Waiting For command...
Gui, Show, x%x1% y%y1% h70 w165, Dl%winName%
gosub, 初次启动游戏
Return

GuiClose:
ExitApp

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     初次启动游戏
检测当前游戏状态:
if (GNSubT(gotTimeStart) > 3600)
	Reload
ToolTip, % winName "窗口已运行：" StoHMS(GNSubT(gotTimeStart)) "注：超过1小时将重启该窗口", 10, % 593 + (gotthenum - 1) *16

dmCoClO( 816,78, "wpxxgb.bmp", dm, winName, 500, 0, 549,181,670,228)	;物品信息关闭
dmCoCli("qrdl5.bmp", dm, winName, 500, 0, 610,343,853,497)		;七日登录收下咯2
dmCoCli("wcrw2.bmp", dm, winName, 500, 0, 64,393,289,520)		;主线任务完成2
dmCoCli("ljcs.bmp", dm, winName, 500, 0, 670,393,838,497)		;主线任务完成2
dmCoCli("lxjyqdx.bmp", dm, winName, 500, 0, 403,342,568,438)		;离线经验单排确定1

dmCoClO( 394,335, "gmcs.bmp", dm, winName, 1000, 0, 501,299,650,372)	;副本购买次数

if dmCoPicR("wlcw111.bmp", dm, winName) {	;网络错误时
	sleep 1000
	Reload
}

dm.UseDict(0)	;等级查询 
dqdj := dm.Ocr(40,43,84,81, "d6dee1-121212|c1ccd0-131313|acbac0-101010|96a6ae-101010|f2f6f6-101010", 0.9)
if dqdj {
	dqdjx := % dqdj
	if ((dqdjx <= 49) and gotdone) {
		FileAppend, % "`n" nowGANforZX, % A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note"
		guiChan("当前等级为：" dqdj "`n主线已完成将切号", statusx)
		Del_F(nowGAPforZX)	;
		filemove, % ToFoPa "\1-主线\" nowGANforZX, % ToFoPa "\2-日常\" nowGANforZX, 1
		SLEEP 500
		Reload		
	}
	else if ((dqdjx >= 50)) {
		FileAppend, % "`n" nowGANforZX, % A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note"
		guiChan("当前等级为：" dqdj "`n主线已完成将切号", statusx)
		Del_F(nowGAPforZX)	;
		filemove, % ToFoPa "\1-主线\" nowGANforZX, % ToFoPa "\2-日常\" nowGANforZX, 1
		SLEEP 500
		Reload
	}
	else
		guiChan("当前等级为：" dqdj , statusx)
}
if (dqdjx and (dqdjx < 6)) {	;夺魂魔使
	dm.UseDict(6)
	dhmsx := dm.Ocr(8,267,157,350, "159f00-080808|139100-101010|0d6100-080808|0f7500-080808", 0.7)
	if (dhmsx = dhms) {
		guiChan("当前等级为：" dqdj "`n正在进行勾魂魔使的任务", statusx)

			sleep 1000
			ControlClick, x108 y371, % winName, , L, 1
			sleep 8000
			dm.MoveTo(179, 425)
			SLEEP 500
			dm.LeftDown()
			sleep 2700
			dm.LeftUp()
			sleep 1000
			ControlClick, x108 y371, % winName, , L, 1
			sleep 2000
	}
}
dm.UseDict(2)	;任务为提升等级
tsdj := dm.Ocr(36,190,117,215, "d6dee1-121212|c1ccd0-131313|acbac0-101010|96a6ae-101010|f2f6f6-101010", 0.8)
if (tsdj = tsdjhz) {
	gotdone := 1
}
	
dm.UseDict(1)	;滑动坐骑
hdzj := dm.Ocr(372,376,613,454, "f5e934-101010|cec32c-101010|e1d32e-101010|cabf2b-101010", 0.6)
if hdzj
{
	dm.moveto(469,423)	;起始位置
	sleep 200
	dm.LeftDown()
	sleep 100
	dm.moveto(481,287)
	sleep 100
	dm.LeftUp()
	sleep 800
}

dm.UseDict(5)	;五倍杀怪
wbsgx := dm.Ocr(16,126,249,230, "6eb3da-101010|5b94b6-080808|5386a6-080808|64a2c6-101010", 0.7)
if (wbsgx) {
	ControlClick,x327 y202, %winName%, , L, 1
	sleep 2000
}

winName := % "ZX" gotthenum	



dmCoCli("djrw1.bmp", dm, winName, 500)	;点击人物1
dmCoCli("djrw2.bmp", dm, winName, 500)	;点击人物2
dmCoCli("djrw3.bmp", dm, winName, 500)	;点击人物3
dmCoCli("djrw5.bmp", dm, winName, 500)	;点击人物5
dmCoCli("djrw6.bmp", dm, winName, 500)	;点击人物6
dmCoCli("djrw7.bmp", dm, winName, 500)	;点击人物6
dmCoCli("djrw8.bmp", dm, winName, 500)	;点击人物6
dmCoCli("djrw9.bmp", dm, winName, 500)	;点击人物6
dmCoCli("djrw10.bmp", dm, winName, 500, 0, 421,217,526,302)	;点击人物6

dmCoCli("smbsy.bmp", dm, winName, 500, 0, 567,102,955,444)		;生命包使用
dmCoCli("hdwp1.bmp", dm, winName, 1200)		;点击获得物品
dmCoCli("cdwp.bmp", dm, winName, 800, 0, 567,102,955,444)		;点击穿戴物品

dmCoCli("lkfjyb.bmp", dm, winName, 800)		;立刻反击
dmCoClO( 486, 470, "qwtys.bmp", dm, winName, 500)	;前往体验赛
dmCoClO( 183, 98, "fjszms.bmp", dm, winName, 500)	;体验赛人物
dmCoClO( 131, 297, "fjszms1.bmp", dm, winName, 500)	;反击

dmCoCli("djzx1.bmp", dm, winName, 1000, 0, 18,84,304,528)		;点击主线
dmCoCli("jxrw1.bmp", dm, winName, 1000, 0, 18,84,304,528)	;继续任务
dmCoCli("wcrw1.bmp", dm, winName, 500, 0, 18,84,304,528)	;完成任务

dmCoCli("tcfb.bmp", dm, winName, 500, 0, 16,98,678,483)		;退出副本
dmCoCli("fbtcqd.bmp", dm, winName, 800, 0, 16,98,678,483)		;副本退出确定
dmCoCli("tzxyg.bmp", dm, winName, 800, 0, 16,98,678,483)		;副本挑战下一关
dmCoCli("tzcgqd.bmp", dm, winName, 800, 0, 16,98,678,483)		;挑战成功确定
dmCoCli("fbjl.bmp", dm, winName, 500, 0, 16,98,678,483)		;副本奖励
dmCoCli("tcfb3.bmp", dm, winName, 500, 0, 385, 364, 568, 450)		;副本死亡退出副本



dmCoCli("djfh1.bmp", dm, winName, 800)		;所有界面点击返回
dmCoCli("jmdx.bmp", dm, winName, 500)		;各种界面点叉
dmCoCli("sddx1.bmp", dm, winName, 500)		;商店红叉

dmCoCli("zxdjqd.bmp", dm, winName, 500)		;珍惜道具确定
dmCoCli("zdkj1.bmp", dm, winName, 500, 0, 291,94,862,459)		;砸蛋开局1
dmCoCli("zdkj2.bmp", dm, winName, 500, 0, 291,94,862,459)		;砸蛋开局2
dmCoCli("dtdx.bmp", dm, winName, 500, 0, 777,10,888,97)		;砸蛋开局2

dmCoCli("qdlq1.bmp", dm, winName, 500)	;确定领取神器等
dmCoCli("qrdl1.bmp", dm, winName, 500, 0, 610,343,853,497)		;七日登录收下咯
dmCoCli("tqjy1.bmp", dm, winName, 800, 0, 229,22,772,501)		;点击提取经验

dmCoClO( 668,70, "tsvipdj.bmp", dm, winName, 500, 0, 229,22,772,501)	;经验领取关闭
dmCoClO( 167,412, "qwcz.bmp", dm, winName, 500)	;前往充值关闭
dmCoClO( 668,70, "hjhy.bmp", dm, winName, 500)	;成为黄金会员

dmCoClO( 764,339, "bcdlts.bmp", dm, winName, 1000, 0, 629,119,957,416)	;本次登录不再提示灰圈
dmCoClO( 935,189, "bcdlts1.bmp", dm, winName, 1000, 0, 629,119,957,416)	;本次登录不再提示打钩点叉

dmCoClO(849, 69, "kfybzbs.bmp", dm, winName, 1000, 0, 339, 58, 439, 97)	;跨服元宝争霸关闭
dmCoClO(791, 59, "kfybzbgjx.bmp", dm, winName, 1000, 0, 409, 424, 551, 501)	;回头干他关闭

dmCoClO( 460,102, "sdhd.bmp", dm, winName, 500)	;商店获得点x
dmCoClO( 832,68, "qrdl2.bmp", dm, winName, 500, 0, 610,343,853,497)	;七日登录灰钮
dmCoClO( 737, 127, "ssht1.bmp", dm, winName, 500)	;神兽昊天
dmCoClO( 924,30, "xxbdx.bmp", dm, winName, 500, 0, 0,0,153,52)	;仙侠板点叉


if dmCoPicR("xmjm.bmp", dm, winName, 4,2,180,43) {		;仙盟相关
	dmCoCli("xmksjr.bmp", dm, winName, 1200)	;点击仙盟快速加入
	dmCoCli("xmdx.bmp", dm, winName, 500)	;仙盟点叉
}

if dmCoPicR("mrbz1.bmp", dm, winName, 4,2,180,43) { ;搜图到每日必做
	dmCoClO( 832,68, "mrbz2hn.bmp", dm, winName, 1000)	;灰钮关闭
	dmCoCli("mrbzsj.bmp", dm, winName, 500, 0, 263,480,410,530)	;绿钮升级
}
dmCoCli("mrbzlqjl.bmp", dm, winName, 500, 0, 560,386,771,486)	;每日必做领取奖励

if dmCoPicR("TMLQ.bmp", dm, winName, 273,16,752,387) {	;天命灵签
	/*
	wIDFF := dm.FindWindow("LDPlayerMainFrame", winName) ;父窗口ID
	wIDzz := dm.EnumWindow(wIDFF, "TheRender","",1)	;子窗口ID 
	dm.BindWindow(wIDzz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
	*/
	dm.moveto(446, 384)	;起始位置
	sleep 200
	dm.LeftDown()
	sleep 100
	dm.moveto(647,427)
	sleep 100
	dm.LeftUp()
	sleep 800
}
dmCoCli("tmlqsrh.bmp", dm, winName, 800)		;天命灵签说人话
dmCoCli("lqhj1.bmp", dm, winName, 800)		;点击领取婚戒
dmCoCli("xslsj.bmp", dm, winName, 800)		;点击先上60级

dmCoClO( 919,28, "fbtcx2.bmp", dm, winName, 1000, 0, 27,1,117,43)	;副本点x
return

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     初次启动游戏
初次启动游戏:
guiChan("初次启动游戏", statusx)
WinActivate, ahk_class LDMultiPlayerMainFrame
sleep 500
muliR(gotthenum)	;点击工作位置
if gotthenum = 1
	nedwinname := "雷电模拟器"
else {
	nedwinnumgot := % gotthenum - 1
	nedwinname := % "雷电模拟器-" nedwinnumgot
}
winwait, %nedwinname%, , , ZX
WinSetTitle, %nedwinname%, , % winName, ZX

Sleep 1000
wIDFF := dm.FindWindow("LDPlayerMainFrame", winName) ;父窗口ID
wIDzz := dm.EnumWindow(wIDFF, "TheRender","",1)	;子窗口ID 
dm.BindWindow(wIDzz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 


guiChan("点击幻剑图标", statusx)
sleep 50
WinMove, % winName, , % 2 + (gotthenum - 1) * 50, 10
Loop {
	dmCoCli("hjicon.bmp", dm, winName, 200)	;点击幻剑图标
	if dmCoPicR("dlrn.bmp", dm, winName)	;找到登录红钮
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) 
		Reload
}
guiChan("清空账号密码", statusx)
Loop {
	/*
	wIDF := dm.FindWindow("", winName) ;父窗口ID
	wIDz := dm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
	dm.BindWindow(wIDz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
	*/
	ControlClick,x500 y233, %winName%, , L, 1
	sleep 200	
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	ControlClick,x500 y280, %winName%, , L, 1
	sleep 200
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if dmCoPicR("zmcl.bmp", dm, winName)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) 
		Reload
}
guiChan("获取账号密码", statusx)
if (fileexist(a_workingdir "\WorkAcc\" gotthenum "\*.acc")) {
	loop, % a_workingdir "\WorkAcc\" gotthenum "\*.acc"
	{
		if (a_index = 1) {
			nowGAPforZX := % A_LoopFileLongPath	;临时文件长路径，完成时删除
			nowGANforZX := % A_LoopFileName	;账号名，在1-主线中另有存档，完成时移动文件到2-日常
			goact := % getL(nowGAPforZX)	;获取账号名
			gopas := % getL(nowGAPforZX, 2)	;获取密码
		}
		break
	}
}
guiChan("输入账号密码", statusx)	
Loop
{
	
	dm.SetKeypadDelay("windows", 50)
	ControlClick,x500 y233, %winName%, , L, 1	;点击账号区域
	sleep 700
	dm.SendString(wIDzz, goact) 
	sleep 2000
	ControlClick,x500 y280, %winName%, , L, 1	;点击密码区域
	sleep 700
	dm.SendString(wIDzz, gopas) 
	sleep 2000
	/*
	Clipboard := % goact
	ClipWait
	Cr_AfterDel(winName, A_WorkingDir "\Nowgo" winName ".log")	;创建文件响应ctrl助手
	sleep 1500
	Loop {
		ControlGetText, gTofCH, Edit1, Ctrl助手	;获取ctrl助手文本
		if gTofCH = % winName 
		{
			dm.KeyDown(86)
			sleep 50
			dm.KeyUp(86)
			sleep 50		
			Del_F(A_WorkingDir "\Nowgo" winName ".log")	
			break
		}
	}
	
	Clipboard :=
	sleep 1500
	
	Cr_AfterDel(winName, A_WorkingDir "\Nowgo" winName ".log")	;创建文件响应ctrl助手
	Clipboard := % gopas
	ClipWait
	Loop {
		ControlGetText, gTofCH, Edit1, Ctrl助手	;获取ctrl助手文本
		if gTofCH = % winName 
		{
			dm.KeyDown(86)
			sleep 50
			dm.KeyUp(86)
			sleep 50		
			Del_F(A_WorkingDir "\Nowgo" winName ".log")			
			break
		}
	}
	*/
	if (!dmCoPicR("zhem.bmp", dm, winName) and !dmCoPicR("mmem.bmp", dm, winName))
		break
	else
		gosub, 清除账号密码
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	if (a_index >= 6) 
		Reload
}
guiChan("点击登录红钮", statusx)	
Clipboard :=
Loop {
	dmCoCli("dlrn.bmp", dm, winName, 500)
	if dmCoPicR("dlhn.bmp", dm, winName) and !dmCoPicR("xfwq.bmp", dm, winName)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 30) 
		Reload
}
guiChan("点击登录黄钮", statusx)
Loop {
	dmCoCli("dlhn.bmp", dm, winName, 1000)
	if dmCoPicR("dt.bmp", dm, winName,10, 300, 500, 540) 	;正在读条
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 200
	if (a_index >= 50) 
		Reload
}
guiChan("等待读条结束", statusx)
Loop {
	if dmCoPicR("dt.bmp", dm, winName)
		sleep 500
	if dmCoPicR("wlcw111.bmp", dm, winName) {	;网络错误时
		sleep 1000
		Reload
	}
	if (dmCoPicR("vp.bmp", dm, winName) or dmCoPicR("kjzd.bmp", dm, winName) or dmCoPicR("jhhs.bmp", dm, winName) or dmCoPicR("bbao.bmp", dm, winName) or !dmCoPicR("dt.bmp", dm, winName,10, 300, 500, 540))	;开局砸蛋，魂兽领取，vip0，背包
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 80) 
		Reload
}
Gui, Destroy
Gui, Add, Text, x6 y7 w150 h20 , > > > 当前状态 < < <
Gui, Add, Text, vstatusx x6 y27 w150 h40 , Waiting For command...
Gui, Show, x%x1% y%y1% h70 w165, Go%winName%x
gotTimeStart := % A_Now
guiChan("检测游戏状态", statusx)
SetTimer, 检测当前游戏状态, 1500
return

清除账号密码:
Loop {
	/*
	wIDF := dm.FindWindow("", winName) ;父窗口ID
	wIDz := dm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
	dm.BindWindow(wIDz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
	*/
	ControlClick,x500 y233, %winName%, , L, 1
	sleep 200	
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	ControlClick,x500 y280, %winName%, , L, 1
	sleep 200
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if dmCoPicR("zmcl.bmp", dm, winName)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 300
	if (a_index >= 60) 
		Reload
}
return

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     函数
guiChan(newtex, ByRef gVar) { ;GUI改变函数
	GuiControl, , gVar, % newtex
}


;获取文件首行字符串
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

;创建文件前删除文件，并写入首行文本
Cr_AfterDel(tex, filLP)
{
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
;删除文件
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

;删除字符串后几位  
delStrL(inputvar,countx := 0) {
	StringTrimRight, ca, inputvar, % Countx
	return % ca
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
dmCoCli(picname, ByRef dmm, FTitle,slpt1 := 0, slpt2 := 0, x1 := 5, y1 := 5, x2 := 950, y2 := 535)
{
	wIDF := dmm.FindWindow("LDPlayerMainFrame", FTitle) ;父窗口ID
	x := ComVar(), y := ComVar()
	gErrorL := dmm.FindPic(x1, y1, x2, y2, picname,"080808",0.7,0, x.ref, y.ref)
	gErrorL := % gErrorL + 1
	if (gErrorL) {	;若找到图
		DmMsCli(x[], y[], dmm)
		sleep, % slpt1
	}
	else if (!gErrorL) {	;若未找到图
		Sleep, % slpt2
	}
}

;后台图片确认函数 
dmCoPicR(picname, ByRef dmm, FTitle, x1 := 5, y1 := 5, x2 := 950 ,y2 := 535) {
	wIDF := dmm.FindWindow("LDPlayerMainFrame", FTitle) ;父窗口ID

	gErrorL := dmm.FindPic(x1, y1, x2, y2, picname,"080808",0.7,0, x, y)
	gErrorL := % gErrorL + 1
	if gErrorL
		return 1
	else
		return 0
}
;后台点击它处函数
dmCoClO( xx, yy,picname, ByRef dmm, FTitle,slpt1 := 0, slpt2 := 0, x1 := 5, y1 := 5, x2 := 950, y2 := 530)
{
	wIDF := dmm.FindWindow("LDPlayerMainFrame", FTitle) ;父窗口ID
/*
	wIDz := dmm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
	if wIDz
		dmm.BindWindow(wIDz,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
*/
	x := ComVar(), y := ComVar()
	gErrorL := dmm.FindPic(x1, y1, x2, y2, picname,"080808",0.7,0, x.ref, y.ref)
	gErrorL := % gErrorL + 1
	if (gErrorL) {	;若找到图
		DmMsCli(xx, yy, dmm)
		sleep, % slpt1
	}
	else if (!gErrorL) {	;若未找到图
		Sleep, % slpt2
	}
}

DmMsCli(x, y,ByRef dmF, slpt := 0) {	;大漠点击函数
	dmF.MoveTo(x, y)
	sleep 50
	dmF.LeftDown()
	sleep 50
	dmF.LeftUp()
	Sleep, % slpt
}

GNSubT(td) {	;用当前时间戳减去给定时间戳，返回单位为秒
	toN := % A_Now
	EnvSub, toN, %td%, Seconds
	return % toN
}

StoHMS(sec) {	;将秒数转换为时 分 秒形式
	if (sec >= 3600) {
		bl := % sec / 3600
		hourN := % Ceil(bl) - 1
		toMin := % Mod(sec, 3600)
		if (toMin < 60) {
			MinN := "0"
			SecondN := % toMin
		}
		else {	
			bl1 := % toMin / 60
			MinN := % Ceil(bl1) - 1
			SecondN := % Mod(toMin, 60)
		}
		return % hourN " 时 " MinN " 分 " SecondN " 秒"
	}
	else if ((sec >= 60) and (sec < 3600)) {
		bl2 := % sec / 60
		MinN := % Ceil(bl2) - 1
		SecondN := % Mod(sec, 60)
		got := % MinN " 分 " SecondN " 秒"
		return % got
	}
	else if (sec < 60) {
		SecondN := % sec
		GP := % SecondN " 秒"
		return % GP
	}
}

;此为窗口坐标确定函数
winpos(ByRef x,ByRef y, win) {	
	zx1 := "ZX1"
	zx2 := "ZX2"
	zx3 := "ZX3"
	zx4 := "ZX4"
	zx5 := "ZX5"
	zx6 := "ZX6"
	zx7 := "ZX7"
	zx8 := "ZX8"
	zx9 := "ZX9"
	zx10 := "ZX10"
	zx11 := "ZX11"
	zx12 := "ZX12"
	if (win = %zx1%) {
		x := 10
		y := 800
	}
	else if (win = %zx2%) {
		x := 180
		y := 800		
	}
	else if (win = %zx3%) {
		x := 350
		y := 800		
	}	
	else if (win = %zx4%) {
		x := 520
		y := 800		
	}
	else if (win = %zx5%) {
		x := 690
		y := 800		
	}
	else if (win = %zx6%) {
		x := 860
		y := 800		
	}
	else if (win = %zx7%) {
		x := 10
		y := 880		
	}		
	else if (win = %zx8%) {
		x := 180
		y := 880		
	}	
	else if (win = %zx9%) {
		x := 350
		y := 880		
	}	
	else if (win = %zx10%) {
		x := 520
		y := 880		
	}	
	else if (win = %zx11%) {
		x := 690
		y := 880		
	}	
	else if (win = %zx12%) {
		x := 860
		y := 880		
	}	
}


conCli(lx, ly, tit) { ;controlclick函数
	ControlClick, % "x" lx " y" ly, % tit, , L, 1
}

muliR(timeofL) { ;控制多开器启动/关闭窗口函数
	if timeofL = 1
		conCli(396, 113,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 2
		conCli(388, 163,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 3
		conCli(388, 213,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 4
		conCli(388, 265,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 5
		conCli(388, 315,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 6
		conCli(388, 365,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 7
		conCli(388, 415,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 8
		conCli(388, 467,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 9
		conCli(388, 515,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 10
		conCli(388, 565,"ahk_class LDMultiPlayerMainFrame")
	else
		return 0
}