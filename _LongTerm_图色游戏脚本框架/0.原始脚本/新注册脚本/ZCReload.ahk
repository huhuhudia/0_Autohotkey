#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
setworkingdir %a_scriptdir%
dm := ComObjCreate( "dm.dmsoft")
dm.SetPath(A_WorkingDir "\dmpic\")
Loop {
	if (winexist("幻剑创建账号脚本")) {
		winclose, 幻剑创建账号脚本
		sleep 500
	}
	else
		break
}
ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")
sleep 300

CoordMode, mouse, screen
dm.EnableBind(0)
dm.UnBindWindow() 

MouseMove, 850, 1050, 0
SLEEP 100
MouseMove, 1870, 1050, 15
sleep 500
intX := ComVar(), intY := ComVar()

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
				dd5 := 1
				break
			}
		}
		if dd5
			break
	}
}
run, % a_workingdir "\ZCx.ahk"
winwait, 幻剑创建账号脚本
Sleep 700
ControlClick, x100 y130, 幻剑创建账号脚本
sleep 1000
ExitApp

return




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
