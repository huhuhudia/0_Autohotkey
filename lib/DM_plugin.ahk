/*
dm.SetPath("C:\Users\Administrator\Desktop\")	;设定大漠工作路径

——— 绑定窗口 ————
wIDF := dm.FindWindow("LDPlayerMainFrame", "雷电模拟器") ;父窗口ID
wIDS := dm.EnumWindow(wIDF, "TheRender","",1)	;子窗口ID 
dm.BindWindow(wIDS,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定,此为雷电模拟器配置

——— orc字典引用 ————
dm.SetDict( 1, "zd.txt")	;设定大漠字典
dm.UseDict(1)		;设定引用字典，引用前需声明字典文件
DmStrSerch := dm.Ocr(8,267,157,350, "", 0.9)	; 1-4 范围 5 为颜色范围 6为模糊匹配程度，值越低速度越慢
*/

global dm := ComObjCreate( "dm.dmsoft" )	;创建大漠对象
global x := ComVar()
global y := ComVar()

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
	
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		Sleep, % slpt
		DmMsCli(x[], y[])
	}
}

DmPieClO(x1, y1, x2, y2, ColorX, xx, yy, slpt := 0,MH := 1) {	;搜色点击它处，模糊匹配默认为1,从左到右从上下
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(xx, yy)
		Sleep, % slpt
	}
}

DmPieR(x1, y1, x2, y2, ColorX, MH := 1) {	;搜色判断，模糊匹配默认为1,从左到右从上下
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x, y)
	return % cl
}

;大漠点击图片函数, 为大漠坐标
DmcliI(picName,  slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(x[], y[])
		Sleep, % slept
	}
}

;大漠点击它处函数，为大漠坐标
DmcliO(xx, yy, picName, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
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