#SingleInstance FORCE
#Include %a_scriptdir%\winInfo_窗口信息获取函数集.ahk

gui, add, listbox, w200 	H300 	vlb 	glb 	HScroll500

GUI, add, edit, w200 vwinid			ReadOnly
GUI, add, edit, w200 vtitleit		ReadOnly
GUI, add, edit, w200 vclassit 		ReadOnly
GUI, add, edit, w200 vexeit 		ReadOnly
GUI, add, edit, w200 vpidit 		ReadOnly
GUI, add, edit, w200 vwinlongpath 	ReadOnly
GUI, add, edit, w200 vwinpos 		ReadOnly
GUI, add, edit, w200 vfwei 			ReadOnly

GUI, add, text, , 注1:双击激活窗口并显示范围
GUI, add, text, , 注2:Esc取消范围显示

gui,add, button, w200 grenewlb	, F5 刷新
gui,add, button, w200 gopenpath	, 打开对应窗口路径文件夹

gui, +toolwindow +AlwaysOnTop +Border
alphawin = thealphawindowgui

listid := allwIDls() 
for i in listid
{
	if (i == 1) {
		GuiControl, , lb, % "|" listid[i]  " <-> " wgTitle(listid[i])
	}
	else {
		GuiControl, , lb, % listid[i] " <-> " wgTitle(listid[i])
	}
}
gui, show
return

lb:
	;单击控件皆产生事件
	GuiControlGet, lb, , lb
	RegExMatch(lb, "(*UCP)^(\w+\s\w+)", it)
	GuiControl, , winid, % it
	GuiControl, , titleit, % wgTitle(it)
	GuiControl, , classit, % wgClass(it)
	GuiControl, , exeit, % wgEXE(it)
	GuiControl, , pidit, % wgPID(it)
	GuiControl, , winlongpath, % wgLP(it)
	
	WinGetPos, xx, yy, ww, hh, % it
	GuiControl, , winpos, % "x := " xx " ,y := " yy 
	GuiControl, , fwei, % "w := " ww " ,h := " hh
	if (A_GuiControlEvent == "DoubleClick") {
	;双击事件
		GuiControlGet, winid, , winid
		;exwinit,上次激活显示的窗口
		if (!exwinit) {
			;还未创建过GUI
			exwinit := winid
			gosub, 创建显示GUI
			return
		}
		else {
			if (exwinit != winid) {
				;当前选择与之前选择窗口不一致
				gui, %alphawin%: destroy
				gosub, 创建显示GUI
				exwinit := winid
				return
			}
			else {
				;当前选择与之前选择窗口一致
				if winexist(alphawin)
					gui, %alphawin%: destroy
				else
					gosub, 创建显示GUI
			}
		}
	}
	return
	
创建显示GUI:
	if not winexist(winid) {
		MsgBox, , 窗口不存在, 即将刷新窗口列表, 1
		gosub, renewlb
		return
	}
	sleep 100
	WinActivate, % winid

	wingetpos, xx, yy, ww, hh, % winid
	gui, %alphawin% : new
	gui, %alphawin% : +AlwaysOnTop -SysMenu -Caption +Border +HwndPiccatch
	gui, %alphawin% : show, x%xx% y%yy% w%ww% h%hh%, % alphawin
	Gui, %alphawin% : Color , FF0000
	winwait, ahk_id %Piccatch%
	WinSet, ExStyle, +0x20, ahk_id %Piccatch%
	WinSet, Transparent, 100, ahk_id %Piccatch%
	return
	

openpath:
	GuiControlGet, winlongpath, , winlongpath
	lpath := strFulltDir(winlongpath)
	run, % lpath 
	return
	
f5::
renewlb:
	;刷新窗口列表
	listid := allwIDls() 
	for i in listid
	{
		if (i == 1) {
			GuiControl, , lb, % "|" listid[i]  " <-> " wgTitle(listid[i])
		}
		else {
			GuiControl, , lb, % listid[i] " <-> " wgTitle(listid[i])
		}
	}
	return

strFulltDir(STRIN) {
	FL := []
	Loop, Parse, % STRIN, `\
		FL.Insert(A_LoopField)
	FL.Remove(FL.MaxIndex())
	for I in FL
	{
		if A_Index = 1
			Dir := % FL[A_Index]
		else
			Dir := % Dir "\" FL[A_Index]
	}
	return % Dir
}

#if winexist(alphawin)

ESC::
	gui, %alphawin%: destroy
	return