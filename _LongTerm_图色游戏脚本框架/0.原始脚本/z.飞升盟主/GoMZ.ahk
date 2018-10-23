

/*
sNum := 7
wName := % "MZ" sNum
tName := % "GoMZ" sNum 
*/

#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
setworkingdir %a_scriptdir%

yh = "

topDir := % delStrL(a_workingdir, 7)	;顶部路径

global dm := ComObjCreate( "dm.dmsoft" )	;创建大漠对象
global x := ComVar(), global y := ComVar()

dm.SetPath(A_WorkingDir "\dmpic\")	;设定大漠工作路径
dm.SetDict(1, "yao.txt")	;设定大漠字典
dm.UseDict(1)		;设定引用字典，引用前需声明字典文件

LdPath := getL(topDir "\PathOfLD_x.path")	;获取雷电模拟器路径
LdCtrlLP := % LdPath "\dnconsole.exe"	;雷电中控路径

gui, font, ceaedcd, 微软雅黑		;字体与颜色
Gui, Color, 161a17				;窗口颜色
Gui, -Caption -SysMenu +AlwaysOnTop

Gui, Add, Text, x6 y2 w30 h16 , %wName%
Gui, Add, Text, x46 y2 w40 h16 , 状态：
Gui, Add, Text, vStatusx x86 y2 w210 h16 , Waiting for command...

yg := % 850 + (sNum - 1) * 25
Gui, Show, x150 y%yg% h22 w306, %tName%

if (winexist(wName)) {
	guiChan("关闭模拟器重启", Statusx)
	nnn := % sNum - 1
	RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
	Sleep 3000
}
SetTimer, 首先启动游戏, -100
Return

GuiClose:
ExitApp
return

;1，清空好友列表
;2，接受到好友申请
;3，添加好友，添加好友确认
;4，邀请加入仙盟
;5，等待好友列表清空，回到盟主流程

盟主流程:
guiChan("检查好友列表", Statusx)
gosub, 关闭所有无用界面
gosub, 清空好友列表
sleep 500
gosub, 关闭所有无用界面
SetTimer, 查询好友邀请情况, -200
return

查询好友邀请情况:

loop {
	guiChan("查询好友邀请情况", Statusx)
	DmcliO(781,141, "tsxfgn.bmp", 800, 461,378,513,407)	;天书过期续费
	DmcliO(720, 38, "hyjmi.bmp", 800, 432, 30, 519, 67)
	DmcliO(778, 75, "hysqjm.bmp", 800, 429, 48, 473, 80)	;关闭好友界面
	wordYou := dm.FindStr(27,347,669,497, "友", "c9f2f4-080808|d0f9fc-080808|b2d8db-080808", 0.7, x.ref, y.ref)
	wordYou := % wordYou + 1
	if wordYou {
		DmMsCli(x[], y[], 800)
	}
	if DmPicR("hysqjm.bmp", 429, 48, 473, 80) {	;当处于好友申请界面时
		DmcliI("hysqty.bmp", 800, 692, 128, 746, 169)	;同意好友申请
		if DmPicR("zwhysq.bmp", 407, 185, 464, 226) {	;搜索到暂无好友申请字样，点叉进行下一流程。
			DmcliO(778, 75, "hysqjm.bmp", 800, 429, 48, 473, 80)	;关闭好友申界面
			settimer, 邀请加入仙盟, -200
			return
		}
	}
	Sleep 200
	;若无搜索到背包字样,好友申请界面字样，进行关闭无用界面
	if (!DmPicR("bb2.bmp", 893, 206, 951, 270, "101010", 0.7)
	and !DmPicR("hysqjm.bmp", 429, 48, 473, 80)) {
		gosub, 关闭所有无用界面
	}
	
}
return

邀请加入仙盟:
guiChan("邀请加入仙盟x3", Statusx)
yqjrxm := 1
loop {
	if DmPicR("hysqjm.bmp", 429, 48, 473, 80) {	;当处于好友申请界面时
		DmcliI("hysqty.bmp", 800, 692, 128, 746, 169)	;同意好友申请
		if DmPicR("zwhysq.bmp", 407, 185, 464, 226) 	;搜索到暂无好友申请字样
			DmcliO(778, 75, "hysqjm.bmp", 800, 429, 48, 473, 80)	;关闭好友申请界面		
	}
	DmcliO(925, 303, "yxjmxs.bmp", 800, 884, 260, 959, 338, "080808", 0.7)	;打开底部栏
	DmcliI("mzhy.bmp", 800, 731, 300, 769, 336)	;点击好友
	DmcliI("mzsj.bmp", 800, 815, 469, 855, 508)	;点击社交
	DmcliI("mzhyxxk.bmp", 800, 707, 107, 745, 160)	;点击好友选项卡
	if DmPicR("mzhyxxr.bmp", 710, 106, 752, 160) {	;选项卡为红色时
		if !DmPicR("mzhywr.bmp", 372, 267, 416, 310)	;未搜索到当前好友无人
			DmMsCli(316, 93, 800)		
	}
	if DmPicR("hyxmyq.bmp", 515, 277, 591, 315) {		;搜索到进行仙盟邀请
		if !xmyq
			xmyq := 1
		else
			xmyq := % xmyq + 1
		DmcliI("hyxmyq.bmp", 800, 515, 277, 591, 315)	;点击仙盟邀请
	}
	if (xmyq >= 3) {
		xmyq := 
		SetTimer, 等待好友列表清空, -200
		return
	}
	Sleep 200
	;若1.无背包，2.无好友界面，3.无仙盟邀请，进行关闭无用流程
	if (!DmPicR("bb2.bmp", 893, 206, 951, 270, "101010", 0.7)	;背包
	and !DmPicR("hyjmi.bmp", 432, 30, 519, 67)	;好友界面
	and !DmPicR("hyxmyq.bmp", 515, 277, 591, 315)) {	;好友邀请界面
		gosub, 关闭所有无用界面
	}
}
yqjrxm :=
return

等待好友列表清空:		;处于仙盟邀请之后，确定好友列表被清空，则回到仙盟流程
guiChan("等待好友列表清空", Statusx)
ddhylbqk := 1
loop {
	guiChan("等待好友列表被清空", Statusx)
	DmcliO(925, 303, "yxjmxs.bmp", 800, 884, 260, 959, 338, "080808", 0.7)	;打开底部栏
	DmcliI("mzhy.bmp", 800, 731, 300, 769, 336)	;点击好友
	DmcliI("mzsj.bmp", 800, 815, 469, 855, 508)	;点击社交
	DmcliI("mzhyxxk.bmp", 800, 707, 107, 745, 160)	;点击好友选项卡
	if DmPicR("mzhyxxr.bmp", 710, 106, 752, 160) {	;选项卡为红色时
		if DmPicR("mzhywr.bmp", 372, 267, 416, 310) {	;搜索到当前好友无人
			SetTimer, 查询好友邀请情况, -200
			return
		}	
	}
	Sleep 200
	;若为搜索到背包，未搜索到好友界面，进行关闭无用界面流程
	if !DmPicR("bb2.bmp", 893, 206, 951, 270, "101010", 0.7)  and !DmPicR("hyjmi.bmp", 432, 30, 519, 67)
		gosub, 关闭所有无用界面

}
ddhylbqk :=
return



清空好友列表:	;开始首先判断
guiChan("清空好友列表", Statusx)
jcFriend := 1
loop {
	DmcliO(925, 303, "yxjmxs.bmp", 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）	
	DmcliI("mzhy.bmp", 800, 731, 300, 769, 336)	;点击好友
	DmcliI("mzsj.bmp", 800, 815, 469, 855, 508)	;点击社交
	DmcliI("mzhy.bmp", 800, 731, 300, 769, 336)	;点击好友
	DmcliI("mzhyxxk.bmp", 800, 707, 107, 745, 160)	;点击好友选项卡
	if DmPicR("mzhyxxr.bmp", 710, 106, 752, 160) {	;选项卡为红色时
		if !DmPicR("mzhywr.bmp", 372, 267, 416, 310)
			DmMsCli(316, 93, 800)
	}
	DmcliI("mzschy.bmp", 800, 523, 324, 570, 367)	;删除好友
	DmcliI("mzschyqd.bmp", 800, 527, 315, 566, 347)	;确认删除好友
	
	if (!DmPicR("mzhyjm.bmp", 435, 30, 470, 59) ;不在好友界面
	and !DmPicR("mzschyqd.bmp", 527, 315, 566, 347)  ;没有删除确定按钮
	and !DmPicR("bb2.bmp", 893, 206, 951, 270, "101010", 0.7)) {	;无背包
		gosub, 关闭所有无用界面
	}
	if DmPicR("mzhywr.bmp", 372, 267, 416, 310) {	;当前无好友
		DmMsCli(711, 50, 800)
		break
	}
	Sleep 200
}
jcFriend :=
return

关闭所有无用界面:
guiChan("关闭所有无用界面", Statusx)
Loop {
	;1.选择型关闭,nowPro不为该流程名时，直接关闭
	if (!jcFriend and !yqjrxm and !ddhylbqk) 
		DmcliO(716, 37,"hyjmi.bmp", 800, 432, 30, 519, 67)
	DmcliI("mzschyqd.bmp", 800, 527, 315, 566, 347)	;确认删除好友	
	DmcliO(781,141, "tsxfgn.bmp", 800, 461,378,513,407)	;天书过期续费	
	
	DmcliO(829, 52, "fljm.bmp", 500, 437, 40, 523, 83, "080808", 0.7)	;关闭福利主界面
	DmcliO(921, 36, "xmjm1.bmp", 500, 37, 2, 115, 36)	;关闭仙盟界面
	DmcliO(820, 56, "yylmjmxx.bmp", 500, 450, 10, 556, 101)	;关闭鱼跃龙门界面
	;1-关闭角色界面 2-关闭魂兽界面 3-关闭魂兽相关弹窗
	DmcliO(394, 328, "jshsfrrl.bmp", 800, 498, 298, 647, 368)	;放入熔炉取消
	DmcliO(768, 102, "jshsfr.bmp", 500, 310, 362, 467, 431)	;关闭魂兽放入界面
	DmcliO(924, 40, "jshsjm.bmp", 500, 34, 1, 122, 39)	;关闭魂兽界面
	DmcliO(924, 40, "jsjmx.bmp", 500, 36, 1, 122, 41)	;关闭角色界面
	DmcliO(140, 18, "lxgjgmjm.bmp", 800, 414, 365, 549, 427)	;购买界面关闭
	DmcliO(925, 37, "lxgjjm.bmp", 800, 20, 1, 138, 36)	;离线挂机界面关闭
	DmcliO(918, 39, "gczjm.bmp", 800, 35, 1, 121, 38)	;攻城战界面关闭
	DmcliO(918, 39, "sjdwjljm.bmp", 800, 48, 3, 162, 44)	;赛季段位奖励关闭
	DmcliO(789,60, "hjstorejm.bmp", 800, 401, 36, 448, 72)	;关闭商城界面
	DmcliO(128, 512, "hjstoregm.bmp", 800, 418, 359, 546, 427)	;关闭购买界面

	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		sleep 1000
		Reload
	}
	DmcliO(127, 507, "lkczhjstore.bmp", 800, 427, 311, 494, 355)	;关闭立刻充值界面
	
	DmcliI("cdwpandj1.bmp", 500, 873, 217, 960, 325)	;点击穿戴物品
	DmcliO(234, 50, "pbsywj.bmp", 300, 195, 15, 274, 83)	;屏蔽所有玩家
	DmcliO(921, 36, "hsxnxd.bmp", 500, 32, 5, 118, 38)	;关闭护送仙女界面
	DmcliO(591, 348, "lxjycgesxsqd.bmp", 500, 479, 193, 657, 275)	;离线经验超24小时确定
	
	DmcliO(765, 339, "wxtshn.bmp", 800, 740, 317, 787, 370)	;温馨提示灰圈，不再提醒
	
	DmcliO(782, 76, "wpxxdx1.bmp", 800, 542, 191, 568, 219)	;物品信息关闭1
	DmcliO(821, 76, "wpxxdx2.bmp", 800, 574, 187, 604, 221)	;物品信息关闭2
	
	DmcliI("dlyx.bmp", 800, 474, 421, 561, 475)	;显示顶部界面（通用）
	DmcliI("dbtc1.bmp", 800, 919, 104, 957, 164, "101010", 0.7)	;显示顶部界面2（通用）
	
	DmcliO(925, 303, "yxjmxs.bmp", 800, 884, 260, 959, 338, "080808", 0.7)	;显示底部界面（通用）
	DmcliO(923, 36, "xmldgbx.bmp", 500, 35, 1, 160, 38, "080808", 0.7)	;关闭仙盟领地
	
	DmcliO(918, 24, "zqjmxxxh.bmp", 500, 40, 1, 116, 35)	;关闭战骑
	DmcliO(918, 24, "lcgbxxxj.bmp", 500, 41, 1, 113, 34)	;关闭灵宠
	DmcliO(691, 64, "xbckxxxd.bmp", 1000, 439, 32, 559, 89)	;关闭寻宝仓库界面
	
	DmcliO(925, 39, "xbjmdx.bmp", 500, 34, 1, 128, 34)	;关闭寻宝界面
	
	DmcliO(918, 312, "xdfbhdtcdxx.bmp", 500, 722, 318, 830, 358)	;vip1，新的副本活动弹窗点x
	
	if DmPicR("wygwtc.bmp", 420, 348, 540, 399)	{ ;我要鼓舞界面
		DmcliI("wygwtc.bmp", 800, 420, 348, 540, 399)	;点击我要鼓舞
		if DmPicR("wygwtc.bmp", 420, 348, 540, 399)
			DmMsCli(660, 137, 5)
	}

	DmcliO(849, 69, "kfybzbs.bmp", 500, 339, 58, 439, 97, "080808", 0.8)	;跨服元宝争霸赛
	DmcliO(791, 59, "kfybzbgjx.bmp", 500, 409, 424, 551, 501, "080808", 0.8)	;跨服元宝争霸赛
	DmcliO(770, 99, "fwqzgrybm.bmp", 500, 408, 368, 566, 432)	;服务器最高荣耀
	DmcliO(757, 92, "dati01x.bmp", 500, 417, 48, 545, 105)	;答题弹窗关闭
	DmcliO(922, 36, "dzjmdxxxl.bmp", 500, 36, 1, 121, 35)	;锻造界面点x
	DmcliO(775, 117, "qyjmgbxdfx.bmp", 500, 440, 67, 526, 139)	;情缘弹窗点x
	
	DmcliI("lxjyqdx.bmp", 800, 403, 342, 568, 438)	;开头离线经验确定
	DmcliI("sywp1.bmp", 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("hdwp1.bmp", 500, 455, 143, 556, 249)	;中心位置获得物品 - 单排（通用）
	DmcliI("zxwcrw.bmp", 500, 75, 411, 267, 516)	;主线完成任务
	DmcliI("flzyzhqr.bmp", 800, 500, 334, 642, 412, "080808", 0.8)	;福利资源找回确认
	DmcliI("jzbsdjrw.bmp", 800, 611, 112, 699, 198)	;激战boss点击人物
	DmcliI("jzbslkfj.bmp", 800, 400, 308, 567, 387)	;激战boss立刻反击
	
	DmcliI("ybzbqwcydd.bmp", 800, 418, 407, 543, 466)	;元宝争霸前往参与
	DmcliI("ybzbqddd.bmp", 800, 398, 387, 558, 459)	;元宝争霸完成确定
	
	DmcliO(151, 68, "lkcz1.bmp", 800, 437, 40, 523, 83)	;关闭充值界面1
	DmcliO(920,42, "czdl1.bmp", 500, 5,2,127,34)	;关闭充值大礼界面2
	DmcliO(925,36, "bossdtdx.bmp", 500, 22, 3, 146, 36)	;关闭激战boss界面
	
	DmcliO(496,414, "tsssdqdx.bmp", 500, 415, 71, 477, 106)	;吞噬神兽界面点确定
	
	DmcliI("jsfsqx.bmp", 800, 337, 295, 439, 364)	;飞升80级开启，弹窗
	
	DmcliO(767, 73, "xmjxdx.bmp", 800, 417, 34, 551, 98, "080808", 0.8)	;仙盟捐献界面
	DmcliO(781, 121, "msxmdxxx.bmp", 500, 488, 334, 634, 443)	;马上选美点叉
	DmcliO(815, 74, "tjgb.bmp", 500, 466, 20, 548, 103)	;天机结婚弹窗关闭
	DmcliO(755, 85, "tjgb.bmp", 500, 426, 62, 536, 102)	;决战华山弹窗关闭
	
	DmcliO(396, 370, "tjgb.bmp", 500, 521, 315, 598, 355)	;福利资源元宝找回
	DmcliO(771, 115, "qwczxd.bmp", 500, 386, 334, 578, 430)	;前往充值关闭
	
	DmcliO(920,281, "hdkq1.bmp", 500, 678, 446, 850, 533)	;关闭右下活动弹窗，前往参与 1
	DmcliO(917,279, "qwcy2.bmp", 500, 699, 458, 842, 529)	;关闭右下活动弹窗，前往参与 2
	DmcliO(934, 189, "wxtsdg.bmp", 500, 736, 314, 788, 366, "090909", 0.7)	;温馨提示打钩了，点叉
	if (DmPicR("qrdlkljl.bmp", 114, 381, 251, 474, "080808", 0.8)) {	;七日登录界面
		loop 2
			DmPieCli(673, 403, 685, 422, "269129-010101", 800)	;按钮位置为绿色
		DmPieClO(675, 400, 686, 425, "727272-010101", 827, 72, 500)
	}
	DmcliI("sjdqd.bmp", 800, 419, 326, 541, 385)	;升级丹确定
	DmcliI("qrdlljcs.bmp", 800, 671, 392, 832, 499)	;七日登录时装立即穿上
	
	if (DmPicR("mrbzjm.bmp", 9, 1, 136, 38, "080808", 0.8)) {	;每日必做界面
		DmPieCli(370, 503, 389 ,523, "45b240-050505", 1200)	;绿钮按下
		DmcliI("mrlqjl.bmp", 800, 589, 414, 745, 490, "080808", 0.8)	;每日领取奖励
		DmPieClO(366, 495, 382, 518, "646464-030303", 921, 42, 500)	;灰钮关闭
	}
	DmcliI("mrlqjl.bmp", 800, 589, 414, 745, 490, "080808", 0.8)	;每日领取奖励
	
	DmcliO(935, 192, "bcdlbztx.bmp", 500, 728, 293, 804, 376, "101010", 0.7)	;本次登录不再提醒
	;----提取经验
	DmcliI("tqjy1.bmp", 500, 546, 254, 687, 313)	;单倍提取位置
	DmcliO(664, 79, "tqjyvip.bmp", 500, 409, 401, 558, 477)	;提升vip等级，点叉
	DmcliO(662, 80, "jycwhjhy.bmp", 500, 423, 379, 550, 476)	;成为黄金会员 点叉
	DmcliO(664, 79, "jyyfx.bmp", 500, 422, 38, 537, 107)	;经验玉符点，点叉
	;3.搜到背包时，break
	if DmPicR("bb.bmp", 893, 206, 951, 270, "101010", 0.7) or DmPicR("bb2.bmp", 893, 206, 951, 270, "101010", 0.7) 
		break
	if (DmPicR("hysqjm.bmp", 429, 48, 473, 80) 
	or DmPicR("hyjmi.bmp", 432, 30, 519, 67) 
	or DmPicR("hyxmyq.bmp", 515, 277, 591, 315)) {		;搜索到1.好友申请界面，2.好友界面，3.仙盟邀请按钮
		break
	}
}
return

首先启动游戏:
guiChan("启动模拟器", Statusx)
nnn := % sNum - 1
RunWait, % "cmd.exe /c " LdCtrlLP " launch --index " nnn, , Hide
if (sNum = 1) {	;启动模拟器
	WinWait, 雷电模拟器
	Sleep 700
	WinSetTitle, 雷电模拟器, , % wName, % "雷电模拟器-"
}
else {
	WinWait, % "雷电模拟器-" nnn
	Sleep 700
	WinSetTitle, % "雷电模拟器-" nnn, , % wName
}
sleep 200
winIDF := dm.FindWindow("LDPlayerMainFrame", wName) ;父窗口ID
winIDS := dm.EnumWindow(winIDF, "TheRender","",1)	;子窗口ID 
dm.BindWindow(winIDS,"gdi2","windows","windows",0)	;设定所有坐标相对窗口绑定 
;移动窗口
if sNum = 1
	WinMove, % wName, , 5, 5
else
	WinMove, % wName, , % 5 + (sNum - 1) * 60, % 5 + (sNum - 1) * 15
guiChan("点击幻剑图标", Statusx)
Loop {
	DmcliI("icon.bmp", 500, 438, 29, 523, 112, "080808", 0.9)
	if DmPicR("dltb.bmp", 500,317,608,387, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 40) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload	
	}
}
guiChan("清空账号密码", statusx)
loop {
	DmMsCli( 492, 205, 500)
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	DmMsCli(516, 247, 500)
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if DmPicR("qksj.bmp", 311, 157, 434, 297, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	if (a_index >= 10) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload	
	}
}
guiChan("获取账号密码", statusx)
if (fileexist(a_workingdir "\7Acc\" sNum ".acc")) {
	loop, % a_workingdir "\7Acc\" sNum ".acc"
	{
		if (a_index = 1) {
			nGAPfZX := % A_LoopFileLongPath	;临时文件长路径，完成时删除
			nGANfZX := % A_LoopFileName	;账号名，在1-主线中另有存档，完成时移动文件到2-日常
			gac := % getL(nGAPfZX)	;获取账号名
			gps := % getL(nGAPfZX, 2)	;获取密码
		}
		break
	}
}
guiChan("输入账号密码", statusx)
dm.SetKeypadDelay("windows", 20)
Loop {
	DmMsCli(492, 205, 700)	;账号位置
	dm.SendString(winIDS, gac) ;输入账号
	sleep 1500
	DmMsCli(516, 247, 700)	;密码位置
	dm.SendString(winIDS, gps)
	sleep 1500
	if (!DmPicR("zhem.bmp", 310,161,461,231) and !DmPicR("mmem.bmp", 332,222,461,287))
		break
	else
		gosub, 清除账号密码
	if (a_index >= 6) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload
	}
}
guiChan("点击登录红钮", statusx)
Loop {
	DmcliI("dltb.bmp", 500, 500, 317, 608, 387)
	if DmPicR("dlyx.bmp", 474, 421, 561, 475) and !DmPicR("xfwq.bmp", 487, 292, 548, 373)	;找到登录黄钮且无新服务器显示时
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 20) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		Reload
	}
}
guiChan("点击登录黄钮", statusx)
Loop {
	DmcliI("dlyx.bmp", 800, 474, 421, 561, 475)
	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
	if DmPicR("dtz.bmp", 127,470,187,525) 	;正在读条
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 200
	if (a_index >= 50) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
}
guiChan("等待读条结束", statusx)
Loop {
	if DmPicR("dtz.bmp", 127,470,187,525)	;读条中
		sleep 500	
	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
	if (!DmPicR("wlcw111.bmp", 271, 164, 674, 375) and !DmPicR("dtz.bmp", 127,470,187,525))
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 80) {
		nnn := % sNum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		sleep 3000
		Reload
	}
}
Gui, Cancel
Sleep 800
Gui, Show
settimer, 盟主流程, -100
return



清除账号密码:
guiChan("清除账号密码", statusx)
loop {
	DmMsCli(492, 205, 500)
	loop 15 {	;删除账号
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	DmMsCli(516,247, 500)
	loop 15 {	;删除密码
		dm.KeyDown(8)
		sleep 20
		dm.KeyUp(8)
		sleep 20
	}
	sleep 500
	if DmPicR("qksj.bmp", 311, 157, 434, 297, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	if (a_index >= 10) 
		Reload	
}


return






guiChan(newtex, ByRef gVar) { ;GUI改变函数
	GuiControl, , gVar, % newtex
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

delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
}

DmSendW(tex, hwndx, slpt := 0) {	;发送文本到窗口,成功发送将延迟
	dm.SetKeypadDelay("windows", 50)
	cl := dm.SendString(hwndx, tex)
	if cl
		Sleep, % slpt
}

DmMsCli(x, y, slpt := 0) {	;大漠点击函数
	dm.MoveTo(x, y)
	sleep 50
	dm.LeftDown()
	sleep 50
	dm.LeftUp()
	Sleep, % slpt
}

DmMsDrag(x1, y1, x2, y2, slpt := 0) {	;大漠鼠标点击拖行
	dm.MoveTo(x1, y1)
	sleep 100
	dm.LeftDown()
	sleep 100
	dm.MoveTo(x2, y2)
	sleep 300
	dm.LeftUp()
	Sleep, % slpt
}


DmPieCli(x1, y1, x2, y2, ColorX, slpt := 0,MH := 1) {	;搜色点击，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		Sleep, % slpt
		DmMsCli(x[], y[])
	}
}

DmPieClO(x1, y1, x2, y2, ColorX, xx, yy, slpt := 0,MH := 1) {	;搜色点击它处，模糊匹配默认为1,从左到右从上下
	x := ComVar(), y := ComVar()
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x.ref, y.ref)
	if (cl) {	
		DmMsCli(xx, yy)
		Sleep, % slpt
	}
	else
		Sleep 5
}

DmPieR(x1, y1, x2, y2, ColorX,MH := 1) {	;搜色判断，模糊匹配默认为1,从左到右从上下
	cl := dm.FindColor(x1, y1, x2, y2, ColorX, MH, 0, x, y)
	return % cl
}

;大漠点击图片函数, 为大漠坐标
DmcliI(picName, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x.ref, y.ref)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(x[], y[])
		Sleep, % slept
	}
}

;大漠点击它处函数，为大漠坐标
DmcliO(xx, yy, picName, slept := 0, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
	gotEL := % gotEL + 1
	if (gotEL) {
		DmMsCli(xx, yy)
		Sleep, % slept
	}
}

;大漠图片查找函数，找到返回1，无返回0
DmPicR(picName, x1 := 0, y1 := 0, x2 := 960, y2 := 540, RGBm := "080808", MH := 0.9) {
	gotEL := dm.FindPic(x1, y1, x2, y2, picName, RGBm, MH, 0, x, y)
	gotEL := % gotEL + 1
	if gotEL 
		return 1
	else
		return 0
}



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
