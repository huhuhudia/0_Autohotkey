#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %A_SCRIPTDIR%


;===========================================================================
;---------------------------------------------------------GUI部分
;===========================================================================
;--------------------------------------------------1.不变文本
Gui, Add, Text, x16 y7 w120 h20 , 幻剑脚本列表：
Gui, Add, Text, x16 y207 w80 h20 , 模拟器路径：
Gui, Add, Text, x156 y17 w60 h20 , 脚本状态：
Gui, Add, Text, x16 y237 w130 h15 , 注1: 双击列表脚本启动
Gui, Add, Text, x166 y237 w130 h15 , 注2: Alt+Esc关闭脚本
Gui, Add, Text, x16 y257 w140 h20 , 注3: 确保ahk版本为32位
Gui, Add, Text, x166 y122 w60 h20 , 账号总数：
Gui, Add, Text, x166 y102 w50 h20 , 变身号：
Gui, Add, Text, x166 y42 w50 h20 , 主线号：
Gui, Add, Text, x166 y62 w50 h20 , 日常号：
Gui, Add, Text, x166 y82 w50 h20 , 成品号：
Gui, Add, Text, x156 y152 w140 h20 , 当前脚本最后修改日期：
;--------------------------------------------------2.改变文本
Gui, Add, Text, vstatusx x216 y17 w40 h20 , 待命			;脚本状态
Gui, Add, Edit, ReadOnly vShowPath_LD x96 y207 w180 h20 , None		;模拟器路径

Gui, Add, Text, vNum_theAllAcc x226 y122 w40 h20 , 0	;账号总数


Gui, Add, Text, vNum_acc1 x216 y42 w40 h20 , 0	;主线号数
Gui, Add, Text, vNum_acc2 x216 y62 w40 h20 , 0	;日常号数
Gui, Add, Text, vNum_acc3 x216 y82 w40 h20 , 0	;成品号数
Gui, Add, Text, vNum_acc5 x216 y102 w40 h20 , 0	;变身号数

Gui, Add, Text, vMD x166 y172 w90 h20 , Date Modified	;脚本最后修改日期.取第二位

;--------------------------------------------------3.其他控件
Gui, Add, ListBox, Choose1 gmylist vmylist x16 y27 w120 h180 , None	;列表
Gui, Add, Button, gAddPath_LD x276 y207 w20 h20 , +	;路径改变按钮
Gui, Add, Button, g注册大漠 x166 y257 w130 h20 , 注册大漠插件	;注册大漠插件按钮
Gui, +AlwaysOnTop
Gui, Show, x1580 y666 h292 w315, 幻剑脚本主控端
gosub, 完善listbox列表
gosub 检测账号文件夹是否存在
gosub, 账号数量查询
gosub, 模拟器路径文件检查
Return

;===========================================================================
;---------------------------------------------------------按钮及快捷键设定设定
;===========================================================================
!esc::
run, exitAHK.exe
return

:*:/date::
Clipboard := 
today := % A_YYYY "年" A_MM "月" A_DD "日"
Clipboard := % today
ClipWait
send, ^v
return

GuiClose:
ExitApp
RAlt::
if winexist("ahk_class #32770")
	WinWaitActive, ahk_class #32770
else
	run, % a_workingdir "\0.大漠\大漠综合工具.exe"
return

rwin::
RUN, C:\Program Files\AutoHotkey\AU3_Spy.exe
IfWinNotActive, Active Window Info
	WinActivate, Active Window Info
return
检测账号文件夹是否存在:
IfExist, % A_WORKINGDIR "\8-变身\*.acc"
{
	loop,  % A_WORKINGDIR "\8-变身\*.acc"
	{
		IfExist, % a_workingdir "\3-成号\" a_loopfilename
			FileDelete, % a_workingdir "\3-成号\" a_loopfilename
	}
}
IfNotExist 1-主线
	FileCreateDir, 1-主线
IfNotExist 2-日常
	FileCreateDir, 2-日常
IfNotExist 3-成号
	FileCreateDir, 3-成号
IfNotExist 8-变身
	FileCreateDir, 8-变身
FileRemoveDir, % a_workingdir "\9-飞升", 1

return

注册大漠:
SetWorkingDir, % A_scriptdir "\0.大漠"
run, % a_workingdir "\注册大漠插件到系统.bat"
SetWorkingDir %A_SCRIPTDIR%
return

AddPath_LD:   ;选择模拟器路径+按钮
IfNotExist %A_workingdir%\PathOfLD_x.path
{
	FileSelectFolder, LDpath_x, *%A_workingdir%
	Cr_AfterDel(LDpath_x, A_WorkingDir "\PathOfLD_x.path")
	GuiControl,, ShowPath_LD, %LDpath_x%
}
IfExist %A_workingdir%\PathOfLD_x.path
{
	MsgBox, 4356, 覆盖路径警告, 已存在雷电模拟器文件夹路径`n是否覆盖？, 10
	IfMsgBox, Yes
	{
		FileSelectFolder, LDpath_x, *%A_workingdir%
		Cr_AfterDel(LDpath_x, A_WorkingDir "\PathOfLD_x.path")
		GuiControl,, ShowPath_LD, %LDpath_x%
	}
	IfMsgBox, No
		return
}
return

mylist:	;gui列表事件
if A_GuiEvent = Normal
{
	GuiControlGet, mylist, , mylist
	datechange("1_注册脚本", a_workingdir "\新注册脚本\ZCx.ahk", mylist, MD)
	
	datechange("2_主线脚本", a_workingdir "\新主线脚本\GoZXmain.ahk", mylist, MD)
	

	datechange("3_日常脚本新版", a_workingdir "\新日常脚本\GoRCmain.ahk", mylist, MD)	
	
	datechange("4_天帝宝库", a_workingdir "\成号_天帝宝库\5-成号模式.ahk", mylist, MD)
	
	datechange("5_仓库收菜", a_workingdir "\x.出金_仓库收菜\收菜辅助.ahk", mylist, MD)
	datechange("6_仓库收菜多开版", a_workingdir "\x.出金_仓库收菜多开版\多开仓库主脚本.ahk", mylist, MD)
	

	datechange("7_摆摊新版", a_workingdir "\x.出金_摆摊准新版\新摆摊主脚本.ahk", mylist, MD)
	datechange("8_飞升盟主", a_workingdir "\z.飞升盟主\盟主脚本.ahk", mylist, MD)	
	

	
	
	datechange("9_自动登录与切号", a_workingdir "\登录与切号脚本\登录切号脚本.ahk", mylist, MD)	
	

}
if A_GuiEvent = DoubleClick
{
	GuiControlGet, mylist, , mylist
	scriptR("1_注册脚本", a_workingdir "\新注册脚本\ZCx.ahk", mylist, statusx)
	
	scriptR("2_主线脚本", a_workingdir "\新主线脚本\GoZXmain.ahk", mylist, statusx)
	

	scriptR("3_日常脚本新版", a_workingdir "\新日常脚本\GoRCmain.ahk", mylist, statusx)	
	
	scriptR("4_天帝宝库", a_workingdir "\成号_天帝宝库\5-成号模式.ahk", mylist, statusx)
	
	
	scriptR("5_仓库收菜", a_workingdir "\x.出金_仓库收菜\收菜辅助.ahk", mylist, statusx)
	scriptR("6_仓库收菜多开版", a_workingdir "\x.出金_仓库收菜多开版\多开仓库主脚本.ahk", mylist, statusx)	
	

	scriptR("7_摆摊新版", a_workingdir "\x.出金_摆摊准新版\新摆摊主脚本.ahk", mylist, statusx)

	scriptR("8_飞升盟主", a_workingdir "\z.飞升盟主\盟主脚本.ahk", mylist, statusx)
	

	
	scriptR("9_自动登录与切号", a_workingdir "\登录与切号脚本\登录切号脚本.ahk", mylist, statusx)

}

return

;通过list名称改变文本控件函数
datechange(chos, DIR, ByRef mylist, ByRef mdd)
{
	dc := % chos
	if mylist = % dc
	{
		dateofModified := getL(DIR, 2)
		GuiControl, , mdd, % dateofModified
	}		
}

;通过list名称运行脚本
scriptR(chos, DIR, ByRef mylist, ByRef mdd)
{
	dc := % chos
	if mylist = % dc
	{
		run, % DIR
		GuiControl, , mdd, 启动
	}
}

;===========================================================================
;---------------------------------------------------------启动首先运行
;===========================================================================
完善listbox列表:
GuiControl, , mylist, |
listADD("1_注册脚本", a_workingdir "\新注册脚本\ZCx.ahk", mylist)

listADD("2_主线脚本", a_workingdir "\新主线脚本\GoZXmain.ahk", mylist)


listADD("3_日常脚本新版", a_workingdir "\新日常脚本\GoRCmain.ahk", mylist)

listADD("4_天帝宝库", a_workingdir "\成号_天帝宝库\5-成号模式.ahk", mylist)

listADD("5_仓库收菜", a_workingdir "\x.出金_仓库收菜\收菜辅助.ahk", mylist)
listADD("6_仓库收菜多开版", a_workingdir "\x.出金_仓库收菜多开版\多开仓库主脚本.ahk", mylist)


listADD("7_摆摊新版", a_workingdir "\x.出金_摆摊准新版\新摆摊主脚本.ahk", mylist)


listADD("8_飞升盟主", a_workingdir "\z.飞升盟主\盟主脚本.ahk", mylist)



listADD("9_自动登录与切号", a_workingdir "\登录与切号脚本\登录切号脚本.ahk", mylist)	

return

listADD(tex, DIR, byref listx)	;一次性添加列表项函数
{
	IfExist, % DIR
	{
		GuiControl, , listx, % tex
	}
}

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

账号数量查询:
IfExist, % A_WORKINGDIR "\1-主线\*.acc"	
{
	loop, % A_WORKINGDIR "\1-主线\*.acc"
	{
		GuiControl, , Num_acc1, % A_Index	
	}
}
IfExist, % A_WORKINGDIR "\2-日常\*.acc"	
{
	loop, % A_WORKINGDIR "\2-日常\*.acc"
	{
		GuiControl, , Num_acc2, % A_Index	
	}
}
IfExist, % A_WORKINGDIR "\3-成号\*.acc"	
{
	loop, % A_WORKINGDIR "\3-成号\*.acc"
	{
		GuiControl, , Num_acc3, % A_Index	
	}
}
IfExist, % A_WORKINGDIR "\8-变身\*.acc"	
{
	loop, % A_WORKINGDIR "\8-变身\*.acc"
	{
		GuiControl, , Num_acc5, % A_Index	
	}
}
GuiControlGet, Num_acc1, , Num_acc1
GuiControlGet, Num_acc2, , Num_acc2
GuiControlGet, Num_acc3, , Num_acc3
GuiControl, , Num_theAllAcc, % Num_acc1 + Num_acc2 + Num_acc3
return

;===========================================================================
;---------------------------------------------------------函数
;===========================================================================
;创建文件前删除文件并写入首行文本
Cr_AfterDel(tex, filLP)
{
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
		{
			break
		}
	}	
	FileAppend, % tex, % filLP ,UTF-8
	Loop
	{
		IfNotExist, % filLP	
			Sleep 10
		Else 
		break
	}
	Loop
	{	
		FileReadLine, caa, % filLP, 1
		if caa = % tex
			break
	}
}
;获取某行字符串
getL(filLP, linenum := 1)
{
	IfExist, % filLP
	{
		Filereadline, caa, % filLP, % linenum
		if caa
			return % caa
		else
			return 0
	}
	else
		return 0
}