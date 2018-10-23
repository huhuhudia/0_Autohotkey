#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
SetWorkingDir %a_scriptdir%
HL001qd := % "*10 " a_workingdir "\picture\HL001qd.png"
HL002sy := % "*10 " a_workingdir "\picture\HL002sy.png"
hl003ry := % "*10 " a_workingdir "\picture\hl003ry.png"
hl005jm1 := % "*10 " a_workingdir "\picture\hl005jm1.png"
hl006wx := % "*10 " a_workingdir "\picture\hl006wx.png"
HL007wx1 := % "*10 " a_workingdir "\picture\HL007wx1.png"
hl008wx2 := % "*10 " a_workingdir "\picture\hl008wx2.png"
hl009hd := % "*10 " a_workingdir "\picture\hl009hd.png"
HL010jy := % "*10 " a_workingdir "\picture\HL010jy.png"
HL011tqj := % "*10 " a_workingdir "\picture\HL011tqj.png"
hl012jyx := % "*10 " a_workingdir "\picture\hl012jyx.png"
hl013db := % "*10 " a_workingdir "\picture\hl013db.png"
hl015jb := % "*10 " a_workingdir "\picture\hl015jb.png"
hl016sjb := % "*10 " a_workingdir "\picture\hl016sjb.png"
hl017tdtc1 := % "*10 " a_workingdir "\picture\hl017tdtc1.png"
hl018tdtc2 := % "*10 " a_workingdir "\picture\hl018tdtc2.png"
hl019jyx := % "*10 " a_workingdir "\picture\hl019jyx.png"
hl020dl := % "*10 " a_workingdir "\picture\hl020dl.png"
hl021hd := % "*10 " a_workingdir "\picture\hl021hd.png"
hl022gx := % "*10 " a_workingdir "\picture\hl022gx.png"
hl023dfx := % "*10 " a_workingdir "\picture\hl023dfx.png"
hl025tc := % "*10 " a_workingdir "\picture\hl025tc.png"
hl026js1 := % "*10 " a_workingdir "\picture\hl026js1.png"
hl027js2 := % "*10 " a_workingdir "\picture\hl027js2.png"
hl028yx := % "*10 " a_workingdir "\picture\hl028yx.png"
hl029bab := % "*10 " a_workingdir "\picture\hl029bab.png"
hl030cs := % "*10 " a_workingdir "\picture\hl030cs.png"
hl031dt := % "*10 " a_workingdir "\picture\hl031dt.png"
hl032xmld := % "*10 "  a_workingdir "\picture\hl032xmld.png"
hl033ry := % "*10 " a_workingdir "\picture\hl033ry.png"
hl035bos := % "*10 " a_workingdir "\picture\hl035bos.png"
hl036wq := % "*10 " a_workingdir "\picture\hl036wq.png"
hl037hs := % "*10 " a_workingdir "\picture\hl037hs.png"
hl038hs := % "*10 " a_workingdir "\picture\hl038hs.png"
hl039xmzb := % "*10 " a_workingdir "\picture\hl039xmzb.png"
hl050qd := % "*10 " a_workingdir "\picture\hl050qd.png"
hl051jy := % "*10 " a_workingdir "\picture\hl051jy.png"
HL052jy := % "*13 " a_workingdir "\picture\HL052jy.png"
hl053jy := % "*10 " a_workingdir "\picture\hl053jy.png"

hl055htg := % "*10 " a_workingdir "\picture\hl055htg.png"
hl056kf := % "*10 " a_workingdir "\picture\hl056kf.png"



SetTimer, mainHelp, 10
return

mainHelp:

IfWinNotExist, 天帝宝库
	ExitApp
	
Loop
{
	if !getL(a_workingdir "\CHjeon\NowGo.id", 1)
		sleep 50
	else
		break
}

;---1.图片点击函数
;cliI(thePathi, cx1, cy1, cx2, cy2)
;---2.点击它处函数
;cliO(ox1, oy1, thepatho, ox2, oy2, ox3, oy3)
;---3.搜图至下一流程函数
;imaG(filpath, fin_x1, fin_y1, fin_x2, fin_y2, next_sub)
cliI(HL001qd, 451, 408, 476, 432)	;离线经验开头1，无抢夺
cliI(HL002sy, 815, 355, 836, 376)	;右侧弹窗使用物品

cliO(774, 136, hl003ry, 436, 420, 459, 443)	;攻城弹窗
cliO(667, 115, hl019jyx, 459, 455, 484, 479)	;黄金会员经验玉符点x
cliO(394, 381, hl018tdtc2, 476, 318, 509, 346)	;天帝宝库元宝弹窗取消
cliO(813, 94, hl028yx, 436, 76, 460, 97)	;玉虚仙境关闭
cliO(928, 75, hl035bos, 28, 33, 56, 64)	;boss大厅界面关闭
imaG(hl022gx, 179, 300, 204, 323, "更新公告关闭")
imaG(hl006wx, 809, 225, 830, 243, "温馨提示取消")
imaG(HL010jy, 422, 458, 447, 479, "经验玉符")
imaG(hl005jm1, 932, 147, 958, 179, "显示顶上图标")
imaG(hl013db, 906, 331, 916, 345, "显示底部菜单")

imaG(hl017tdtc1, 476, 316, 508, 347, "天帝宝库元宝弹窗")	;元宝弹窗打钩
imaG(hl020dl, 449, 440, 485, 476, "点击登录")	;元宝弹窗打钩


cliO(936, 227, hl008wx2, 753, 361, 776, 389)	;温馨提示点叉
cliO(736, 130, hl015jb, 328, 122, 356, 153)	;绝版神兽点x
cliO(918, 316, hl016sjb, 875, 327, 902, 358)	;世界boss活动右下弹窗提醒点x
cliO(919, 347, hl021hd, 877, 358, 903, 388)	;答题活动右下角弹窗点x
cliO(920, 74, hl023dfx, 7, 36, 36, 69)	;巅峰竞技关闭
cliO(821, 99, hl026js1, 453, 84, 474, 105)	;集市关闭1
cliO(748, 117, hl031dt, 452, 100, 478, 122, 300)	;答题活动关闭
cliO(923, 73, hl032xmld, 76, 36, 107, 66)	;仙盟领地关闭
cliO(751, 123, hl036wq, 449, 102, 470, 120)	;温泉界面关闭
cliO(750, 120, hl037hs, 435, 104, 459, 126)	;护送仙女关闭
cliO(748, 117, hl038hs, 481, 100, 504, 123)	;决战华山关闭
cliO(750, 119, hl039xmzb, 436, 101, 459, 121)	;仙盟争霸活动关闭
cliO(779, 77, hl051jy, 445, 57, 471, 83)	;酒宴关闭




cliO(792, 92, hl055htg, 477, 481, 515, 510)	;元宝争霸，回头干他
cliO(852, 102, hl056kf, 356, 91, 386, 121)	;元宝争霸点叉

cliI(hl027js2, 808, 83, 836, 118)	;集市关闭2
cliI(hl030cs, 463, 341, 482, 362, 800)	;图标处登录重试点击钮
cliI(hl033ry, 754, 117, 792, 155)	;全服最高荣耀
cliI(hl050qd, 452, 447, 475, 469)	;上线离线挂机两格点击确定
imaG(hl029bab, 363, 235, 382, 253, "版本更新回到主界面")	;元宝弹窗打钩
cliO(774, 77, HL052jy, 439, 55, 473, 83)	;酒宴关闭2
cliO(614, 365, hl053jy, 498, 354, 539, 378)	;vip1经验提取

imaG(hl025tc, 331, 243, 355, 267, "退出游戏按钮取消")	;退出游戏按钮取消

cliI(hl009hd, 495, 226, 514, 245)	;获得物品随机点

return

版本更新回到主界面:
cliO(980, 510, hl029bab, 363, 235, 382, 253)	;版本更新回到主界面
sleep 1000
return

退出游戏按钮取消:
sleep 800
cliO(405, 356, hl025tc, 331, 243, 355, 267)
return

更新公告关闭:
SLEEP 1200
IF picR(hl022gx, 179, 300, 204, 323)
{
	MouseClick, L, 833, 88, 1, 0
}
return

天帝宝库元宝弹窗:
cliO(492, 331, hl017tdtc1, 476, 316, 508, 347)	;天帝宝库元宝弹窗
sleep 500
return

点击登录:
sleep 1500
cliI(hl020dl, 449, 440, 485, 476)
return

显示顶上图标:
cliI(hl005jm1, 932, 147, 958, 179)	;显示顶上图标
sleep 500
return

显示底部菜单:
cliI(hl013db, 906, 331, 916, 345)	;显示底部菜单
return

温馨提示取消:
cliO(766, 376, HL007wx1, 752, 362, 780, 389)	;点击打钩
sleep 500
return

经验玉符:
cliI(HL011tqj, 595, 308, 612, 326)	;点击提取经验
cliO(665, 117, hl012jyx, 364, 138, 384, 158)	;关闭经验玉符
return

;---1.图片点击函数
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
;---2.点击它处函数
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
;---3.搜图至下一流程函数
imaG(filpath, fin_x1, fin_y1, fin_x2, fin_y2, next_sub)
{
	imagesearch, , , %fin_x1%, %fin_y1%, %fin_x2%, %fin_y2%, %filpath%
	if !errorlevel
	{
		gosub, %next_sub%
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
			msgbox, 错误`n判断图片路径错误
		}
		if errorlevel = 1
		{
			return 0
		}
	}
}
