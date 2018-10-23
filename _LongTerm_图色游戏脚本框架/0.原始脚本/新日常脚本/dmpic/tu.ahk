#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%

dm := ComObjCreate( "dm.dmsoft")
dm.SetPath(A_WorkingDir)
dm.SetDict( 0, "RConly.txt")	;设定大漠字典
nowPro :=

Loop {

	;1.选择型关闭,nowPro不为该流程名时，直接关闭
	if nowPro != % "领取福利"
		DmcliO(829, 52, "fljm.bmp", dm, 500, 437, 40, 523, 83, "080808", 0.7)	;关闭福利主界面
	if nowPro != % "仙盟"
		DmcliO(921, 36, "xmjm1.bmp", dm, 500, 37, 2, 115, 36)	;关闭仙盟界面

	if nowPro != % "龙神佑体"
		DmcliO(838, 107, "yylmjmxx.bmp", dm, 500, 449, 47, 571, 149)	;关闭鱼跃龙门界面
	
	/*
	;2.非选择通用
	DmcliO(765, 339, "wxtshn.bmp", dm, 800, 740, 317, 787, 370)	;温馨提示灰圈，不再提醒
	
	DmcliI("dlyx.bmp", dm, 800, 474, 421, 561, 475)	;显示顶部界面（通用）
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	
	
	DmcliI("lxjyqdx.bmp", dm, 800, 403, 342, 568, 438)	;开头离线经验确定
	DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249)	;中心位置获得物品 - 单排（通用）
	DmcliI("zxwcrw.bmp", dm, 500, 75, 411, 267, 516)	;主线完成任务
	DmcliI("flzyzhqr.bmp", dm, 800, 500, 334, 642, 412, "080808", 0.8)	;福利资源找回确认
	
	DmcliO(151, 68, "lkcz1.bmp", dm, 800, 437, 40, 523, 83)	;关闭充值界面1
	DmcliO(920,42, "czdl1.bmp", dm, 500, 5,2,127,34)	;关闭充值界面2
	
	DmcliO(767, 73, "xmjxdx.bmp", dm, 800, 417, 34, 551, 98, "080808", 0.8)	;仙盟捐献界面
	
	DmcliO(815, 74, "tjgb.bmp", dm, 500, 466, 20, 548, 103)	;天机结婚弹窗关闭
	DmcliO(396, 370, "tjgb.bmp", dm, 500, 521, 315, 598, 355)	;福利资源元宝找回
	DmcliO(771, 115, "qwczxd.bmp", dm, 500, 386, 334, 578, 430)	;前往充值关闭
	
	DmcliO(920,281, "lkcz1.bmp", dm, 500, 678, 446, 850, 533)	;关闭右下活动弹窗，前往参与 1
	DmcliO(917,279, "qwcy2.bmp", dm, 500, 699, 458, 842, 529)	;关闭右下活动弹窗，前往参与 2
	DmcliO(934, 189, "wxtshn.bmp", dm, 500, 736, 314, 788, 366, "090909", 0.7)	;温馨提示打钩了，点叉
	if (DmPicR("qrdlkljl.bmp", dm, 114, 381, 251, 474, "080808", 0.8)) {	;七日登录界面
		loop 2
			DmPieCli(673, 403, 685, 422, "269129-010101", dm, 800)	;按钮位置为绿色
		DmPieClO(675, 400, 686, 425, "727272-010101", 827, 72, dm, 500)
	}
	DmcliI("sjdqd.bmp", dm, 800, 419, 326, 541, 385)	;升级丹确定
	DmcliI("qrdlljcs.bmp", dm, 800, 671, 392, 832, 499)	;七日登录时装立即穿上
	
	if (DmPicR("mrbzjm.bmp", dm, 9, 1, 136, 38, "080808", 0.8)) {	;每日必做界面
		DmPieCli(370, 503, 389 ,523, "45b240-050505", dm, 1200)	;绿钮按下
		DmcliI("mrlqjl.bmp", dm, 800, 589, 414, 745, 490, "080808", 0.8)	;每日领取奖励
		DmPieClO(366, 495, 382, 518, "646464-030303", 921, 42, dm, 500)	;灰钮关闭
	}
	DmcliI("mrlqjl.bmp", dm, 800, 589, 414, 745, 490, "080808", 0.8)	;每日领取奖励
	
	DmcliO(935, 192, "bcdlbztx.bmp", dm, 500, 728, 293, 804, 376, "101010", 0.7)	;本次登录不再提醒
	;----提取经验
	DmcliI("tqjy1.bmp", dm, 500, 546, 254, 687, 313)	;单倍提取位置
	DmcliO(664, 79, "tqjyvip.bmp", dm, 500, 409, 401, 558, 477)	;提升vip等级，点叉
	DmcliO(662, 80, "jycwhjhy.bmp", dm, 500, 423, 379, 550, 476)	;成为黄金会员 点叉
	DmcliO(664, 79, "jyyfx.bmp", dm, 500, 422, 38, 537, 107)	;经验玉符点，点叉
	*/
	;3.搜到背包时，break
	if (DmPicR("bb.bmp", dm, 893, 206, 951, 270, "101010", 0.7) or DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) {
		break
	}
	if nowPro = % "领取福利"
	{
		if DmPicR("fljm.bmp", dm, 437, 40, 523, 83, "101010", 0.7)
			break
	}
	else if nowPro = % "仙盟"
	{
		if (DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)) {
			DmPieClO(199, 46, 220, 63, "c43440-080808", 194, 81, dm, 800)	;点击仙盟福利
			break
		}
	}
	else if nowPro = % "龙神佑体"
	{
		if DmPicR("yylmjm.bmp", dm, 402, 38, 494, 74)
			break
	}
}

return



;——— 大漠必备函数 用以指针坐标输出 ————
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

;——— 大漠自制函数 搜图等 ————

DmSendW(tex, hwndx,ByRef dmF, slpt := 0) {	;发送文本到窗口,成功发送将延迟
	dmF.SetKeypadDelay("windows", 50)
	cl := dmF.SendString(hwndx, tex)
	if cl
		Sleep, % slpt
}

DmMsCli(x, y,ByRef dmF, slpt := 0) {	;大漠点击函数
	dmF.MoveTo(x, y)
	sleep 50
	dmF.LeftDown()
	sleep 50
	dmF.LeftUp()
	Sleep, % slpt
}

DmMsDrag(x1, y1,ByRef dmF, x2, y2, slpt := 0) {	;大漠鼠标点击拖行
	dmF.MoveTo(x, y)
	sleep 100
	dmF.LeftDown()
	sleep 100
	dmF.MoveTo(x2, y2)
	sleep 300
	dmF.LeftUp()
	Sleep, % slpt
}

;大漠点击图片函数, 为大漠坐标
DmcliI(picName, ByRef dmF, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	x := ComVar(), y := ComVar()
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(x[], y[], dmF)
		Sleep, % slept
	}
	else
		sleep 2
}

;大漠点击它处函数，为大漠坐标
DmcliO(xx, yy, picName, ByRef dmF, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	x := ComVar(), y := ComVar()
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(xx, yy, dmF)
		Sleep, % slept
	}
	else
		Sleep 10
}

;大漠图片查找函数，找到返回1，无返回0
DmPicR(picName, ByRef dmF, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
	gotEL := % gotEL + 1
	if (gotEL) {
		Sleep 3
		return 1
	}
	else {
		Sleep 3
		return 0
	}
}

DmPieCli(x1, y1, x2, y2, ColorX, ByRef dmF, slpt := 0,MH := 1) {	;搜色点击，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(x[], y[], dmF)
		Sleep, % slpt
	}
	else
		Sleep 2
}

DmPieClO(x1, y1, x2, y2, ColorX, xx, yy, ByRef dmF, slpt := 0,MH := 1) {	;搜色点击它处，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(xx, yy, dmF)
		Sleep, % slpt
	}
	else
		Sleep 2
}


DmPieR(x1, y1, x2, y2, ColorX, ByRef dmF,MH := 1) {	;搜色判断，模糊匹配默认为1,从左到右从上下
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x, y)
	Sleep 5
	return % cl
}



;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     必要函数 
conCli(lx, ly, tit) { ;controlclick函数
	ControlClick, % "x" lx " y" ly, % tit, , L, 1
}

delStrL(inputvar,countx := 0) { ;删除字符串后几位  
    StringTrimRight, ca, inputvar, % Countx
    return % ca
}

guiChan(newtex, ByRef gVar) { ;GUI改变函数
	GuiControl, , gVar, % newtex
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

getL(filLP, linenum := 1) { ;获取文件某行字符串，无返回0，默认首行
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
