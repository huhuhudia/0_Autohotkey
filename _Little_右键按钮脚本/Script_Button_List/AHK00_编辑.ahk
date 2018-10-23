#NoEnv
#SingleInstance force
gosub, 创建控件
gosub, 完善文件列表

FileReadLine, editpath, % a_SCRIPTDIR "\Else\编辑器路径.txt", 1

yh = "
return


edit_now:	;双击功能
if A_GuiEvent = Normal
	dd :=
if A_GuiEvent = DoubleClick
{
	GuiControlGet, listb, , listb
	pathneed := % Ay_Path[listb]
	Run, % editpath " " yh pathneed yh
}
return 


创建控件:
CoordMode, mouse, screen
MouseGetPos, xx, yy

Gui, +AlwaysOnTop -SysMenu
Gui, Add, ListBox, vlistb gedit_now w150 h280 , ListBox
gui, show, x%xx% y%yy%,脚本列表/右键退出
return

完善文件列表:
GuiControl, , listb, |
Ay_Path := []
Loop, % a_SCRIPTDIR "\*.ahk", 0, 1
{
	StringTrimRight, CC, A_LoopFileName, 4
	Ay_Path[CC] := A_LoopFileLongPath
	GuiControl, , listb, %CC%
}
return

^~RButton::
RButton::
gui,Destroy
Sleep 500
ExitApp
