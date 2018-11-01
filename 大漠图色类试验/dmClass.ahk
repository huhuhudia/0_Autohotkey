
global dmx := ComObjCreate( "dm.dmsoft" )
global __x := ComVar()
global __y := ComVar()

/*
大漠前期工作流程：
	1.利用大漠综合工具确认目标工作区域，取窗口句柄
	2.枚举取图，验证图色
	3.试验鼠标模式，后台点击反应
	4.试验键盘输出模式，后台控件反应
*/

gdmWHD() {	;获取大漠的窗口句柄控件文本
	ControlGetText, dmedithd, Edit45, ahk_exe 大漠综合工具.exe
	return % dmedithd
}


gdmCRgLs() {	;获取大漠窗口选择范围的包括宽高的6位坐标参数列表
	dh = ,
	kh = (
	kh2 = )
	HL := []
	ControlGetText, chosrg, Edit47, ahk_exe 大漠综合工具.exe
	if !chosrg	;为空时返回0
		return 0
	StringReplace, chosrg, chosrg, % dh , o, 1
	StringReplace, chosrg, chosrg, % kh , % "", 1
	StringReplace, chosrg, chosrg, % kh2 , % "", 1
	StringReplace, chosrg, chosrg, 宽高 , % "", 1
	MsgBox, % chosrg
	Loop, Parse, chosrg, o
		HL.Insert(A_LoopField)	
	return % HL
}



Class dmClass {
	dispmode := ["gdi", "gdi2", "dx2", "dx3"]
	__New() {
		this.dm := dmx 
	}

	topH() {
		
		;设置大漠默认
		this.dm.SetPath(A_ScriptDir)

		hd := this.dm.GetForegroundWindow()
		;根据id查找窗口程序名

		for i in sl
		{
			MsgBox, % sl[i]
			for l in this.dispmode
			{
				this.dm.GetClientSize(sl[i], __x.ref, __y.ref) 
				ti := this.dm.GetWindowTitle(sl[i])
				ddd := this.dm.GetWindowClass(sl[i])
				
				;tt := this.dm.BindWindow(sl[i], this.dispmode[l], "normal", "normal", 0)
			;	dm_ret := this.dm.Capture( 0, 0, 2000, 2000, "Cls." ddd "-TT." ti "-" sl[i] "-" this.dispmode[l] ".bmp")

				
			}
		}
		return % tl
	}
	HDLS(hd)  {	;根据获取的窗口句柄枚举出所在程序的所有关联句柄
		dh = ,
		;根据句柄查找窗口对应的程序
		EXE := this.dm.GetWindowProcessPath(hd) 
		loop, % EXE
			EXE := % A_LoopFileName
		;根据hd查找窗口标题
		title := this.dm.GetWindowTitle(hd)
		;根据hd查找窗口类
		clas := this.dm.GetWindowClass(hd)
		
		;枚举与此hd程序相关的所有窗口id
		LLL := this.dm.EnumWindowByProcess(EXE, title, clas, 16)
		HL := []
		StringReplace, LLL, LLL, % dh , o, 1
		Loop, Parse, LLL, o
			HL.Insert(A_LoopField)
		return % HL
	}
	
/*
;获取置顶窗口的id
hd := this.dm.GetForegroundWindow()
;获取鼠标位置的窗口id
hd2 := this.dm.GetMousePointWindow()
*/

}


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