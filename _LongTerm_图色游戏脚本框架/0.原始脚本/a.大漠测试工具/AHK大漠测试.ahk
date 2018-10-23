#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %a_scriptdir%
DMW := "DMwindow"
ToFoPa := % delStrL(a_workingdir, 9)
dm := ComObjCreate( "dm.dmsoft")
dm.SetPath(A_WorkingDir)

RGBm := "080808"
MH := "0.9"
dh = ,
Gui, Add, Edit, -Wrap ReadOnly x256 y15 w390 h135 , % "> - Func Area 函数生成区域 -----<<<<<<<<<<<<<<<<<<<<<<<<<"
Gui, Add, Text, x11 y137 w95 h18 , F9 _ 坐标范围：
Gui, Add, Text, x11 y117 w95 h18 , F8 _ 绑定窗口：

Gui, Add, Text, vfindPos x106 y137 w120 h18 , 0`,0`,1920`,1080	;坐标范围
Gui, Add, Text, vWinID x106 y117 w95 h18 , None	;绑定窗口ID



Gui, Add, Tab, gclitab vtabN x6 y7 w240 h103 , 图片|鼠标|像素|字库

Gui, Tab, 图片

Gui, Add, Text, x166 y37 w50 h20 , % " .bmp"
Gui, Add, Text, x16 y37 w80 h20 , F5`/F6 图片名`:

Gui, Add, Text, x16 y65 w130 h20 , F7 / F4 ----- 它坐标:

Gui, Add, Text, x16 y89 w40 h18 , ⊙注：
Gui, Add, Text, x56 y89 w180 h18 , F1移动 / F2点击 / F3点击它处

Gui, Add, Edit, vOposOfPic ReadOnly x146 y62 w70 h20 , 0,0	;它坐标
Gui, Add, Edit, vthePicNx ReadOnly x96 y35 w70 h20 , PicN

Gui, Tab, 鼠标
Gui, Add, Text, x16 y89 w40 h16 , ⊙注：
Gui, Add, Text, x56 y89 w150 h16 , F1移动 / F2点击 / F3拖行
Gui, Add, Text, x36 y72 w110 h16 , F7 鼠标当前坐标：

Gui, Add, Text, x16 y37 w90 h16 , F5 --- 坐标1:

Gui, Add, Text, vMpos1 x101 y37 w100 h15 , 0`,0	;鼠标坐标1

Gui, Add, Text, x16 y55 w90 h16 , F6 --- 坐标2:

Gui, Add, Text, vMpos2 x101 y55 w100 h15 , 0`,0	;鼠标坐标2


Gui, Add, Edit, vthemouseposnow ReadOnly x146 y69 w90 h17 , 0`,0	;鼠标当前坐标

Gui, Tab, 像素
Gui, Add, Text, x16 y35 w115 h16 , F4 / alt 1-0 色值:
Gui, Add, Text, x16 y53 w80 h16 , F5 色值浮动:
Gui, Add, Text, vcolorWave x96 y53 w50 h15 , 默认
Gui, Add, Text, x156 y53 w50 h16 , F6 模糊:
Gui, Add, Text, vxsmhz x206 y53 w30 h16 , 默认
Gui, Add, Edit, vpiexFindiT ReadOnly x136 y33 w100 h18 , 000000
Gui, Add, Text, x16 y89 w40 h16 , ⊙注：
Gui, Add, Text, x56 y89 w150 h16 , F1移动 / F2点击 / F3它处
Gui, Add, Text, x16 y71 w130 h16 , F7 -------- 它坐标:
Gui, Add, Edit, vOposxs ReadOnly x146 y69 w90 h16 , 0`,0

Gui, Tab, 字库
Gui, Add, Text, x16 y37 w80 h16 , F5 字库文件:
Gui, Add, Edit, vzikuming ReadOnly x96 y33 w130 h20 , RConly.txt

Gui, Add, Text, x16 y60 w100 h16 , F6/F7 色值范围:
Gui, Add, Edit, vszfwf ReadOnly x115 y58 w110 h20 , 000000-000000
Gui, Add, Text, x16 y83 w50 h20 , F4模糊:
Gui, Add, Text, vzkmhcs x66 y83 w40 h20 , 默认
Gui, Add, Text, x116 y89 w110 h16 , ⊙注：F1 ORC测试


ProExit("大漠综合工具.exe")
Gui, +AlwaysOnTop
Gui, Show, x685 y319 h160 w653, AutoHotkey大漠测试工具
Return

/* 此处为大漠窗口控件编号注释
大漠控件编号备注：
Edit44	<<<<色彩描述
Edit45	<<<<窗口句柄
Edit47	<<<<选择范围，坐标，包括宽高

色值坐标编号备注：
Edit46	<<<< 位1
Edit48	<<<< 位2
Edit49	<<<< 位3
Edit50	<<<< 位4
Edit51	<<<< 位5
Edit52	<<<< 位6
Edit53	<<<< 位7
Edit54	<<<< 位8
Edit55	<<<< 位9
Edit56	<<<< 位10
*/

GuiClose:
ExitApp

!n::
InputBox, colorss, 输入图片色值系数, % "当前为：" RGBm
if colorss
	RGBm := % colorss
return

!m::
InputBox, colorxxx, 输入图片模糊系数, % "当前为：" MH
if colorxxx
	MH := % colorxxx
return

F1::
gosub, 获取控件参数
guiCGt(tabN)
if tabN = % "图片"
{
	x := ComVar(), y := ComVar()
	;要紧在【坐标范围】 【图片名】
	gomove := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gomove := % gomove + 1
	if gomove
		dm.MoveTo(x[], y[])
	else
		msgbox, Picture not Found！`nPicname : %picName%
}

else if tabN = % "鼠标"
	dm.MoveTo(xx1, yy1)

else if tabN = % "像素"
{
	x := ComVar(), y := ComVar()
	;要紧在【坐标范围】 【色值】
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if cl
		dm.MoveTo(x[], y[])
	else
		msgbox, Color not Found！The Color `: %ColorX%
}
else if tabN = % "字库"
{
	;要紧在 【字典名称】 【坐标范围】 【色值范围】
	dm.SetDict( 1, dirName)
	dm.UseDict(1)
	
	DmStrSerch := dm.Ocr(x1, y1, x2, y2, colorfilednn, 0.9)
	if DmStrSerch
		MsgBox, % "ORC搜索得到字符串：" DmStrSerch
	else
		msgbox, ORC未识别到文字
}
return

F2::
gosub, 获取控件参数
return

f3::
gosub, 获取控件参数
return

获取控件参数:

return

clitab:

return

生成函数:

return


^0::
FileReadLine, L1, % A_WORKINGDIR "\DMpath.txt", 1
Run, % L1
winwait, ahk_exe 大漠综合工具.exe
WinMove, ahk_exe 大漠综合工具.exe, , -1003, 511
WinSetTitle, ahk_exe 大漠综合工具.exe, , % DMW
WinSet, ALWAYSONTOP, ON, % DMW
return

^2::	;大漠中获取窗口句柄按钮
{
WinActivate, % DMW
CoordMode, mouse, screen
MouseGetPos, Xmo, Ymo
WinWaitActive, % DMW
CoordMode, mouse, window
MouseMove, 724, 188, 0
sleep 200
send, {lbutton down}
CoordMode, mouse, screen
Sleep 300
MouseMove, % Xmo, % Ymo
CoordMode, mouse, window
}
return

^3::	;点击绑定窗口
{
ControlClick, x615 y185, % DMW
sleep 200
theTextID := CtrlGTex("Edit45", DMW)
IF (theTextID) {
	guiChan(theTextID, WinID)
	dm.BindWindow(theTextID, "gdi2", "normal", "normal", 0)
}
}
return

~$F4::
guiCGt(tabN)
if tabN = % "图片"
{
	inputbox, ddc, 输入点击它坐标, 格式为“111,111”。
	if ddc
		GuiControl, , OposOfPic, % ddc
}
if tabN = % "像素"
{
	inputbox, findPiex, 输入查找像素, 格式为“000000”。 6 位
	if findPiex
		GuiControl, , piexFindiT, % findPiex
}
if tabN = % "字库"
{
	inputbox, zkmh, 输入模糊参数, 格式为“0`.1 - 1”
	if zkmh
		GuiControl, , zkmhcs, % zkmh	
}
return


$f5::
guiCGt(tabN)
if tabN = % "图片"
{
	picNNN := % CtrlGTex("Edit1", "另存为")
	guiChan(picNNN, thePicNx)	;左为文本
}
else if tabN = % "鼠标"
{
	x := ComVar(), y := ComVar()
	dm.GetCursorPos(x.ref, y.ref)
	GuiControl, , Mpos1, % x[] "`," y[]
}
else if tabN = % "像素"
{
	inputbox, sezhifudong, 输入色值浮动值, 格式为“010101”
	if sezhifudong
		GuiControl, , colorWave, % sezhifudong
}
else if tabN = % "字库"
{
	FileSelectFile, ziKU, 3, , 选择字库文件, dmORC (*.txt)
	if (ziKU) {
		lenghtofziku := StrLen(ziKU)
		StringGetPos, posofXG, ziKU, `\, R
		StringTrimLeft, zikuFN, ziKU, % posofXG + 1
		GuiControl, , zikuming, % zikuFN
	}
}
return

$F6::
guiCGt(tabN)
if tabN = % "图片"
{
	inputbox, picNamenb, 输入图片名, 不带后缀
	if picNamenb
		guiChan(picNamenb, thePicNx)
}
else if tabN = % "鼠标"
{
	x := ComVar(), y := ComVar()
	dm.GetCursorPos(x.ref, y.ref)
	GuiControl, , Mpos2, % x[] "`," y[]
}
else if tabN = % "像素"
{
	inputbox, xsmh, 输入模糊参数, 格式为“0`.1 - 1”
	if xsmh
		GuiControl, , xsmhz, % xsmh
}
else if tabN = % "字库"
{
	SZFW := CtrlGTex("Edit44", DMW)
	if SZFW
		GuiControl, , szfwf, % SZFW
	
}
return

$F7::
guiCGt(tabN)
if tabN = % "图片"
{
	x := ComVar(), y := ComVar()
	dm.GetCursorPos(x.ref, y.ref)
	GuiControl, , OposOfPic, % x[] "`," y[]
}
else if tabN = % "鼠标"
{
	x := ComVar(), y := ComVar()
	dm.GetCursorPos(x.ref, y.ref)
	GuiControl, , themouseposnow, % x[] "`," y[]
}
else if tabN = % "像素"
{
	x := ComVar(), y := ComVar()
	dm.GetCursorPos(x.ref, y.ref)	
	GuiControl, , Oposxs, % x[] "`," y[]
}
else if tabN = % "字库"
{
	inputbox, zkszfwbbb, 输入色值范围, 格式为“000000-000000”
	if zkszfwbbb
		GuiControl, , szfwf, % zkszfwbbb
}
return

$F8::
theTextID := CtrlGTex("Edit45", DMW)
guiChan(theTextID, WinID)
return

$F9::
theGoPTex := CtrlGTex("Edit47", DMW)
StringGetPos, posOfit, theGoPTex, 宽
StringLeft, GoOver, theGoPTex, % posOfit - 1
GuiControl, , findPos, % GoOver
return



^Tab::
if numotabxl = 4
	numotabxl := 1

else if numotabxl < 4
	numotabxl := % numotabxl + 1

if !numotabxl 
	numotabxl := 2

	GuiControl, Choose, tabN, % numotabxl
return


;-----函数区域----------------------------------------------------------------------------------------------------------------------------------------
guiCGt(ByRef Gvar) {	;将GUI控件保存至唯一参数，即gui变量名
	GuiControlGet, Gvar, , Gvar
}

CtrlGTex(ctrlName, winTitle) {	;获取窗口控件文本内容并输出
	ControlGetText, theText, % ctrlName, % winTitle
	return %theText%
}

guiChan(newtex, ByRef gVar) { ;GUI改变函数
	GuiControl, , gVar, % newtex
}


delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}

ProExit(proName) { ;关闭所有同名进程  
	loop
	{
		Process, Close, % proName
		sleep 100
		if !errorlevel
			break
	}
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
	dmF.MoveTo(x1, y1)
	sleep 100
	dmF.LeftDown()
	sleep 100
	dmF.MoveTo(x2, y2)
	sleep 300
	dmF.LeftUp()
	Sleep, % slpt
}


DmPieCli(x1, y1, x2, y2, ColorX, ByRef dmF, slpt := 0,MH := 1) {	;搜色点击，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		Sleep, % slpt
		DmMsCli(x[], y[], dmF)
	}
}

DmPieClO(x1, y1, x2, y2, ColorX, xx, yy, ByRef dmF, slpt := 0,MH := 1) {	;搜色点击它处，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(xx, yy, dmF)
		Sleep, % slpt
	}
	else
		Sleep 5
}

DmPieR(x1, y1, x2, y2, ColorX, ByRef dmF,MH := 1) {	;搜色判断，模糊匹配默认为1,从左到右从上下
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x, y)
	return % cl
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
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
	gotEL := % gotEL + 1
	if gotEL 
		return 1
	else
		return 0
}

conCli(lx, ly, tit) { ;controlclick函数
	ControlClick, % "x" lx " y" ly, % tit, , L, 1
}