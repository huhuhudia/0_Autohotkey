#Include %A_ScriptDir%\WinPath.ahk
#Include %A_ScriptDir%\Clipboard_复制黏贴.ahk
#Include %A_ScriptDir%\一键多用函数.ahk
#NoEnv
#SingleInstance FORCE
	if !fileexist(A_SCRIPTDIR "\Script_Button_List")
		FileCreateDir, % A_SCRIPTDIR "\Script_Button_List"
return
:*:/inclu::
dd = #include `%A_ScriptDir`%\
clip_in(dd)
return
f6::
	winget, IDD, ID, A
	WinGetPos, , , WW, HH, ahk_id %IDD%
	WinMove, ahk_id %IDD%, , % (a_screenwidth - WW) / 2, % (A_ScreenHeight - HH) / 2
	
return

F12::
KCLable("F12", f1func_dict, ["窗口工具", "测试"])
return

窗口工具:
run, C:\Users\UOLO\Desktop\0_Autohotkey\lib\显示所有窗口信息.ahk
return
测试:

return

/* =========================================================================================
									GUI右键功能列表
============================================================================================
*/

^rButton:: ;ctrl + 右键 显示/隐藏按键界面
	;一、设定鼠标坐标全屏，作为界面显示窗口坐标
	CoordMode, mouse, screen	
	MouseGetPos, MPosX, MPosY
	;二、创建GUI
	if (soh := !soh) {
		Array_File := []
		;1.获取文件列表（不递归子文件夹），创建启动按钮字典
		loop, % A_SCRIPTDIR "\Script_Button_List\*.*", 0, 0
			Array_File[A_LoopFileName] := A_LoopFileLongPath
		
		;2.创建GUI按钮，按钮事件皆设定[A_Button]标签
		for fileName in Array_File
			gui,add, BUTTON, % "gButton_Event", % fileName
		
		;3.设定GUI始终置顶,显示GUI
			Gui, % "-SysMenu -Caption +AlwaysOnTop"
			gui, show, % "x" MPosX " y" MPosY
	}
	;三、销毁GUI
	else 
		gui, % "Destroy"
return

Button_Event:	;文件名按钮事件
	Run, % Array_File[A_GuiControl]		;1.运行子脚本，A_guicontrol内置变量为当前执行脚本承载的文本
	gui, % "Destroy"					;2.销毁窗口
	soh :=								;3.赋空soh,使下回快捷启动显示GUI
return

/* ===========================
        主脚本按键功能项
==============================
*/ #If (soh) ;-> 仅当GUI显示时 |

RButton::							;GUI界面存在时，右键也执行销毁界面功能
	gui, % "Destroy"
	soh := !soh
return


/* =========================================================================================
									其他按键功能项 0
============================================================================================
*/ #if ("MainKey")	;-> 默认始终执行  |

	Insert::Reload		;1.重启
	!Esc::Send,!{f4}	;2.发送alt+f4
	
/* =========================================================================================
									其他按键功能项 1
============================================================================================
*/ #if ("1")	;-> 默认始终执行  |

	;获取文件长路径
	;后缀为ahk时用默认编辑器运行
	;若非，直接输出NumpadEnter键
	
$NumpadEnter::
	;编辑器路径
	scite = C:\Program Files\AutoHotkey\SciTE\SciTE.exe
	yh = "	;代替引号字符串
	a_fileLP := Explorer_GetSelected() 
	if !a_fileLP
		Send, {NumpadEnter}
	else
		FoundPos := RegExMatch(a_fileLP, "^.+(\.ahk$)", char)
	if char
		Run, %scite% "%a_fileLP%" 
return

/* =========================================================================================
									其他按键功能项 2
============================================================================================
*/ #if ("2")	;-> 默认始终执行  |

^Right::winMoveX("right")	;增加当前窗口宽度
^Left::winMoveX("left")		;减小当前窗口宽度
^up::winMoveX("up")			;增加当前窗口高度
^down::winMoveX("down")		;减小当前窗口高度

;窗口移动函数
winMoveX(key, speed := 10, increment := 1.2) {
	;1.创建key列表，若参数错误报错	
	keylist := {"right" : 1, "left" : 1, "up" : 1, "down" : 1}
	if !(keylist[key]) {
		for i in keylist
			tex := % tex i "`n"
		MsgBox, % "key值设定错误，参考以下key值：`n" tex
		return
	}
	;2.获取当前窗口ID
	WinGet, AwinID, ID, A
	AwinID := % "ahk_ID " AwinID
	;3.居中窗口
	WinGetPos, , , WW, WH, % AwinID
	WinMove, %  AwinID, , % (A_ScreenWidth - WW) / 2, % (A_ScreenHeight - WH) / 2
	;4.设定按键规则
	loop {
		if a_index < 30	
			speed += (A_Index * increment)
		
		if not getkeystate(key, "P")
			break
		
		WW := % (key == "right") ? (WW += speed) : WW
		WW := % (key == "left")  ? (WW -= speed) : WW
		WH := % (key == "up")    ? (WH += speed) : WH
		WH := % (key == "down")  ? (WH -= speed) : WH
		WW := % (WW <= 0) ? 0 : WW
		WH := % (WH <= 0) ? 0 : WH
		WW := % (WW >= A_ScreenWidth) ? A_ScreenWidth : WW
		WH := % (WH >= A_ScreenHeight) ? A_ScreenHeight : WH
		WX := % (A_ScreenWidth - WW) / 2		;窗口屏幕位置x
		WY := % (A_ScreenHeight - WH) / 2		;窗口屏幕位置y
		
		WinMove, % AwinID, , % WX, % WY, % WW, % WH
	}
}