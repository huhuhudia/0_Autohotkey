#Include %a_scriptdir%\winInfo_窗口信息获取函数集.ahk
gui, add, listbox, w150 H300 vlb glb
GUI, add, edit, w150 vwinid ReadOnly
GUI, add, edit, w150 vtitleit ReadOnly
GUI, add, edit, w150 vclassit ReadOnly
GUI, add, edit, w150 vexeit ReadOnly
GUI, add, edit, w150 vpidit ReadOnly



listid := allwIDls() 
for i in listid
{
	if (i == 1) {
		GuiControl, , lb, % "|" listid[i]
	}
	else {
		GuiControl, , lb, % listid[i]
	}
}
gui, show
return

lb:
GuiControlGet, lb, , lb
GuiControl, , winid, % lb
GuiControl, , titleit, % wgTitle(lb)
GuiControl, , classit, % wgClass(lb)
GuiControl, , exeit, % wgEXE(lb)
GuiControl, , pidit, % wgPID(lb)


return

