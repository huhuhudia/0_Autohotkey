
#NoEnv
#SingleInstance FORCE

if not fileexist(A_SCRIPTDIR "\Script_Button_List")
	FileCreateDir, % A_SCRIPTDIR "\Script_Button_List"

return

!r::Reload
!e::Edit
!Esc::
Send,!{f4}
return


!WheelUp::
WinMaximize, A
return

!WheelDown::
WinRestore, A
return

!RButton::
WinMinimize, A
return


^rButton::
	;ctrl + 右键弹出控制界面
	CoordMode, mouse, screen
	MouseGetPos, xx, yy

	soh := !soh
	if soh {
		gosub, 创建按钮控件
		gui, show, x%xx% y%yy%
	}		
	else
		gui, Destroy
return



创建按钮控件:

Array_File :=
Array_File := []
loop, % A_SCRIPTDIR "\Script_Button_List\*.*", 0, 0
{
	StringTrimRight, func%A_Index%, A_LoopFileName, 4
	sss := func%A_Index%
	Array_File[sss] := A_LoopFileLongPath
}
nowlable :=
loop {
	
	if (func%a_INDEX%) {
		nowlable := % func%a_INDEX%
		;gui,add, BUTTON, % "g" nowlable, % nowlable
		gui,add, BUTTON, g按钮, % nowlable
	}
 
	else
		break
}
Gui, -SysMenu -Caption +AlwaysOnTop
return

按钮:
	soh := 
	gui, hide
	Run, % Array_File[A_GuiControl] 
return

