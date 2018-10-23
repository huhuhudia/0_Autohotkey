#NoEnv
#Persistent
#SingleInstance force
;●●●●●●GUI创建●●●●●●=========================================================
;------●●主要按钮●●----------------------------------------------
Gui, Add, Button, gRunZC_Y x12 y10 w90 h30 , 注册(F5)
Gui, Add, Button, gRunZX_Y x12 y45 w90 h30 , 主线模式(F6)
Gui, Add, Button, gRunRC_Y x12 y80 w90 h30 , 日常模式(F7)
Gui, Add, Button, gRunCL_Y x12 y115 w90 h30 , 材料模式(F8)
Gui, Add, Button, gExitAllScript_N x42 y220 w170 h30 , 强制关闭所有(INSERT)

Gui, Add, Text, x22 y160 w110 h20 , 模拟器文件夹路径：
Gui, Add, Button, gAddPath_LD x22 y180 w30 h20 , +
Gui, Add, Edit, vShowPath_LD x52 y180 w190 h20 , 按“+”选取模拟器文件夹

;------●●信息显示●●----------------------------------------------
Gui, Add, Text, x122 y20 w70 h30 , 当前状态：
Gui, Add, Text, vNow_Script_Status x182 y20 w70 h30 , 待命

Gui, Add, Text, x122 y50 w60 h20 , 主线号数：
Gui, Add, Text, vNum_ZXZH x182 y50 w60 h20 , 0

Gui, Add, Text, x122 y70 w60 h20 , 日常号数：
Gui, Add, Text, vNum_RCZH x182 y70 w60 h20 , 0

Gui, Add, Text, x122 y90 w60 h20 , 成品号数：
Gui, Add, Text, vNum_CHZH x182 y90 w60 h20 , 0

Gui, Add, Text, x122 y120 w40 h20 , 总数：
Gui, Add, Text, vNum_theAllAcc x162 y120 w60 h20 , 0

;------●●显示GUI●●----------------------------------------------
Gui, Show,  x1550 y680 h269 w255, 幻剑脚本主控端

gosub 模拟器路径文件检查
gosub 账号数量查询
gosub 检测账号文件夹是否存在
settimer, 号数与脚本状态查询, 15000
Return

;●●●●●●脚本启动首先运行●●●●●●============================================================
;1.模拟器文件夹路径的记录文件查询,控制edit的ShowPath_LD控件
;2.edit修改
;3.三种账号数量查询，总数为三种账号相加
;4.添加检测状态标签（号数+脚本状态）
;5.账号文件夹查询
!esc::
run, % a_workingdir "\exitAHK.exe"
return


检测账号文件夹是否存在:
IfNotExist 1-主线
	{
	FileCreateDir, 1-主线
	}
IfNotExist 2-日常
	{
	FileCreateDir, 2-日常
	}
IfNotExist 3-成号
	{
	FileCreateDir, 3-成号
	}
return

号数与脚本状态查询:
IfWinExist, 幻剑-账号创建
	{
	GuiControl,, Now_Script_Status, 注册
	}
IfWinNotExist, 幻剑-账号创建
	{
	status_none := 1
	}
IfWinExist, 幻剑-主线模式
	{
	GuiControl,, Now_Script_Status, 主线
	}
IfWinNotExist, 幻剑-主线模式
	{
	status_none := % status_none + 1
	}
IfWinExist, 幻剑-成号模式
	{
	GuiControl,, Now_Script_Status, 材料
	}
IfWinNotExist, 幻剑-成号模式
	{
	status_none := % status_none + 1
	}
if status_none = 3
	{
	GuiControl,, Now_Script_Status, 待命
	}

IfExist %A_workingdir%\1-主线\*.acc
	{
	LOOP %A_workingdir%\1-主线\*.acc
		{
		GuiControl,, Num_ZXZH, %A_index%
		}
	}
IfExist %A_workingdir%\2-日常\*.acc
	{
	LOOP %A_workingdir%\2-日常\*.acc
		{
		GuiControl,, Num_RCZH, %A_index%
		}
	}
IfExist %A_workingdir%\3-成号\*.acc
	{
	LOOP %A_workingdir%\3-成号\*.acc
		{
		GuiControl,, Num_CHZH, %A_index%
		}
	}
GuiControlGet, Num_acc1, , Num_ZXZH
GuiControlGet, Num_acc2, , Num_RCZH
GuiControlGet, Num_acc3, , Num_CHZH
GuiControl,, Num_theAllAcc, % Num_acc1 + Num_acc2 + Num_acc3
return

账号数量查询:
IfExist %A_workingdir%\1-主线\*.acc
	{
	LOOP %A_workingdir%\1-主线\*.acc
		{
		GuiControl,, Num_ZXZH, %A_index%
		}
	}
IfExist %A_workingdir%\2-日常\*.acc
	{
	LOOP %A_workingdir%\2-日常\*.acc
		{
		GuiControl,, Num_RCZH, %A_index%
		}
	}
IfExist %A_workingdir%\3-成号\*.acc
	{
	LOOP %A_workingdir%\3-成号\*.acc
		{
		GuiControl,, Num_CHZH, %A_index%
		}
	}
Gui, Submit, NoHide
GuiControlGet, Num_acc1, , Num_ZXZH
GuiControlGet, Num_acc2, , Num_RCZH
GuiControlGet, Num_acc3, , Num_CHZH
GuiControl,, Num_theAllAcc, % Num_acc1 + Num_acc2 + Num_acc3
return


模拟器路径文件检查:
IfNotExist %A_workingdir%\PathOfLD_x.path
{
	MsgBox, 4100, 未设置模拟器路径, 请确认您已安装雷神模拟器！`n是否选择雷神模拟器文件夹？, 5
	IfMsgBox, Yes
		{
		FileSelectFolder, LDpath_x, *%A_workingdir%
		FileAppend, %LDpath_x%, PathOfLD_x.path 
		GuiControl,, ShowPath_LD, %LDpath_x%
		}
	IfMsgBox, No
		{
		return
		}
}
IfExist %A_workingdir%\PathOfLD_x.path
{
	FileReadLine, LDpath_x, PathOfLD_x.path, 1
	GuiControl,, ShowPath_LD, %LDpath_x%
}
return
;----------------------------------------------------

;●●●●●●按钮快捷键●●●●●●============================================================
f5::
gosub RunZC_Y
return

f6::
gosub RunZX_Y
return

f7::
gosub RunRC_Y
return

f8::
gosub RunCL_Y
return

insert::
gosub ExitAllScript_N
return

;●●●●●●按钮功能●●●●●●============================================================
;------●●添加雷电模拟器路径，创建路径查询文件，控制edit的ShowPath_LD●●----------------------------------------------
AddPath_LD:   
IfNotExist %A_workingdir%\PathOfLD_x.path
	{
	FileSelectFolder, LDpath_x, *%A_workingdir%
	FileAppend, %LDpath_x%, PathOfLD_x.path 
	GuiControl,, ShowPath_LD, %LDpath_x%
	}
IfExist %A_workingdir%\PathOfLD_x.path
	{
	MsgBox, 4356, 覆盖路径警告, 已存在雷电模拟器文件夹路径`n是否覆盖？, 10
	IfMsgBox, Yes
		{
		FileSelectFolder, LDpath_x, *%A_workingdir%
		FileDelete, PathOfLD_x.path
		FileAppend, %LDpath_x%, PathOfLD_x.path 
		GuiControl,, ShowPath_LD, %LDpath_x%
		}
	IfMsgBox, No
		{
		return
		}
	}
return

;------●●强行关闭所有脚本●●----------------------------------------------
ExitAllScript_N:
WinClose, 幻剑-账号创建
WinClose, 幻剑-主线模式
WinClose, 幻剑-日常模式
WinClose, 幻剑-材料模式
GuiControl,, Now_Script_Status, 待命
return


;------●●启动注册模式●●----------------------------------------------
RunZC_Y:
gosub 检查路径
Detection_SConflict("2-账号创建.ahk", "注册", "幻剑-主线模式", "主线脚本", "幻剑-成号模式", "材料模式", "幻剑-日常模式", "日常模式", "幻剑-账号创建")
return

;------●●启动主线模式●●----------------------------------------------
RunZX_Y:
gosub 检查路径
Detection_SConflict("3-主线模式.ahk", "主线", "幻剑-账号创建", "注册脚本", "幻剑-成号模式", "材料模式", "幻剑-日常模式", "日常模式", "幻剑-主线模式")
return

;------●●启动日常模式●●----------------------------------------------
RunRC_Y:  
gosub 检查路径
Detection_SConflict("4-日常模式.ahk", "日常", "幻剑-账号创建", "注册脚本", "幻剑-成号模式", "材料模式", "幻剑-主线模式", "主线脚本", "幻剑-日常模式")
return

;------●●启动材料模式●●----------------------------------------------
RunCL_Y:  
gosub 检查路径
Detection_SConflict("5-成号模式.ahk", "材料", "幻剑-账号创建", "注册脚本", "幻剑-日常模式", "日常模式", "幻剑-主线模式", "主线脚本", "幻剑-成号模式")
return

;------●●检测脚本冲突函数●●----------------------------------------------
Detection_SConflict(Will_runS, run_status_edit, test_S1, test_S1msg, test_S2, test_S2msg, test_S3, test_S3msg , test_main2)
{
IfWinExist %test_main2%
	{
	TrayTip, , 【%run_status_edit%】脚本当前正在运行！`n请勿重复启动。, 5, 3
	return
	}
IfNotExist %Will_runS%
	{
	msgbox, , 错误, 该脚本不存在,请联系作者!
	return
	}

IfWinExist %test_S1%
	{
	msgbox, 4100, 警告, 【%test_S1msg%】正在运行`n是否关闭并开启%Will_runS%, 5
	IfMsgBox, Yes
		{
		WinClose %test_S1%
		run, %Will_runS%
		GuiControl,, Now_Script_Status, %run_status_edit%
		return
		}
	IfMsgBox, No
		{
		Return
		}
	}
IfWinExist %test_S2%
	{
	msgbox, 4100, 警告, 【%test_S2msg%】正在运行`n是否关闭并开启%Will_runS%, 5
	IfMsgBox, Yes
		{
		WinClose %test_S2%
		run, %Will_runS%
		GuiControl,, Now_Script_Status, %run_status_edit%
		return
		}
	IfMsgBox, No
		{
		Return
		}
	}
IfWinExist %test_S3%
	{
	msgbox, 4100, 警告, 【%test_S3msg%】正在运行`n是否关闭并开启%Will_runS%, 5
	IfMsgBox, Yes
		{
		WinClose %test_S3%
		run, %Will_runS%
		GuiControl,, Now_Script_Status, %run_status_edit%
		return
		}
	IfMsgBox, No
		{
		Return
		}
	}
If !WinExist(test_S1) and !WinExist(test_S2)
	{
	run %Will_runS%
	GuiControl,, Now_Script_Status, %run_status_edit%
	}
}

GuiClose:
ExitApp
;----------------------------------------------------
检查路径:
IfNotExist %A_workingdir%\PathOfLD_x.path
{
gosub AddPath_LD
}
return
