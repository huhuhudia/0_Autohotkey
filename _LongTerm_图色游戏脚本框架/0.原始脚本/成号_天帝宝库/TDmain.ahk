/*Date Modified:
2018年04月18日
*/

#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %a_scriptdir%
dm := ComObjCreate( "dm.dmsoft")
;开头首先启动
Gui, Add, Text, x6 y7 w70 h20 , 当前状态：
Gui, Add, Text, vstatusv x6 y27 w210 h50 , TDmain Go!
gosub, 图片路径变量读取
Gui, Show, x137 y825 h85 w228, TDStatus

IfNotExist, % a_workingdir "\CHjeon\NowGo.id"
{
	gosub, 初次登陆游戏	;创建num.id文件，每次登陆NowGO.id文件，登陆成功删除NowGo.id
}
sleep 200
gosub, TDmain
return

GuiClose:
ExitApp

不改变账号登陆游戏:
WJQS :=	;文件缺失
WLCW :=	;网路错误
if !bbzhdl
	bbzhdl := 1
else
	bbzhdl := % bbzhdl + 1
wokwin := % getL(a_workingdir "\CHjeon\NowGo.id", 1)	;获取工作窗口
StringTrimLeft, wokwin, wokwin, 2	;获取关闭编号，为整数
muliR(wokwin, 1)	;关闭该编号模拟器
sleep 3000
muliR(wokwin)
WinWait, ahk_class LDPlayerMainFrame, , , TD
WinSetTitle, ahk_class LDPlayerMainFrame, , % "TD" wokwin, TD	;设置工作窗口文件
GUITextC("【不改变账号重新登录】`n当前窗口编号：" wokwin "   次数:" bbzhdl "`n当前流程：点击幻剑图标")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if picR(DL01tb, 462, 78, 478, 100)
	{
		sleep 2000
		cliI(DL01tb, 462, 78, 478, 100)
		if a_index = 15
		{
			cwcqcg :=
			gosub, 不改变账号登陆游戏
			break
		}
	}
	if picR(DL02dl, 500, 352, 521, 375)
	{
		sleep 300
		break
	}
}
GUITextC("【不改变账号重新登录】`n当前窗口编号：" wokwin "   次数:" bbzhdl "`n当前流程：点击登陆红钮")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg
		break
	if a_index = 30
	{
		cwcqcg :=
		gosub, 不改变账号登陆游戏
	}
	cliI(DL02dl, 500, 352, 521, 375)	;点击登陆红钮
	sleep 600
	if picR(DL05dh, 515, 465, 555, 500)	;登录黄钮
		break
}
GUITextC("【不改变账号重新登录】`n当前窗口编号：" wokwin "   次数:" bbzhdl "`n当前流程：点击登陆黄钮")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg
		break
	Sleep 1000
	if a_index = 100
	{
		cwcqcg :=
		gosub 不改变账号登陆游戏
		break
	}
	cliI(DL05dh, 515, 465, 555, 500)	;点击登陆黄钮
	if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包，完成流程
		break
	if picR(mn029wlcw, 391, 245, 429, 266)	;网络错误时
	{
		cwcqcg :=
		gosub, 不改变账号登陆游戏
		break
	}
}
cwcqcg := 1
bbzhdl := 
return

关闭重启游戏:
WJQS :=
WLCW :=
wokwin := % getL(a_workingdir "\CHjeon\NowGo.id", 1)	;获取工作窗口
StringTrimLeft, wokwin, wokwin, 2	;获取关闭编号，为整数
muliR(wokwin, 1)	;关闭该编号模拟器
sleep 3000
muliR(wokwin)
WinWait, ahk_class LDPlayerMainFrame, , , TD
WinSetTitle, ahk_class LDPlayerMainFrame, , % "TD" wokwin, TD	;设置工作窗口文件
if !cqdl
	cqdl := 1
else
	cqdl := % cqdl + 1
;点击幻剑图标
;输入账号密码
;点击登陆红钮
;点击登陆黄钮，直到遇见背包，创建.job以及.time文件
;1.点击幻剑图标
GUITextC("【关闭重登】`n当前窗口编号：" wokwin "   次数:" cqdl "`n当前流程：点击幻剑图标")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"	
	if tbwsx = 16
	{
		tbwsx := 
		gosub, 关闭重启游戏
		break
	}
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
		gosub, 关闭重启游戏
		
		break
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
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"	
	if cwcqcg
		break
	Clipboard :=
	GUITextC("【关闭重登】`n当前窗口编号：" wokwin "   次数:" cqdl "`n当前流程：清空账号密码")
	Loop
	{
		IfWinExist, VirtualBox Headless Frontend
			run, % a_workingdir "\TDreload.ahk"	
		if cwcqcg
			break
		if A_Index = 15
		{
			gosub 关闭重启游戏
			
			break
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
	;1.鼠标移至账号处，2.获取账号密码，3.设置剪切板，4.黏贴账号
	MouseMove, 533, 239, 0
	SLEEP 300
		;获取未完成账号长路径
	didnt := 
	GUITextC("【关闭重登】`n当前窗口编号：" wokwin "   次数:" cqdl "`n当前流程：输入账号密码")
	LOOP, % delFStr(a_workingdir, 8) "\3-成号\*.acc"
	{
		if SRT_AllL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", A_LoopFileName)	;已完成账号搜索，
		{
			alldone := 1
			didnt := 1
		}
		else
			didnt := 
		if SRT_AllL(A_WorkingDir "\CHjeon\loged.note", A_LoopFileName)	;已完成账号搜索，
			didnt := 1
		if !didnt	;账号未工作，则设置当前工作账号
		{
			NWACC := % A_LoopFileLongPath	;获取工作账号长路径
			NAFNAME := % A_LoopFileName	;获取工作账号文件名
			didnt := 
			break
		}
	}
	if didnt	;写入everydone至日期.note以及窗口号.note
	{
		WWN := % getL(a_workingdir "\CHjeon\NowGo.id", 1)	;获取完成工作窗口
		if alldone
			Ad_ToLL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", "everydone")	;写入完成账号到日期.note文件尾行
		Ad_ToLL(a_workingdir "\CHjeon\" WWN ".time", "everydone")	;写入完成账号到日期.time文件尾行
		gosub, 关闭退出脚本及附属脚本
	}
	didnt := 
		;设置账号密码并输入

	MouseClick, L, 533, 239, 1, 0
	SLEEP 600
	Clipboard := % getL(NWACC, 1)	;获取工作账号首行账号
	ClipWait
	SEND, ^v	;黏贴账号
	sleep 100
	Clipboard :=
	MouseMove, 533, 281, 0
	sleep 200
	Clipboard := % getL(NWACC, 2)	;获取工作账号次行密码
	MouseClick, L, 533, 281, 1, 0
	SLEEP 600
	ClipWait
	SEND, ^v
	sleep 500
	break
}
GUITextC("【关闭重登】`n当前窗口编号：" wokwin "   次数:" cqdl "`n当前流程：点击登陆红钮")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg
		break
	if a_index = 30
		gosub, 关闭重启游戏
	cliI(DL02dl, 500, 352, 521, 375)	;点击登陆红钮
	sleep 600
	if picR(DL05dh, 515, 465, 555, 500)
		break
}
;4.点击登陆黄钮，直到遇见背包，创建.job以及.time文件
GUITextC("【关闭重登】`n当前窗口编号：" wokwin "   次数:" cqdl "`n当前流程：点击登陆黄钮")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg
		break
	Sleep 500
	if a_index = 100
	{
		cwcqcg :=
		gosub 关闭重启游戏
		break
	}
	cliI(DL05dh, 515, 465, 555, 500)	;点击登陆黄钮
	Sleep 500
	if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包，删除NowGo文件，创建loged.note文件.time与.job文件，文件名为窗口名，1行为账号文件名，2行为1
	{
		workwinnow := getL(A_WorkingDir "\CHjeon\NowGo.id", 1)
		Ad_ToLL(A_WorkingDir "\CHjeon\loged.note", NAFNAME)
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".job")
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".time")
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".job", "1")
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".time", "1")
		break
	}
	if picR(mn029wlcw, 391, 245, 429, 266)	;网络错误时
	{
		workwinnow := getL(A_WorkingDir "\CHjeon\NowGo.id", 1)
		Ad_ToLL(A_WorkingDir "\CHjeon\loged.note", NAFNAME)
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".job")
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".time")
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".job", "1")
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".time", "1")
		cwcqcg :=
		gosub, 不改变账号登陆游戏
		break
	}
}
cwcqcg := 1
return

初次登陆游戏:
winNum := getL(a_workingdir "\TDdrop.cho", 2)
LOOP % winNum
{
	Cr_AfterDel("TD" a_index, A_WorkingDir "\CHjeon\" A_Index ".id")
}

loop % winNum
{
	BLD := % A_Index
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	GUITextC("【初次登录】`n当前窗口编号：" BLD "`n当前流程：点击幻剑图标")
	muliR(A_Index)
	WinWait, ahk_class LDPlayerMainFrame, , , TD
	WinSetTitle, ahk_class LDPlayerMainFrame, , % "TD" a_index, TD	;设置工作窗口文件
	Cr_AfterDel("TD" a_index, A_WorkingDir "\CHjeon\NowGo.id")	;创建当前工作文件
	;1.点击幻剑图标
	Loop
	{
		IfWinExist, VirtualBox Headless Frontend
			run, % a_workingdir "\TDreload.ahk"
		if tbwsx = 16
		{
			tbwsx := 
			gosub, 关闭重启游戏
			ExitApp
		}
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
			gosub, 关闭重启游戏
			break
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
	tbwsx := 
	;2.输入账号密码
	Loop
	{
		IfWinExist, VirtualBox Headless Frontend
			run, % a_workingdir "\TDreload.ahk"
		if cwcqcg
			break
		Clipboard :=
		GUITextC("【初次登录】`n当前窗口编号：" BLD "`n当前流程：清空账号密码")
		Loop
		{
			if A_Index = 15
				gosub 关闭重启游戏
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
		;1.鼠标移至账号处，2.获取账号密码，3.设置剪切板，4.黏贴账号
		MouseMove, 533, 239, 0
		SLEEP 300
			;获取未完成账号长路径
		didnt := 
		LOOP, % delFStr(a_workingdir, 8) "\3-成号\*.acc"
		{
			aloopfn := A_LoopFileName
			if SRT_AllL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", aloopfn)	;已完成账号搜索
			{
				alldone := 1
				didnt := 1
			}
			else
				didnt := 
			if SRT_AllL(A_WorkingDir "\CHjeon\loged.note", aloopfn)	;已完成账号搜索，
				didnt := 1
			if !didnt	;账号未工作，则设置当前工作账号
			{
				NWACC := % A_LoopFileLongPath	;获取工作账号长路径
				NAFNAME := % A_LoopFileName	;获取工作账号文件名
				didnt := ""
				break
			}
		}
		if didnt = 1
		{
			WWN := % getL(a_workingdir "\CHjeon\NowGo.id", 1)	;获取完成工作窗口
			if alldone
				Ad_ToLL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", "everydone")	;写入完成账号到日期.note文件尾行
			Ad_ToLL(a_workingdir "\CHjeon\" WWN ".time", "everydone")	;写入完成账号到日期.time文件尾行
			gosub, 关闭退出脚本及附属脚本
		}
		didnt := 
			;设置账号密码并输入
		GUITextC("【初次登录】`n当前窗口编号：" BLD "`n当前流程：输入账号密码")
		MouseClick, L, 533, 239, 1, 0
		SLEEP 600
		Clipboard := % getL(NWACC, 1)	;获取工作账号首行账号
		ClipWait
		SEND, ^v	;黏贴账号
		sleep 100
		Clipboard :=
		MouseMove, 533, 281, 0
		sleep 200
		Clipboard := % getL(NWACC, 2)	;获取工作账号次行密码
		MouseClick, L, 533, 281, 1, 0
		SLEEP 600
		ClipWait
		SEND, ^v
		sleep 500
		break
	}
	;3.点击登陆红钮
	GUITextC("【初次登录】`n当前窗口编号：" BLD "`n点击登陆红钮")
	Loop
	{
		IfWinExist, VirtualBox Headless Frontend
			run, % a_workingdir "\TDreload.ahk"
		if cwcqcg
			break
		if thiswindone
			break
		if a_index = 30
			gosub, 关闭重启游戏
		
		cliI(DL02dl, 500, 352, 521, 375)	;点击登陆红钮
		sleep 600
		if picR(DL05dh, 515, 465, 555, 500)
			break
	}
	;4.点击登陆黄钮，直到遇见背包，创建.job以及.time文件
	GUITextC("【初次登录】`n当前窗口编号：" BLD "`n点击登陆黄钮")
	Loop
	{
		IfWinExist, VirtualBox Headless Frontend
			run, % a_workingdir "\TDreload.ahk"		
		if cwcqcg
			break

		Sleep 500
		if a_index = 100
			gosub 关闭重启游戏
		cliI(DL05dh, 515, 465, 555, 500)	;点击登陆黄钮
		Sleep 500
		if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包，删除NowGo文件，创建loged.note文件.time与.job文件，文件名为窗口名，1行为账号文件名，2行为1
		{
			workwinnow := getL(A_WorkingDir "\CHjeon\NowGo.id", 1)
			Ad_ToLL(A_WorkingDir "\CHjeon\loged.note", NAFNAME)
			Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".job")
			Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".time")
			Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".job", "1")
			Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".time", "1")
			Del_F(A_WorkingDir "\CHjeon\NowGo.id")	;删除nowGo文件,重启则不删除
			break
		}
		if picR(mn029wlcw, 391, 245, 429, 266)	;网络错误时
		{
			workwinnow := getL(A_WorkingDir "\CHjeon\NowGo.id", 1)
			Ad_ToLL(A_WorkingDir "\CHjeon\loged.note", NAFNAME)
			Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".job")
			Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".time")
			Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".job", "1")
			Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".time", "1")
			cwcqcg := 
			gosub, 不改变账号登陆游戏
			break
		}
	}
	cwcqcg :=
}
Del_F(a_workingdir "\CHjeon\NowGo.id")
ExitApp
return

关闭退出脚本及附属脚本:
nowT := 
LtimeL :=
LOTimeL := 
winacned := 
Del_F(a_workingdir "\CHjeon\NowGo.id")
ExitApp
return

;●主要脚本●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
TDmain:
WokingW := % getL(a_workingdir "\CHjeon\NowGo.id", 1)	;获取当前工作窗口名
everydone := "everydone"
LtimeL := getLastL(a_workingdir "\CHjeon\" WokingW ".time")
if LtimeL = % everydone
	gosub, 关闭退出脚本及附属脚本
LtimeL2 := getLastL(a_workingdir "\note\" A_YYYY A_MM A_DD ".note")
if LtimeL2 = % everydone
{
	winclose, 天帝宝库
	msgbox, 当日所有账号工作完成`n单机确定退出所有账号`n或晚间12点后脚本将全部重启
	return
}

if picR(DL01tb, 462, 78, 478, 100)	;检测到图标页面
	gosub, 关闭重启游戏
if picR(DL02dl, 500, 352, 521, 375)	;检测到登陆红钮
	gosub, 关闭重启游戏
IfNotExist, % a_workingdir "\CHjeon\" WokingW ".job"
	WJQS := 1
else
	WJQS :=
if picR(mn032cw, 425, 244, 466, 268)
	WLCW := 1
else
	WLCW :=
if (WJQS and !WLCW)	;文件缺失，并无网络错误
	gosub, 关闭重启游戏
else if (WJQS and WLCW)	;文件缺失，且网络错误
	gosub, 关闭重启游戏
else if (!WJQS and WLCW) ;只是网络错误
{
	gosub, 不改变账号登陆游戏
	cwcqcg := 
}
else
	sleep 0
everydone := "everydone"
LtimeL := getLastL(a_workingdir "\CHjeon\" WokingW ".time")
if picR(mn030bcdl, 434, 246, 471, 267)	;别处登陆
{
	logedadd := % getL(a_workingdir "\CHjeon\" WokingW ".time", 1)
	Ad_ToLL(A_WorkingDir "\CHjeon\loged.note", logedadd)
	Del_F(a_workingdir "\CHjeon\" WokingW ".job")	;删除.job文件
	Del_F(a_workingdir "\CHjeon\" WokingW ".time")	;删除.time文件
	gosub, 关闭重启游戏
}
if LtimeL = % everydone
{
	gosub, 关闭退出脚本及附属脚本
}
if LtimeL = 1	;若匹配尚未领取则领取
{
	gosub, 天帝初次领取	;领取后记录下次领取时间
	gosub, 关闭退出脚本及附属脚本
}
else
{
	nowT := % A_Now
	EnvSub, nowT, % LtimeL, Seconds
	if nowT >= 1	;当前工作窗口剩余下次天帝领取工作不足1秒，进行领取天帝宝库任务
	{
		gosub, 天帝初次领取
	}
	Loop % a_workingdir "\CHjeon\*.time"
	{
		a_longpath := % A_LoopFileLongPath
		StringTrimRight, winacned, A_LoopFileName, 5	;获取当前判断窗口名
		LOTimeL := getLastL(a_longpath)	;获取其他工作窗口尾行时间
		nowT := % A_Now
		EnvSub, nowT, % LOTimeL, Seconds
		if nowT >= 1
		{
			Cr_AfterDel(winacned, a_workingdir "\CHjeon\NowGo.id")
			WinActivate, % winacned
			WinWaitActive, % winacned
			gosub, 天帝初次领取
			gosub, 关闭退出脚本及附属脚本
		}
	}
}
;若无，执行普通任务
lastjobline := % getLastL(a_workingdir "\CHjeon\" WokingW ".job")
jobG( 1, "魂兽任务", lastjobline)
jobG( "魂兽进行时", "魂兽任务", lastjobline)
gosub, 关闭退出脚本及附属脚本
return

;●脚本主体●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
;---2.天帝工作
;领取后记录下次领取时间
;保存到对应窗口
;完成领取则删除对应窗口天帝及普通任务日志.job和.time
;------①天帝初

天帝初次领取:
cl1 := "怒风猎手"
cl2 := "小檀"
cl3 := "后羿"
cl4 := "牛魔"
cl5 := "嫦娥"
cl6 := "长生剑仙"
dropcl := % getL(A_WorkingDir "\TDdrop.cho", 1)
;第1个loop，开启宝库界面
gosub, 关闭所有无用界面	;包括天帝宝库,直到看到背包；

run, TDhelp2.ahk, , , acPIDx
GUITextC("当前流程：`n打开天帝界面至材料页面")
Loop
{
	if a_INDEX = 160
		GOSUB, 不改变账号登陆游戏
	cliO(923, 76, mn027lx, 21, 35, 48, 67)	;关闭离线挂机页面
	cliO(923, 76, mn027lx, 21, 35, 48, 67)	;关闭离线挂机
	cliI(mn028flx, 821, 76, 842, 94)	;关闭福利页面
	cliO(923, 73, mn035hsx, 43, 35, 78, 67)	;魂兽关闭
	cliO(832, 83, mn037thx, 436, 69, 458, 92)	;特惠活动点x
	cliI(mn001xb, 690, 132, 704, 149)
	sleep 350
	cliI(mn031tb2, 677, 156, 699, 176)	;右起第3位，出3图标，点第2图标
	cliI(mn002td, 725, 165, 739, 179)
	
	cliI(mn038icon1, 740, 124, 761, 143)	;右起第二位icon
	cliI(mn039icon2, 776, 160, 795, 176)	;右起第二位弹出另外界面icon	
	cliI(mn050icon5, 739, 159, 759, 179)	;右起第二位弹出另外界面icon		
	
	if tdw = 16
	{
		tdw := 
		gosub, 不改变账号登陆游戏
	}
	if picR(mn036td, 19, 291, 81, 345)	;天帝宝库未刷新
	{
		if !tdw
			tdw := 1
		else
			tdw := % tdw + 1
		sleep 150
	}
	
	else
		tdw := 
	nowwwin := % getL(A_WorkingDir "\CHjeon\NowGo.id", 1)
	if dropcl = % cl1	;怒风
	{
		;1.判断是否到红，break
		;2.点击非红怒风
		GUITextC("当前流程：`n判断怒风")
		if dmPicR("d1nf.bmp", 0, 100, 150, 560, nowwwin, A_WorkingDir "\dmpic\", dm)	;判断结果
			break
		dmCli("u1nf.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl2	;小檀
	{
		;1.判断是否到红，break
		;2.点击非红小檀
		if dmPicR("d2xt.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)	;判断结果
			break
		dmCli("u2xt.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl3	;后羿
	{
		;1.判断是否到红，break
		;2.点击非红后羿
		if dmPicR("d3hy.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u3hy.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl4	;牛魔
	{
		;1.判断是否到红，break
		;2.点击非红后羿
		if dmPicR("d4nm.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u4nm.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl5	;嫦娥
	{
		;1.判断是否到红，break
		;2.点击非红嫦娥
		if dmPicR("d5ce.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u5ce.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl6	;长生剑仙
	{
		;1.判断是否到红，break
		;2.点击非红长生剑仙
		if dmPicR("d6cs.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u6cs.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
}
Process, Close, % acPIDx
sleep 300
;判断当前领取情况
GUITextC("当前流程：`n判断领取情况")
Loop
{
	if picR(mn027lx, 21, 35, 48, 67)
	{
		gosub, 天地领取出现离线挂机
	}
	if picR(mn018rw, 479, 491, 501, 515)	;当前为人王检测
	{
		;1可领，点击
		;2等待时间，记录到.time文件，中断循环，
		;3今日无人王免费次数，点击
		if picR(mn023rwmf, 229, 530, 247, 549)	;已免费，点击
		{
			sleep 200
			cliI(mn025rwjf, 195, 493, 216, 514)
			sleep 1300
		}
		
		if picR(tdrw10m, 246, 450, 282, 471)	;天帝等待10分钟，实际11分钟
		{
			timead(11)
			break
		}
		else if picR(tdrw09m, 254, 449, 273, 470)	;天帝等待9分钟，实际10分钟
		{
			timead(10)
			break			
		}
		else if picR(tdrw08m, 253, 450, 276, 471)	;天帝等待8分钟，实际9分钟
		{
			timead(9)
			break
		}
		else if picR(tdrw07m, 253, 449, 275, 471)	;天帝等待7分钟，实际8分钟
		{
			timead(8)
			break
		}
		else if picR(tdrw06m, 254, 449, 274, 470)	;天帝等待6分钟，实际7分钟
		{
			timead(7)
			break
		}
		else if picR(tdrw05m, 255, 450, 273, 469)	;天帝等待5分钟，实际6分钟
		{
			timead(6)
			break		
		}
		else if picR(tdrw04m, 254, 449, 274, 470)	;天帝等待4分钟，实际5分钟
		{
			timead(5)
			break
		}
		else if picR(tdrw03m, 254, 449, 274, 470)	;天帝等待3分钟，实际4分钟
		{
			timead(4)
			break
		}
		else if picR(tdrw02m, 253, 448, 275, 470)	;天帝等待2分钟，实际3分钟
		{
			timead(3)
			break		
		}
		else if picR(tdrw01m, 254, 450, 275, 471)	;天帝等待1分钟，实际2分钟
		{
			timead(2)
			break
		}
		if picR(mn026rwp, 232, 438, 334, 482)	;地王未开，继续点人王
		{
			sleep 200
			cliI(mn025rwjf, 195, 493, 216, 514)
			sleep 1300
		}
	}

	else if picR(mn019dw, 478, 493, 501, 516)	;当前为地王检测
	{
		if !bcr
			bcr := 1
		else
			bcr := % bcr + 1
		;1.可领，点击
		;2.地王等待时间，记录到.time文件，中断循环
		;3.领取之上为空白，删除文件，退出游戏，中断循环
		if picR(mn020dwmf, 513, 530, 533, 551)	;地王本次免费【免】
		{
			sleep 200
			cliI(mn019dw, 478, 493, 501, 516)	;点击地王领取
			sleep 2500
		}
		if picR(mn021dwtc, 492, 437, 532, 480)	;完成任务，删除文件，退出游戏
		{
			FileReadLine, xxacc, % a_workingdir "\CHjeon\" jj2x ".job", 1
			loop, % a_workingdir "\3-成号\*.acc"
			{
				FileReadLine, xxbcc, % A_LoopFileLongPath, 1
				if xxbcc = % xxacc
				{
					Ad_ToLL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", a_loopfilename)
					break
				}
			}
			Del_F(a_workingdir "\CHjeon\" jj2x ".time")
			Del_F(a_workingdir "\CHjeon\" jj2x ".job")
			gosub, 完成天帝宝库退出
			ExitApp
			return
		}
		if picR(tddw04m, 480, 450, 499, 470)	;地王等待4分钟，实际5分钟
		{
			timead(5)
			break
		}
		else if picR(tddw07m, 479, 449, 500, 470)	;地王等待7分钟，实际8分钟	
		{
			timead(8)
			break		
		}
		else if picR(tddw06m, 479, 450, 499, 470)	;地王等待6分钟，实际7分钟	
		{
			timead(7)
			break			
		}
		else if picR(tddw05m, 478, 450, 499, 470)	;地王等待5分钟，实际6分钟
		{
			timead(6)
			break
		}
		else if picR(tddw03m, 479, 449, 501, 470)	;地王等待3分钟，实际4分钟
		{
			timead(4)
			break
		}
		else if picR(tddw02m, 480, 449, 501, 470)	;地王等待2分钟，实际3分钟
		{
			timead(3)
			break
		}
		else if picR(tddw01m, 479, 448, 502, 471)	;地王等待1分钟，实际2分钟
		{
			timead(2)
			break		
		}
		else if (bcr >= 3)
		{
			timead(1)
			break			
		}
	}	
}
bcr :=
gosub, 关闭天帝宝库界面
gosub, 关闭退出脚本及附属脚本
return

timead(addt)	;天帝一次性函数
{
	Loop
	{
		WinGetTitle, noacwin, A
		IfExist, % a_workingdir "\CHjeon\" noacwin ".time"
		{
			timN := % A_Now
			EnvAdd, timN, % 60 * addt, Seconds
			FileAppend, % "`n" timN, % a_workingdir  "\CHjeon\" noacwin ".time"
			sleep 500
			break
		}
		else
		{
			sleep 100
		}
		if a_index = 150
		{
			msgbox, 时间等待函数错误
			ExitApp
		}
	}
}

天地领取出现离线挂机:
Loop
{
	dropcl := % getL(A_WorkingDir "\TDdrop.cho", 1)
	cliI(mn001xb, 690, 132, 704, 149)	;寻宝图标
	cliO(923, 76, mn027lx, 21, 35, 48, 67)	;关闭离线挂机页面
	sleep 500
	cliI(mn031tb2, 677, 156, 699, 176)	;右起第3位，出3图标，点第2图标
	cliI(mn002td, 725, 165, 739, 179)
	nowwwin := % getL(A_WorkingDir "\CHjeon\NowGo.id", 1)
	if dropcl = % cl1	;怒风
	{
		;1.判断是否到红，break
		;2.点击非红怒风

		if dmPicR("d1nf.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)	;判断结果
			break
		dmCli("u1nf.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl2	;小檀
	{
		;1.判断是否到红，break
		;2.点击非红小檀
		if dmPicR("d2xt.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)	;判断结果
			break
		dmCli("u2xt.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl3	;后羿
	{
		;1.判断是否到红，break
		;2.点击非红后羿
		if dmPicR("d3hy.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u3hy.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl4	;牛魔
	{
		;1.判断是否到红，break
		;2.点击非红后羿
		if dmPicR("d4nm.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u4nm.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl5	;嫦娥
	{
		;1.判断是否到红，break
		;2.点击非红嫦娥
		if dmPicR("d5ce.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u5ce.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if dropcl = % cl6	;长生剑仙
	{
		;1.判断是否到红，break
		;2.点击非红长生剑仙
		if dmPicR("d6cs.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm)
			break
		dmCli("u6cs.bmp", 0, 100, 100, 560, nowwwin, A_WorkingDir "\dmpic\", dm, 300)	;点击
	}
	else if a_index = 30
	{
		gosub, 不改变账号登陆游戏
		cwcqcg :=
		ExitApp
	}
}
return


;---3.普通任务
完成天帝宝库退出:		;加入完成账号到日期.note尾行,删除该窗口.job，.time文件，并重启登陆游戏
WWN := % getL(a_workingdir "\CHjeon\NowGo.id", 1)	;获取完成工作窗口
doneacc := % getL(a_workingdir "\CHjeon\" WWN ".job", 1)	;获取完成工作账号
Ad_ToLL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", doneacc)	;写入完成账号到日期.note文件尾行
Del_F(a_workingdir "\CHjeon\" WWN ".job")	;删除.job文件
Del_F(a_workingdir "\CHjeon\" WWN ".time")	;删除.time文件
;以下为改变切换账号重新登陆游戏
StringTrimLeft, WWN, WWN, 2	;获取关闭编号，为整数
muliR(WWN, 1)	;关闭该编号模拟器
sleep 2500
muliR(WWN)	;启动该编号模拟器
WinWait, ahk_class LDPlayerMainFrame, , , TD
WinSetTitle, ahk_class LDPlayerMainFrame, , % "TD" WWN, TD	;设置工作窗口文件
;1.点击幻剑图标
GUITextC("【完成天帝任务切号】`n当前窗口编号：" WWN "`n当前流程：点击幻剑图标")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg	;重登或不切号完成时
		break
	if tbwsx = 16
	{
		tbwsx := 
		gosub, 关闭重启游戏
		ExitApp
	}
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
		gosub, 关闭重启游戏
		break
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
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg
		break
	Clipboard :=
	;清空账号密码
	GUITextC("【完成天帝任务切号】`n当前窗口编号：" WWN "`n当前流程：清空账号密码")
	Loop
	{
		IfWinExist, VirtualBox Headless Frontend
			run, % a_workingdir "\TDreload.ahk"
		if A_Index = 15
			gosub 关闭重启游戏
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
	;1.鼠标移至账号处，2.获取账号密码，3.设置剪切板，4.黏贴账号
	MouseMove, 533, 239, 0
	SLEEP 300
	;获取未完成账号长路径
	GUITextC("【完成天帝任务切号】`n当前窗口编号：" WWN "`n当前流程：输入账号密码")
	LOOP, % delFStr(a_workingdir, 8) "\3-成号\*.acc"
	{
		if SRT_AllL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", A_LoopFileName)	;已完成账号搜索
		{
			alldone := 1
			didnt := 1
		}
		else
			didnt := 
		if SRT_AllL(A_WorkingDir "\CHjeon\loged.note", A_LoopFileName)	;已完成账号搜索，
			didnt := 1
		if !didnt	;账号未工作，则设置当前工作账号
		{
			NWACC := % A_LoopFileLongPath	;获取工作账号长路径
			NAFNAME := % A_LoopFileName	;获取工作账号文件名
			didnt := 
			break
		}

	}
	if didnt	;写入everydone至日期.note以及窗口号.note
	{
		WWN := % getL(a_workingdir "\CHjeon\NowGo.id", 1)	;获取完成工作窗口
		if alldone
			Ad_ToLL(A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", "everydone")	;写入完成账号到日期.note文件尾行
		Ad_ToLL(a_workingdir "\CHjeon\" WWN ".time", "everydone")	;写入完成账号到日期.time文件尾行
		gosub, 关闭退出脚本及附属脚本
	}
	didnt := 
		;设置账号密码并输入
	MouseClick, L, 533, 239, 1, 0
	SLEEP 600
	Clipboard := % getL(NWACC, 1)	;获取工作账号首行账号
	ClipWait
	SEND, ^v	;黏贴账号
	sleep 100
	Clipboard :=
	MouseMove, 533, 281, 0
	sleep 200
	Clipboard := % getL(NWACC, 2)	;获取工作账号次行密码
	MouseClick, L, 533, 281, 1, 0
	SLEEP 600
	ClipWait
	SEND, ^v
	sleep 500
	break
}
GUITextC("【完成天帝任务切号】`n当前窗口编号：" WWN "`n当前流程：点击登录红钮")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg
		break
	if thiswindone
		break
	if a_index = 30
		gosub, 关闭重启游戏
	cliI(DL02dl, 500, 352, 521, 375)	;点击登陆红钮
	sleep 600
	if picR(DL05dh, 515, 465, 555, 500)
		break
}
;4.点击登陆黄钮，直到遇见背包，创建.job以及.time文件
GUITextC("【完成天帝任务切号】`n当前窗口编号：" WWN "`n当前流程：点击登录黄钮")
Loop
{
	IfWinExist, VirtualBox Headless Frontend
		run, % a_workingdir "\TDreload.ahk"
	if cwcqcg
		break
	Sleep 500
	if a_index = 100
		gosub 关闭重启游戏
	cliI(DL05dh, 515, 465, 555, 500)	;点击登陆黄钮
	Sleep 500
	if picR(DL03bb, 926, 280, 939, 298)	;搜图到背包，删除NowGo文件，创建loged.note文件.time与.job文件，文件名为窗口名，1行为账号文件名，2行为1
	{
		workwinnow := getL(A_WorkingDir "\CHjeon\NowGo.id", 1)
		Ad_ToLL(A_WorkingDir "\CHjeon\loged.note", NAFNAME)
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".job")
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".time")
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".job", "1")
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".time", "1")
		Del_F(A_WorkingDir "\CHjeon\NowGo.id")	;删除nowGo文件,重启则不删除
		ExitApp
	}
	if picR(mn029wlcw, 391, 245, 429, 266)	;网络错误时
	{
		workwinnow := getL(A_WorkingDir "\CHjeon\NowGo.id", 1)	;获取TD窗口
		Ad_ToLL(A_WorkingDir "\CHjeon\loged.note", NAFNAME)	;写入切号前账号到loged
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".job")	;写入当前账号
		Cr_AfterDel(NAFNAME, A_WorkingDir "\CHjeon\" workwinnow ".time")	;写入当前账号
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".job", "1")
		Ad_ToLL(A_WorkingDir "\CHjeon\" workwinnow ".time", "1")
		gosub, 不改变账号登陆游戏
		break
	}
}
Del_F(A_WorkingDir "\CHjeon\NowGo.id")	;删除nowGo文件,重启则不删除
ExitApp
return

魂兽任务:	;中途退出进行天帝任务将在.job记录【魂兽进行时】，完成魂兽将记录下一任务【福利领取进行时】
gosub, 关闭退出脚本及附属脚本
return

关闭所有无用界面:
;角色
;魂兽
;副本
;仙盟
;攻城
;福利
;离线挂机
;天帝宝库
;其他活动-1.鱼跃龙门2.每周福利3.卡片兑换
GUITextC("当前流程：`n关闭所有无用界面`n即将领取天帝宝库")
Loop
{
	cliO(925, 75, mn003tdm, 22, 34, 55, 63)	;关闭天帝宝库
	cliO(923, 76, mn027lx, 21, 35, 48, 67)	;关闭离线挂机
	cliI(mn028flx, 821, 76, 842, 94)	;关闭福利页面
	cliO(923, 73, mn035hsx, 43, 35, 78, 67)	;魂兽关闭
	cliO(832, 83, mn037thx, 436, 69, 458, 92)	;特惠活动点x
	if picR(DL03bb, 926, 280, 939, 298)	;背包
		break
	sleep 1000
	if a_index = 30
	{
		gosub, 不改变账号登陆游戏
		ExitApp
	}
}
return

关闭天帝宝库界面:
GUITextC("当前流程：`n关闭天帝界面`n即将退出当前流程")
Loop
{
	cliO(925, 75, mn003tdm, 22, 34, 55, 63)	;关闭天帝宝库
	if picR(DL03bb, 926, 280, 939, 298)	;背包
		break
	if a_index = 5
	{
		gosub, 关闭所有无用界面
		break
	}
	sleep 1000
}
return

;●图片路径变量●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
图片路径变量读取:
{
DL01tb := % "*10 " A_workingdir "\picture\DL01tb.png"
DL02dl := % "*10 " A_workingdir "\picture\DL02dl.png"
DL03bb := % "*10 " A_workingdir "\picture\DL03bb.png"
DL05dh := % "*10 " A_workingdir "\picture\DL05dh.png"
dl06zh := % "*10 " a_workingdir "\picture\dl06zh.png"
dl07ma := % "*10 " a_workingdir "\picture\dl07ma.png"
;人王等待时间
tdrw10m := % "*10 " a_workingdir "\picture\tdrw10m.png"
tdrw09m := % "*10 " a_workingdir "\picture\tdrw09m.png"
tdrw08m := % "*10 " a_workingdir "\picture\tdrw08m.png"
tdrw07m := % "*10 " a_workingdir "\picture\tdrw07m.png"
tdrw06m := % "*10 " a_workingdir "\picture\tdrw06m.png"
tdrw05m := % "*10 " a_workingdir "\picture\tdrw05m.png"
tdrw04m := % "*10 " a_workingdir "\picture\tdrw04m.png"
tdrw03m := % "*10 " a_workingdir "\picture\tdrw03m.png"
tdrw02m := % "*10 " a_workingdir "\picture\tdrw02m.png"
tdrw01m := % "*10 " a_workingdir "\picture\tdrw01m.png"
;地王等待时间
tddw07m := % "*10 " a_workingdir "\picture\tddw07m.png"
tddw06m := % "*10 " a_workingdir "\picture\tddw06m.png"
tddw05m := % "*10 " a_workingdir "\picture\tddw05m.png"
tddw04m := % "*10 " a_workingdir "\picture\tddw04m.png"
tddw03m := % "*10 " a_workingdir "\picture\tddw03m.png"
tddw02m := % "*10 " a_workingdir "\picture\tddw02m.png"
tddw01m := % "*10 " a_workingdir "\picture\tddw01m.png"
;其他图片
mn001xb := % "*10 " a_workingdir "\picture\mn001xb.png"
mn002td := % "*10 " a_workingdir "\picture\mn002td.png"
mn003tdm := % "*10 " a_workingdir "\picture\mn003tdm.png"
mn005nf := % "*10 " a_workingdir "\picture\mn005nf.png"
mn006nf1 := % "*10 " a_workingdir "\picture\mn006nf1.png"
mn07xt := % "*10 " a_workingdir "\picture\mn07xt.png"
mn08xt1 := % "*10 " a_workingdir "\picture\mn08xt1.png"
mn009hy := % "*10 " a_workingdir "\picture\mn009hy.png"
mn010hy1 := % "*10 " a_workingdir "\picture\mn010hy1.png"
mn011nm := % "*10 " a_workingdir "\picture\mn011nm.png"
mn012nm1 := % "*10 " a_workingdir "\picture\mn012nm1.png"
mn013ce := % "*10 " a_workingdir "\picture\mn013ce.png"
mn015ce1 := % "*10 " a_workingdir "\picture\mn015ce1.png"
mn016cs := % "*10 " a_workingdir "\picture\mn016cs.png"
mn017cs1 := % "*10 " a_workingdir "\picture\mn017cs1.png"
mn018rw := % "*10 " a_workingdir "\picture\mn018rw.png"
mn019dw := % "*10 " a_workingdir "\picture\mn019dw.png"
mn020dwmf := % "*10 " a_workingdir "\picture\mn020dwmf.png"
mn021dwtc := % "*10 " a_workingdir "\picture\mn021dwtc.png"
MN022TCQD := % "*10 " a_workingdir "\picture\MN022TCQD.png"
mn023rwmf := % "*10 " a_workingdir "\picture\mn023rwmf.png"
mn025rwjf := % "*10 " a_workingdir "\picture\mn025rwjf.png"
mn026rwp := % "*10 " a_workingdir "\picture\mn026rwp.png"
mn027lx := % "*10 " a_workingdir "\picture\mn027lx.png"
mn028flx := % "*10 " a_workingdir "\picture\mn028flx.png"
mn029wlcw := % "*10 " a_workingdir "\picture\mn029wlcw.png"
mn030bcdl := % "*10 " a_workingdir "\picture\mn030bcdl.png"
mn031tb2 := % "*10 " a_workingdir "\picture\mn031tb2.png"
mn032cw := % "*10 " a_workingdir "\picture\mn032cw.png"
mn033tbcw := % "*10 "  a_workingdir "\picture\mn033tbcw.png"
mn035hsx := % "*10 "  a_workingdir "\picture\mn035hsx.png"
mn036td := % "*10 "  a_workingdir "\picture\mn036td.png"
mn037thx := % "*10 " a_workingdir "\picture\mn037thx.png"

mn038icon1 := % "*10 " a_workingdir "\picture\mn038icon1.png"
mn039icon2 := % "*10 " a_workingdir "\picture\mn039icon2.png"
mn050icon5 := % "*10 " a_workingdir "\picture\mn050icon5.png"

}
return

;●一般函数●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
;---1.图片点击函数
cliI(thePathi, cx1, cy1, cx2, cy2)
{
	ImageSearch, xx, yy, %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	if errorlevel = 0
	{
		MouseClick, L, %xx%, %yy%, 1, 0
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliI图片不存在`n%thePathi%
	}
}
;---2.点击它处函数
cliO(ox1, oy1, thepatho, ox2, oy2, ox3, oy3)
{
	ImageSearch, , , %ox2%, %oy2%, %ox3%, %oy3%, % thepatho
	if errorlevel = 0
	{
		MouseClick, L, %ox1%, %oy1%, 1, 0
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliO图片不存在`n%thepatho%
	}
}
;---3.无限判断点击函数
cliA(thpatha, ax1, ay1, ax2, ay2, thepathb, bx1, by1, bx2, by2)
{
	Loop
	{
		ImageSearch, lx, ly, %ax1%, %ay1%, %ax2%, %ay2%, % thpatha
		if errorlevel = 0
		{
			MouseClick, L, %lx%, %ly%, 1, 0
		}
		else if errorlevel = 2
		{
			MsgBox, 错误`nCliA点击图片不存在`n`[cli`]%thpatha%
		}
		ImageSearch, , , %bx1%, %by1%, %bx2%, %by2%, % thepathb
		if errorlevel = 0
		{
			break
		}
		else if errorlevel = 2
		{
			MsgBox, 错误`nCliA判断图片不存在`n`[pan`]%thepathb%
		}
		if a_index = 300
		{
			TrayTip, 超时警告, 超过1分钟未达到指定状态`n当前任务将结束
			break
		}
		IfWinNotExist, 天帝宝库
		{
			ExitApp
		}
		sleep 200
	}
}
;---4.普通任务判断函数
jobG(pjob, gosubx, ByRef jnow)
{
	cal := % pjob
	if jnow = % cal
	{
		gosub, % gosubx
		gosub, 关闭退出脚本及附属脚本
	}
}
;---5.搜图判断函数，找到返回1，没找到返回0
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
;---6.删除文件直到区确定无该文件
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
;---7.获取某行字符串
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
;---8.查询文件夹下是否有该名的文件
SFFFBT(fodp, tex)
{
	Loop, % fodp "\*.*"
	{
	If a_loopfilename = % tex
		Return % a_loopfilename
	}
	Return 0
}
;---9.控制多开器启动/关闭窗口函数
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
;---10.controlclick函数
conCli(lx, ly, tit)
{
	ControlClick, % "x" lx " y" ly, % tit, , L, 1
}
;---11.创建文件前删除该文件确认后写入首行文本，确认首行文本后完成
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
;---12.检测文件文本匹配，所有行，成功返回1,无匹配返回0
SRT_AllL(filLP, tex)
{
	loop, read, % filLP
	{
		caa := % A_LoopReadLine
		if caa = % tex
		{
			gotit := 1
			break
		}
	}
	if gotit
	{
		gotit := 
		return 1
	}
	else
		return 0
}
;---13.写入文本到尾行，确认尾行文本后结束
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
;---14.tooltip函数，位置一定
TTscreen(tex, x1 := 239, y1 := 883)
{
	CoordMode, tooltip, screen
	ToolTip, % "当前流程：`n" tex, % x1, % y1
}
;---15.获取文件尾行字符串
getLastL(filLP)
{
	IfExist, % filLP
	{
		loop, read, % filLP
		{
			lastline := % A_LoopReadLine
		}
		if lastline
			return % lastline
		else
			return 0
	}
	else
		return 0
}
;---16.窗口有文本改变函数
GUITextC(tex, ByRef guiv := "statusv")
{
	GuiControl, , %guiv%, % tex
}
;---17.文本删减函数，默认自右起
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

;大漠函数
dmCli(picname, x1, y1, x2, y2, title, dir, ByRef dmm, cliSlp := 0, nfdSlp := 0)
{
	dmm.SetPath(dir)	;设定图片文件夹路径
	
	hwndx := dmm.FindWindow("", title) 	;设定查找窗口
	dm_ret := dmm.BindWindow(hwndx,"normal","normal","normal",0)	;绑定查找窗口
	xx := ComVar(), yy := ComVar()
	goterrorlevel := dmm.FindPic(x1, y1, x2, y2, picname,"090909",0.8,0, xx.ref, yy.ref)
	goterrorlevel := % goterrorlevel + 1
	if (goterrorlevel) {
		dmm.moveto(xx[], yy[])
        dmm.LeftClick()
        sleep, % clislp
        return 1
    }
	else {
        sleep, % nfdSlp
		return 0 
    }
}

;点击它处函数
dmCliO(x3, y3,picname, x1, y1, x2, y2, title, dir, ByRef dmm, cliSlp := 0, nfdSlp := 0)
{
	dmm.SetPath(dir)	;设定图片文件夹路径
	hwndx := dmm.FindWindow("", title) 	;设定查找窗口
	dm_ret := dmm.BindWindow(hwndx,"normal","normal","normal",0)	;绑定查找窗口
	xx := ComVar(), yy := ComVar()
	goterrorlevel := dmm.FindPic(x1, y1, x2, y2, picname,"101010",0.6,0, xx.ref, yy.ref)
	goterrorlevel := % goterrorlevel + 1
	if (goterrorlevel) {
		MouseClick, L, %x3%, %y3%, 1, 0		;需查找ahk相对窗口坐标
        sleep, % clislp
        return 1
    }
	else {
        sleep, % nfdSlp
		return 0 
    }
}

;判断返回函数
dmPicR(picname, x1, y1, x2, y2, title, dir, ByRef dmm)
{
	dmm.SetPath(dir)	;设定图片文件夹路径
	hwndx := dmm.FindWindow("", title) 	;设定查找窗口
	dm_ret := dmm.BindWindow(hwndx,"normal","normal","normal",0)	;绑定查找窗口
	xx := ComVar(), yy := ComVar()
	goterrorlevel := dmm.FindPic(x1, y1, x2, y2, picname,"080808",0.8,0, xx.ref, yy.ref)
	goterrorlevel := % goterrorlevel + 1
	if goterrorlevel
		return 1
	else
		return 0
}

ComVar(Type=0xC)
{
    static base := { __Get: "ComVarGet", __Set: "ComVarSet", __Delete: "ComVarDel" }
    ; 创建含 1 个 VARIANT 类型变量的数组.  此方法可以让内部代码处理
    ; 在 VARIANT 和 AutoHotkey 内部类型之间的所有转换.
    arr := ComObjArray(Type, 1)
    ; 锁定数组并检索到 VARIANT 的指针.
    DllCall("oleaut32\SafeArrayAccessData", "ptr", ComObjValue(arr), "ptr*", arr_data)
    ; 保存可用于传递 VARIANT ByRef 的数组和对象.
    return { ref: ComObjParameter(0x4000|Type, arr_data), _: arr, base: base }
}

ComVarGet(cv, p*) { ; 当脚本访问未知字段时调用.
    if p.MaxIndex() = "" ; 没有名称/参数, 即 cv[]
        return cv._[0]
}
ComVarSet(cv, v, p*) { ; 当脚本设置未知字段时调用.
    if p.MaxIndex() = "" ; 没有名称/参数, 即 cv[]:=v
        return cv._[0] := v
}
ComVarDel(cv) { ; 当对象被释放时调用.
    ;必须进行这样的处理以释放内部数组.
    DllCall("oleaut32\SafeArrayUnaccessData", "ptr", ComObjValue(cv._))
}

