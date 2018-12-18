SNum := 8
winName := "RC8"
storeCho := "忽略商城"
OReload := 1
GcUnDo := 0
HSChos := "转真元"
BBZL := 1
xmUnD := 1
lmUnD := 0
txUnD := 0
tpDH := 1
FSBoss := 0
lxjyUnD := 1
global TDBK := % "忽略天帝"
BSCE := 1
DFJJ := 1
JYUNDO := 1
  
;真元绑元皆未弄字典
/*
SNum := 1
winName := % "RC" SNum
storeCho := "忽略商城"
OReload := 1
GcUnDo := 1
HSChos := "跳过转换"
BBZL := 1
xmUnD := 1
lmUnD := 1	;龙神佑体不做
txUnD := 1	;退出仙盟
tpDH := 1	;图谱兑换
FSBoss := 0
lxjyUnD := 1
global TDBK := "小檀"

BSCE := 1 	;变身嫦娥
DFJJ := 1	;巅峰竞技

JYUNDO := 1	;不做经验  
*/

{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先声明 / 1.顶部路径 2.大漠字典等
#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
setworkingdir %a_scriptdir%
ToFoPa := % delStrL(a_workingdir, 6)	;顶部路径

Loop {  ;关闭模拟器
    if (winexist(winName)) {
        WinClose, % winName
        Sleep 5000
    }
    else
        break
}

dm := ComObjCreate( "dm.dmsoft")
dm.SetPath(A_WorkingDir "\dmpic\")
dm.SetDict( 0, "RConly.txt")	;设定大漠字典
dm.SetDict( 1, "yao.txt")


dm.SetDict( 2, "rwbk.txt")	;人王等待时间
dm.SetDict( 3, "dwbk.txt")	;地王等待时间


x := ComVar(), y := ComVar()
}
{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     窗体属性 
gui, font, ceaedcd, 微软雅黑		;字体与颜色
Gui, Color, 161a17				;窗口颜色
Gui, -Caption -SysMenu +AlwaysOnTop
}
{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     不变文本 
Gui, Add, Text, x9 y27 w38 h16 , 等级：
Gui, Add, Text, x89 y27 w38 h16 , 绑元：
Gui, Add, Text, x169 y27 w38 h16 , 真元：
Gui, Add, Text, x59 y7 w38 h16 , 状态：
}
{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     主要控件 
Gui, Add, Text, vGUIWINNAME x9 y7 w38 h16 , WinN	;窗口名
Gui, Add, Text, vnowLevel x49 y27 w38 h16 , 0		;等级
Gui, Add, Text, x129 y27 w38 h16 , 0	;绑元
Gui, Add, Text, x209 y27 w38 h16 , 0	;真元
Gui, Add, Text, vstatusX x99 y7 w150 h16 , Waiting For command...	;状态
}
{ ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     首先启动游戏，至cancle或reload 
Loop {	;首先启动检查是否有残余窗口
	if (winexist(winName)) {
		WinClose, % winName
		sleep 200
	}
	else
		break
}

if (Mod(SNum, 2)) {	;单数窗口为单数
	winX := 100
	winY := % 683 + (Ceil(SNum / 2) - 1) * 53

}
else { ;窗口为双数，改变y
	winX := 358
	winY := % 683 + (SNum / 2 - 1) * 53
}
Gui, Show, x%winX% y%winY% h50 w253, Go%winName%
gosub, 首先启动游戏
Return
}

GuiClose:
ExitApp

首先启动游戏:
IF !qiehao
{ ;1.激活多开器
guiChan("启动模拟器", statusX)
WinActivate, ahk_class LDMultiPlayerMainFrame
muliR(SNum)
if SNum = 1
	nedwinname := "雷电模拟器"
else {
	nedwinnumgot := % SNum - 1
	nedwinname := % "雷电模拟器-" nedwinnumgot
}
winwait, %nedwinname%, , , RC
sleep 500
WinSetTitle, %nedwinname%, , %winName%, RC
sleep 1000
WinMove, % winName, , % 2 + (SNum - 1) * 50, 10
winIDF := dm.FindWindow("LDPlayerMainFrame", winName) ;父窗口ID
winIDS := dm.EnumWindow(winIDF, "TheRender","",1)	;子窗口ID 
dm.BindWindow(winIDS,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
GuiControl, , GUIWINNAME, % "RC" SNum
}
qiehao := 
;点击幻剑图标
guiChan("点击幻剑图标", statusX)
Loop {
	DmcliI("icon.bmp", dm, 500, 438, 29, 523, 112, "080808", 0.9)
	if DmPicR("dltb.bmp", dm, 500,317,608,387, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 40) 
		Reload	
}
guiChan("清空账号密码", statusX)
loop {
	DmMsCli( 492, 205, dm, 500)
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	DmMsCli( 516,247, dm, 500)
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if DmPicR("qksj.bmp", dm, 311,157,434,297, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	if (a_index >= 10) 
		Reload	
}
guiChan("获取账号密码", statusX)
if (fileexist(a_workingdir "\WorkAcc\" SNum "\*.acc")) {
	loop, % a_workingdir "\WorkAcc\" SNum "\*.acc"
	{
		if (a_index = 1) {
			nowGAPforZX := % A_LoopFileLongPath	;临时文件长路径，完成时删除
			nowGANforZX := % A_LoopFileName	;账号名，在1-主线中另有存档，完成时移动文件到2-日常
			goact := % getL(nowGAPforZX)	;获取账号名
			gopas := % getL(nowGAPforZX, 2)	;获取密码
		}
		break
	}
}
else {
	guiChan("该脚本结束,查询邻近文件夹", statusX)
	if Mod(SNum, 2)
		findAnother := % SNum + 1
	else
		findAnother := % SNum - 1
	loop, % a_workingdir "\WorkAcc\" findAnother "\*.acc"
		dlxxx := % A_Index
	if (dlxxx >= 3) {
		clxxx := % dlxxx - 1
		loop, % a_workingdir "\WorkAcc\" findAnother "\*.acc"
		{
			if (a_index = clxxx) {
				nowGAPforZX := % A_LoopFileLongPath	;临时文件长路径，完成时删除
				nowGANforZX := % A_LoopFileName	;账号名，在1-主线中另有存档，完成时移动文件到2-日常
				goact := % getL(nowGAPforZX)	;获取账号名
				gopas := % getL(nowGAPforZX, 2)	;获取密码
				FileMove, % nowGAPforZX, % A_WorkingDir "\WorkAcc\" SNum "\" nowGANforZX, 1
				break
			}
		}
	}
	else {
		Gui, Cancel
		Sleep 1000
		Gui, Show
		guiChan("该脚本任务结束", statusX)
		return
	}
}
guiChan("输入账号密码", statusX)
dm.SetKeypadDelay("windows", 50)
Loop {
	DmMsCli( 492, 205, dm, 700)	;账号位置
	dm.SendString(winIDS, goact) ;输入账号
	sleep 1500
	DmMsCli( 516,247, dm, 700)	;密码位置
	dm.SendString(winIDS, gopas)
	sleep 1500
	if (!DmPicR("zhem.bmp", dm, 310,161,461,231) and !DmPicR("mmem.bmp", dm, 332,222,461,287))
		break
	else
		gosub, 清除账号密码
	if (a_index >= 6) 
		Reload
}
guiChan("点击登录红钮", statusX)
Loop {
	DmcliI("dltb.bmp", dm, 500, 500,317,608,387)
	if DmPicR("dlyx.bmp", dm, 474, 421, 561, 475) and !DmPicR("xfwq.bmp", dm, 487,292,548,373)	;找到登录黄钮且无新服务器显示时
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 20) 
		Reload
}
guiChan("点击登录黄钮", statusX)
Loop {
	DmcliI("dlyx.bmp", dm, 800, 474, 421, 561, 475)
	DmcliI("khdjbbbcq.bmp", dm, 800, 547,319,590,347)	;客户端重启等
	DmcliI("icon.bmp", dm, 500, 438, 29, 523, 112, "080808", 0.9)	;点击幻剑图标
	DmcliI("dltb.bmp", dm, 500, 500,317,608,387)	;点击登录红钮
	if DmPicR("dtz.bmp", dm, 127,470,187,525) 	;正在读条
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 200
	if (a_index >= 120) 
		Reload
}
guiChan("等待读条结束", statusX)
Loop {
	if DmPicR("dtz.bmp", dm, 127,470,187,525)	;读条中
		sleep 500	
	if DmPicR("wlcw111.bmp", dm) {	;网络错误时
		sleep 1000
		Reload
	}
	if (DmPicR("bb.bmp", dm, 890,206,952,267) or !DmPicR("dtz.bmp", dm, 127,470,187,525))
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 80) 
		Reload	
}
guiChan("即将进行主要流程", statusX)
Gui, Cancel
Sleep 1000
Gui, Show
SetTimer, 主要流程, -300
return

清除账号密码:
loop {
	DmMsCli( 492, 205, dm, 500)
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	DmMsCli( 516,247, dm, 500)
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if DmPicR("qksj.bmp", dm, 311,157,434,297, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	if (a_index >= 10) 
		Reload	
}
return



liuCheng( NowPro,ByRef proX, ByRef STATU) {	;一次性流程函数
	proX := % NowPro
	guiChan(proX, STATU)
	gosub, 关闭所有无用界面
	gosub, 查询等级
	gosub, % proX
	
}
查询等级:
dm.UseDict(0)		;设定引用字典，引用前需声明字典文件
DmStrSerch := dm.Ocr(19, 13, 84, 104, "d6dee1-121212|c1ccd0-131313|acbac0-101010|96a6ae-101010|f2f6f6-101010", 0.9)	;搜索到背包，查询等级
if DmStrSerch
{
	DJLONG := StrLen(DmStrSerch)
	IF DJLONG != 1
		guicontrol, , nowLevel, % DmStrSerch
}
return


主要流程:


liuCheng("领取福利", nowPro, statusX)
if (!xmUnD) and (!txUnD) and (!FSBoss)
	liuCheng("仙盟", nowPro, statusX)
if (txUnD) and (!FSBoss)
	liuCheng("退出仙盟", nowPro, statusX)

if tpDH
	liuCheng("图谱兑换", nowPro, statusX)

if !lmUnD
	liuCheng("龙神佑体", nowPro, statusX)

if BBZL 
	liuCheng("背包整理", nowPro, statusX)



liuCheng("魂兽", nowPro, statusX)	;魂兽任务

if HSChos = % "转真元"
	liuCheng("御魂", nowPro, statusX)	;吃元宝

else if HSChos = % "转飞升"
	liuCheng("转飞升", nowPro, statusX)	;转飞升经验

if FSBoss and !CantFSBoss
	liuCheng("飞升Boss", nowPro, statusX)	;转飞升经验

if cXMStore
	liuCheng("查询仙盟状态", nowPro, statusX)	;转飞升经验

if TJMZHY 
{
	liuCheng("删除所有好友", nowPro, statusX)
	liuCheng("添加盟主好友", nowPro, statusX)	;转飞升经验
	liuCheng("等待仙盟邀请", nowPro, statusX)	;转飞升经验	
	liuCheng("存入仙盟仓库", nowPro, statusX)	;转飞升经验	
	liuCheng("删除所有好友", nowPro, statusX)
	liuCheng("退出仙盟", nowPro, statusX)

}
else
	liuCheng("退出仙盟", nowPro, statusX)



cXMStore :=
CantFSBoss := 
TJMZHY :=
if storeCho = % "小精华"
	liuCheng("商城购买小精华", nowPro, statusX)	;商城购买小精华

;liuCheng("节日活动", nowPro, statusX)	;劳动节等

liuCheng("攻城战", nowPro, statusX)	;攻城战，大致等级为65以上

if !lxjyUnD
	liuCheng("离线挂机", nowPro, statusX)	;离线挂机

if BSCE
	liuCheng("变身嫦娥", nowPro, statusX)	;变身嫦娥

if TDBK != % "忽略天帝"
	liuCheng("天帝宝库", nowPro, statusX)	;离线挂机
if DFJJ 
	liuCheng("检查巅峰段位", nowPro, statusX)	;离线挂机

SetTimer, 切号, -300
return

变身嫦娥:
GuiControlGet, nowLevel, , nowLevel
loop {
	if nowLevel < 80
		break
	if !DmPicR("bsiconn.bmp", dm, 812,409,859,453)
		DmcliO(925, 303, "yxjmxs.bmp", dm, 1300, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliI("bsiconn.bmp", dm, 800, 812,409,859,453)	;点击变身icon1
	DmcliI("bsicon2.bmp", dm, 800, 804,294,842,342)	;点击变身icon2
	DmcliI("bsicon3.bmp", dm, 800, 834,302,875,336)	;点击变身icon3
	if !DmPicR("ceicony.bmp", dm, 46,144,82,178) and DmPicR("bsjmddddd.bmp", dm, 22,3,104,31) {		;变身界面下未搜到嫦娥选项，下拉左侧并点击嫦娥
		if DmPicR("ceiconbrown.bmp", dm, 34,131,55,150)		;有嫦娥头像，点击嫦娥头像
			DmcliI("ceiconbrown.bmp", dm, 800, 34,131,55,150)	;点击嫦娥头像
		else {	;无嫦娥头像，下拉左侧
			DmMsDrag(9,178, dm, 13,292, 1500)
			DmMsCli(55,137, dm, 800)
		}
	}
	if (DmPicR("cespyxicon.bmp", dm, 792,432,834,470) and DmPieR(835, 436, 872, 460, "c11c28-050505", dm, 0.9)) { 	;数字为红时
		if DmPicR("cejjtbxxxxx.bmp", dm, 797,488,831,513) {
			gosub, 转移账号至8变身
			break
		}
		if DmPicR("cejhannnnn.bmp", dm, 800,487,836,517)	;激活图标
			break
	}
			
	
	if DmPicR("cespyxicon.bmp", dm, 792,432,834,470) and DmPieR(833,435,902,461, "0b7d0b-050505", dm, 0.9)	;数字为绿时
		DmcliI("cejhannnnn.bmp", dm, 800,800,487,836,517)	;激活图标
	DmcliI("cejhcgtc.bmp", dm, 800,630,363,668,395)	;激活成功弹窗确认图标
	if DmPicR("cejjtbxxxxx.bmp", dm, 797,488,831,513) {	;进阶图标
		gosub, 转移账号至8变身
		break
	}
	if DmPicR("cewcicondddddd.bmp", dm, 63,124,87,143) {	;嫦娥图标为彩色
		gosub, 转移账号至8变身
		break		
	}
	if !DmPicR("bsjmddddd.bmp", dm, 22,3,104,31) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)	;无变身界面和背包
		gosub, 关闭所有无用界面
	if (DmPicR("bsjmddddd.bmp", dm, 22,3,104,31) 
	and !DmPicR("cejjtbxxxxx.bmp", dm, 797,488,831,513) 
	and !DmPicR("cejhannnnn.bmp", dm, 797,488,831,513)) {
		gosub, 关闭所有无用界面
	}
	sleep 200
	if a_index >= 80
	{
		if OReload
			Reload
		else
			guiChan("警告,变身流程卡点", statusX)
	}	
	
}
return

转移账号至8变身:
if !fileexist(ToFoPa "\8-变身\" nowGANforZX )
{
	if fileexist(ToFoPa "\3-成号\" nowGANforZX)
		FileMove, % ToFoPa "\3-成号\" nowGANforZX, % ToFoPa "\8-变身\" nowGANforZX, 1
}

return


检查巅峰段位:
Loop {
	guiChan("检查巅峰段位", statusX) 
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	DmcliI("djdfjj.bmp", dm, 800, 868,147,898,157)	;点击巅峰竞技
	DmcliI("djdwsd.bmp", dm, 800, 40,64,61,95)	;点击段位商店
	if DmPicR("dfjjwdw.bmp", dm, 229, 353, 288, 371) {	;巅峰竞技无段位
		gosub, 关闭巅峰界面
		gosub, 报名参赛
		gosub, 等待巅峰开始
		gosub, 等待巅峰结束
		return
	}
	else if (DmPicR("qteddw.bmp", dm, 221,349,268,379) or DmPicR("qteddw2.bmp", dm, 219,346,269,380)) {	;巅峰等级为青铜，点击购买后return
		loop 3 {
			DmcliI("djybgmr.bmp", dm, 800, 507,259,547,278)	;点击元宝购买
			DmcliI("djgmgreen.bmp", dm, 800, 459,380,520,410)	;点击元宝购买绿钮
			sleep 300
		}
		return
	}
	
	if !DmPicR("dfjjjm.bmp", dm, 13,4,103,30) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)		;不在巅峰竞技界面也无背包时候
		gosub, 关闭所有无用界面
	
	sleep 300
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告,检查巅峰段位卡点", statusX)
	}	
	
}
return

关闭巅峰界面:
nowPro := % "关闭巅峰界面"
Loop {
	guiChan("关闭巅峰界面", statusX) 
	DmcliO(920,37, "dfjjjm.bmp", dm, 800, 13,4,103,30)	;关闭巅峰界面
	if !DmPicR("dfjjjm.bmp", dm, 13,4,103,30) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)
		gosub, 关闭所有无用界面
	if DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)	;搜索到背包
		break
	sleep 300
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告,关闭巅峰界面卡点", statusX)
	}	
}
return



报名参赛:
nowPro := % "报名参赛"
Loop {
	guiChan("报名参赛", statusX) 
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	DmcliI("djdfjj.bmp", dm, 800, 868,147,898,157)	;点击巅峰竞技
	DmcliI("wybmmmmm.bmp", dm, 1500, 318,426,367,452)	;点击报名参赛
	DmcliI("qdbmmmmm.bmp", dm, 1000, 260,191,589,527)	;点击报名确定
	if DmPicR("ghbsssss.bmp", dm, 109,429,177,452) 	;搜索到切换变身
		break
	if !DmPicR("dfjjjm.bmp", dm, 13,4,103,30) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)
		gosub, 关闭所有无用界面
	
	sleep 300

	
}
return


等待巅峰开始:
nowPro := % "等待巅峰开始"
bmjs := % A_Now
Loop {
	guiChan("等待巅峰开始", statusX) 
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	DmcliI("djdfjj.bmp", dm, 800, 868,147,898,157)	;点击巅峰竞技
	if DmPicR("jrsccccc.bmp", dm, 315,426,361,453) { 	;搜索到进入赛场
		break
	}
	if !DmPicR("dfjjjm.bmp", dm, 13,4,103,30) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)
		gosub, 关闭所有无用界面
	
	sleep 300
	
	if (GNSubT(bmjs) > 4200) {
		donexxxxx := 1
		break
	}
		
}
return

等待巅峰结束:
nowPro := % "等待巅峰结束"
loop {
	if donexxxxx
		break
	if (GNSubT(bmjs) > 4200) {
		donexxxxx := 1
		break
	}	
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	DmcliI("djdfjj.bmp", dm, 800, 868,147,898,157)	;点击巅峰竞技
	DmcliI("jrsccccc.bmp", dm, 800, 315,426,361,453)	;点击进入赛场
	DmcliO(920,37, "dfjjjm.bmp", dm, 800, 13,4,103,30)	;关闭巅峰界面
	gosub, 关闭所有无用界面
	sleep 5000
}
bmjs :=
donexxxxx := 
return


天帝宝库:
GuiControlGet, nowLevel, , nowLevel
loop {
	if nowLevel < 78
		break
	if DmPicR("tdbkjmn.bmp", dm, 49,2,103,31) {	;天帝宝库界面下
		if DmPicR("tdbkleftbbbbb.bmp", dm,16,194,99,250) {	;天帝左侧为空
			if !tdleftblank
				tdleftblank := 1
			else
				tdleftblank := % tdleftblank + 1
			sleep 1000
		}
		else
			tdleftblank :=
	}
	
	if tdleftblank > 3
		Reload
	
	
	if (!timeWaiting) {
		DmcliI("dbtc1.bmp", dm, 1200, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
		guiChan("天帝宝库查询", statusX) 
		
		;1.点击天帝icon 2.点击天帝第二icon 3.点击所需确认选项卡
		;4.确认选项卡时 5. 判定结果 6.时间到，点击 7.时间未到，保存时间,timeWaiting := 
		
		DmcliI("tdicon1.bmp", dm, 800, 665,72,782,90, "080808", 0.7)	;点击天帝宝库icon1
		DmcliI("tdbkicon1.bmp", dm, 800, 603,113,833,124, "080808", 0.7)	;点击天帝宝库弹窗icon1
		
		DCTDT("怒风猎手", "u1nf.bmp", dm, 600, 0, 100, 150, 560, "080808", 0.8)	;怒风猎手
		DCTDT("小檀", "u2xt.bmp", dm, 600, 0, 100, 150, 560, "080808", 0.8)	;小檀
		DCTDT("后羿", "u3hy.bmp", dm, 600, 0, 100, 150, 560, "080808", 0.8)	;后羿
		DCTDT("牛魔", "u4nm.bmp", dm, 600, 0, 100, 150, 560, "080808", 0.8)	;牛魔
		DCTDT("嫦娥", "u5ce.bmp", dm, 600, 0, 100, 150, 560, "080808", 0.8)	;嫦娥
		
		if (TDPICR("怒风猎手", "d1nf.bmp", dm, 0, 100, 150, 560, "080808", 0.8)
		or TDPICR("小檀", "d2xt.bmp", dm, 0, 100, 150, 560, "080808", 0.8)
		or TDPICR("后羿", "d3hy.bmp", dm, 0, 100, 150, 560, "080808", 0.8)
		or TDPICR("牛魔", "d4nm.bmp", dm, 0, 100, 150, 560, "080808", 0.8)
		or TDPICR("嫦娥", "d5ce.bmp", dm, 0, 100, 150, 560, "080808", 0.8)) {
			cTimeN := 1
		}
		else
			cTimeN :=
		

		if (cTimeN) {	;当在确认页面时，进行主要流程
			if DmPicR("dhbkjfblue.bmp", dm, 493,456,530,482) { 		;当天帝宝库为绿时

				if DmPicR("tdbktcxh.bmp", dm, 467,396,557,449, "020202", 0.9) {	;天帝宝库退出信号
					sleep 200
					loop 6 {
						if DmPicR("tdbktcxh.bmp", dm, 467,396,557,449, "010101", 0.9)
						{
							if !plmmddd
								plmmddd := 1
							else
								plmmddd := % plmmddd + 1
							sleep 300
						}
						else
							plmmddd :=
						sleep 300
					}
				}
				if plmmddd > 2
					break
				plmmddd :=

				if DmPicR("bcmftdaa.bmp", dm, 492,495,544,515)		;地王的本次免费字样
					DmMsCli(519,471, dm, 1200)	;点击地王解封一次
				else {
					dm.UseDict(3)
					sleep 100
					;地王宝库
					gotTimeW := dm.Ocr(477,408,513,441, "9ea9ad-020202|cfd5d7-020202|e3e8e9-020202|d8dddf-020202|c5ccce-020202|bbc3c6-020202|a3acb1-020202|a8b2b5-020202|c9d0d2-020202|b7bfc2-020202", 0.8)	
					if (gotTimeW) {
						TOSWait := % TAddS(gotTimeW * 60)
						timeWaiting := 1						
					}
					else {
						TOSWait := % TAddS(20)
						timeWaiting := 1							
					}
				}
			}
			if DmPicR("dhbkjfbrown.bmp", dm, 477,456,523,482) {	;当天帝宝库为灰时，
				;1搜索左侧免费字样，有，点击左侧领取，无查询剩余时间
				if DmPicR("rwbkblank.bmp", dm, 250,405,328,439)		;人王部分白色
					DmMsCli(231, 470, dm, 1200)
				if DmPicR("bcmftdd.bmp", dm, 193,494,263,515)	;本次免费字样
					DmMsCli(231, 470, dm, 1200)		;点击人王解封一次

				else {
					dm.UseDict(2)
					sleep 100
					;人王宝库的字样
					gotTimeW := dm.Ocr(249,406,289,440, "f5f9f9-020202|a1abae-020202|d5dbdc-020202|d1d7d8-020202|c1c8ca-020202|9ea8ab-020202|c5cdcf-020202|e8eced-020202|909da0-020202|d8dedf-020202", 0.8)
					if (gotTimeW) {
						TOSWait := % TAddS(gotTimeW * 60)
						timeWaiting := 1
					}
					else {
						TOSWait := % TAddS(20)
						timeWaiting := 1						
					}
				}
			}
		}
		DmcliI("hdwp1.bmp", dm, 800, 455, 143, 556, 249)	;中心位置获得物品 - 单排（通用）
	}
	
	else {
		guiChan("天帝等待：" GNSubT(TOSWait), statusX) 
		DmcliI("hdwp1.bmp", dm, 800, 455, 143, 556, 249)	;中心位置获得物品 - 单排（通用）
		DmcliO(921,29, "tdbkjmn.bmp", dm, 800, 49,2,103,31)	;关闭天帝宝库
		
		
		if GNSubT(TOSWait) > 1 
			timeWaiting := 
		if !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)
			gosub, 关闭所有无用界面
		sleep 500
	}
	sleep 200
	if !DmPicR("tdbkjmn.bmp", dm, 49,2,103,31) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)		;未搜图到天帝宝库界面或未搜到背包界面
		gosub, 关闭所有无用界面
}
plmmddd := 
return                                                                                                                                                                                                                                     
;一次性函数，判断类型大漠点击
DCTDT(tdType ,picName, ByRef dmF, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.8) {
	if tdType = % TDBK
	{
		x := ComVar(), y := ComVar()
		gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
		gotEL := % gotEL + 1
		if (gotEL) {
			DmMsCli(x[], y[], dmF)
			Sleep, % slept
		}
		else
			sleep 2
	}
}

TDPICR(tdType, picName, ByRef dmF, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.8) {
	if tdType = % TDBK
	{
		gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
		gotEL := % gotEL + 1
		if (gotEL) {
			Sleep 3
			return 1
		}
		else {
			Sleep 2
			return 0
		}
	}
}

图谱兑换:
loop {
	guiChan("图谱兑换", statusX) 
	GuiControlGet, nowLevel, , nowLevel
	if nowLevel < 80
		break
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	DmcliI("thhdicon.bmp", dm, 500, 731, 72, 775, 120)	;特惠活动icon	
	DmcliI("tetpdhbq.bmp", dm, 800, 198, 152, 241, 175)	;图谱兑换标签页	
	
	DmcliI("tetpdhbq2.bmp", dm, 800, 180, 203, 233, 229)	;图谱兑换标签页2	
	
	if (DmPicR("tpdhred.bmp", dm, 183, 147, 227, 176) or DmPicR("tpdhred2.bmp", dm, 179, 204, 229, 233)) {	;图谱兑换为红色

		if !DmPicR("tphsdh.bmp", dm, 668, 337, 688, 358)	;未搜图到魂兽丹，上拉
			DmMsDrag(577, 190, dm, 579, 283, 800)
		else {
			if DmPicR("thhsydh.bmp", dm, 710, 336, 743, 366) or DmPieR(332, 380, 562, 391, "db5b59-070707", dm, 0.8)  	;2处判定，一是无卡片，二是领取完毕，直接break
				break
			else {
				if !tppppp
					tppppp := 1
				else
					tppppp := tppppp + 1
				loop 10
					DmMsCli(725,376, dm, 250)
			}
		}
	}
	if tppppp >= 7
		break
	if DmPicR("thhdjm.bmp", dm, 435, 39, 489, 58) {	;特惠活动界面下
		if !DmPicR("thhdbt.bmp", dm, 822, 235, 847, 472)		;未搜到右边边条
			gosub, 关闭所有无用界面
	}
	if !DmPicR("thhdjm.bmp", dm, 435, 39, 489, 58) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)		;不在特惠活动且无背包
		gosub, 关闭所有无用界面
	Sleep 100
	if a_index >= 80
	{
		if OReload
			Reload
		else
			guiChan("警告,图谱兑换卡点", statusX)
	}
}
tppppp :=
return

背包整理:
Loop {
	guiChan("背包整理", statusX) 
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	DmcliI("sywp1.bmp", dm, 800, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliI("jsicon.bmp", dm, 800, 259, 440, 470, 530, "080808", 0.8)	;点击角色icon
	DmcliI("bbddd.bmp", dm, 800, 900, 213, 942, 260, "080808", 0.7)	;背包图标图标
	DmcliI("jsjmbbls.bmp", dm, 800, 3, 145, 80, 226, "080808", 0.8)	;角色界面背包为蓝色
	
	if (DmPicR("jsjmx.bmp", dm, 36, 1, 122, 41) 	;角色界面	
	and DmPicR("jsbbjmyb.bmp", dm, 885, 230, 925, 313)	;右侧
	and DmPicR("jsjmzltb.bmp", dm, 819, 460, 863, 507)) {	;整理图标
		DmcliI("jsjmzltb.bmp", dm, 1200, 819, 460, 863, 507, "080808", 0.8)	;角色界面背包为蓝色
		if !cacal 
			cacal := 1
		else
			cacal := % cacal + 1
	}
	
	else
		gosub, 关闭所有无用界面
	
	if (cacal >= 3) {
		cacal := 
		break
	}
	sleep 300
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告,背包整理卡点", statusX)
	}
	
}
return


领取福利:
/*	;日常签到被取消流程
guiChan("领取福利1：签到奖励", STATU)
Loop {	;领取福利1：签到奖励
	;通用点击
	DmcliI("dlyx.bmp", dm, 800, 474, 421, 561, 475)	;显示顶部界面（通用）
	
	;主要流程	
	DmcliI("flicon.bmp", dm, 800, 251, 2, 844, 139)	;点击福利图标1
	if (DmPicR("qdred.bmp", dm, 173,94,227,132, "090909", 0.8))	{;搜图到签到奖励
		DmPieCli(359, 138, 373, 425, "147686-050505", dm, 800)	;第 1列搜索
		DmPieCli(459, 140, 481, 427, "147686-050505", dm, 800)	;第 2列搜索
		DmPieCli(559, 139, 579, 426, "147686-050505", dm, 800)	;第 3列搜索
		DmPieCli(666, 137, 686, 425, "147686-050505", dm, 800)	;第 4列搜索
		DmPieCli(770, 137, 789, 426, "147686-050505", dm, 800)	;第 5列搜索
		if DmPieR(323, 139, 826, 425, "268d38-101010", dm)	;整个范围找到绿色
			break
	}
}
if (DmPicR("qdred.bmp", dm, 173,94,227,132, "090909", 0.8))	{	;签到流程结束后, 搜图到签到奖励
	loop 2
		DmMsCli(373, 465, dm, 50)	;签到2天
	loop 2
		DmMsCli(467, 466, dm, 50)	;签到5天
	loop 2
		DmMsCli(575, 466, dm, 50)	;签到10天
	loop 2
		DmMsCli(575, 466, dm, 50)	;签到17天
	loop 2
		DmMsCli(766, 468, dm, 50)	;签到26天
}
*/

Loop {
	if JYUNDO
		break
	guiChan("领取福利1：离线经验", statusX)
	;通用点击
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	;主要流程	
	DmcliI("flicon.bmp", dm, 800, 251, 2, 844, 139, "101010", 0.7)	;点击福利图标1
	DmcliI("flicon2.bmp", dm, 800, 268, 11, 849, 135, "101010", 0.7)	;点击福利图标2
	
	DmcliI("lxjy.bmp", dm, 800, 114, 72, 314, 206, "080808", 0.7)	;点击离线经验
	if (DmPicR("lxjyx.bmp", dm, 151, 73, 278, 199, "101010", 0.6)) {	;搜到红色离线经验字样
		DmPieCli(688, 249, 757, 271, "259028-010101", dm, 800) ;若领取范围为绿色，则点击绿色，若为灰色，break直到下一流程
		if DmPieR(688, 249, 757, 271, "656565-010101", dm)	;为灰色
			break
	}
	if !DmPicR("fljm.bmp", dm, 437, 40, 523, 83)	;未查询到福利界面，gosub
		gosub, 关闭所有无用界面
	;超时判断
	sleep 300
	if ((a_index > 15) and DmPicR("fljm.bmp", dm, 437, 40, 523, 83))
	{
		DmMsDrag(237, 160, dm, 237, 250, 1500)
	}
	if a_index >= 60
	{
		if OReload
			Reload
		else
			guiChan("警告,福利-离线经验卡点", statusX)
	}
}

loop {
	guiChan("领取福利2：成就", statusX)
	;主要流程	
	DmcliI("flcj1.bmp", dm, 800, 154, 124, 283, 254, "101010", 0.7)	;点击福利 - 成就
	if (DmPicR("flcjred.bmp", dm, 168, 119, 278, 266, "101010", 0.7)) {	;福利成就为红
		DmPieCli(715, 134, 773, 156, "259028-010101", dm, 100)	;第1格
		DmPieCli(712, 245, 777, 266, "259028-010101", dm, 100)	;第2格
		DmPieCli(716, 359, 774, 379, "259028-010101", dm, 100)	;第3格
		DmPieCli(714, 473, 775, 493, "259028-010101", dm, 100)	;第4格
		qw1 := % DmPieR(720, 150, 779, 168, "208999-020202", dm)	;1前往
		qw2 := % DmPieR(718, 262, 779, 283, "208999-020202", dm)	;2前往
		qw3 := % DmPieR(721, 374, 777, 395, "208999-020202", dm)	;3前往
		qw4 := % DmPieR(722, 486, 776, 500, "208999-020202", dm)	;4前往
		if (qw1 and qw2 and qw3 and qw4)
			break
	}
	sleep 800
	DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	DmcliI("flicon.bmp", dm, 800, 251, 2, 844, 139, "101010", 0.7)	;点击福利图标1
	DmcliI("flicon2.bmp", dm, 800, 268, 11, 849, 135, "101010", 0.7)	;点击福利图标2
	if !DmPicR("fljm.bmp", dm, 437, 40, 523, 83)	;未查询到福利界面，gosub
		gosub, 关闭所有无用界面
	;通用点击
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	;超时判断
	sleep 200
	if a_index >= 60
	{
		if OReload
			Reload
		else
			guiChan("警告！福利-成就卡点", statusX)
	}
}
loop 4 
	qw%A_Index% :=  

loop {
	guiChan("领取福利3：等级礼包", statusX)
	;主要流程	
	DmcliI("fldjlb.bmp", dm, 800, 155, 238, 287, 311, "080808", 0.8)	;点击福利 - 等级礼包
	if (DmPicR("fljm.bmp", dm, 437, 40, 523, 83)) {	;在福利界面下,未找到等级礼包选项
		if (!DmPicR("fldjlb.bmp", dm, 437, 40, 523, 83) and !DmPicR("fldjlbred.bmp", dm, 169, 246, 283, 307)) {
			if !djlbx 
				djlbx := 1
			else
				djlbx := % djlbx + 1
			if djlbx >= 3
				break
		}
	}
	else 
		gosub, 关闭所有无用界面
	if (DmPicR("fldjlbred.bmp", dm, 169, 246, 283, 307)) {	;在等级礼包界面下
		DmPieCli(692, 132, 702, 160, "259028-010101", dm)
		DmPieCli(692, 245, 702, 287, "259028-010101", dm)
		DmPieCli(692, 351, 702, 399, "259028-010101", dm)
		DmPieCli(690, 460, 702, 512, "259028-010101", dm)
		Sleep 1000
		DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
		DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
		if (!DmPieR(692, 132, 702, 160, "259028-010101", dm) and !DmPieR(682, 245, 698, 287, "259028-010101", dm) and !DmPieR(692, 351, 702, 399, "259028-010101", dm) and !DmPieR(690, 460, 702, 512, "259028-010101", dm))
			break
	}
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	DmcliI("flicon.bmp", dm, 800, 251, 2, 844, 139, "101010", 0.7)	;点击福利图标1
	DmcliI("flicon2.bmp", dm, 800, 268, 11, 849, 135, "101010", 0.7)	;点击福利图标2
	;超时判断，直接跳过
	sleep 200
	if a_index >= 10
		break
}
djlbx := 

Loop {
	if JYUNDO
		break
	guiChan("领取福利4：资源找回", statusX)
	DmcliI("flzyzh.bmp", dm, 800, 161, 341, 277, 421, "080808", 0.8)	;福利资源找回空白
	DmcliI("flzyzh2.bmp", dm, 800, 165, 403, 280, 475, "080808", 0.8)	;福利资源找回空白2
	DmcliI("flzyzhdjkbc.bmp", dm, 800, 168, 360, 275, 406, "080808", 0.8)	;福利资源找回空白3
	if (DmPicR("flzyzhred.bmp", dm, 176, 349, 269, 409) or DmPicR("flzyzhred2.bmp", dm, 169, 418, 285, 464)) {
		DmcliI("flzyzhqbmf.bmp", dm, 800, 533, 451, 658, 523, "080808", 0.8)	;福利资源找回免费
		if (DmPieR(542, 472, 567, 478, "646464-020202", dm) or DmPicR("flzyzhmfb.bmp", dm, 559, 461, 645, 517)) {
			break
		}
	}
	if DmPicR("flzyzhmfb.bmp", dm, 559, 461, 645, 517)
		break
	DmcliI("flzyzhqbmf.bmp", dm, 800, 533, 451, 658, 523, "080808", 0.8)	;福利资源找回免费
	DmcliI("flzyzhqr.bmp", dm, 800, 500, 334, 642, 412, "080808", 0.8)	;福利资源找回确认
	;福利通用
	if !DmPicR("fljm.bmp", dm, 437, 40, 523, 83)	;若不在福利界面下
		gosub, 关闭所有无用界面
	DmcliI("flicon.bmp", dm, 800, 251, 2, 844, 139, "101010", 0.7)	;点击福利图标1
	DmcliI("flicon2.bmp", dm, 800, 268, 11, 849, 135, "101010", 0.7)	;点击福利图标2	
	;超时判断，直接跳过
	sleep 500
	if a_index >= 10
		DmPieCli(541, 472, 559, 479, "259028-000000", dm, 500)	;若为绿色，则点击
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告,福利-资源找回卡点", statusX)
	}
}

Loop {
	;主要流程	
	guiChan("领取福利5：邮件领取", statusX)
	DmcliI("flyj1.bmp", dm, 800, 188, 401, 257, 464, "080808", 0.8)	;福利邮件空白1
	DmcliI("flyj2.bmp", dm, 800, 187, 461, 257, 523, "080808", 0.8)	;福利邮件空白1
	if (DmPicR("flyj3.bmp", dm, 188, 466, 260, 524) or DmPicR("flyj5.bmp", dm, 184, 404, 258, 463) or DmPicR("flyjdez2.bmp", dm, 182, 412, 262, 469)) {	;在邮件界面下
		
		DmPieCli(765, 474, 788, 492, "157e8a-101010", dm, 800)
		if DmPieR(762, 470, 800, 476, "555555-010101", dm)	;若领取位置为灰色
			break
	}
	if DmPicR("yjqblq2.bmp", dm, 711, 442, 845, 530)	;邮件全部领取为灰色
		break
	
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	;福利通用
	if !DmPicR("fljm.bmp", dm, 437, 40, 523, 83)	;若不在福利界面下
		gosub, 关闭所有无用界面
	DmcliO(920,281, "lkcz1.bmp", dm, 500, 678, 446, 850, 533)	;关闭右下活动弹窗，前往参与 1
	DmcliO(917,279, "qwcy2.bmp", dm, 500, 699, 458, 842, 529)	;关闭右下活动弹窗，前往参与 2
	DmcliI("flicon.bmp", dm, 800, 251, 2, 844, 139, "101010", 0.7)	;点击福利图标1
	DmcliI("flicon2.bmp", dm, 800, 268, 11, 849, 135, "101010", 0.7)	;点击福利图标2	
	;超时判断
	sleep 500
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告,福利-邮件卡点", statusX)	
	}
}
return

仙盟:

Loop {
	guiChan("仙盟流程", statusX)
	;通用点击
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	DmcliO(925, 303, "yxjmxs.bmp", dm, 1200, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	;主要流程
	DmcliI("xmicon.bmp", dm, 800, 541, 421, 864, 531, "080808", 0.8)	;仙盟图标
	DmcliO(767, 73, "xmjxdx.bmp", dm, 800, 417, 34, 551, 98, "080808", 0.8)	;仙盟捐献界面
	if DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)	;搜图到仙盟界面
		DmPieClO(199, 46, 220, 63, "c43440-080808", 194, 81, dm, 800)	;点击仙盟福利
	if (DmPicR("xmksjr.bmp", dm, 624, 362, 845, 505)) {	;搜图到仙盟快速加入
		DmMsCli(736, 444, dm, 500)	;点击快速加入
		DmMsCli(923, 34, dm, 500)	;点击关闭
		break
	}
	else if !DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)
		gosub, 关闭所有无用界面
	if (DmPicR("xmflylq.bmp", dm, 134, 43, 250, 126)) {	;图为仙盟福利已领取
		DmMsCli(923, 34, dm, 500)
		break
	}
	;超时判断
	sleep 500
	if a_index >= 40
	{
		if OReload
			Reload
		else
			guiChan("警告！仙盟卡点", statusX)
	}
}
return

退出仙盟:
loop {
	guiChan("退出仙盟", statusX)
	DmcliO(767, 73, "xmjxdx.bmp", dm, 800, 417, 34, 551, 98, "080808", 0.8)	;仙盟捐献界面
	DmcliO(925, 303, "yxjmxs.bmp", dm, 1200, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliI("xmicon.bmp", dm, 800, 541, 421, 864, 531, "080808", 0.8)	;仙盟图标
	if (DmPicR("xmksjr.bmp", dm, 624, 362, 845, 505)) {	;搜图到仙盟快速加入
		DmMsCli(923, 34, dm, 500)	;点击关闭
		break
	}
	if DmPicR("tcxmccc.bmp", dm, 164, 479, 257, 533) {
		if !txerror
			txerror := 1
		else
			txerror := % txerror + 1
		DmcliI("tcxmccc.bmp", dm, 800, 164, 479, 257, 533)	;退出仙盟
	}
	if txerror > 5
		break
	DmcliO(574, 336, "tcxmcc2.bmp", dm, 800, 411, 201, 488, 247)	;退出仙盟确认
	DmcliO(561, 337, "tcxmqd22222.bmp", dm, 800, 330,208,378,241)	;退出仙盟再确认
	DmcliI("xmczddd.bmp", dm, 800, 156, 483, 254, 524)	;点击仙盟操作
	DmcliI("jsxmxxx.bmp", dm, 800, 156, 435, 258, 472)	;点击解散仙盟
	DmcliO(581, 346, "jsxmddd.bmp", dm, 800, 412, 200, 486, 240)	;解散仙盟确认
	DmcliO(581, 346, "jsxmdd2.bmp", dm, 800, 362, 208, 437, 245)	;解散再次确认
	if !DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36) 
	or !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7) {
		gosub, 关闭所有无用界面
	}
	sleep 200
	if a_index >= 15
		break
}
return


龙神佑体:
GuiControlGet, nowLevel, , nowLevel
Loop {
	guiChan("龙神佑体", statusX)
	if nowLevel < 50
		break
	DmcliI("yylmicon.bmp", dm, 500, 319, 42, 447, 152, "101010", 0.8)	;点击鱼跃龙门icon
	DmcliI("yylmicon2.bmp", dm, 500, 274, 44, 376, 154, "080808", 0.8)	;点击鱼跃龙门icon2
	DmcliI("yylmicon3.bmp", dm, 500, 417, 69, 485, 130, "080808", 0.8)	;点击鱼跃龙门icon3
	DmcliI("yylmicon5.bmp", dm, 500, 342, 50, 637, 142, "080808", 0.7)	;点击鱼跃龙门icon5
	DmcliI("yylmlshy.bmp", dm, 500, 803, 371, 890, 465)	;点击龙神护佑
	DmcliI("yylsjl.bmp", dm, 1000, 250, 391, 392, 468)	;点击领取奖励
	DmcliI("hdwp1.bmp", dm, 600, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	if (DmPicR("yylshyred.bmp", dm, 809, 357, 895, 460)) {	;龙神佑体红色钮
		if DmPieR(289, 412, 316, 421, "727272-010101", dm)
			break
	}
	else
		gosub, 关闭所有无用界面
	;超时判断
	sleep 200
	if a_index >= 15
		break
	
}
return



魂兽:
loop {
	guiChan("魂兽", statusX)
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliI("jsicon.bmp", dm, 800, 259, 440, 470, 530, "080808", 0.8)	;点击角色icon
	DmcliI("jsfsqx.bmp", dm, 800, 337, 295, 439, 364)	;飞升80级开启，弹窗
	DmcliI("jssxicon.bmp", dm, 800, 7, 89, 80, 153)	;点击属性框格
	DmcliI("jshsicon.bmp", dm, 800, 146, 451, 237, 532)	;点击魂兽icon
	DmcliI("jshsttb.bmp", dm, 800, 1, 218, 68, 278)	;点击魂兽吞天白格
	if (DmPicR("jshsttred.bmp", dm, 1, 206, 80, 285, "080808", 0.8)) {	;吞天为红色时
		if !DmPicR("jshsjiahao.bmp", dm, 547, 248, 624, 325, "080808", 0.8)
			DmcliI("jshstsdj.bmp", dm, 800, 651, 475, 737, 529, "080808", 0.8)	;提升等级
		DmcliI("jshsjiahao.bmp", dm, 1000, 547, 248, 624, 325, "080808", 0.8)	;点击加号
	}
	if DmPicR("jshsfr.bmp", dm, 310, 362, 467, 431, "080808", 0.8)	;在放入界面中
	{
		sleep 1500
		if DmPicR("jshsblank.bmp", dm, 221, 129, 269, 176, "010101", 1)	;第一格为空白，直接break
			break
		else	;点击第一格不为空则点击
			DmMsCli(248, 156, dm, 500)
		gosub, 魂兽弹窗检测
		if !DmPicR("jshsblank.bmp", dm, 317, 133, 362, 174, "010101", 1)	;第二格不为空
			DmMsCli(344, 155, dm, 500)
		gosub, 魂兽弹窗检测
		if !DmPicR("jshsblank.bmp", dm, 408, 125, 463, 179, "010101", 1)	;第三格
			DmMsCli(439, 156, dm, 500)
		gosub, 魂兽弹窗检测
		if !DmPicR("jshsblank.bmp", dm, 504, 126, 559, 177, "010101", 1)	;第四格
			DmMsCli(531, 154, dm, 500)
		gosub, 魂兽弹窗检测
		if !DmPicR("jshsblank.bmp", dm, 222, 217, 271, 263, "010101", 1)	;第五格
			DmMsCli(244, 241, dm, 500)
		gosub, 魂兽弹窗检测
		if !DmPicR("jshsblank.bmp", dm, 313, 214, 368, 264, "010101", 1)	;第六格
			DmMsCli(341, 243, dm, 500)
		gosub, 魂兽弹窗检测
		if !DmPicR("jshsblank.bmp", dm, 407, 213, 464, 268, "010101", 1)	;第七格
			DmMsCli(439, 241, dm, 500)
		gosub, 魂兽弹窗检测
		if !DmPicR("jshsblank.bmp", dm, 407, 213, 464, 268, "010101", 1)	;第八格
			DmMsCli(531, 242, dm, 500)
		gosub, 魂兽弹窗检测
		sleep 1000
	}
	DmcliI("jshsfr.bmp", dm, 500, 310, 362, 467, 431, "080808", 0.8)	;点击放入
	if !DmPicR("jsjmx.bmp", dm, 36, 1, 122, 41) and !DmPicR("jshsjm.bmp", dm, 34, 1, 122, 39) and !DmPicR("jshsttred.bmp", dm, 310, 362, 467, 431)
		gosub, 关闭所有无用界面
	;超时判断
	
	if ((a_index > 20) and DmPicR("jshsjm.bmp", dm, 34, 1, 122, 39)) {	;	魂兽界面下纠错
		DmMsDrag(32, 229, dm, 32, 290, 1500)
	}
	sleep 200
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！魂兽吃装卡点", statusX)	
	}
}

return

转飞升:
GuiControlGet, nowLevel, , nowLevel
Loop {
	if nowLevel < 80
		break
	guiChan("转飞升", statusX)
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliI("jsicon.bmp", dm, 800, 259, 440, 470, 530, "080808", 0.8)	;点击角色icon
	DmcliI("jshsyh.bmp", dm, 800, 5, 285, 62, 337)	;点击御魂
	if DmPicR("jshsyh1dy5.bmp", dm, 653, 183, 718, 233) or DmPicR("jshssycsl.bmp", dm, 812, 485, 881, 532)	;低于5级时，剩余次数为0时
		break
	if DmPicR("jshsyhred.bmp", dm, 3, 283, 64, 342)		;在红色御魂钮界面 
	{
		DmPieCli(788, 429, 834, 441, "17858e-020202", dm, 800)	;转换钮像素点击
		if DmPieR(783, 352, 791, 370, "6c6c6c-010101", dm)
			break
	}
	else
		gosub, 关闭所有无用界面
	DmcliI("jshsxwzh.bmp", dm, 800, 776, 415, 850, 453)	;点击转换
	
	if DmPicR("jshsdhxwg.bmp", dm, 320, 358, 391, 392) {		;兑换界面
		if !xwdhaj
			xwdhaj := 1
		else
			xwdhaj := % xwdhaj + 1
		DmcliI("jshsdhxwg.bmp", dm, 800, 320, 358, 391, 392)	;点击弹窗兑换
	}
	if xwdhaj >= 3
	{
		DmcliO(761, 87,"jshsdhxwg.bmp", dm, 800, 320, 358, 391, 392)	;关闭兑换界面
		break
	}
	if DmPicR("hsxwdhwc.bmp", dm, 374, 399, 440, 435) {		;兑换3次完成
		DmcliO(761, 87,"jshsdhxwg.bmp", dm, 800, 320, 358, 391, 392)	;关闭兑换界面
		break
	}
	DmcliO(601, 348, "jshsdhqd.bmp", dm, 800, 483, 243, 534, 267)	;魂兽兑换确认
	DmcliO(588, 347, "jshsxwzhdq2.bmp", dm, 800, 446,228,520,257)	;魂兽兑换确认2
	sleep 200
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！魂兽吃装卡点", statusX)	
	}
}
gosub, 检查飞升情况
return

检查飞升情况:

nowPro := % "检查飞升"
gosub, 关闭所有无用界面
loop {
	guiChan("检查飞升情况", statusX)
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliO(601, 348, "jshsdhqd.bmp", dm, 800, 483, 243, 534, 267)	;魂兽兑换确认
	DmcliO(588, 347, "jshsxwzhdq2.bmp", dm, 800, 446,228,520,257)	;魂兽兑换确认2
	if !DmPicR("blackfs.bmp", dm, 29,3,92,33)		;不在飞升界面下的兑换被关闭
		DmcliO(761, 87,"jshsdhxwg.bmp", dm, 800, 320, 358, 391, 392)	;关闭兑换界面
	DmcliI("jsicon.bmp", dm, 800, 259, 440, 470, 530, "080808", 0.8)	;点击角色icon
	
	DmcliI("fsiconn.bmp", dm, 800, 349, 485, 382, 535)	;点击飞升icon
	
	DmcliI("djfsccc.bmp", dm, 800, 451, 473, 517, 504)	;点击飞升绿钮
	
	DmcliI("djfscli.bmp", dm, 800, 666, 361, 702, 395)	;飞升成功弹窗
	DmcliI("fsjyzhqdxx.bmp", dm, 800, 545,328,623,364)	;飞升转换确定钮
	
	if (DmPicR("blackfs.bmp", dm, 29,3,92,33) and DmPicR("fsonlyfor.bmp", dm, 260, 180, 298, 223)) {	;飞升仅4级
		DmcliO(761, 87,"jshsdhxwg.bmp", dm, 800, 320, 358, 391, 392)	;关闭兑换界面
		CantFSBoss := 1
		break
	}
	if DmPicR("fsjmddd.bmp", dm, 30, 3, 85, 33) {	;飞升界面下
		if DmPieR(273, 430, 399, 451, "cf1e2b-060606", dm, 0.8)	;飞升修为为红
			break
	}
	
	if DmPicR("fslsan2.bmp", dm, 303, 477, 332, 502) {	;1到2级飞升绿钮
		if DmPieR(273,430,342,449, "5bcd41-050505", dm, 0.8)	;1级到2级飞升修为为绿
			DmcliI("fslsan2.bmp", dm, 800, 303, 477, 332, 502)
	}
	
	if (!DmPicR("fsjmddd.bmp", dm, 30, 3, 85, 33) ;飞升界面
	and !DmPicR("jshsdhxwg.bmp", dm, 320, 358, 391, 392)	;魂兽兑换
	and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) {	;背包icon
		gosub, 关闭所有无用界面
	}
	sleep 200
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！检查飞升卡点", statusX)	
	}
}
return

御魂:
loop {
	guiChan("御魂吃元宝", statusX)
	DmcliI("jshsyh.bmp", dm, 800, 5, 285, 62, 337)	;点击御魂
	if DmPicR("jshsyh1dy5.bmp", dm, 653, 183, 718, 233) or DmPicR("jshssycsl.bmp", dm, 812, 485, 881, 532)	;低于5级时，剩余次数为0时
		break
	if  DmPicR("jshsyhred.bmp", dm, 3, 283, 64, 342)		;在红色御魂钮界面 
	{
		DmPieCli(788, 429, 834, 441, "17858e-020202", dm, 800)	;转换钮像素点击
		if DmPieR(783, 352, 791, 370, "6c6c6c-010101", dm)
			break
	}
	else
		gosub, 关闭所有无用界面
	DmcliI("jshszhyb.bmp", dm, 800, 769, 329, 872, 404)	;点击转换
	DmcliI("jshsxhjyqd.bmp", dm, 800, 518, 324, 643, 368)	;御魂转换确定
	DmcliI("jsicon.bmp", dm, 800, 259, 440, 470, 530, "080808", 0.8)	;点击角色icon
	;超时判断
	sleep 200
	if ((a_index > 10) and DmPicR("jshsjm.bmp", dm, 34, 1, 122, 39))
	{
		if DmPieR(54, 219, 63, 237, "35243b-010101", dm)
			DmMsCli(33, 304, dm, 50)
	}
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！御魂元宝卡点", statusX)	
	}
}
return

飞升Boss:

GuiControlGet, nowLevel, , nowLevel
bossN := 1
loop {
	if nowLevel < 80
		break
	guiChan("飞升Boss战", statusX)
	DmcliI("tttttc.bmp", dm, 800, 421,418,468,457)		;退出战斗
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	if DmPicR("fsgrslred.bmp", dm, 16,68,46,95) {	;个人首领为红时
		if !DmPicR("jrtzbrown.bmp", dm, 725,405,758,427) and !DmPicR("jrtzgren.bmp", dm, 725,404,761,428)		;未搜到进入挑战灰或绿
			gosub, 关闭所有无用界面
	}
	if (!unZDZ) {
		guiChan("飞升Boss界面检查", statusX)
		DmcliI("jzbossicon.bmp", dm, 800, 874, 75, 895, 95)		;点击激战bossicon
		DmcliI("grslgreen.bmp", dm, 800, 22, 68, 55, 93)		;点击个人首领
		if DmPicR("fsgrslred.bmp", dm, 16,68,46,95)	{	;个人首领为红时
			if !DmPicR("fsbf1red.bmp", dm, 224,99,256,128) and !DmPicR("fsbf1whi.bmp", dm, 227, 114, 255, 148) ;未搜图到飞升1红或白
				DmMsDrag(299,126, dm, 344,321, 1000)
			if (bossN = 1) {	;检查飞升1时
				DmcliI("fsbf1whi.bmp", dm, 800, 227, 114, 255, 148)		;点击1号首领白
				if DmPicR("fsbf1red.bmp", dm, 224,99,256,128) {		;1号首领为红时
					
					if DmPicR("jrtzbrown.bmp", dm, 725,405,758,427) 		;进入挑战为灰色
						bossN := 2
					else
						DmcliI("jrtzgren.bmp", dm, 5000, 725,404,761,428)		;点击进入挑战绿
				}
			}
			if (bossN = 2) {	;检查飞升2
				DmcliI("fsbf2whi.bmp", dm, 800, 228, 190, 248, 220)		;点击2号首领白
				if DmPicR("fsbf2red.bmp", dm, 226,187,251,218) {		;2号首领为红时
					
					if DmPicR("jrtzbrown.bmp", dm, 725,405,758,427) 		;进入挑战为灰色
						bossN := 3
					else
						DmcliI("jrtzgren.bmp", dm, 5000, 725,404,761,428)		;点击进入挑战绿					
				}
			}
			if (bossN = 3) {
				DmcliI("fsbf3whi.bmp", dm, 800, 230, 280, 254, 301)		;点击3号首领白
				if DmPicR("fsbf3red.bmp", dm, 228, 276, 253, 295) {		;3号首领为红时
					
					if DmPicR("jrtzbrown.bmp", dm, 725,405,758,427) 		;进入挑战为灰色
						bossN := 5
					else
						DmcliI("jrtzgren.bmp", dm, 7000, 725,404,761,428)		;点击进入挑战绿										
				}
			}
			

		}

	}
	if DmPicR("zdztcan.bmp", dm, 203, 151, 311, 254) {	;在战斗中
		cXMStore := 1
		guiChan("战斗中", statusX)
		DmcliI("gbwgjz.bmp", dm, 800, 839, 298, 866, 322)		;改变状态为挂机中
		unZDZ := 1
	}
	if (DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7) and !DmPicR("zdztcan.bmp", dm, 240,183,278,222)) {	;有背包，无战斗中
		sleep 2000
		if (DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7) and !DmPicR("zdztcan.bmp", dm, 240,183,278,222))
			unZDZ :=
	}
	else if DmPicR("zdztcan.bmp", dm, 240,183,278,222) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)
		gosub, 关闭所有无用界面
	
	if bossN = 5	;所有查询完毕
		break
	
	if (!DmPicR("bossdtdx.bmp", dm, 22, 3, 146, 36)		;不在激战boss界面
	and !DmPicR("zdztcan.bmp", dm, 240,183,278,222)	;不在战斗中
	and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) {
		gosub, 关闭所有无用界面
	}
	
	DmcliO(925,36, "bossdtdx.bmp", dm, 500, 22, 3, 146, 36)
	sleep 200
	if a_index >= 5000
	{
		if OReload
			Reload
		else
			guiChan("警告！飞升boss卡点", statusX)	
	}
}
bossN :=
return

查询仙盟状态:
if DmPicR("zdztcan.bmp", dm, 203, 151, 311, 254) {	;在战斗中

	cXMStore := 1
	guiChan("战斗中", statusX)
	DmcliI("gbwgjz.bmp", dm, 800, 839, 298, 866, 322)		;改变状态为挂机中
	unZDZ := 1
	liuCheng("飞升Boss", nowPro, statusX)	;转飞升经验
}

Loop {
	guiChan("查询仙盟状态", statusX)
	;通用点击
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	DmcliO(925, 303, "yxjmxs.bmp", dm, 1200, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	;主要流程
	DmcliI("xmicon.bmp", dm, 800, 541, 421, 864, 531, "080808", 0.8)	;仙盟图标
	DmcliO(767, 73, "xmjxdx.bmp", dm, 800, 417, 34, 551, 98, "080808", 0.8)	;仙盟捐献界面
	if DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)	;搜图到仙盟界面
		DmPieClO(199, 46, 220, 63, "c43440-080808", 194, 81, dm, 800)	;点击仙盟福利
	if (DmPicR("xmksjr.bmp", dm, 624, 362, 845, 505)) {	;搜图到仙盟快速加入
		TJMZHY := 1
		DmMsCli(923, 34, dm, 500)	;点击关闭
		break
	}
	else if !DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)
		gosub, 关闭所有无用界面
	if (DmPicR("xmflylq.bmp", dm, 134, 43, 250, 126)) {	;图为仙盟福利已领取
		DmMsCli(923, 34, dm, 500)
		break
	}
	;超时判断
	sleep 500
	if a_index >= 40
	{
		if OReload
			Reload
		else
			guiChan("警告！飞升后仙盟卡点", statusX)
	}
}
return
删除所有好友:
loop {
	guiChan("清空好友列表", statusX)
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）	
	DmcliI("mzhy.bmp", dm,800, 731, 300, 769, 336)	;点击好友
	DmcliI("mzsj.bmp", dm,800, 815, 469, 855, 508)	;点击社交
	DmcliI("mzhy.bmp", dm,800, 731, 300, 769, 336)	;点击好友
	DmcliI("mzhyxxk.bmp", dm, 800, 707, 107, 745, 160)	;点击好友选项卡
	if DmPicR("mzhyxxr.bmp", dm, 710, 106, 752, 160) {	;选项卡为红色时
		if !DmPicR("mzhywr.bmp", dm, 372, 267, 416, 310)
			DmMsCli(316, 93, dm, 800)
	}
	DmcliI("mzschy.bmp", dm, 800, 523, 324, 570, 367)	;删除好友
	DmcliI("schy222d.bmp", dm, 800, 377,355,446,388)	;删除好友2
	DmcliI("mzschyqd.bmp", dm, 800, 527, 315, 566, 347)	;确认删除好友
	
	if (!DmPicR("mzhyjm.bmp", dm, 435, 30, 470, 59) ;不在好友界面
	and !DmPicR("mzschyqd.bmp", dm, 527, 315, 566, 347)  ;没有删除确定按钮
	and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) {	;无背包
		gosub, 关闭所有无用界面
	}
	if DmPicR("mzhywr.bmp", dm, 372, 267, 416, 310) {	;当前无好友
		DmMsCli(711, 50, dm, 800)
		break
	}

	sleep 200
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！删除好友卡点", statusX)
	}

}

return

添加盟主好友:
MZname := % getL(a_workingdir "\MZN.ned", SNum)
Loop {
	guiChan("添加盟主好友", statusX)
	DmcliO(925, 303, "yxjmxs.bmp", dm,800, 884, 260, 959, 338, "080808", 0.7)	;打开底部栏
	DmcliI("mzhy.bmp", dm, 800, 731, 300, 769, 336)	;点击好友
	DmcliI("mzsj.bmp", dm,  800, 815, 469, 855, 508)	;点击社交	
	DmcliI("sshymza.bmp", dm,  800, 710,265,746,324)	;点击搜索选项卡	
	if DmPicR("sshymzb.bmp", dm, 703,266,752,319) {	;搜索为红时
		if DmPicR("blankleft.bmp", dm, 275,69,319,116)		;左为空白
			DmMsCli(301, 90, dm, 600)		;点击空白处
	}
	if !DmPicR("blanktop.bmp", dm, 23,13,48,81) and DmPicR("blanktop.bmp", dm, 165,19,182,81)	;有字部分为空白，固定空白部分为判定输入框弹出
		DmMsCli(275,90, dm, 500)	
	

	if DmPicR("blanktop.bmp", dm, 23,13,48,81) {		;当搜索到有字部分白，输入盟主名字
		dm.SendString(winIDS, MZname)
		sleep 800
		DmMsCli(275,109, dm, 500)	
	}
	if DmPicR("sshymzb.bmp", dm, 703,266,752,319) and !DmPicR("blankleft.bmp", dm, 275,69,319,116)		;搜索为红时，左边不为白时，点击搜索
		DmcliI("ssandjjjjj.bmp", dm,  800, 620,77,684,113)	;点击搜索	
	DmcliI("hyqmddj.bmp", dm,  800, 344,165,430,194)		;点击亲密度
	
	if DmPicR("schy222d.bmp", dm, 377,355,446,388)	;发现删除好友时
		break
	;DmcliI("schy222d.bmp", dm, 800, 377,355,446,388)	;删除好友2
	if DmPicR("tjwhydjan.bmp", dm, 382,298,446,343) {	;添加为好友按钮
		if !tjhydd
			tjhydd := 1
		else
			tjhydd := % tjhydd + 1
		DmcliI("tjwhydjan.bmp", dm,  800, 382,298,446,343)	;点击添加好友按钮
	}
	if tjhydd and !Mod(tjhydd, 3) {
		sleep 5000
		DmcliI("mzhyxxk.bmp", dm, 800, 707, 107, 745, 160)	;点击好友选项卡
	}
	if DmPicR("mzhyxxr.bmp", dm,710, 106, 752, 160) {	;好友选项卡为红色时
		if DmPicR("hyxxkqmd.bmp", dm, 348,115,395,135)	;亲密度
			hyhavedone := 1
	}
	if hyhavedone
		break
	if (!DmPicR("mzhyxxr.bmp", dm,710, 106, 752, 160) 
	and !DmPicR("mzhyxxk.bmp", dm, 707, 107, 745, 160)	
	and !DmPicR("blanktop.bmp", dm, 23,13,48,81)
	and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) { ;没发现好友，顶部输入框，背包
		gosub, 关闭所有无用界面
	}
	
	sleep 200
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！飞升后仙盟卡点", statusX)
	}

}
DmcliO(635,132, "schy222d.bmp", dm,800, 377,355,446,388)
tjhydd :=
hyhavedone := 
return

等待仙盟邀请:
DmcliO(635,132, "schy222d.bmp", dm,800, 377,355,446,388)	;打开底部栏
loop {
	guiChan("等待仙盟邀请", statusX)
	dm.UseDict(1)	
	wordYou := dm.FindStr(4,339,667,535, "邀", "c9f2f4-080808|d0f9fc-080808|b2d8db-080808|c3ebed-080808|88aab2-080808", 0.7, x.ref, y.ref)
	wordYou := % wordYou + 1
	if wordYou {
		DmMsCli(x[] + 12, y[] + 12, dm, 800)
	}	
	if DmPicR("yqjrxmjjn.bmp", dm,356,325,431,354) {	;拒绝钮 
		DmcliO(569,342, "yqjrxmjjn.bmp", dm, 800, 356,325,431,354)	;拒绝钮，按加入
		break
	}
	
	if !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7) and !DmPicR("yqjrxmjjn.bmp", dm,356,325,431,354)
		gosub, 关闭所有无用界面
	sleep 300
	if a_index >= 1000
	{
		if OReload
			Reload
		else
			guiChan("警告！等待仙盟卡点", statusX)
	}	
	
}
return

存入仙盟仓库:
loop {
	guiChan("存入仙盟仓库", statusX)
	;通用点击
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249, "101010", 0.7)	;中心位置获得物品 - 单排（通用）
	DmcliO(925, 303, "yxjmxs.bmp", dm, 1200, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	;主要流程
	DmcliI("xmicon.bmp", dm, 800, 541, 421, 864, 531, "080808", 0.8)	;仙盟图标
	DmcliO(767, 73, "xmjxdx.bmp", dm, 800, 417, 34, 551, 98, "080808", 0.8)	;仙盟捐献界面	
	if (DmPicR("xmksjr.bmp", dm, 624, 362, 845, 505)) 	;搜图到仙盟快速加入
		break

	if DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)	;搜图到仙盟界面
		DmPieClO(199, 46, 220, 63, "c43440-080808", 194, 81, dm, 800)	;点击仙盟福利
	if (DmPicR("xmflylq.bmp", dm, 134, 43, 250, 126)) {	;图为仙盟福利已领取
		if !fllqqqqq
			fllqqqqq := 1
	}
	if fllqqqqq
	{
		if DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)	;仙盟界面下
		{
			if !DmPicR("xmckkkkk.bmp", dm, 12,243,53,269) and !DmPicR("xmckhhhhh.bmp", dm, 15,240,51,267)	;没搜到仙盟仓库绿或红
				DmMsDrag(39,178, dm, 32,347, 800)
			DmcliI("xmckkkkk.bmp", dm, 800, 12,243,53,269)
			if DmPicR("xmckhhhhh.bmp", dm, 15,240,51,267) {	;仙盟仓库为红色
				if DmPicR("plcqdjddd.bmp", dm, 756,468,825,489) { 	;搜图至批量存入时
					if !DmPicR("tstoreblank.bmp", dm, 553,115,612,170)	;第一格不为空白，点击第一格
						DmMsCli(580,131, dm, 800)
				}
			}
		}


		if DmPicR("tstoreblank.bmp", dm, 553,115,612,170) {	;第一格为空白时
			break
		}
	}
	if DmPicR("crandjjjjj.bmp", dm, 452,387,519,420) {	;发现存入按钮
		DmcliI("djzdddddd.bmp", dm, 800, 548,236,625,277)	;点击最大
		DmcliI("crandjjjjj.bmp", dm, 800, 452,387,519,420)	;点击存入
	}
	if !DmPicR("crandjjjjj.bmp", dm, 452,387,519,420) and !DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36) and !DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)
		gosub, 关闭所有无用界面
	
	sleep 300
	if a_index >= 100
	{
		if OReload
			Reload
		else
			guiChan("警告！仙盟仓库卡点", statusX)
	}
	
}
fllqqqqq :=
return


商城购买小精华:
GuiControlGet, nowLevel, , nowLevel 
Loop {
	if nowLevel < 78
		break
	if nowLevel > 95
		break
	guiChan("购买小精华", statusX)
	DmcliO(918, 312, "xdfbhdtcdxx.bmp", dm, 500, 722, 318, 830, 358)	;vip1，新的副本活动弹窗点x
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliI("hjstoreicon.bmp", dm, 800, 859,450,947,526)	;点击商城icon
	if DmPicR("hjstorejm.bmp", dm, 401, 36, 448, 72)	;发现商城界面
	{
		sleep 500
		;若发现高级变身精华，点击购买，否则下拉，元宝不足时退出
		if !DmPicR("gjbsjhtubiao.bmp", dm, 502, 117, 549, 159)	;未查找到高级变身精华图标
			DmMsDrag(148, 452, dm, 145, 120, 1200)
		DmcliO(718, 212, "gjbsjhtubiao.bmp", dm, 800, 502, 117, 549, 159)	;发现图标点击购买
	}
	else
		gosub, 关闭所有无用界面
	DmcliO(301, 416, "hjstoreqr.bmp", dm, 800, 521, 122, 587, 184)	;计算器界面关闭
	if DmPicR("hjstoregm.bmp", dm, 418, 359, 546, 427) and DmPicR("hjstoregmgjbs.bmp", dm, 412, 146, 554, 185)
		DmMsCli(483, 392, dm, 1000)	;发现购买以及高级变身精华字样，点击购买坐标
	if DmPicR("lkczhjstore.bmp", dm, 427, 311, 494, 355)	;立刻充值字样
		break
	sleep 100
	if a_index >= 60
	{
		if OReload
			Reload
		else
			guiChan("警告！商城小精华卡点", statusX)	
	}
}
return


魂兽弹窗检测:
if (DmPicR("jshsfrrl.bmp", dm, 498, 298, 647, 368)) {	;放入熔炉界面
	DmcliO(493, 281, "jshshq.bmp", dm, 1500, 460, 256, 522, 308)	;点击灰圈
	DmcliO(572, 330, "jshsfrrlgou.bmp", dm, 1000, 457, 251, 526, 314)	;打钩后放入熔炉
}
return

攻城战:
guicontrolget, nowLevel, , nowLevel
loop {
	if nowLevel < 65
		break
	guiChan("攻城战首界面查询", statusX)
	;通用点击
	DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	;主要流程
	DmcliI("gczicon.bmp", dm, 800, 254, 4, 591, 72, "101010", 0.7)	;点击攻城战icon
	DmcliI("gczicon2.bmp", dm, 800, 324, 4, 646, 71, "101010", 0.7)	;点击攻城战icon2
	if DmPicR("gczjm.bmp", dm, 35, 1, 121, 38) {	;攻城战界面
		sleep 500
		if !DmPicR("wcglgczyc.bmp", dm, 812, 206, 917, 286)	;卫城攻略
			DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
		if DmPieR(195, 374, 214, 387, "c2303d-020202", dm)	;首位
			DmMsCli(184, 390, dm, 5)
		else
			GC1None := 1
		if DmPieR(448, 375, 472, 387, "c2303d-020202", dm)	;次位
			DmMsCli(437, 385, dm, 5)
		else
			GC2None := 1
		if DmPieR(629, 376, 654, 386, "c2303d-020202", dm)	;三位
			DmMsCli(621, 386, dm, 5)
		else
			GC3None := 1
		if DmPieR(815, 374, 834, 389, "c2303d-020202", dm)	;肆位
			DmMsCli(799, 387, dm, 5)
		else
			GC4None := 1
	}
	else
		gosub, 关闭所有无用界面
	DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("cdwpandj1.bmp", dm, 500, 873, 217, 960, 325)	;点击穿戴物品
	DmcliO(918, 39, "sjdwjljm.bmp", dm, 800, 48, 3, 162, 44)	;赛季段位奖励关闭
	if DmPicR("wygwtc.bmp", dm, 420, 348, 540, 399)	{ ;我要鼓舞界面
		DmcliI("wygwtc.bmp", dm, 800, 420, 348, 540, 399)	;点击我要鼓舞
		if DmPicR("wygwtc.bmp", dm, 420, 348, 540, 399)
			DmMsCli(660, 137, dm, 5)
	}
	if GC1None and GC2None and GC3None and GC4None
		break
	;超时选项
	sleep 200
	if a_index >= 30
	{
		if OReload
			Reload
		else
			guiChan("警告！攻城首界面卡点", statusX)
	}
}
GC1None := 
GC2None := 
GC3None := 
GC4None := 
loop {
	if GcUnDo
		break
	if nowLevel < 65
		break
	guiChan("段位等级奖励", statusX)
	DmcliI("gczicon.bmp", dm, 800, 254, 4, 591, 72, "101010", 0.7)	;点击攻城战icon
	DmcliI("gczicon2.bmp", dm, 800, 324, 4, 646, 71, "101010", 0.7)	;点击攻城战icon2
	DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249)	;中心位置获得物品 - 单排（通用）
	DmcliI("sjdwandj.bmp", dm, 800, 593, 46, 745, 101)	;点击赛季段位按钮
	if DmPicR("sjdwjljm.bmp", dm, 48, 3, 162, 44) and DmPicR("sjdwcbk.bmp", dm, 856, 202, 884, 332)	;找到赛季段位界面和右侧边框
	{
		if !DmPieR(787, 134, 793, 486, "157a88-020202", dm)	{ ;找不到蓝色按钮
			if !huadong
				huadong := 1
			else
				huadong := % huadong + 1
			if huadong >= 9
				break
			else
				DmMsDrag(776, 410, dm, 776, 400, 1800)
		}
		else
			DmPieCli(787, 134, 793, 486, "157a88-020202", dm, 500)
	}
	else {
		gosub, 关闭所有无用界面
	}
	if !DmPicR("gczjm.bmp", dm, 35, 1, 121, 38) and !DmPicR("sjdwjljm.bmp", dm, 48, 3, 162, 44)
		gosub, 关闭所有无用界面
	;超时判断
	sleep 50
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！段位等级卡点", statusX)
	}
}
huadong := 
return

离线挂机:
loop {
	guiChan("离线挂机", statusX)
	loop 2
		DmcliI("lxgjgmjm.bmp", dm, 800, 414, 365, 549, 427, "080808", 0.8)	;点击购买按钮
	DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("lxgjicon.bmp", dm, 800, 545, 116, 937, 201, "080808", 0.7)	;点击离线挂机图标
	
	DmcliI("lxgjicon6.bmp", dm, 800, 481, 120, 817, 191, "080808", 0.7)	;点击离线挂机图标2
	
	
	DmcliI("lxgjsyjyk.bmp", dm, 800, 716, 215, 858, 281, "080808", 0.8)	;点击使用按钮
	
	DmcliO(591, 348, "lxjycgesxsqd.bmp", dm, 500, 479, 193, 657, 275)	;离线经验超24小时确定
	if DmPicR("lxgjgmjm.bmp", dm, 414, 365, 549, 427)	;发现购买按钮
	{
		if DmPicR("lxgjslw6.bmp", dm, 414, 365, 549, 427) or DmPicR("lxgjslw6s.bmp", dm, 465, 268, 516, 319, "090909", 0.8)	;数量为6
			DmcliI("lxgjgmjm.bmp", dm, 800, 414, 365, 549, 427, "080808", 0.8)	;点击购买按钮
		else {
			if !DmPicR("lxgjjsqqr.bmp", dm, 516, 122, 600, 188)	;未发现计算机界面，
				DmMsCli(506, 292, dm, 800)
		}
	}
	if DmPicR("lxgjjsqqr.bmp", dm, 516, 122, 600, 188)	;发现计算器界面
	{
		loop 2
			DmMsCli(558, 89, dm, 500)	;删除数字按钮
		DmMsCli(488, 149, dm, 1300)	;计算器6按钮	
	}
	if DmPicR("lxgj24xs.bmp", dm, 597, 198, 719, 285) or DmPicR("bdybbz.bmp", dm, 282, 315, 420, 411, "080808", 0.8)	;搜索到24小时，或者元宝不足
		break
	if !DmPicR("lxgjjm.bmp", dm, 20, 1, 138, 36) and !DmPicR("lxgjgmjm.bmp", dm, 414, 365, 549, 427)	;未找到离线挂机界面或者购买挂机卡界面
		gosub, 关闭所有无用界面
	;超时判断
	sleep 200
	if a_index >= 50
	{
		if OReload
			Reload
		else
			guiChan("警告！离线挂机卡点", statusX)
	}
}
return

关闭所有无用界面:
guiChan(nowPro " 关闭无用界面", statusX)
Loop {
	;1.选择型关闭,nowPro不为该流程名时，直接关闭
	if nowPro != % "领取福利"
		DmcliO(829, 52, "fljm.bmp", dm, 500, 437, 40, 523, 83, "080808", 0.7)	;关闭福利主界面
	if nowPro != % "仙盟"
	{
		if nowPro != % "退出仙盟"
		{
			if nowPro != % "存入仙盟仓库"
			{
				if nowPro != % "查询仙盟状态"
					DmcliO(921, 36, "xmjm1.bmp", dm, 500, 37, 2, 115, 36)	;关闭仙盟界面
			}
		}
	}
	if nowPro != % "退出仙盟"
	{
		DmcliO(574, 336, "tcxmcc2.bmp", dm, 800, 411, 201, 488, 247)	;退出仙盟确认
		DmcliO(561, 337, "tcxmqd22222.bmp", dm, 800, 330,208,378,241)	;退出仙盟再确认
		DmcliO(581, 346, "jsxmddd.bmp", dm, 800, 412, 200, 486, 240)	;解散仙盟确认
		DmcliO(581, 346, "jsxmdd2.bmp", dm, 800, 362, 208, 437, 245)	;解散再次确认
	}
	
	if nowPro != % "存入仙盟仓库"
		DmcliI("ckcrddxxx.bmp", dm, 800, 644,93,670,120)	;存入界面点叉
		
	if nowPro != % "龙神佑体"
		DmcliO(820, 56, "yylmjmxx.bmp", dm, 500, 450, 10, 556, 101)	;关闭鱼跃龙门界面
	if nowPro != % "魂兽"
	{
		;1-关闭角色界面 2-关闭魂兽界面 3-关闭魂兽相关弹窗
		DmcliO(394, 328, "jshsfrrl.bmp", dm, 800, 498, 298, 647, 368)	;放入熔炉取消
		DmcliO(768, 102, "jshsfr.bmp", dm, 500, 310, 362, 467, 431)	;关闭魂兽放入界面
		if nowPro != % "御魂" 
		{
			if nowPro != % "转飞升" 
			{
				if nowPro != % "背包整理" 
				{
					DmcliO(924, 40, "jshsjm.bmp", dm, 500, 34, 1, 122, 39)	;关闭魂兽界面
					if nowPro != % "检查飞升" 
						DmcliO(924, 40, "jsjmx.bmp", dm, 500, 36, 1, 122, 41)	;关闭角色界面
				}
			}
		}
	}
	if nowPro != % "转飞升" 
		DmcliO(761, 87,"jshsdhxwg.bmp", dm, 800, 320, 358, 391, 392)
	
	if nowPro != % "检查飞升" 
		DmcliO(922, 37,"fsjmddd.bmp", dm, 800, 30, 3, 85, 33)		;关闭飞升界面
	
	
	if nowPro != % "离线挂机"
	{
		DmcliO(140, 18, "lxgjgmjm.bmp", dm, 800, 414, 365, 549, 427)	;购买界面关闭
		DmcliO(925, 37, "lxgjjm.bmp", dm, 800, 20, 1, 138, 36)	;离线挂机界面关闭
	}
	if nowPro != % "攻城战"
	{
		DmcliO(918, 39, "gczjm.bmp", dm, 800, 35, 1, 121, 38)	;攻城战界面关闭
		DmcliO(918, 39, "sjdwjljm.bmp", dm, 800, 48, 3, 162, 44)	;赛季段位奖励关闭
	}
	if nowPro != % "商城购买小精华"
	{
		DmcliO(789,60, "hjstorejm.bmp", dm, 800, 401, 36, 448, 72)	;关闭商城界面
		DmcliO(128, 512, "hjstoregm.bmp", dm, 800, 418, 359, 546, 427)	;关闭购买界面
	}
	if nowPro != % "添加盟主好友"
	{
		if nowPro != % "删除所有好友"
		{
			DmcliO(702, 39, "sshymzb.bmp", dm, 800, 703,266,752,319)
			DmcliO(702, 39, "sshymza.bmp", dm, 800, 710,265,746,324)
		}
	}
	
	
	if nowPro != % "图谱兑换"
		DmcliO(832, 53, "thhdjm.bmp", dm, 800, 435, 39, 489, 58)	;关闭特惠活动界面
	
	if nowPro != % "飞升Boss"
		DmcliO(925,36, "bossdtdx.bmp", dm, 500, 22, 3, 146, 36)	;关闭激战boss界面

	if nowPro != % "离线挂机"
		DmcliO(925,36, "lxgjjm.bmp", dm, 500, 20, 1, 138, 36)	;关闭离线挂机界面

	if nowPro != % "天帝宝库"
		DmcliO(921,29, "tdbkjmn.bmp", dm, 800, 49,2,103,31)	;关闭天帝宝库
	
	if nowPro != % "变身嫦娥"
		DmcliO(921,29,"bsjmddddd.bmp", dm, 800, 22,3,104,31)
	
	if nowPro = % "关闭巅峰界面"
		DmcliO(920,37, "dfjjjm.bmp", dm, 800, 13,4,103,30)	;关闭巅峰界面
	
	;2.非选择通用
	if DmPicR("wlcw111.bmp", dm) {	;网络错误时
		sleep 1000
		Reload
	}
	DmcliI("qdbmmmmm.bmp", dm, 1000, 260,191,589,527)	;点击报名确定
	DmcliO(569,342, "yqjrxmjjn.bmp", dm, 800, 356,325,431,354)	;仙盟拒绝加入钮，点击加入
	DmcliO(275,90, "blanktop.bmp", dm, 800, 165,19,182,81)	;输入框	
	
	DmcliO(127, 507, "lkczhjstore.bmp", dm, 800, 427, 311, 494, 355)	;关闭立刻充值界面
	DmcliO(601, 348, "jshsdhqd.bmp", dm, 800, 483, 243, 534, 267)	;魂兽兑换确认
	DmcliO(588, 347, "jshsxwzhdq2.bmp", dm, 800, 446,228,520,257)	;魂兽兑换确认2
	DmcliI("fsjyzhqdxx.bmp", dm, 800, 545,328,623,364)	;飞升转换确定钮	
	DmcliO(784,139, "tsxfgn.bmp", dm, 800, 461,378,513,407)	;天书过期续费
	
	if !FSBoss
		DmcliI("cdwpandj1.bmp", dm, 500, 873, 217, 960, 325)	;点击穿戴物品
	DmcliO(234, 50, "pbsywj.bmp", dm, 300, 195, 15, 274, 83)	;屏蔽所有玩家
	DmcliO(921, 36, "hsxnxd.bmp", dm, 500, 32, 5, 118, 38)	;关闭护送仙女界面
	DmcliO(591, 348, "lxjycgesxsqd.bmp", dm, 500, 479, 193, 657, 275)	;离线经验超24小时确定
	
	DmcliO(765, 339, "wxtshn.bmp", dm, 800, 740, 317, 787, 370)	;温馨提示灰圈，不再提醒
	
	DmcliI("tttttc.bmp", dm, 800, 421,418,468,457)		;副本退出战斗
	DmcliO(782, 76, "wpxxdx1.bmp", dm, 800, 542, 191, 568, 219)	;物品信息关闭1
	DmcliO(821, 76, "wpxxdx2.bmp", dm, 800, 574, 187, 604, 221)	;物品信息关闭2
	

	DmcliI("dbtc1.bmp", dm, 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	
	DmcliO(925, 303, "yxjmxs.bmp", dm, 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliO(923, 36, "xmldgbx.bmp", dm, 500, 35, 1, 160, 38, "080808", 0.7)	;关闭仙盟领地
	DmcliI("cejhcgtc.bmp", dm, 800,630,363,668,395)	;变身激活成功弹窗确认图标
	DmcliO(918, 24, "zqjmxxxh.bmp", dm, 500, 40, 1, 116, 35)	;关闭战骑
	DmcliO(918, 24, "lcgbxxxj.bmp", dm, 500, 41, 1, 113, 34)	;关闭灵宠
	DmcliO(691, 64, "xbckxxxd.bmp", dm, 1000, 439, 32, 559, 89)	;关闭寻宝仓库界面
	
	DmcliO(925, 39, "xbjmdx.bmp", dm, 500, 34, 1, 128, 34)	;关闭寻宝界面
	
	DmcliO(918, 312, "xdfbhdtcdxx.bmp", dm, 500, 722, 318, 830, 358)	;vip1，新的副本活动弹窗点x
	
	if DmPicR("wygwtc.bmp", dm, 420, 348, 540, 399)	{ ;我要鼓舞界面
		DmcliI("wygwtc.bmp", dm, 800, 420, 348, 540, 399)	;点击我要鼓舞
		if DmPicR("wygwtc.bmp", dm, 420, 348, 540, 399)
			DmMsCli(660, 137, dm, 5)
	}

	DmcliO(849, 69, "kfybzbs.bmp", dm, 500, 339, 58, 439, 97, "080808", 0.8)	;跨服元宝争霸赛
	DmcliO(791, 59, "kfybzbgjx.bmp", dm, 500, 409, 424, 551, 501, "080808", 0.8)	;跨服元宝争霸赛
	DmcliO(770, 99, "fwqzgrybm.bmp", dm, 500, 408, 368, 566, 432)	;服务器最高荣耀
	DmcliO(757, 92, "dati01x.bmp", dm, 500, 417, 48, 545, 105)	;答题弹窗关闭
	DmcliO(922, 36, "dzjmdxxxl.bmp", dm, 500, 36, 1, 121, 35)	;锻造界面点x
	DmcliO(775, 117, "qyjmgbxdfx.bmp", dm, 500, 440, 67, 526, 139)	;情缘弹窗点x



	DmcliI("lxjyqdx.bmp", dm, 800, 403, 342, 568, 438)	;开头离线经验确定
	DmcliI("sywp1.bmp", dm, 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("hdwp1.bmp", dm, 500, 455, 143, 556, 249)	;中心位置获得物品 - 单排（通用）
	DmcliI("zxwcrw.bmp", dm, 500, 75, 411, 267, 516)	;主线完成任务
	DmcliI("flzyzhqr.bmp", dm, 800, 500, 334, 642, 412, "080808", 0.8)	;福利资源找回确认
	DmcliI("jzbsdjrw.bmp", dm, 800, 611, 112, 699, 198)	;激战boss点击人物
	DmcliI("jzbslkfj.bmp", dm, 800, 400, 308, 567, 387)	;激战boss立刻反击
	
	DmcliI("ybzbqwcydd.bmp", dm, 800, 418, 407, 543, 466)	;元宝争霸前往参与
	DmcliI("ybzbqddd.bmp", dm, 800, 398, 387, 558, 459)	;元宝争霸完成确定
	
	DmcliO(151, 68, "lkcz1.bmp", dm, 800, 437, 40, 523, 83)	;关闭充值界面1
	DmcliO(920,42, "czdl1.bmp", dm, 500, 5,2,127,34)	;关闭充值大礼界面2
	
	
	
	DmcliO(496,414, "tsssdqdx.bmp", dm, 500, 415, 71, 477, 106)	;吞噬神兽界面点确定
	
	
	
	DmcliI("jsfsqx.bmp", dm, 800, 337, 295, 439, 364)	;飞升80级开启，弹窗
	
	DmcliO(767, 73, "xmjxdx.bmp", dm, 800, 417, 34, 551, 98, "080808", 0.8)	;仙盟捐献界面
	DmcliO(781, 121, "msxmdxxx.bmp", dm, 500, 488, 334, 634, 443)	;马上选美点叉
	DmcliO(815, 74, "tjgb.bmp", dm, 500, 466, 20, 548, 103)	;天机结婚弹窗关闭
	DmcliO(755, 85, "tjgb.bmp", dm, 500, 426, 62, 536, 102)	;决战华山弹窗关闭
	
	DmcliO(396, 370, "tjgb.bmp", dm, 500, 521, 315, 598, 355)	;福利资源元宝找回
	DmcliO(771, 115, "qwczxd.bmp", dm, 500, 386, 334, 578, 430)	;前往充值关闭
	
	DmcliO(920,281, "hdkq1.bmp", dm, 500, 678, 446, 850, 533)	;关闭右下活动弹窗，前往参与 1
	DmcliO(917,279, "qwcy2.bmp", dm, 500, 699, 458, 842, 529)	;关闭右下活动弹窗，前往参与 2
	DmcliO(934, 189, "wxtsdg.bmp", dm, 500, 736, 314, 788, 366, "090909", 0.7)	;温馨提示打钩了，点叉
	if (DmPicR("qrdlkljl.bmp", dm, 114, 381, 251, 474, "080808", 0.8)) {	;七日登录界面
		loop 2
			DmPieCli(673, 403, 685, 422, "269129-010101", dm, 800)	;按钮位置为绿色
		DmPieClO(675, 400, 686, 425, "727272-010101", 827, 72, dm, 500)
	}
	DmcliI("sjdqd.bmp", dm, 800, 419, 326, 541, 385)	;升级丹确定
	DmcliI("qrdlljcs.bmp", dm, 800, 671, 392, 832, 499)	;七日登录时装立即穿上
	
	if (DmPicR("mrbzjm.bmp", dm, 9, 1, 136, 38, "080808", 0.8)) {	;每日必做界面
		DmPieCli(370, 503, 389 ,523, "45b240-050505", dm, 1200)	;绿钮按下
		DmcliI("mrlqjl.bmp", dm, 800, 589, 414, 745, 490, "080808", 0.8)	;每日领取奖励
		DmPieClO(366, 495, 382, 518, "646464-030303", 921, 42, dm, 500)	;灰钮关闭
	}
	DmcliI("mrlqjl.bmp", dm, 800, 589, 414, 745, 490, "080808", 0.8)	;每日领取奖励
	
	DmcliO(935, 192, "bcdlbztx.bmp", dm, 500, 728, 293, 804, 376, "101010", 0.7)	;本次登录不再提醒
	;----提取经验
	if !JYUNDO
		DmcliI("tqjy1.bmp", dm, 500, 546, 254, 687, 313)	;单倍提取位置
	DmcliO(664, 79, "tqjyvip.bmp", dm, 500, 409, 401, 558, 477)	;提升vip等级，点叉
	DmcliO(662, 80, "jycwhjhy.bmp", dm, 500, 423, 379, 550, 476)	;成为黄金会员 点叉
	DmcliO(664, 79, "jyyfx.bmp", dm, 500, 422, 38, 537, 107)	;经验玉符点，点叉
	;3.搜到背包时，break
	if (DmPicR("bb.bmp", dm, 893, 206, 951, 270, "101010", 0.7) or DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) {
		break
	}
	if nowPro = % "领取福利"
	{
		if DmPicR("fljm.bmp", dm, 437, 40, 523, 83, "101010", 0.7)
			break
	}
	else if nowPro = % "退出仙盟"
	{
		DmcliI("tcxmccc.bmp", dm, 800, 164, 479, 257, 533)	;退出仙盟
		DmcliO(574, 336, "tcxmcc2.bmp", dm, 800, 411, 201, 488, 247)	;退出仙盟确认
		DmcliI("xmczddd.bmp", dm, 800, 156, 483, 254, 524)	;点击仙盟操作
		DmcliI("jsxmxxx.bmp", dm, 800, 156, 435, 258, 472)	;点击解散仙盟
		DmcliO(581, 346, "jsxmddd.bmp", dm, 800, 412, 200, 486, 240)	;解散仙盟确认
		DmcliO(581, 346, "jsxmdd2.bmp", dm, 800, 362, 208, 437, 245)	;解散再次确认		
		break
	}
	else if nowPro = % "仙盟"
	{
		if (DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)) {
			DmPieClO(199, 46, 220, 63, "c43440-080808", 194, 81, dm, 800)	;点击仙盟福利
			break
		}
	}
	else if nowPro = % "查询仙盟状态"
	{
		if (DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36)) {
			DmPieClO(199, 46, 220, 63, "c43440-080808", 194, 81, dm, 800)	;点击仙盟福利
			break
		}		
	}
	else if nowPro = % "龙神佑体"
	{
		if DmPicR("yylmjm.bmp", dm, 402, 38, 494, 74)
			break
	}
	else if nowPro = % "魂兽"
	{
		if DmPicR("jsjmx.bmp", dm, 36, 1, 122, 41) or DmPicR("jshsjm.bmp", dm, 34, 1, 122, 39) or DmPicR("jshsjm.bmp", dm, 310, 362, 467, 431)
			break
	}
	else if nowPro = % "御魂"
	{
		DmcliI("jshsxhjyqd.bmp", dm, 800, 518, 324, 643, 368)	;御魂转换确定
		if DmPicR("jshsjm.bmp", dm, 34, 1, 122, 39)
			break
	}
	else if nowPro = % "转飞升"
	{
		if DmPicR("jshsdhxwg.bmp", dm, 320, 358, 391, 392) or DmPicR("jshsjm.bmp", dm, 34, 1, 122, 39)		;兑换按钮或魂兽界面
			break
	}
	
	else if nowPro = % "攻城战"
	{
		if DmPicR("gczjm.bmp", dm, 35, 1, 121, 38) or DmPicR("sjdwjljm.bmp", dm, 48, 3, 162, 44)
			break
	}
	else if nowPro = % "离线挂机"
	{
		if DmPicR("lxgjjm.bmp", dm, 20, 1, 138, 36) or DmPicR("lxgjgmjm.bmp", dm, 414, 365, 549, 427)	;离线挂机界面
			break
	}

	else if nowPro = % "商城购买小精华"
	{
		if DmPicR("hjstorejm.bmp", dm, 401, 36, 448, 72) or DmPicR("hjstoregm.bmp", dm, 418, 359, 546, 427)	;商城购买界面
			break
	}
	else if nowPro = % "背包整理"
	{
		DmcliO(924, 40, "jshsjm.bmp", dm, 500, 34, 1, 122, 39)	;关闭魂兽界面
		if DmPicR("jsjmx.bmp", dm, 36, 1, 122, 41)
			break
	}
	else if nowPro = % "图谱兑换"
	{
		if DmPicR("thhdbt.bmp", dm, 822, 235, 847, 472)		;右侧边条
			break
	}
	else if nowPro = % "检查飞升"
	{
		if DmPicR("fsjmddd.bmp", dm, 30, 3, 85, 33)
			break
	}
	
	else if nowPro = % "飞升Boss"
	{
		if DmPicR("bossdtdx.bmp", dm, 22, 3, 146, 36) or DmPicR("zdztcan.bmp", dm, 203, 151, 311, 254)	;激战boss界面或战斗中界面
			break
	}
	else if nowPro = % "添加盟主好友"
	{
		if (DmPicR("mzhyxxr.bmp", dm,710, 106, 752, 160) 
		or DmPicR("mzhyxxk.bmp", dm, 707, 107, 745, 160)	
		or DmPicR("blanktop.bmp", dm, 23,13,48,81)
		or DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) { ;没发现好友，顶部输入框，背包		
			break
		}
	}
	else if nowPro = % "删除所有好友"
	{
		if (DmPicR("mzhyxxr.bmp", dm,710, 106, 752, 160) 
		or DmPicR("mzhyxxk.bmp", dm, 707, 107, 745, 160)	
		or DmPicR("bb2.bmp", dm, 893, 206, 951, 270, "101010", 0.7)) { ;没发现好友，顶部输入框，背包		
			break
		}
	}
	else if nowPro = % "等待仙盟邀请"
	{
		DmcliO(635,132, "schy222d.bmp", dm,800, 377,355,446,388)	;删除好友2
		if DmPicR("yqjrxmjjn.bmp", dm,356,325,431,354)		;拒绝钮
			break
	}
	else if nowPro = % "存入仙盟仓库"
	{
		if DmPicR("xmjm1.bmp", dm, 37, 2, 115, 36) or DmPicR("crandjjjjj.bmp", dm, 452,387,519,420)	;仙盟界面时，存入界面时
			break
	}
	
	else if nowPro = % "天帝宝库"
	{
		if (!timeWaiting) {
			if DmPicR("tdbkjmn.bmp", dm, 49,2,103,31)
				break
		}
		else
			DmcliO(921,29, "tdbkjmn.bmp", dm, 800, 49,2,103,31)	;关闭天帝宝库
	}
	
	else if nowPro = % "离线挂机"
	{
		if DmPicR("lxgjjm.bmp", dm, 20, 1, 138, 36) or DmPicR("lxgjgmjm.bmp", dm, 414, 365, 549, 427)
			break
	}
	else if nowPro = % "变身嫦娥"
	{
		if DmPicR("bsjmddddd.bmp", dm, 22,3,104,31)
			break
	}
	else if nowPro = % "检查巅峰段位"
	{
		if DmPicR("dfjjjm.bmp", dm, 13,4,103,30)
			break
	}
	else if nowPro = % "报名参赛"
	{
		if DmPicR("dfjjjm.bmp", dm, 13,4,103,30)
			break
	}	
	else if nowPro = % "等待巅峰开始"
	{
		if DmPicR("dfjjjm.bmp", dm, 13,4,103,30)
			break
	}
	else if nowPro = % "等待巅峰结束"
		break
	
	Sleep 100
	if a_index > 80
	{
		if OReload
			Reload
		else
			guiChan(nowPro "关闭所有界面卡点", statusX)
	}
}
return

切号:
guicontrolget, nowLevel, , nowLevel
if nowLevel >= 78
{
	if fileexist(ToFoPa "\2-日常\*.acc")
	{
		if fileexist(ToFoPa "\2-日常\" nowGANforZX)
			FileMove, % ToFoPa "\2-日常\" nowGANforZX, % ToFoPa "\3-成号\" nowGANforZX, 1
	}
}

Del_F(A_WorkingDir "\WorkAcc\" SNum "\" nowGANforZX)	;删除当前登录临时文件
FileAppend, % "`n" nowGANforZX, % A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", UTF-8


DmStrSerch :=
guicontrol, , nowLevel, 0
guiChan("退出游戏", statusX)
loop {
	ControlClick, x980 y462, % "RC" SNum
	Sleep 1300
	DmcliI("tcyxqd.bmp", dm, 1200, 503, 278, 611, 369, "080808", 0.8)	;点击退出确定
	if DmPicR("icon.bmp", dm, 438, 29, 523, 112, "080808", 0.8)
		break
	if a_index >= 10
		Reload
}
qiehao := 1
SetTimer, 首先启动游戏, -300
return

;——— 大漠必备函数 用以指针坐标输出 ————
ComVar(Type=0xC) {
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

;——— 大漠自制函数 搜图等 ————

DmSendW(tex, hwndx,ByRef dmF, slpt := 0) {	;发送文本到窗口,成功发送将延迟
	dmF.SetKeypadDelay("windows", 50)
	cl := dmF.SendString(hwndx, tex)
	if cl
		Sleep, % slpt
}

DmMsCli(x, y,ByRef dmF, slpt := 0) {	;大漠点击函数
	dmF.MoveTo(x, y)
	sleep 50
	dmF.LeftDown()
	sleep 50
	dmF.LeftUp()
	Sleep, % slpt
}

DmMsDrag(x1, y1,ByRef dmF, x2, y2, slpt := 0) {	;大漠鼠标点击拖行
	dmF.MoveTo(x1, y1)
	sleep 200
	dmF.LeftDown()
	sleep 200
	dmF.MoveTo(x2, y2)
	sleep 500
	dmF.LeftUp()
	Sleep, % slpt
}

;大漠点击图片函数, 为大漠坐标
DmcliI(picName, ByRef dmF, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	x := ComVar(), y := ComVar()
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(x[], y[], dmF)
		Sleep, % slept
	}
	else
		sleep 2
}

;大漠点击它处函数，为大漠坐标
DmcliO(xx, yy, picName, ByRef dmF, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	x := ComVar(), y := ComVar()
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(xx, yy, dmF)
		Sleep, % slept
	}
	else
		Sleep 2
}

;大漠图片查找函数，找到返回1，无返回0
DmPicR(picName, ByRef dmF, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dmF.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
	gotEL := % gotEL + 1
	if (gotEL) {
		Sleep 3
		return 1
	}
	else {
		Sleep 2
		return 0
	}
}

DmPieCli(x1, y1, x2, y2, ColorX, ByRef dmF, slpt := 0,MH := 1) {	;搜色点击，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(x[], y[], dmF)
		Sleep, % slpt
	}
	else
		Sleep 2
}

DmPieClO(x1, y1, x2, y2, ColorX, xx, yy, ByRef dmF, slpt := 0,MH := 1) {	;搜色点击它处，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(xx, yy, dmF)
		Sleep, % slpt
	}
	else
		Sleep 2
}


DmPieR(x1, y1, x2, y2, ColorX, ByRef dmF,MH := 1) {	;搜色判断，模糊匹配默认为1,从左到右从上下
	cl := dmF.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x, y)
	Sleep 2
	return % cl
}

GNSubT(td) {	;用当前时间戳减去给定时间戳，返回单位为秒
	toN := % A_Now
	EnvSub, toN, %td%, Seconds
	return % toN
}


TAddS(sec) {	;用当前时间戳加上秒数，返回为时间戳
	tn := % A_Now
	EnvAdd, tn, % sec, Seconds
	return % tn
}

Del_F(filLP) { ;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}
}

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     必要函数 
conCli(lx, ly, tit) { ;controlclick函数
	ControlClick, % "x" lx " y" ly, % tit, , L, 1
}

delStrL(inputvar,countx := 0) { ;删除字符串后几位  
    StringTrimRight, ca, inputvar, % Countx
    return % ca
}

guiChan(newtex, ByRef gVar) { ;GUI改变函数
	GuiControl, , gVar, % newtex
}

muliR(timeofL) { ;控制多开器启动/关闭窗口函数
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
}

getL(filLP, linenum := 1) { ;获取文件某行字符串，无返回0，默认首行
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
