/*Date Modified:
2018年04月20日
*/

#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %A_ScriptDir%

Gui, Add, Text, x6 y7 w140 h20 , 》》》请选择账号《《《
Gui, Add, Text, x16 y317 w120 h20 , 设置仓库模拟器序号

Gui, Add, ListBox, vstoreaclist x6 y27 w140 h290 , None
Gui, Add, DropDownList, R10 vCTNOWN x16 y337 w120 h20 , None
Gui, Add, Button, gfreshTheAcList x26 y367 w100 h30 , 刷新账号
Gui, Add, Button, g启动收菜辅助 x26 y407 w100 h30 , 启动/暂停
gosub, 关闭所有现行模拟器及多开器
gosub, 查询雷神模拟器路径并获取
gosub, 查询仓库账号并完善区号列表
gosub, 完善下拉菜单	;启动时创建文件
gosub, 图片变量定义
Gui, Show, x1605 y143 h455 w154, 幻剑收菜辅助
return

GuiClose:
ExitApp

关闭所有现行模拟器及多开器:
{
ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")
}
return

freshTheAcList:
IfNotExist, % a_workingdir "\accStore\*.acc"
{
	msgbox, accStore文件夹下无仓库号存在`n脚本将无法启动
	GuiControl, , storeaclist, % "|仓库账号不存在||"
	return
}
else
{
	Loop, % a_workingdir "\accStore\*.acc"
	{
		if a_index = 1
			GuiControl, , storeaclist, % "|" A_LoopFileName "||"
		else
			GuiControl, , storeaclist, % A_LoopFileName
	}
}
return

查询雷神模拟器路径并获取:
IfNotExist % delFStr(a_workingdir, 10) "\PathOfLD_x.path"
{
	MsgBox, 4100, 未设置模拟器路径, 请确认您已安装雷神模拟器！`n是否选择雷神模拟器文件夹？
	IfMsgBox, Yes
	{
		FileSelectFolder, LDpath_x, *%A_workingdir%
		FileAppend, %LDpath_x%, % delFStr(a_workingdir, 10) "\PathOfLD_x.path"
	}
	IfMsgBox, No
	{
		MsgBox, 未设置模拟器路径`n脚本将无法启动
		return
	}
}
return

查询仓库账号并完善区号列表:
IfNotExist, % a_workingdir "\accStore"
	Cr_EmpFod(a_workingdir "\accStore")
IfNotExist, % a_workingdir "\accStore\*.acc"
{
	msgbox, accStore文件夹下无仓库号存在`n脚本将无法启动
	GuiControl, , storeaclist, % "|仓库账号不存在||"
	return
}
else
{
	Loop, % a_workingdir "\accStore\*.acc"
	{
		if a_index = 1
			GuiControl, , storeaclist, % "|" A_LoopFileName "||"
		else
			GuiControl, , storeaclist, % A_LoopFileName
	}
}
return

完善下拉菜单:
IfNotExist, % a_workingdir "\droped.cho"
{
	loop 10
	{
		if a_index = 1
			GuiControl, , CTNOWN, % "|" A_Index "||"
		else
			GuiControl, , CTNOWN, % A_Index
	}
}
else
{
	loop 10
	{
		if a_index = 1
		{
			if A_Index = % getL(a_workingdir "\droped.cho", 1)
				GuiControl, , CTNOWN, % "|" A_Index "||"
			else
				GuiControl, , CTNOWN, % "|" A_Index
		}
		else
		{
			if A_Index = % getL(a_workingdir "\droped.cho", 1)
				GuiControl, , CTNOWN, % A_Index "||"
			else
				GuiControl, , CTNOWN, % A_Index
		}
	}
}
return

启动收菜辅助:
roe := !roe
if roe
{
	IfWinNotExist, ahk_class LDPlayerMainFrame
	{
		Cr_EmpFil(a_workingdir "\go.go")
		TrayTip, 收菜辅助启动, 将自动登录所选账号`n请勿操作鼠标键盘`n窗口将强制置顶`n强制关闭请按Alt+Esc, 10
		GuiControlGet, CTNOWN, , CTNOWN
		IfNotExist, % a_workingdir "\droped.cho"
			Ad_ToLL(a_workingdir "\droped.cho", CTNOWN)	;若文件不存在，直接写入
		else
			Cr_AfterDel(CTNOWN, a_workingdir "\droped.cho")	;若存在，删除后写入
		run, SChelp.ahk
		run, SCWinActive.ahk
		gosub, 登录账号
	}
	else
	{
		Cr_EmpFil(a_workingdir "\go.go")
		TrayTip, 脚本重启, 若尚未登录账号`n请按Alt+Esc关闭所有窗口并重启
		run, % a_workingdir "\SChelp.ahk"
		run, % a_workingdir "\SCWinActive.ahk"
	}

}
else
{
	Del_F(a_workingdir "\go.go")
	TrayTip, 收菜辅助暂停, 所有功能将停止运行, 10
}
return

登录账号:
ldpath := getL(delFStr(a_workingdir, 10) "\PathOfLD_x.path")	;
IfNotExist, % ldpath "\dnmultiplayer.exe"
{
	msgbox, 雷电模拟器路径错误`n请从【主控端】设置雷电模拟器路径
	return
}
run, % ldpath "\dnmultiplayer.exe"	;开启多开器
WinWait, ahk_class LDMultiPlayerMainFrame	;等待多开器出现
Sleep 500
GuiControlGet, CTNOWN, , CTNOWN	;获取仓库模拟器位置
muliR(CTNOWN)	;启动该序号位置模拟器
winwait, ahk_class LDPlayerMainFrame
WinSetTitle, ahk_class LDPlayerMainFrame, , AccStore
;1.点击幻剑图标
Loop
{
	if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包
		break
	if picR(mn033tbcw, 443, 62, 524, 142)	;图标未刷新
	{
		if !tbwsx
			tbwsx := 1
		else
			tbwsx := % tbwsx + 1
	}
	else
		tbwsx := 
	if a_index = 60
	{
		msgbox, 模拟器错误`n请按Alt+Esc关闭脚本并尝试重启脚本
		return
	}
	if picR(DL01tb, 462, 78, 478, 100)	;搜图到幻剑图标
	{
		tbwsx := 
		sleep 500
		cliI(DL01tb, 462, 78, 478, 100)
	}
	if picR(DL02dl, 500, 352, 521, 375)	;搜索到红钮
	{
		sleep 300
		break
	}	
		sleep 500
}
;2.输入账号密码
Loop
{
	if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包
		break
	if ungotac
		break
	Clipboard :=
	Loop
	{
		if A_Index = 15
		{
			msgbox, 模拟器错误`n请按Alt+Esc关闭脚本并尝试重启脚本
			return
		}
		MouseClick, l, 533, 239, 1, 0
		sleep 300
		send, {BS 20}
		Sleep 300
		MouseClick, l, 533, 281, 1, 0
		sleep 300
		send, {BS 20}
		sleep 1000
		zhx := picR(dl06zh, 388, 232, 404, 248)
		mix := picR(dl07ma, 367, 273, 383, 289)
		if (zhx and mix)
			break
	}
	;获取工作账号
	GuiControlGet, storeaclist, , storeaclist
	acn := % getL(A_WorkingDir "\accStore\" storeaclist, 1)
	pas := % getL(A_WorkingDir "\accStore\" storeaclist, 2)
	;1.鼠标移至账号处  2.设置剪切板  3.黏贴账号
	MouseMove, 533, 239, 0
	SLEEP 300
	;设置账号密码并输入
	MouseClick, L, 533, 239, 1, 0
	SLEEP 600
	Clipboard := % acn	;剪切板为账号
	ClipWait
	SEND, ^v	;黏贴账号
	sleep 100
	Clipboard :=
	MouseMove, 533, 281, 0
	sleep 200
	Clipboard := % pas	;剪切板为密码
	MouseClick, L, 533, 281, 1, 0
	SLEEP 600
	ClipWait
	SEND, ^v
	sleep 500
	break
}
;3.点击登录红钮
Loop
{
	if a_index = 30
		gosub, 登录账号
	cliI(DL02dl, 500, 352, 521, 375)	;点击登陆红钮
	sleep 600
	if picR(DL05dh, 515, 465, 555, 500)
		break
	if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包
		break
}
;4.点击登录黄钮
Loop
{
	Sleep 500
	if a_index = 100
	{
		cq := 1
		gosub 登录账号
		break
	}
	cliI(DL05dh, 515, 465, 555, 500)	;点击登陆黄钮
	Sleep 500
	if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包，删除NowGo文件，创建loged.note文件.time与.job文件，文件名为窗口名，1行为账号文件名，2行为1
		break
	if picR(mn029wlcw, 391, 245, 429, 266)	;网络错误时
	{
		ungotac := 1
		gosub, 登录账号
		break
	}
}
ungotac :=
cq :=
TrayTip, 登录成功,请按照快捷键指示进行材料收取工作, 10
return

图片变量定义:
DL01tb := % "*10 " A_workingdir "\picture\DL01tb.png"
DL02dl := % "*10 " A_workingdir "\picture\DL02dl.png"
DL03bb := % "*10 " A_workingdir "\picture\DL03bb.png"
DL05dh := % "*10 " A_workingdir "\picture\DL05dh.png"
dl06zh := % "*10 " a_workingdir "\picture\dl06zh.png"
dl07ma := % "*10 " a_workingdir "\picture\dl07ma.png"
mn033tbcw := % "*10 " a_workingdir "\picture\mn033tbcw.png"
mn029wlcw := % "*10 " a_workingdir "\picture\mn029wlcw.png"

TW001 := % "*10 " a_workingdir "\picture\TW001.png"
TW002 := % "*10 " a_workingdir "\picture\TW002.png"
TW003 := % "*10 " a_workingdir "\picture\TW003.png"
TW004 := % "*10 " a_workingdir "\picture\TW004.png"
TW005 := % "*10 " a_workingdir "\picture\TW005.png"
TW006 := % "*10 " a_workingdir "\picture\TW006.png"
TW008 := % "*10 " a_workingdir "\picture\TW008.png"

sc001js := % "*10 " a_workingdir "\picture\sc001js.png"
sc002tw := % "*10 " a_workingdir "\picture\sc002tw.png"
sc003dt := % "*10 " a_workingdir "\picture\sc003dt.png"
sc005dt1 := % "*10 " a_workingdir "\picture\sc005dt1.png"
sc006fh1 := % "*10 " a_workingdir "\picture\sc006fh1.png"
sc007twx := % "*10 " a_workingdir "\picture\sc007twx.png"
sc008zp := % "*10 " a_workingdir "\picture\sc008zp.png"
sc009yiy := % "*10 " a_workingdir "\picture\sc009yiy.png"
sc010gml := % "*10 " a_workingdir "\picture\sc010gml.png"
sc011zd := % "*10 " a_workingdir "\picture\sc011zd.png"
sc012yiy := % "*10 " a_workingdir "\picture\sc012yiy.png"
sc013gm := % "*10 " a_workingdir "\picture\sc013gm.png"
sc015hs := % "*10 " a_workingdir "\picture\sc015hs.png"
sc016dt1 := % "*10 " a_workingdir "\picture\sc016dt1.png"
sc017dt2 := % "*10 " a_workingdir "\picture\sc017dt2.png"
sc018dqdt := % "*10 " a_workingdir "\picture\sc018dqdt.png"
sc019sjdt := % "*10 " a_workingdir "\picture\sc019sjdt.png"
sc020sd := % "*10 " a_workingdir "\picture\sc020sd.png"
sc021dtx := % "*10 " a_workingdir "\picture\sc021dtx.png"

return


;1.删除字符串后几位字符函数
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
;2.空文件夹创建函数
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
;3.写入文本到尾行，确认尾行文本后结束
Ad_ToLL(filLP, tex)
{
	FileRead, ca, % filLP
	if ca
	{
		FileAppend, % "`n" tex, % filLP ,UTF-8
		Loop
		{
			loop, read, % filLP
			{
				lastline := % A_LoopReadLine
			}
			if lastline = % tex
				break
		}
	}
	else
	{
		FileAppend, % tex, % filLP ,UTF-8
		Loop
		{
			loop,read, % filLP
			{
				lastline := % A_LoopReadLine
			}
			if lastline = % tex
				break
		}
	}
}
;4.创建文件前删除该文件确认后写入首行文本，确认首行文本后完成
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
;5.获取某行字符串
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
;6.控制多开器启动/关闭窗口函数
muliR(timeofL, mode := 0)
{
	if timeofL = 1
		conCli(396, 113,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 2
		conCli(388, 163,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 3
		conCli(388, 213,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 4
		conCli(388, 265,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 5
		conCli(388, 315,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 6
		conCli(388, 365,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 7
		conCli(388, 415,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 8
		conCli(388, 467,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 9
		conCli(388, 515,"ahk_class LDMultiPlayerMainFrame")
	else if timeofL = 10
		conCli(388, 565,"ahk_class LDMultiPlayerMainFrame")
	else
		return 0
	if mode
	{
		WinWait, ahk_class MessageBoxWindow
		ControlClick, x281 y171, ahk_class MessageBoxWindow
	}
}
;7.controlclick函数
conCli(lx, ly, tit)
{
	ControlClick, % "x" lx " y" ly, % tit, , L, 1
}
;8.关闭所有同名进程
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
;9.搜图判断函数
picR(thePathi, cx1, cy1, cx2, cy2)
{
	ImageSearch, , , %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	{
		if !errorlevel
		{
			return 1
		}
		if errorlevel = 2
		{
			msgbox, 错误`n判断图片路径错误`n%thePathi%
		}
		if errorlevel = 1
		{
			return 0
		}
	}
}
;10.图片点击函数
cliI(thePathi, cx1, cy1, cx2, cy2, slpt := 0)
{
	ImageSearch, xx, yy, %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	if errorlevel = 0
	{
		MouseClick, L, %xx%, %yy%, 1, 0
		Sleep, % slpt
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliI图片不存在
	}
}
;11.空文件夹创建
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
;12.删除文件
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
;13.点击它处函数
cliO(ox1, oy1, thepatho, ox2, oy2, ox3, oy3, slpt := 0)
{
	ImageSearch, , , %ox2%, %oy2%, %ox3%, %oy3%, % thepatho
	if errorlevel = 0
	{
		MouseClick, L, %ox1%, %oy1%, 1, 0
		Sleep, % slpt
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliO图片不存在`n %thepatho%
	}
}

NumLock::
ToolTip
SetTimer, 重复搜索摊位, Off
Del_F(a_workingdir "\go.go")
return

暂停脚本检测:
Loop
{
	if getkeystate("Numlock", "P")
	{
		ToolTip
		Del_F(a_workingdir "\go.go")
		SetTimer, 重复搜索摊位, Off
		return
	}
	else
		break
}
return

飞到集市:
;循环点地图;搜到地图两字，break
;图16.17.18，19,20,21
ToolTip, 正在飞向集市, 0, 0
Loop
{
	gosub, 暂停脚本检测
	cliI(sc003dt, 928, 53, 948, 84, 1000)	;点击地图
	if picR(sc005dt1, 483, 68, 507, 93)	;搜到地图
		break
}
sleep 200
if (picR(sc016dt1, 366, 415, 413, 438) or picR(sc017dt2, 786, 322, 825, 346))	;搜到望舒仙子或葬龙峰
{
	Loop 2
	{
		MouseClick, L, 530, 171, 1, 0
		sleep 700
	}
	gosub, 关闭地图
	return
}
else	;两图皆无，即无望舒和葬龙峰两图
{
	Loop
	{

		cliI(sc018dqdt, 848, 187, 875, 212, 600)	;点击当前地图
		cliI(sc019sjdt, 847, 285, 875, 308, 600)	;点击世界地图
		cliI(sc020sd, 463, 322, 488, 343, 600)	;点击神都
		if (picR(sc016dt1, 366, 415, 413, 438) or picR(sc017dt2, 786, 322, 825, 346))	;出现葬龙峰或神都
		{
			Loop 2
			{
				MouseClick, L, 530, 171, 1, 0
				sleep 700
			}
			break
			gosub, 关闭地图
			return
		}
		;点击当前地图，点击世界地图，点击神都，出现望舒或葬龙为止
	}
}
;若有在神都，地图左右两处有一
;若两图都无, 点击大地图,飞至神都，休息8秒
;若有一点击集市2次，sleep 关闭地图。
return

关闭地图:
cliO(830, 87, sc021dtx, 480, 66, 509, 94, 800)	;搜到地图点叉
return

重复搜索摊位:
Loop
{
	ToolTip, 正在搜索摊位, 0, 0
	gosub, 暂停脚本检测
	if picR(sc001js, 397, 402, 413, 417)	;集市
	{
		cliI(sc001js, 397, 402, 413, 417)	;点击集市
		sleep 1500
	}
	else if picR(DL03bb, 926, 280, 939, 298) and !picR(sc001js, 397, 402, 413, 417)	;有背包无集市
	{
		gosub, 飞到集市
		return
	}
	else
		return
	if picR(TW001, 227, 201, 239, 222)	;一号摊位
	{
		Loop
		{
			cliI(TW001, 227, 201, 239, 222, 1000)	;点击1号摊位
			if picR(sc002tw, 323, 124, 371, 149)	;出现摊位标题
			{
				goti := 1
				break
			}
		}
		
	}
	else if picR(TW002, 437, 200, 450, 222)	;二号摊位
	{
		Loop
		{
			cliI(TW002, 437, 200, 450, 222, 1000)	;点击2号摊位
			if picR(sc002tw, 323, 124, 371, 149)	;出现摊位标题
			{
				goti := 1
				break
			}
		}
		
	}
	else if picR(TW003, 647, 200, 664, 223)	;三号摊位
	{
		Loop
		{
			cliI(TW003, 647, 200, 664, 223, 1000)	;点击3号摊位
			if picR(sc002tw, 323, 124, 371, 149)	;出现摊位标题
			{
				goti := 1
				break
			}
		}
		
	}
	else if picR(TW004, 225, 263, 240, 287)	;四号摊位
	{
		Loop
		{
			cliI(TW004, 225, 263, 240, 287, 1000)	;点击4号摊位
			if picR(sc002tw, 323, 124, 371, 149)	;出现摊位标题
			{
				goti := 1
				break
			}
		}
		
	}
	else if	picR(TW005, 436, 262, 452, 287)	;五号摊位
	{
		Loop
		{
			cliI(TW005, 436, 262, 452, 287, 1000)	;点击5号摊位
			if picR(sc002tw, 323, 124, 371, 149)	;出现摊位标题
			{
				goti := 1
				break
			}
		}
		
	}		
	else if picR(TW006, 646, 263, 664, 287)	;六号摊位
	{
		Loop
		{
			cliI(TW006, 646, 263, 664, 287, 1000)	;点击6号摊位
			if picR(sc002tw, 323, 124, 371, 149)	;出现摊位标题
			{
				goti := 1
				break
			}
		}
		
	}	
	;七号摊位暂缺
	else if picR(TW008, 437, 327, 452, 351)	;八号摊位
	{
		Loop
		{
			cliI(TW008, 437, 327, 452, 351, 1000)	;点击8号摊位
			if picR(sc002tw, 323, 124, 371, 149)	;出现摊位标题
			{
				goti := 1
				break
			}
		}
		
	}
	else	;无摊位返回集市
	{
		Loop
		{
			cliI(sc006fh1, 805, 84, 832, 117, 800)	;返回摊位
			cliI(sc007twx, 805, 89, 830, 116, 800)	;关闭集市
			if picR(DL03bb, 926, 280, 939, 298)
			{
				goti := 1
				break
			}
		}
		return
	}
	if goti
	{
		goti :=
		break
	}
}
;以下为购买流程
Loop
{
	sleep 350
	;搜索是否1元宝，是点击蓝购买2次，间隔300sleep，
	Loop
	{
		if picR(sc008zp, 400, 126, 435, 147)	;图为我方设定招牌
		{
			if picR(sc009yiy, 420, 204, 458, 233)	;图为一元宝
				cliI(sc010gml, 517, 207, 547, 229, 300)	;点击购买
		}
		if picR(sc011zd, 588, 269, 617, 290)	;出现购买界面
			break
	}
	Loop
	{
		if picR(sc009yiy, 420, 204, 458, 233)	;图为一元宝
			cliI(sc010gml, 517, 207, 547, 229, 300)	;点击购买
		if picR(sc012yiy, 418, 303, 459, 330)	;单价为1
			cliI(sc011zd, 588, 269, 617, 290, 700)	;点击最大
		cliI(sc013gm, 447, 389, 478, 418, 700)	;点击绿色购买
		if picR(sc015hs, 742, 282, 775, 310)	;灰色购买
			break
	}
	Loop
	{
		cliI(sc006fh1, 805, 84, 832, 117, 800)	;返回摊位
		cliI(sc007twx, 805, 89, 830, 116, 800)	;关闭集市
		if picR(DL03bb, 926, 280, 939, 298)
			return
	}
}
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>辅助从此处开始
#IF roe
;1.自动飞行至摆摊区
;2.摊位搜索
!1::
CoordMode, tooltip, window
ToolTip, 正在自动查询摊位, 0, 0
Cr_EmpFil(a_workingdir "\go.go")
;1,loop，点击集市，休息1.5秒，有东西，点击后，休息1.8秒，无，关闭，return。
SetTimer, 重复搜索摊位, 50
return
;3.选择摊位
;4.自动识别购买物品
;5.无法识别则以物品位置坐标点击购买
