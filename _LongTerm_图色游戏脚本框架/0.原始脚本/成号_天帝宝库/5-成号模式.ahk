/*Date Modified:
2018年04月18日
*/

#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %a_scriptdir%
gosub, 启动第一界面
return

GuiClose:
ExitApp
;●初选界面●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
 ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
启动第一界面:
Gui, Add, Button, gRunTiandi x12 y30 w100 h30 , 天帝宝库
Gui, Add, Button, x12 y70 w100 h30 , 其他【待定】
Gui, Add, Button, x122 y30 w70 h70 , - 出金 -
Gui, Add, Text, x12 y10 w60 h20 , 成号数量：
Gui, Add, Text, vDaccN x72 y10 w40 h20 , 0
gosub, 查询可用成号数量
Gui, Show, x1500 y300 h110 w205, 幻剑-成号
Return	

查询可用成号数量:
if SSfx_Num(delFStr(a_workingdir, 8) "\3-成号", "acc")
	guicontrol, , DaccN, % SSfx_Num(delFStr(a_workingdir, 8) "\3-成号", "acc")
else
{
	msgbox,未检测到成号存在`n脚本将退出`!
	ExitApp	
}
return

 ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

;●启动天帝宝库，更新GUI●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

RunTiandi:
Gui, Destroy	;销毁初选界面
;------①不变文本行
Gui, Add, Text, x22 y60 w60 h20 , 选择材料：
Gui, Add, Text, x25 y92 w50 h20 , 窗口数：
Gui, Add, Text, x12 y10 w65 h20 , 成号数量：
Gui, Add, Text, x12 y30 w60 h20 , 今日完成：
Gui, Add, Text, x132 y10 w50 h20 , ↓状态↓
Gui, Add, Text, x22 y130 w90 h20 , 当前窗口编号：
Gui, Add, Text, x22 y150 w60 h20 , 当前账号：

;------②两个下拉选项
Gui, Add, DropDownList, vcaiLiao R7 x82 y58 w100 h20 , DropDownList	;材料模式选择
Gui, Add, DropDownList, vwinNum R15 x82 y90 w40 h20 , DropDownList	;窗口数量选择

;------③变动文本项目
Gui, Add, Text, vSCstatus x138 y30 w55 h20 , (待命) ;当前脚本状态
Gui, Add, Text, VDaccN x72 y10 w60 h20 , 0	;成号数量
Gui, Add, Text, vbedonenum x72 y30 w60 h20 , 0	;当前完成账号数量
Gui, Add, Text, vchanti x112 y130 w90 h20 , 0	;当前窗口编号
Gui, Add, Text, vchangeac x82 y150 w120 h20 , None	;当前窗口账号
;------④一个按钮
Gui, Add, Button, g启动o关闭天帝计划 x35 y175 w130 h30 , 启动/退出
;------⑤启动首先运行
gosub, 删除_创建工作
gosub, 关闭所有现有模拟器
gosub, 查询可用成号数量
gosub, 查询完成账号数量
gosub, 查询雷神模拟器路径并获取
gosub, 下拉菜单完全
;------x.最终显
Gui, Show, x1500 y300 h220 w200, 天帝宝库
return


删除_创建工作:
Cr_EmpFod(a_workingdir "\note")
Cr_EmpFod(a_workingdir "\CHjeon")
Cr_EmpFil(a_workingdir "\note\" A_YYYY A_MM A_DD ".note")
Del_F(a_workingdir "\CHjeon\*.id")
Del_F(a_workingdir "\CHjeon\*.job")
Del_F(a_workingdir "\CHjeon\*.time")
Del_F(a_workingdir "\CHjeon\loged.note")
return

关闭所有现有模拟器:

ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")
;ProExit(proName)---关闭所有同名进程
return

查询完成账号数量:
GuiControl, , bedonenum, % Fileline_Num(a_workingdir "\note\" A_YYYY A_MM A_DD ".note")
return

查询雷神模拟器路径并获取:
IfNotExist, % delFStr(a_workingdir, 8) "\PathOfLD_x.path"
{
	MsgBox, 4100, 未设置模拟器路径, 请确认您已安装雷神模拟器！`n是否选择雷神模拟器文件夹？, 5
	IfMsgBox, Yes
		{
		FileSelectFolder, LDpath_x, *%A_workingdir%
		FileAppend, %LDpath_x%, % delFStr(a_workingdir, 8) "\PathOfLD_x.path"
		}
	IfMsgBox, No
		{
		MsgBox, 未设置模拟器路径`n脚本将被关闭
		ExitApp
		return
		}
}
FileReadLine, PathLD, % delFStr(a_workingdir, 8) "\PathOfLD_x.path", 1
return


下拉菜单完全:

GuiControl, , caiLiao , |怒风猎手||小檀|后羿|牛魔|嫦娥|长生剑仙
loop 13
{
	if A_Index = 1
	{
		GuiControl, , winNum , |1
	}
	else if a_index = 8
	{
		GuiControl, , winNum , % a_index "||"
	}
	else
	{
		GuiControl, , winNum , % a_index "|"
	}
}
;添加上次关闭前最后选项
IfExist, % a_workingdir "\TDdrop.cho"
{
	FileReadLine, CLend, % a_workingdir "\TDdrop.cho", 1
	GuiControl, , caiLiao , % CLend "||"
	FileReadLine, WNend, % a_workingdir "\TDdrop.cho", 2
	GuiControl, , winNum , % WNend "||"
}
return


保存下拉菜单选项:	;脚本启动时运行
IfNotExist, % a_workingdir "\TDdrop.cho"
{
	GuiControlGet, CL, , caiLiao
	GuiControlGet, WN, , winNum
	FileAppend, % CL "`n" WN, % a_workingdir "\TDdrop.cho", UTF-8
}
else
{
	GuiControlGet, CL, , caiLiao
	GuiControlGet, WN, , winNum
	FileDelete, % a_workingdir "\TDdrop.cho"
	sleep 500
	FileAppend, % CL "`n" WN, % a_workingdir "\TDdrop.cho", UTF-8
}
return

 

;●函数集合●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
;---1.关闭所有同名进程
ProExit(proName)
{
	loop
	{
		Process, Close, % proName
		sleep 100
		if !errorlevel
		{
			break
		}
	}
}
;---2.图片点击函数
cliI(thePathi, cx1, cy1, cx2, cy2)
{
	ImageSearch, xx, yy, %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	if errorlevel = 0
	{
		MouseClick, L, %xx%, %yy%, 1, 0
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliI图片不存在
	}
}
;文件夹下所有同后缀文件数量
SSfx_Num(fdName, sfx)
{
	IfExist, % fdName "\*." sfx 
	{
		Loop, % fdName "\*." sfx
		{
			dda := A_Index 
		}
		return % dda
	}
	else
	{
		return 0
	}
}
;输出文本行数
Fileline_Num(filLP)
{
	IfExist, % filLP
	{
		Loop, read, % filLP
		{
			dda := A_Index 
		}
If !dda
Return 0
		return % dda
	}
Else
Return 0
}
;空白文件夹创建
Cr_EmpFod(fodLP)
{
IfNotExist, % fodLP
{
FileCreateDir, % fodLP
Loop
{
IfExist, % fodLP
Break
Else
Sleep 10
}
}
}
;空白文本创建
Cr_EmpFil(filLP)
{
	IfNotExist, % filLP
	{
		FileAppend, , % filLP
		Loop
		{
			IfExist % filLP
				break
			sleep 20
		}
	}
}
;删除文件并确认删除情况
Del_F(filLP)
{
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}
}
;创建文件前删除该文件确认后写入首行文本，确认首行文本后完成
Cr_AfterDel(filLP, tex)
{
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
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
;输出某行内容
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
;激活并等待激活窗口
winacwait(title)
{
	WinActivate, % title
	WinWaitActive, % title
}
;文本删减函数，默认自右起
delFStr(inputvar,countx := 0, rol := "R")
{
	rightx := "R"
	leftx := "L"
	if rol = % rightx
	{
		StringTrimRight, ca, inputvar, % Countx
		return % ca
	}
	else if rol = % leftx
	{
		StringTrimLeft, ca, inputvar, % Countx
		return % ca
	}
}

;●天帝脚本启动●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
启动o关闭天帝计划:
qoe := !qoe
if qoe
{
	GuiControl, , SCstatus, (启动)
	gosub, MainTiandi
}
else
{
	SetTimer, 计时工作, off
	Gui, Destroy	;销毁天帝宝库界面
	gosub, 启动第一界面
}
return
 

MainTiandi:
gosub, 保存下拉菜单选项
gosub, 启动多开器
run, TDwinactivate.ahk
run, TDhelp.ahk
runwait, TDmain.ahk
run, TDtaxtfar.ahk
SetTimer, 计时工作, 20
return

启动多开器:
;~~~以下为启动多开器
run, % PathLD "\dnmultiplayer.exe"
;探测左下角，无勾则点击到有勾，有勾则点击到无勾到有勾
Loop
{
	IfWinExist, ahk_class LDMultiPlayerMainFrame
	{
		SLEEP 1000
		break
	}
}
;~~~以下为定位窗口
GuiControlGet, loopN, , winNum
;窗口定位完毕关闭多开器
return
 
计时工作:
loop % loopN
{
	;查询日期
	TrayTip, , 查询日期, 10
	IfNotExist, % a_workingdir "\note\" a_yyyy A_MM A_DD ".note"
	{
		runwait, TDreload.ahk
	}
	;1.查询完成数量，即今日.note文件行数
	TrayTip, , 查询完成数量, 10
	GuiControl, , bedonenum, % Fileline_Num(a_workingdir "\note\" A_YYYY A_MM A_DD ".note")	
	;2.激活工作窗口
	TrayTip, , 激活工作窗口, 10
	workTitle := getL( A_WorkingDir "\CHjeon\" a_index ".id", 1)
	winacwait(workTitle)
	;3.创建当前激活窗口工作文件,NowGO.id，用以main等其他辅助脚本辨识
	TrayTip, , 创建NowGo文件, 10
	Cr_AfterDel(a_workingdir "\CHjeon\NowGo.id", workTitle)
	;4.查询job文件下账号，存在，改变GUI当前账号
	TrayTip, , 识别当前窗口账号, 10
	jobFile := % a_workingdir "\CHjeon\" workTitle ".job"
	if getL(jobFile, 1)
		GuiControl, , changeac, % getL(jobFile, 1)	;改变gui工作窗·口对应账号
	;5.改变工作窗口GUI
	GuiControl, , chanti, % workTitle	;改变gui工作窗口编号
	run, TDmain.ahk
	WinWait, TDStatus
	Loop
	{
		IfWinNotExist, TDStatus
			break
	}
}
return