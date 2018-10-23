/*
2018年04月28日
1完善诸控件
2删除临时脚本文件
3删除临时账号文件
优先级以主脚本为参考移动账号文件
窗口数以主脚本为主创建脚本文件
忽略商城选项在子脚本中进行流程管控
*/

{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先声明 / 1.顶部路径 2.大漠字典等
#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%
yh = "
ToFoPa := % delStrL(a_workingdir, 6)	;顶部路径
toDay := % A_YYYY A_MM A_DD
}
{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    GUI不变文本等
Gui, +AlwaysOnTop


Gui, Add, Text, x18 y7 w50 h16 , 成号数：
Gui, Add, Text, vChacNN x68 y7 w38 h16 , 0		;3-成号数	每隔一段时间检查

Gui, Add, Text, x18 y25 w50 h16 , 变身号：
Gui, Add, Text, vbsNN x68 y25 w38 h16 , 0		;8-变身数	每隔一段时间检查

Gui, Add, Text, x109 y7 w50 h16 , 日常号：
Gui, Add, Text, vRcacNN x159 y7 w38 h16 , 0		;2-日常号数 	每隔一段时间检查

Gui, Add, Radio, g变身号优先 vyxB x100 y25 w70 h20 , 变身优先	;先移动成号，若第二天未完，也移动成号，若所有账号具空，移动所有日常号到工作账号下，然后重启所有脚本
Gui, Add, Radio, g成号优先 vyxC x18 y45 w70 h20 , 成号优先	;先移动成号，若第二天未完，也移动成号，若所有账号具空，移动所有日常号到工作账号下，然后重启所有脚本
Gui, Add, Radio, g小号优先 vyxR x100 y45 w90 h20 , 小号优先		;先移动日常号，若第二天未完，也移动成号，若所有账号具空，移动所有日常号到工作账号下，然后重启所有脚本

Gui, Add, Text, x26 y78 w60 h16 , 商店选择：
Gui, Add, DropDownList, R3 vsdxz_x x86 y75 w80 h13 , DropDownList	;商店选择

Gui, Add, Text, x26 y100 w60 h16 , 魂兽选择：
Gui, Add, DropDownList, R5  vHSchos x86 y97 w80 h13 , DropDownList	;魂兽选择

Gui, Add, Text, x26 y122 w60 h16 , 天帝宝库：
Gui, Add, DropDownList, R9  vTDBK x86 y119 w80 h13 , DropDownList	;天帝宝库

Gui, Add, Text, x36 y148 w50 h16 , 窗口数：
Gui, Add, DropDownList, R12 vnum_wingw x86 y145 w60 h13 , DropDownList	;窗口数目


Gui, Add, Text, x26 y173 w60 h16 , 今日完成：
Gui, Add, Text, vjrwctd x86 y173 w38 h16 , 0	;今日完成，于note文件中查询行数
Gui, Add, Button, grunMZM x126 y171 w50 h18 , 盟主名

Gui, Add, Button, gROE x17 y197 w160 h28 ,  _____  启   动  _____		;唯一按钮，启动脚本




}

{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    GUI主要控件



Gui, Add, CheckBox, vOReload x16 y231 w70 h20 , 超时重启
Gui, Add, CheckBox, vGcUnDo x16 y254 w95 h20 , 忽略攻城
Gui, Add, CheckBox, vxmUnD x16 y277 w70 h20 , 忽略仙盟
Gui, Add, CheckBox, vlmUnD x16 y299 w70 h20 , 忽略龙神
Gui, Add, CheckBox, vlxjyUnD x16 y321 w70 h20 , 忽略离线
Gui, Add, CheckBox, vJYUNDO x16 y343 w70 h20 , 忽略经验 

Gui, Add, CheckBox, vBBZL x107 y231 w70 h20 , 背包整理
Gui, Add, CheckBox, vtpDH x107 y254 w70 h20 , 图谱兑换
Gui, Add, CheckBox, vtxUnD x107 y277 w70 h20 , 退出仙盟
Gui, Add, CheckBox, vFSBoss x107 y299 w70 h20 , 飞升Boss
Gui, Add, CheckBox, vBSCE x107 y321 w70 h20 , 变身嫦娥
Gui, Add, CheckBox, gDFJJ vDFJJ x107 y343 w70 h20 , 巅峰竞技


/*
Gui, Add, CheckBox, vOReload x16 y211 w70 h20 , 超时重启
Gui, Add, CheckBox, vGcUnDo x96 y211 w95 h20 , 忽略攻城奖励
Gui, Add, CheckBox, vxmUnD x96 y234 w70 h20 , 忽略仙盟
Gui, Add, CheckBox, vlmUnD x16 y257 w70 h20 , 忽略龙神
Gui, Add, CheckBox, vlxjyUnD x16 y301 w70 h20 , 忽略离线


Gui, Add, CheckBox, vBBZL x16 y234 w70 h20 , 背包整理
Gui, Add, CheckBox, vtpDH x16 y279 w70 h20 , 图谱兑换
Gui, Add, CheckBox, vtxUnD x96 y257 w70 h20 , 退出仙盟
Gui, Add, CheckBox, vFSBoss x96 y279 w70 h20 , 飞升Boss
Gui, Add, CheckBox, vBSCE x96 y301 w70 h20 , 变身嫦娥

*/





}
{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>    启动前首先声明
gosub, 关闭雷电模拟器及脚本
gosub, 检查雷电多开器
gosub, 删除临时文件
gosub, 检查账号文件
gosub, 完善诸控件
Gui, Show, x1580 y268 h367 w193, 幻剑日常主脚本

Return
}

DFJJ:		;巅峰竞技
GuiControlGet, DFJJ, , DFJJ		;巅峰竞技选项
GuiControlGet, yxB, , yxB		;变身号被选中时候

if (DFJJ) {	;如果巅峰竞技被选中，看变身是否被选中
	if (!yxB) {
		MsgBox, 请选择变身优先后再勾起该选项`n操作将被忽略
		guicontrol, , DFJJ, 0
		return
	}
}
return

变身号优先:
GuiControlGet, yxB, , yxB
if (yxB) {	;当前选择变身号
	GuiControlGet, bsNN, , bsNN 
	if !bsNN	;无变身号存在
	{
		msgbox, 当前无变身号存在`n无法选择
		guicontrol, , yxB, 0
		GuiControlGet, RcacNN, , RcacNN
		GuiControlGet, ChacNN, , ChacNN
		if RcacNN and ChacNN
			guicontrol, , yxC, 1
		else if RcacNN and !ChacNN
			guicontrol, , yxR, 1
		else if !RcacNN and ChacNN
			guicontrol, , yxC, 1
	}
}
return

runMZM:
run, % a_workingdir "\盟主设定.ahk"
return

ROE:	;RunOrExit
goRun := !goRun
if goRun {
	nowTime := % A_Now	;当前首次启动时间戳
	nextDay0 := % gotNDT()	;次日0时时间戳
	Cr_EmpFil(a_workingdir "\note\" toDay ".note")
	;即将创建临时选择日志文件
	GuiControlGet, OReload, , OReload	;是否重启选项
	GuiControlGet, GcUnDo, , GcUnDo		;是否不做攻城战选项
	GuiControlGet, youXianJi1, , yxC	;成号优先
	GuiControlGet, youXianJi2, , yxR	;小号优先
	GuiControlGet, youXianJi3, , yxB	;变身优先
	
	
	GuiControlGet, storeCho, , sdxz_x		;商店选择
	GuiControlGet, winNum, , num_wingw	;窗口数量
	GuiControlGet, chosofhs, , HSchos	;魂兽选择
	GuiControlGet, BBZL, , BBZL	;魂兽选择
	GuiControlGet, xmUnD, , xmUnD	;忽略仙盟
	GuiControlGet, JYUNDO, , JYUNDO	;忽略经验
	
	GuiControlGet, lmUnD, , lmUnD	;忽略龙神
	GuiControlGet, txUnD, , txUnD	;退出仙盟
	GuiControlGet, tpDH, , tpDH		;图谱兑换
	GuiControlGet, FSBoss, , FSBoss		;飞升boss
	GuiControlGet, lxjyUnD, , lxjyUnD		;离线经验
	GuiControlGet, TDBK, , TDBK		;离线经验
	
	GuiControlGet, BSCE, , BSCE		;变身嫦娥
	GuiControlGet, DFJJ, , DFJJ		;巅峰竞技
	
	
	
/*
lmUnD忽略龙神
txUnD退出仙盟	
*/
	
	
	if youXianJi1
		choLine1 := 1
	else if youXianJi2
		choLine1 := 2
	else if youXianJi3
		choLine1 := 3
	choLine2 := % storeCho	;次行商店选择
	choLine3 := % winNum		;第3行窗口数量
	choLine4 := % OReload		;第4行重启选项
	choLine5 := % GcUnDo		;第5行是否不做攻城战
	choLine6 := % chosofhs		;第6行是否不做攻城战
	choLine7 := % BBZL			;第7行是否做背包整理
	choLine8 := % xmUnD			;第8行是否忽略仙盟
	choLine9 := % lmUnD			;第9行是否忽略龙神佑体
	choLine10 := % txUnD		;第10行是否退出仙盟
	choLine11 := % tpDH			;第11行是否兑换图谱
	choLine12 := % FSBoss		;第12行，是否打飞升
	choLine13 := % lxjyUnD		;第13行，是否离线经验
	choLine14 := % TDBK			;第14行，天帝宝库
	choLine15 := % BSCE			;第14行，变身嫦娥
	choLine16 := % DFJJ			;第16行，巅峰竞技
	choLine17 := % JYUNDO
	
	;创建临时选择文件夹
	Cr_AfterDel(choLine1 "`n" choLine2 "`n" choLine3 "`n" choLine4 "`n" choLine5 "`n" choLine6 "`n" choLine7 "`n" choLine8 "`n" choLine9 "`n" choLine10 "`n" choLine11 "`n" choLine12 "`n" choLine13 "`n" choLine14 "`n" choLine15 "`n" choLine16 "`n" choLine17, a_workingdir "\GoRC.cho")
	if choLine1 = 1
		gosub, 转移成号至临时文件夹
	else if choLine1 = 2
		gosub, 转移日常号至临时文件夹
	else if choLine1 = 3
		gosub, 转移变身号至临时文件夹
	sleep 800
	run, % LdPath "\dnmultiplayer.exe"	;启动多开器
	WinWait, ahk_class LDMultiPlayerMainFrame
	Del_F(A_WorkingDir "\RC*.ahk")	;删除ahk临时工作文件
	sleep 800
	;创建子脚本
	FileRead, gotScriptX, % A_WorkingDir "\GoRCX.ahk"	;获取主脚本文件内容

	loop %winNum%
		FileAppend, % "SNum := " A_Index "`nwinName := " yh "RC" A_Index yh "`nstoreCho := " yh choLine2 yh "`nOReload := " choLine4 "`nGcUnDo := " choLine5 "`nHSChos := " yh choLine6 yh "`nBBZL := " choLine7 "`nxmUnD := " choLine8 "`nlmUnD := "choLine9 "`ntxUnD := " choLine10 "`ntpDH := " choLine11 "`nFSBoss := " choLine12 "`nlxjyUnD := " choLine13 "`nglobal TDBK := % " yh choLine14 yh "`nBSCE := " choLine15 "`nDFJJ := " choLine16 "`nJYUNDO := " choLine17 "`n" gotScriptX, % A_WorkingDir "\RC" A_Index ".ahk", UTF-8	;创建文件
	;注，最末尾添加的为脚本主体，再次加入元素请加于  【gotScriptX】   之前
	
	
	
	; winNum 为窗口数量
	loop %winNum%
	{
		run, % a_workingdir "\RC" A_Index ".ahk"
		WinWait, % "GoRC" A_Index
		Sleep 200
		ggggg := % A_Index
		Loop {
			If !WINEXIST("GoRC" ggggg)
				break
		}
	}
	SetTimer, 窗口等检测, -10000
}
else {
	SetTimer, 窗口等检测, Off
	gosub, NLock
}
return

窗口等检测:
CoordMode, MOUSE, screen
MouseMove, 1600, 900, 0
CoordMode, MOUSE, window
;检测日志文件行数
if !fileexist(a_workingdir "\note\" a_yyyy a_mm a_dd ".note")
	Cr_EmpFil(a_workingdir "\note\" a_yyyy a_mm a_dd ".note")	;若无日志文件则创建
else {	;今日完成为文件行数
	lineofN := % gFLineN(a_workingdir "\note\" a_yyyy a_mm a_dd ".note")
	if lineofN
		GuiControl, , jrwctd, % lineofN - 1
}

;检查日期，若为第二天，重启脚本
if (GTSubN(nextDay0) < 0) {
	gosub, nextdayreload
	return
}
else
	TrayTip, 注意, % SStoHMS(GTSubN(nextDay0)) "`n后将重启脚本", 1
;检查顶部路径成号和日常号数量 
rcHao := % FENumG(ToFoPa "\2-日常", "acc")
dHao := % FENumG(ToFoPa "\3-成号", "acc")
BHAO := % FENumG(ToFoPa "\8-变身", "acc")
if rcHao
	guicontrol, , RcacNN, % rcHao
else 
	guicontrol, , RcacNN, 0
if dHao
	guicontrol, , ChacNN, % dHao
else 
	guicontrol, , ChacNN, 0
if BHAO
	guicontrol, , bsNN, % BHAO
else
	guicontrol, , bsNN, 0
;检查剩余账号数量，若无，查看另一文件夹是否有账号，若无，进入计时，若有，关闭脚本，拷贝文件，重启子脚本
loop, % a_workingdir "\WorkAcc\*.acc", 0, 1
	gotEdNum := % A_Index
if (!gotEdNum) {	;无剩余账号
	notelinenum := % gFLineN(a_workingdir "\note\" A_YYYY A_MM A_DD ".note")	;获取note文件行数
	gotnnnnn := % notelinenum - 1
	loop, % ToFoPa "\2-日常\*.acc"
		richanghaoshu := % A_Index
	loop, % ToFoPa "\3-成号\*.acc"
		chenghaoshu := % A_Index
	gotnnnnn := % richanghaoshu + chenghaoshu - gotnnnnn
	if gotnnnnn > 7
	{
		if (choLine1 = 1) {	;当前工作为成号,检查是否存在日常号
			if (fileexist(ToFoPa "\2-日常\*.acc"))	{ ;存在日常号
				gosub, 关闭雷电模拟器及脚本
				gosub, 转移日常号至临时文件夹
				goRun :=
				run, % LdPath "\dnmultiplayer.exe"	;启动多开器
				WinWait, ahk_class LDMultiPlayerMainFrame
				Sleep 1000
				gosub, 重启所有子脚本
				settimer, 窗口等检测, -10000
				return
			}
			else {	;不存在日常号
				settimer, 窗口等检测, -10
				return
			}
		}
		else if (choLine1 = 2) {	;当前工作为日常号,检查是否存在成号
			if (fileexist(ToFoPa "\3-成号\*.acc"))	{ ;存在成号
				gosub, 关闭雷电模拟器及脚本
				gosub, 转移成号至临时文件夹
				goRun :=
				Sleep 1000
				run, % LdPath "\dnmultiplayer.exe"	;启动多开器
				WinWait, ahk_class LDMultiPlayerMainFrame
				gosub, 重启所有子脚本
				settimer, 窗口等检测, -10000
				return
			}
			else {	;不存在日常号
				settimer, 窗口等检测, -10
				return
			}		
		}
		else if (choLine1 = 3) {
			settimer, 窗口等检测, -10
			return
		}
	}
}
gotEdNum :=
;移动雷电模拟器各窗口
winmove, ahk_class LDMultiPlayerMainFrame, , 1180, 10
Loop 10 {
	if WINEXIST("RC" A_Index)
	{
		WinMove, % "RC" A_Index, , % 2 + (A_Index - 1) * 50, 10
		WinActivate, % "RC" A_Index
		sleep 1000
	}
}

SetTimer, 窗口等检测, -15000
return

重启所有子脚本:
loop %winNum%
{
	run, % a_workingdir "\RC" A_Index ".ahk"
	WinWait, % "GoRC" A_Index
	Sleep 200
	ggggg := % A_Index
	Loop {
		If !WINEXIST("GoRC" ggggg)
			break
	}
}
return

nextdayreload:
gosub, 关闭雷电模拟器及脚本
loop, % a_workingdir "\WorkAcc\*.acc", 0, 1	;删除临时账号文件
	FileDelete, % A_LOOPFILELONGPATH
sleep 500
goRun :=
gosub, ROE
return

转移成号至临时文件夹:
toDay := % A_YYYY A_MM A_DD
Loop, % ToFoPa "\3-成号\*.acc"
{	
	yuShu := % Mod(a_index, winNum)
	if yuShu
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" yuShu "\*.*", 1
	else
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" winNum "\*.*", 1
}
loop, read, % A_WORKINGDIR "\note\" toDay ".note"
{
	Alprdl := % A_LoopReadLine
	Loop, % a_workingdir "\WorkAcc\*.acc", 0, 1
	{
		if Alprdl = % A_LoopFileName
			Del_F(A_LoopFileLongPath)
	}
}
return

转移变身号至临时文件夹:
toDay := % A_YYYY A_MM A_DD
Loop, % ToFoPa "\8-变身\*.acc"
{
	yuShu := % Mod(a_index, winNum)
	if yuShu
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" yuShu "\*.*", 1
	else
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" winNum "\*.*", 1
}
loop, read, % A_WORKINGDIR "\note\" toDay ".note"
{
	Alprdl := % A_LoopReadLine
	Loop, % a_workingdir "\WorkAcc\*.acc", 0, 1
	{
		if Alprdl = % A_LoopFileName
			Del_F(A_LoopFileLongPath)
	}
}
return

转移日常号至临时文件夹:
toDay := % A_YYYY A_MM A_DD
Loop, % ToFoPa "\2-日常\*.acc"
{	
	yuShu := % Mod(a_index, winNum)
	if yuShu
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" yuShu "\*.*", 1
	else
		FileCopy, % A_LoopFileLongPath, % A_WorkingDir "\WorkAcc\" winNum "\*.*", 1
}
loop, read, % A_WORKINGDIR "\note\" toDay ".note"
{
	Alprdl := % A_LoopReadLine
	Loop, % a_workingdir "\WorkAcc\*.acc", 0, 1
	{
		if Alprdl = % A_LoopFileName
			Del_F(A_LoopFileLongPath)
	}
}
return



NumLock::
gosub, NLock
return

NLock:
SetTimer, 窗口等检测, Off
Loop 10 
	WinClose, % "GoZX" A_Index

gosub, 窗口等检测
return

成号优先:
GuiControlGet, CHYXM, , ChacNN 
IF (!CHYXM) {
	MsgBox, 当前不存在成号`n无法选择
	GuiControl, , yxR, 1
}
return

小号优先:
guiControlGet, XHYXM, , RcacNN 
if (!XHYXM) {
	MsgBox, 当前不存在日常号`n无法选择
	GuiControl, , yxC, 1
}
return

删除临时文件:
Del_F(A_WorkingDir "\RC*.ahk")	;删除ahk临时工作文件
Loop, % A_WORKINGDIR "\WorkAcc\*.acc", 0, 1	;删除临时账号
	Del_F(A_LoopFileLongPath)
loop, % A_WORKINGDIR "\note\*.note"		;删除前日日志文件
{
	gotname := % A_LoopFileName
	gotLP := % A_LoopFileLongPath
	toDaynote := % toDay ".note"
	if (gotname != toDaynote)
		Del_F(gotLP)
}
IfNotExist, % a_workingdir "\note"
	Cr_EmpFod(a_workingdir "\note")
IfNotExist, % a_workingdir "\note\" toDay ".note"
	Cr_EmpFil(a_workingdir "\note\" toDay ".note")
IfExist, % a_workingdir "\note\" toDay ".note"
{
	Loop, read, % a_workingdir "\note\" toDay ".note"
		NumOfTodayDone := % A_Index
	if NumOfTodayDone >= 2
		GuiControl, , jrwctd, % NumOfTodayDone - 1	
}
return

完善诸控件:
if (!fileexist(a_workingdir "\GoRC.cho")) {	;不存在选择日志
	;以下为单选项 成号/日常 工作优先级 
	if (FENumG(ToFoPa "\2-日常", "acc") and FENumG(ToFoPa "\3-成号", "acc"))		;默认为成号优先
		GuiControl, , yxC, 1
	else if (FENumG(ToFoPa "\2-日常", "acc") and !FENumG(ToFoPa "\3-成号", "acc"))	;若无成号，默认小号优先
		GuiControl, , yxR, 1
	else if (!FENumG(ToFoPa "\2-日常", "acc") and FENumG(ToFoPa "\3-成号", "acc"))	;若无小号，默认成号优先
		GuiControl, , yxC, 1
	;以下为商城选项，目前以商店选择为主
	guicontrol, , sdxz_x, |忽略商城|| ;商店选择
	guicontrol, , sdxz_x, 小精华 ;商店选择
	
	guicontrol, , TDBK, |忽略天帝||怒风猎手|小檀|后羿|牛魔|嫦娥 ;天帝选择
	
	;以下为魂兽选项
	guicontrol, , HSchos, |跳过转换|| ;魂兽选择
	guicontrol, , HSchos, 转真元 ;魂兽选择
	guicontrol, , HSchos, 转飞升 ;魂兽选择
	;以下为窗口选项，目前以7个窗口为主
	loop 10 {	;至多10个窗口
		if (a_index = 1) {
			guicontrol, , num_wingw, |1
		}
		else if (a_index = 7) {
			guicontrol, , num_wingw, % a_index "||"
		}
		else
			guicontrol, , num_wingw, % a_index 
	}
}
else {	;存在选择日志
	firG := getL(a_workingdir "\GoRC.cho", 1)	;第一行选择优先级，1为成号，2为小号0
	secG := getL(a_workingdir "\GoRC.cho", 2)	;第二行为商城选项	此处当在子脚本中以变量体现 ，1为忽略商城 2为大于77级查找小精华
	trdG := getL(a_workingdir "\GoRC.cho", 3)	;第三行为窗口数选项
	forG := getL(a_workingdir "\GoRC.cho", 4)	;第四行,超时重启
	fivG := getL(a_workingdir "\GoRC.cho", 5)	;第五行,忽略攻城战
	sixG := getL(a_workingdir "\GoRC.cho", 6)	;第六行,魂兽选择
	sevG := getL(a_workingdir "\GoRC.cho", 7)	;第七行,背包整理
	eigG := getL(a_workingdir "\GoRC.cho", 8)	;第八行,忽略仙盟
	ninG := getL(a_workingdir "\GoRC.cho", 9)	;第九行,忽略龙神
	tenG := getL(a_workingdir "\GoRC.cho", 10)	;第九行,退出仙盟
	elvG := getL(a_workingdir "\GoRC.cho", 11)	;第九行,退出仙盟
	tlvG := getL(a_workingdir "\GoRC.cho", 12)	;第九行,退出仙盟
	tirG := getL(a_workingdir "\GoRC.cho", 13)
	fotG := getL(a_workingdir "\GoRC.cho", 14) ;第十四行，天帝宝库
	fvtG := getL(a_workingdir "\GoRC.cho", 15)
	sxtG := getL(a_workingdir "\GoRC.cho", 16)
	setG := getL(a_workingdir "\GoRC.cho", 17)	;第十七行
	
	;超时及忽略攻城战选项
	if forG
		guicontrol, , OReload, 1
	else 
		guicontrol, , OReload, 0
	if fivG
		guicontrol, , GcUnDo, 1
	else
		guicontrol, , GcUnDo, 0
	if sevG
		guicontrol, , BBZL, 1
	else
		guicontrol, , BBZL, 0
	if eigG
		GuiControl, , xmUnD, 1
	else
		GuiControl, , xmUnD, 0
	if ninG
		GuiControl, , lmUnD, 1
	else
		GuiControl, , lmUnD, 0
	if tenG
		GuiControl, , txUnD, 1
	else
		GuiControl, , txUnD, 0
	if elvG
		GuiControl, , tpDH, 1
	else
		GuiControl, , tpDH, 0
	if tlvG
		GuiControl, , FSBoss, 1
	else
		GuiControl, , FSBoss, 0
	if tirG
		GuiControl, , lxjyUnD, 1
	else
		GuiControl, , lxjyUnD, 0
	
	if setG
		GuiControl, , JYUNDO, 1
	else
		GuiControl, , JYUNDO, 0
	
	if (fotG) {
		guicontrol, , TDBK, |忽略天帝||怒风猎手|小檀|后羿|牛魔|嫦娥 ;天帝选择
		guicontrol, , TDBK, % "|忽略天帝|怒风猎手|小檀|后羿|牛魔|嫦娥|" fotG "||" ;天帝选择
	}
	else
		guicontrol, , TDBK, |忽略天帝||怒风猎手|小檀|后羿|牛魔|嫦娥 ;天帝选择
	if fvtG
		GuiControl, , BSCE, 1
	else
		GuiControl, , BSCE, 0
	
	if (sxtG) {
		if FENumG(ToFoPa "\8-变身", "acc") and (firG = 3)
			GuiControl, , DFJJ, 1
	}
	else
		GuiControl, , DFJJ, 0
	;以下为单选项 成号/日常 工作优先级 
	if (FENumG(ToFoPa "\2-日常", "acc") and (firG = 2))	;若无成号，默认小号优先
		GuiControl, , yxR, 1
	else if FENumG(ToFoPa "\3-成号", "acc") and (firG = 1) 	;若无小号，默认成号优先
		GuiControl, , yxC, 1
	else if FENumG(ToFoPa "\8-变身", "acc") and (firG = 3)
		GuiControl, , yxB, 1
	else {
		if FENumG(ToFoPa "\2-日常", "acc")
			GuiControl, , yxR, 1
		else if FENumG(ToFoPa "\3-成号", "acc")
			GuiControl, , yxC, 1
		else if FENumG(ToFoPa "\8-变身", "acc")
			GuiControl, , yxB, 1
		else {
			MsgBox, 当前无账号存在，脚本将退出
			ExitApp
		}
			
	}
	;以下为商城选项，目前以商店选择为主
	guicontrol, , sdxz_x, |忽略商城|| ;商店选择
	guicontrol, , sdxz_x, 小精华 ;商店选择
	if secG = % "小精华"
		guicontrol, , sdxz_x, 小精华|| 
	;以下为魂兽选项
	guicontrol, , HSchos, |跳过转换|| ;魂兽选择
	guicontrol, , HSchos, 转真元 ;魂兽选择
	guicontrol, , HSchos, 转飞升 ;魂兽选择	
	if sixG = % "转真元"
		guicontrol, , HSchos, 转真元|| ;魂兽选择
	else if sixG = % "转飞升"
		guicontrol, , HSchos, 转飞升|| ;魂兽选择
	;以下为窗口选项，目前以7个窗口为主
	loop 10 {	;至多10个窗口
		if (a_index = 1) {
			guicontrol, , num_wingw, |1
		}
		else if (a_index = 7) {
			guicontrol, , num_wingw, % a_index "||"
		}
		else
			guicontrol, , num_wingw, % a_index 
	}
	if trdG
		guicontrol, , num_wingw, % trdG "||"
}
return

GuiClose:
ExitApp

检查账号文件:
if (!fileexist(ToFoPa "\2-日常\*.acc") and !fileexist(ToFoPa "\3-成号\*.acc") and !fileexist(ToFoPa "\8-变身\*.acc")) {	;若日常和成号文件夹中具无文件，退出
	msgbox, 未发现账号文件`n脚本将退出
	ExitApp
}
{ ;检查日常账号
guicontrol, , RcacNN, 0
theRcAcN := % FENumG(ToFoPa "\2-日常", "acc")
if theRcAcN
	guicontrol, , RcacNN, % theRcAcN
}
{ ;检查成号
guicontrol, , ChacNN, 0
theChAcN := % FENumG(ToFoPa "\3-成号", "acc")
if theChAcN
	guicontrol, , ChacNN, % theChAcN
}
{ ;检查变身号
guicontrol, , bsNN, 0
theBsAcN := % FENumG(ToFoPa "\8-变身", "acc")
if theBsAcN
	guicontrol, , bsNN, % theBsAcN
}


Loop 10 {	;创建10个临时空白文件夹
	Cr_EmpFod(a_workingdir "\WorkAcc\" a_index)
}
return

检查雷电多开器:
if (!FileExist(ToFoPa "\PathOfLD_x.path")) {	;检查是否存在雷电模拟器路径文件
	msgbox, 雷电模拟器路径不存在`n请于主控端设置路径`n当前脚本将退出
	ExitApp
	return
}
LdPath := getL(ToFoPa "\PathOfLD_x.path")	;获取雷电模拟器路径
if (!FileExist(LdPath "\dnmultiplayer.exe")) {	;检查是否存在雷电模拟器
	msgbox, 雷电模拟器路径错误`n脚本将无法运行`n请于主控端设置正确路径`n当前脚本将退出。
	ExitApp
	return
}
return

关闭雷电模拟器及脚本:
Loop 10 {	;关闭所有脚本
	winclose, % "GoRC" A_Index
}
ProExit("dnplayer.exe")
ProExit("LdBoxSVC.exe")
ProExit("VirtualBox.exe")
ProExit("dnmultiplayer.exe")

return


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     必要函数

delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}

FENumG(fod, EndN) { ;输出某文件夹下某种格式后缀文件数目
	loop, % fod "\*." EndN
		numgot := % A_Index
	return % numgot
}

Cr_EmpFod(fodLP) { 	;创建空白工作文件夹，若存在，则不创建
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

getL(filLP, linenum := 1) { ;获取某行字符串，无返回0
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

ProExit(proName) { ;关闭所有同名进程  
	loop
	{
		Process, Close, % proName
		sleep 100
		if !errorlevel
			break
	}
}

Del_F(filLP) { ;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
			FileDelete, % filLP
		IfNotExist, % filLP
			break
	}
}

Cr_AfterDel(tex, filLP) { ;创建文件前删除该文件确认后写入文本
	Loop {
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}	
	FileAppend, % tex, % filLP ,UTF-8
}	

Cr_EmpFil(filLP) { ;创建空白  文件  ,若存在文件，不动作
	IfNotExist, % filLP
	{
		FileAppend, , % filLP
		Loop {
			IfExist % filLP
				break
			sleep 20
		}
	}
}

gotNDT() {	;获取次日0时时间戳
	td := % A_Now
	EnvAdd, td, 1, Days
	StringTrimRight, td, td, 6
	td := % td "000000"
	return % td
}

gFLineN(filLP) {	;获取文件行数
	loop, read, % filLP
		linen := % A_Index
	return % linen
}

GTSubN(td) {	;获取一个时间戳与现在时间的差值，单位为秒
	EnvSub, td, %A_Now%, Seconds
	return % td
}

SStoHMS(sec) {	;将秒数转换为时 分 秒形式
	if (sec >= 3600) {
		bl := % sec / 3600
		hourN := % Ceil(bl) - 1
		toMin := % Mod(sec, 3600)
		if (toMin < 60) {
			MinN := "0"
			SecondN := % toMin
		}
		else {	
			bl1 := % toMin / 60
			MinN := % Ceil(bl1) - 1
			SecondN := % Mod(toMin, 60)
		}
		return % hourN " 时 " MinN " 分 " SecondN " 秒"
	}
	else if ((sec >= 60) and (sec < 3600)) {
		bl2 := % sec / 60
		MinN := % Ceil(bl2) - 1
		SecondN := % Mod(sec, 60)
		got := % MinN " 分 " SecondN " 秒"
		return % got
	}
	else if (sec < 60)
		return % SecondN " 秒"
}
;○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○
;○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○
;○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○
;○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○
;○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○