#NoEnv
#NoTrayIcon
#SingleInstance Force
SetBatchLines -1
DetectHiddenWindows On

CreateGUI()
CreateMenu()
RefreshList()
return

GuiClose:
GuiEscape:
ExitApp

CreateGUI() {
	global
	Gui, Font, s10, 微软雅黑
	Gui, Add, ListView, xm w700 r10 Grid HwndHLV gLvEvent AltSubmit, 文件名|文件路径|PID
	Loop, Parse, % "退出|重启|暂停|暂停热键|结束进程", |
		Gui, Add, Button, % (A_Index=1 ? "" : "x+40") . " Disabled gExecMenu", %A_LoopField%
	Gui, Add, Button, x+100 gReloadAll, 重启全部
	Gui, Add, Button, x+55 gRefreshList vBtnRefresh, 刷新列表
	Gui, Show,, AHK 进程管理 v1.05
}

CreateMenu() {
	Loop, Parse, % "退出|重启|暂停|暂停热键||结束进程", |
		Menu, lvMenu, Add, % A_LoopField, MenuHandler
}

RefreshList() {
	static selfPID := DllCall("GetCurrentProcessId")

	LV_Delete()

	WinGet, id, List, ahk_class AutoHotkey
	Loop, %id% {
		this_id := id%A_Index%
		WinGet, this_pid, PID, ahk_id %this_id%

		if (this_pid != selfPID)
		{
			WinGetTitle, this_title, ahk_id %this_id%
			fPath := RegExReplace(this_title, " - AutoHotkey v[\d.]+$")
			SplitPath, fPath, fName
			
			LV_Add("", fName, fPath, this_pid)
		}
	}

	LV_ModifyCol()
	LV_ModifyCol(1, "Sort")
	GuiControl,, BtnRefresh, 刷新列表
}

GuiContextMenu(GuiHwnd, CtrlHwnd) {
	global HLV
	if (CtrlHwnd = HLV) && LV_GetNext() {
		Menu, lvMenu, Show
	}
}

MenuHandler(ItemName) {
	static cmd := {重启: 65303, 暂停热键: 65305, 暂停: 65306, 退出: 65307}
	static WM_COMMAND := 0x111

	if (ItemName = "结束进程") {
		for i, obj in GetSelectedInfo()
			Process, Close, % obj.pid
	} else {
		for i, obj in GetSelectedInfo()
			PostMessage, WM_COMMAND, % cmd[ItemName],,, % obj.path " ahk_pid " obj.pid
	}

	if (ItemName = "重启") {
		GuiControl,, BtnRefresh, 刷新中...
		SetTimer, RefreshList, -3000
	} else if (ItemName ~= "退出|结束")
		SetTimer, RefreshList, -300
}

GetSelectedInfo() {
	RowNum := 0, arr := []
	while, RowNum := LV_GetNext(RowNum) {
		LV_GetText(path, RowNum, 2)
		LV_GetText(pid, RowNum, 3)
		arr.push( {pid: pid, path: path} )
	}
	return arr
}

LvEvent() {
	if !(A_GuiEvent == "I")
		return

	GuiControlGet, isEnabled, Enabled, 退出
	nSelected := LV_GetCount("Selected")
	if !(isEnabled && nSelected) || !(!isEnabled && !nSelected)
	{
		Loop, Parse, % "退出|重启|暂停|暂停热键|结束进程", |
			GuiControl, % "Enabled" !!nSelected, %A_LoopField%
	}
}

ExecMenu() {
	MenuHandler(A_GuiControl)
}

ReloadAll() {
	Loop, % LV_GetCount()
	{
		LV_GetText(path, A_Index, 2)
		LV_GetText(pid, A_Index, 3)
		PostMessage, 0x111, 65303,,, % path " ahk_pid " pid
	}
}