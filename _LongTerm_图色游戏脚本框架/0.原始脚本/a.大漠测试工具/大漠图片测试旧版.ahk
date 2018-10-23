
#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%

dh := ","

dm := ComObjCreate( "dm.dmsoft" )	;创建大漠对象
dm.SetPath(A_WorkingDir)	;设定大漠工作路径
dm.SetDict( 1, "RConly.txt")	;设定大漠字典
dm.UseDict(1)		;设定引用字典，引用前需声明字典文件

Gui, Add, Text, x36 y7 w50 h16 , 图片名：
Gui, Add, Text, x36 y27 w60 h16 , 坐标范围：
Gui, Add, Text, x36 y47 w60 h16 , 点击位置：
Gui, Add, Text, x16 y67 w20 h20 , F8	;窗口句柄

Gui, Add, Text, vpicN x96 y7 w80 h16 , Picname	;图片名
Gui, Add, Text, vzbfw x106 y27 w100 h16 , 0`,0`,0`,0	;坐标范围
Gui, Add, Text, vdjwz x106 y47 w100 h16 , 0`,0	;点击位置
Gui, Add, Text, x16 y7 w20 h20 , F5
Gui, Add, Text, x16 y27 w20 h20 , F6
Gui, Add, Text, x16 y47 w20 h20 , F7

Gui, Add, Text, x36 y67 w60 h16 , 窗口句柄：
Gui, Add, Text, vckjb x106 y67 w100 h16 , 000000 	;窗口句柄
Gui, Add, Text, x50 y97 w30 h20 , F2/F3
Gui, Add, Text, x86 y97 w110 h16 , 搜图、点击测试

Gui, +AlwaysOnTop
Gui, Show, x1218 y816 h123 w213, 大漠图片测试
Return

f6::
Clipboard :=
SEND, ^c
ClipWait
gotpos := % Clipboard
GuiControl, , zbfw, % gotpos
return

f2::
gosub, 获取图片参数
DmPicR(picName ".bmp", dm, x1, y1, x2, y2, "080808", 0.8)
return

f3::
gosub, 获取图片参数
DmcliO(xx, yy, picName ".bmp", dm, 0, x1, y1, x2, y2, "080808", 0.9) 
return

f9::
gosub, 获取图片参数
x := ComVar(), y := ComVar()
cl := dm.FindColor(x1, y1, x2, y2, "259028-000000", 1, 0, x.ref, y.ref)
if cl
	dm.MoveTo(x[], y[])
else 
	msgbox, GG
return

f10::
gosub, 获取图片参数
GuiControlGet, zbfw, , zbfw
GuiControlGet, djwz, , djwz

FileAppend, % "坐标范围`n" zbfw "`n点击位置`n" djwz "`n图片名:`n" picName ".bmp", % a_workingdir "\" picName ".txt"
return

f11::
gosub, 获取图片参数
DmStrSerch := dm.Ocr(x1, y1, x2, y2, "d6dee1-121212|c1ccd0-131313|acbac0-101010|96a6ae-101010|f2f6f6-101010", 0.9)
msgbox, % DmStrSerch
return

!q::
Reload
return
获取图片参数:
GuiControlGet, picName, , picN	;得到图片名
GuiControlGet, pos1, , zbfw	;得到坐标
StringReplace, pos1, pos1, %dh%, o, ReplaceAll	;将逗号替换为o
StringGetPos, oplac1, pos1, o	;获取左边o的位置
StringLeft, x1, pos1, % oplac1	;x1为该参数
StringGetPos, oplac2, pos1, o, 1
dx1 := StrLen(pos1)
StringRight, y2, pos1, % dx1 - oplac2 - 1	;x1为该参数
StringTrimLeft, pos1, pos1, % oplac1 + 1
StringTrimRight, pos1, pos1, % dx1 - oplac2	;剩下两位，o左边为y1，右边为x2
StringGetPos, oplac1, pos1, o	;获取左边o的位置
StringLeft, y1, pos1, % oplac1	;x1为该参数
StringTrimLeft, x2, pos1, % oplac1 + 1
GuiControlGet, DJWZ, , djwz
StringReplace, DJWZ, DJWZ, %dh%, o, ReplaceAll	;将逗号替换为o
StringGetPos, oplac1, DJWZ, o	;获取左边o的位置
StringLeft, xx, DJWZ, % oplac1	;x1为该参数
StringTrimLeft, yy, DJWZ, % oplac1 + 1
return


f7::
Clipboard :=
SEND, ^c
ClipWait
gotpos := % Clipboard
GuiControl, , djwz, % gotpos
return

f5::
Clipboard :=
SEND, ^c
ClipWait
GuiControl, , picN, % Clipboard
return

f8::
Clipboard :=
SEND, ^c
ClipWait
GuiControl, , ckjb, % Clipboard
winID := % Clipboard
dm.BindWindow(winID,"gdi2","normal","windows",0)	;设定所有坐标相对窗口绑定,此为雷电模拟器配置
return


GuiClose:
ExitApp

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
}

;大漠图片查找函数，找到返回1，无返回0
DmPicR(picName, ByRef dmF, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	x := ComVar(), y := ComVar()
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		dmF.moveto(x[], y[])
		return 1
	}
	else
		MsgBox, didnt found
		return 0
}

