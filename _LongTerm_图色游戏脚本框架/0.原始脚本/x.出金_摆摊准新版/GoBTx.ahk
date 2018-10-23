
/*
SMode := % "小精华"
Snum := 1
WkiWin := % "BT1"
TisWin := % "GoBT1"
*/

#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%

global PDQH	;判断切号变量
global SMode

global dm := ComObjCreate( "dm.dmsoft" )	;创建大漠对象
dm.SetPath(A_WorkingDir "\dmpic\")
global x := ComVar(), global y := ComVar()

topDir := % delStrL(a_workingdir, 11)	;顶部路径
LdPath := getL(topDir "\PathOfLD_x.path")	;获取雷电模拟器路径
LdCtrlLP := % LdPath "\dnconsole.exe"	;雷电中控路径
toDay := % A_YYYY A_MM A_DD
TWM := % "〕≡∏◇|⊥■"	;此为摊位名

gui, font, ceaedcd, 微软雅黑		;字体与颜色
Gui, Color, 161a17				;窗口颜色
Gui, -Caption -SysMenu +AlwaysOnTop

Gui, Add, Text, x6 y7 w80 h20 , 脚本状态：
Gui, Add, Text, x86 y7 w80 h20 , %WkiWin%

Gui, Add, Text, vStatusx x6 y27 w160 h20 , Waiting for command...

if Snum = 1
	winPX := 1550, winPY := 30
else if Snum = 2
	winPX := 1730, winPY := 30
else if Snum = 3
	winPX := 1550, winPY := 90
else if Snum = 4
	winPX := 1730, winPY := 90

Loop {
	if !WINEXIST(WkiWin)
		break
	else {
		guiChan("关闭模拟器重启", Statusx)
		nnn := % Snum - 1
		RunWait, % "cmd.exe /c " LdCtrlLP " quit --index " nnn, , Hide
		Sleep 3000
		break
	}
}

Gui, Show, x%winPX% y%winPY% h55 w176, %TisWin%
gosub, 启动模拟器
return

GuiClose:
ExitApp

启动模拟器:
guiChan("  状态：启动模拟器", Statusx)
nnn := % Snum - 1

RunWait, % "cmd.exe /c " LdCtrlLP " launch --index " nnn, , Hide

if (Snum = 1) {	;启动模拟器
	WinWait, 雷电模拟器
	Sleep 700
	WinSetTitle, 雷电模拟器, , % WkiWin, % "雷电模拟器-"
}
else {
	WinWait, % "雷电模拟器-" nnn
	Sleep 300
	WinSetTitle, 雷电模拟器, , % WkiWin	
}

;移动窗口
if Snum = 1
	WinMove, % WkiWin, , 1, 1
else if Snum = 2
	WinMove, % WkiWin, , 550, 1
else if Snum = 3
	WinMove, % WkiWin, , 1, 455
else if Snum = 4
	WinMove, % WkiWin, , 550, 455
sleep 300
SetTimer, 登录游戏, -100

return

登录游戏:
if !qiehao
{
winIDF := dm.FindWindow("LDPlayerMainFrame", WkiWin) ;父窗口ID
winIDS := dm.EnumWindow(winIDF, "TheRender","",1)	;子窗口ID 
dm.BindWindow(winIDS,"gdi","windows","windows",0)	;设定所有坐标相对窗口绑定 
}
guiChan("  状态：点击幻剑图标", Statusx)
Loop {
	DmcliI("icon.bmp", 500, 438, 29, 523, 112, "080808", 0.9)
	if DmPicR("dltb.bmp", 500,317,608,387, "080808", 0.9)
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 40) 
		Reload	
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
	if (a_index >= 10) 
		Reload	
}
guiChan("获取账号密码", statusx)
if (fileexist(a_workingdir "\Acc\" Snum "\*.acc")) {
	loop, % a_workingdir "\Acc\" Snum "\*.acc"
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
else {
	guiChan("该脚本结束,查询邻近文件夹", statusx)
	if Mod(Snum, 2)
		findAnother := % Snum + 1
	else
		findAnother := % Snum - 1
	loop, % a_workingdir "\Acc\" findAnother "\*.acc"
		dlxxx := % A_Index
	if (dlxxx >= 3) {
		clxxx := % dlxxx - 1
		loop, % a_workingdir "\Acc\" findAnother "\*.acc"
		{
			if (a_index = clxxx) {
				nGAPfZX := % A_LoopFileLongPath	;临时文件长路径，完成时删除
				nGANfZX := % A_LoopFileName	;账号名，在1-主线中另有存档，完成时移动文件到2-日常
				gac := % getL(nGAPfZX)	;获取账号名
				gps := % getL(nGAPfZX, 2)	;获取密码
				FileMove, % nGAPfZX, % A_WorkingDir "\Acc\" Snum "\" nGANfZX, 1
				break
			}
		}
	}
	else {
		Gui, Cancel
		Sleep 1000
		Gui, Show
		guiChan("该脚本任务结束", statusx)
		return
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
	if (a_index >= 6) 
		Reload
}
guiChan("点击登录红钮", statusx)
Loop {
	DmcliI("dltb.bmp", 500, 500, 317, 608, 387)
	if DmPicR("dlyx.bmp", 474, 421, 561, 475) and !DmPicR("xfwq.bmp", 487, 292, 548, 373)	;找到登录黄钮且无新服务器显示时
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 20) 
		Reload
}
guiChan("点击登录黄钮", statusx)
Loop {
	DmcliI("dlyx.bmp", 800, 474, 421, 561, 475)
	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		sleep 1000
		Reload
	}
	if DmPicR("dtz.bmp", 127,470,187,525) 	;正在读条
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 200
	if (a_index >= 50) 
		Reload
}
guiChan("等待读条结束", statusx)
Loop {
	if DmPicR("dtz.bmp", 127,470,187,525)	;读条中
		sleep 500	
	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		sleep 1000
		Reload
	}
	if (!DmPicR("wlcw111.bmp") and !DmPicR("dtz.bmp", 127,470,187,525))
		break
	;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>所有循环等待时间及超时纠错
	sleep 500
	if (a_index >= 80) 
		Reload	
}
guiChan("即将进行主要流程", statusx)
Gui, Cancel
Sleep 1000
Gui, Show
SetTimer, 主要流程, -1000
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

主要流程:

guiChan("主要流程", statusx)

if DmPicR("btzpzy.bmp", 355, 205, 405, 246, "080808", 0.7)	;招牌字样
or DmPicR("shurukuang.bmp", 329, 7, 450, 91, "080808", 0.7) {	;输入框
	SetTimer, 摆摊流程, -100
	return
}

else if DmPicR("btstjm.bmp", 154, 403, 254, 454)	;出售界面或者收摊界面
or DmPicR("btcsjm.bmp", 444, 346, 483, 388) {
	SetTimer, 摆摊流程, -100
	return
}

else if DmPicR("bbx.bmp", 899, 214, 950, 261, "080808", 0.7) ;有背包
and DmPicR("bticon.bmp", 537, 353, 594, 413, "080808", 0.7) { ;有摊位icon
	SetTimer, 摆摊流程, -100		;最终回到主界面
	return
}

else if DmPicR("bbx.bmp", 899, 214, 950, 261, "080808", 0.7) 
and !DmPicR("bticon.bmp", 538, 356, 594, 416, "080808", 0.7) {
	sleep 500
	if DmPicR("bticon.bmp", 538, 356, 594, 416, "080808", 0.7) {
		SetTimer, 摆摊流程, -100		;最终回到主界面
		return		
	}
	SetTimer, 飞向集市
	return
}

else if DmPicR("dtdqdtr.bmp", 827, 123, 882, 219) ;当前地图为红
or  DmPicR("dtsjdt.bmp", 839, 223, 884, 316) {	;世界地图为红
	SetTimer, 飞向集市, -100	
	return
}


else {
	SetTimer, 关闭所有无用界面, -100
	return
}
return

摆摊流程:
if !pl
	pl := 1
else
	pl := % pl + 1
if !Mod(pl, 10) {
	pl :=
	SetTimer, 关闭所有无用界面, -100
	return
}
DmcliI("bticon.bmp", 800, 537, 353, 594, 413)	;点击摆摊图标

if DmPicR("btzpzy.bmp", 355, 205, 405, 246)	{	;摆摊字样
	if DmPicR("btzpsxzy.bmp", 417, 213, 451, 254)	;为所需招牌
		DmMsCli(468, 340, 500)
	else {
		DmMsCli(506, 227, 500)
		loop 15 {	;删除原招牌
			dm.KeyDown(8)
			sleep 20
			dm.KeyUp(8)
			sleep 20
		}
		sleep 200
		dm.SendString(winIDS, TWM)
		sleep 500
	}
}
if DmPicR("shurukuang.bmp", 329, 7, 450, 91)	;搜索到输入框，直接点击空白处
	DmMsCli(464, 174, 800)
if DmPicR("btstjm.bmp", 154, 403, 254, 454) {	;搜索到收摊字样
	sleep 300
	;若未搜索到左侧第一格有物品，则上架商品，若无商品，收摊切号
	if DmPicR("blankleft.bmp", 156, 122, 213, 178) {	;左侧第一格无物
		if DmPicR("blankright.bmp", 541, 140, 584, 188) { ;1.右侧第一格完全为空白，直接切号
			loop  {
				sleep 300
				if DmPicR("blankright.bmp", 541, 140, 584, 188) {
					if !ggxxx
						ggxxx := 1
					else
						ggxxx := % ggxxx + 1
				}
				else {
					ggxxx :=
					break
				}
				if ggxxx >= 5
				{
					ggxxx :=
					SetTimer, 切号, -100
					return
				}
			}
		}
		else {
			if SMode = % "无差别"
				DmMsCli(566, 163, 700)	;第一格商品
		}
		
		;3.选择材料收菜方式
		DMcliCL("小精华", "bscl.bmp")
		DMcliCL("猎手", "lscl.bmp")
		DMcliCL("小檀", "xtcl.bmp")
		DMcliCL("后羿", "hycl.bmp")
		DMcliCL("牛魔", "nmcl.bmp")
		DMcliCL("嫦娥", "cecl.bmp")
		if (PDQH) {
			SetTimer, 切号, -100
			return
		}
			
	}
	;若有商品，摆摊点叉		
	else 
		DmMsCli(819, 68, 200)
}
if DmPicR("btcsjm.bmp", 444, 346, 483, 388) {	;搜索到出售界面
	loop 2
		DmMsCli(599, 245, 300)
	if DmPicR("btwuyb.bmp", 396, 264, 477, 306) {	;无元宝
		loop 2
			DmMsCli(476, 280, 500)		
	}
}
if DmPicR("shurukuang.bmp", 329, 7, 450, 91)	;搜索到输入框，直接点击空白处
	DmMsCli(464, 174, 500)
if DmPicR("btyb1.bmp", 395, 261, 467, 302)	;搜索到1元宝,点击出售
	DmMsCli(479, 358, 500)
SetTimer, 主要流程, -100
return



切号:
loop 2
	DmcliI("btstjm.bmp", 300, 154, 403, 254, 454)
PDQH := 
Del_F(A_WorkingDir "\Acc\" Snum "\" nGANfZX)
FileAppend, % "`n" nGANfZX, % A_WorkingDir "\note\" A_YYYY A_MM A_DD ".note", UTF-8
guiChan("退出游戏", statusx)
loop {
	ControlClick, x980 y462, % "BT" SNum
	Sleep 1300
	DmcliI("tcyxqd.bmp", 1200, 503, 278, 611, 369, "080808", 0.8)	;点击退出确定
	if DmPicR("icon.bmp", 438, 29, 523, 112, "080808", 0.8)
		break
	if a_index >= 10
		Reload
}
qiehao := 1
SetTimer, 登录游戏, -100
return 

DMcliCL(CLN, picN) {	;一次性函数，摆摊选择材料
	if SMode = % CLN
	{
		if DmPicR(picN, 526, 127, 805, 266, "030303", 0.6)
			DmcliI(picN, 700, 526, 127, 805, 266, "030303", 0.6)	;点击材料物品
		else {
			Loop {
				if !DmPicR(picN, 526, 127, 805, 266, "030303", 0.6) {	;未找到需要的图标
					if !bl
						bl := 1
					else
						bl := % bl + 1
				}
				else
					break
				if (bl >= 7) {
					PDQH := 1
					break
				}
				Sleep 300
			}
		}
	}
}


关闭所有无用界面:
Loop {
	if DmPicR("wlcw111.bmp", 271, 164, 674, 375) {	;网络错误时
		sleep 1000
		Reload
	}
	if DmPicR("shurukuang.bmp", 329, 7, 450, 91)	;搜索到输入框，直接点击空白处
		DmMsCli(464, 174, 800)
	guiChan("关闭所有无用界面", statusx)
	
	DmcliO(920,281, "hdkq1.bmp", 500, 678, 446, 850, 533)	;关闭右下活动弹窗，前往参与 1
	DmcliO(917,279, "qwcy2.bmp", 500, 699, 458, 842, 529)	;关闭右下活动弹窗，前往参与 2
	DmcliO(829, 52, "fljm.bmp", 500, 437, 40, 523, 83, "080808", 0.7)	;关闭福利主界面
	DmcliI("cdwpandj1.bmp", 500, 873, 217, 960, 325)	;点击穿戴物品
	DmcliO(765, 339, "wxtshn.bmp", 800, 740, 317, 787, 370)	;温馨提示灰圈，不再提醒
	DmcliO(849, 69, "kfybzbs.bmp", 500, 339, 58, 439, 97, "080808", 0.8)	;跨服元宝争霸赛
	DmcliO(791, 59, "kfybzbgjx.bmp", 500, 409, 424, 551, 501, "080808", 0.8)	;跨服元宝争霸赛
	DmcliO(770, 99, "fwqzgrybm.bmp", 500, 408, 368, 566, 432)	;服务器最高荣耀
	DmcliO(757, 92, "dati01x.bmp", 500, 417, 48, 545, 105)	;答题弹窗关闭
	DmcliO(775, 117, "qyjmgbxdfx.bmp", 500, 440, 67, 526, 139)	;情缘弹窗点x
	DmcliI("lxjyqdx.bmp", 800, 403, 342, 568, 438)	;开头离线经验确定
	DmcliI("sywp1.bmp", 500, 744, 286, 932, 380)	;使用物品小弹窗（通用）
	DmcliI("hdwp1.bmp", 500, 455, 143, 556, 249)	;中心位置获得物品 - 单排（通用）
	
	DmcliO(924, 40, "jshsjm.bmp", 500, 34, 1, 122, 39)	;关闭魂兽界面
	DmcliO(816, 72, "xxjmdx.bmp", 500, 559, 178, 643, 230)	;物品信息点叉
	DmcliO(815, 74, "tjgb.bmp", 500, 466, 20, 548, 103)	;天机结婚弹窗关闭
	
	DmcliO(815, 74, "bbdaaa.bmp", 500, 352, 54, 418, 91)	;跨服元宝争霸点x
	DmcliO(793, 57, "bbdaab1.bmp", 500, 449, 445, 513, 475)	;跨服元宝争回头干他点x
	
	
	DmcliO(921, 42, "mrbzjm.bmp", 500, 9, 1, 136, 38)	;每日必做界面关闭
	
	
	DmcliO(755, 85, "jzhskdx.bmp", 500, 426, 62, 536, 102)	;决战华山弹窗关闭
	
	DmcliO(934, 189, "wxtsdg.bmp", 500, 736, 314, 788, 366, "090909", 0.7)	;温馨提示打钩了，点叉
	
	DmcliI("tqjy1.bmp", 500, 546, 254, 687, 313)	;单倍提取位置
	DmcliO(664, 79, "tqjyvip.bmp", 500, 409, 401, 558, 477)	;提升vip等级，点叉
	
	DmcliO(662, 80, "jycwhjhy.bmp", 500, 423, 379, 550, 476)	;成为黄金会员 点叉
	
	
	DmcliO(664, 79, "jyyfx.bmp", 500, 422, 38, 537, 107)	;经验玉符点，点叉
	
	if DmPicR("dtdqdtr.bmp", 827, 123, 882, 219) ;当前地图为红
	or  DmPicR("dtsjdt.bmp", 839, 223, 884, 316) {	;世界地图为红
		SetTimer, 主要流程, -100
		return
	}
	/*
	if DmPicR("ckscjsjm.bmp", 439, 35, 486, 77, "080808", 0.8) 
	or DmPicR("cksctjtw.bmp", 194, 81, 268, 115) 
	or DmPicR("jsicon.bmp", 357, 348, 429, 415, "080808", 0.7) {	;当前在集市界面或者摊位界面
		SetTimer, 主要流程, -100
		return
	}
	*/
	if DmPicR("bbx.bmp", 899, 214, 950, 261, "080808", 0.7) {	;背包图标
		SetTimer, 主要流程, -100
		return
	}
	if DmPicR("btzpzy.bmp", 355, 205, 405, 246, "080808", 0.7)	;招牌字样
	or DmPicR("shurukuang.bmp", 329, 7, 450, 91, "080808", 0.7) {	;输入框
		SetTimer, 摆摊流程, -100
		return
	}
	if DmPicR("btstjm.bmp", 154, 403, 254, 454) {	;收摊字样
		SetTimer, 摆摊流程, -100
		return
	}
	if DmPicR("btcsjm.bmp", 444, 346, 483, 388) {	;出售界面
		SetTimer, 摆摊流程, -100
		return
	}

}
return

飞向集市:
guiChan("飞向集市", statusx)
DmcliI("dticon.bmp", 800, 911, 6, 956, 58)	;点击地图icon
if DmPicR("dtdqdtr.bmp", 827, 123, 882, 219) ;当前地图为红
or  DmPicR("dtsjdt.bmp", 839, 223, 884, 316) {	;世界地图为红

	if DmPicR("dtposws.bmp", 383, 383, 432, 424)	;望舒仙子
	or DmPicR("dtposjxt.bmp", 358, 114, 429, 180) {	;吉祥天
		loop 2
			DmMsCli(551, 113, 500)	;摊位坐标
		DmcliI("dtysjxxx.bmp", 1800, 815, 35, 847, 74)	;地图右上角的叉
		if DmPicR("bbx.bmp", 899, 214, 950, 261, "080808", 0.7) {	;背包图样
			dm.MoveTo(108, 389)
			sleep 200
			dm.LeftDown()
			sleep 800
			dm.LeftUp()
			sleep 100
		}
	}
	
	else 
		DmMsCli(864, 272, 700)
	
	DmcliI("dtsdicon.bmp", 800, 437, 279, 509, 328)	;点击神都icon
}
if DmPicR("dtposws.bmp", 383, 383, 432, 424)	;望舒仙子
or DmPicR("dtposjxt.bmp", 358, 114, 429, 180) {	;吉祥天

	loop 2
		DmMsCli(516, 134, 500)	;摊位坐标
	
	DmcliI("dtysjxxx.bmp", 1800, 815, 35, 847, 74)	;地图右上角的叉
	if DmPicR("bbx.bmp", 899, 214, 950, 261, "080808", 0.7) {	;背包图样
		dm.MoveTo(108, 389)
		sleep 200
		dm.LeftDown()
		sleep 800
		dm.LeftUp()
		sleep 100
	}
}
SetTimer, 主要流程, -100
return

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     必要函数
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


guiChan(newtex, ByRef gVar) { ;GUI改变文本函数，若为选择型控件，newText可为0或1
	GuiControl, , gVar, % newtex
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



delStrL(inputvar,countx := 0) { ;删除字符串后几位  
	StringTrimRight, ca, inputvar, % Countx
	return % ca
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

Del_F(filLP) { ;删除文件直到区确定无该文件
	Loop {
		IfExist, % filLP
			FileDelete, % filLP
		IfNotExist, % filLP
			break
	}
}