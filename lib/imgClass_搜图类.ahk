/*
一、img类-创建图片搜索对象：

	thepic := new img([1]"img001.png", [2]100, [3]100, [4]200, [5]200, [6]a_scriptdir "\pic", [7]500, [8]"*60 ",[9]560, [10]200) 
		[ 1 ]:文件名    
		[2-5]:可省，默认范围右下角为屏幕分辨率  
		[ 6 ]:可省，默认A_WorkingDir    
		[ 7 ]:可省，默认为0点击后休眠时间
		[ 8 ]:可省，默认为空字符串，
		[9-10]:可省，与imgCOr()相关搜索到图片时默认点击坐标，默认0, 0
	
方法：
	thepic.setscr() ;设定图色与鼠标 相对全屏
	thepic.setwin()	;设定图色与鼠标 相对窗口
	
	result := thepic.imgRBl()	;执行搜索，返回布尔值结果赋值给result，返回1为找到，0为未找到
	result := thepic.imgRLs()	;执行搜索，返回[x, y]列表结果赋值给result，找到图片返回result[1]为x坐标，result[2]为y坐标，result为空时未找到图片
		
	thepic.imgMM()				;执行搜索，找到图片移动鼠标到搜索图片的位置，返回1，未找到图片返回false
	thepic.imgCli()				;执行搜索，找到图片点击图片位置，返回1，未找到返回false
	thepic.imgCOr()				;执行搜索，找到图片点击预设对象第9，第10个坐标参数，返回1，未找到返回false
	
	result := thepic.imgSRgRLs(x1, y1, x2, y2)	;临时设置搜索范围，找到返回列表[x, y]，未找到返回false
	thepic.imgSRgCli(x1, y1, x2, y2)			;临时设置搜索范围，找到点击目标，返回1，未找到返回flase
	thepic.imgCOr2(xx1, yy1, , , , )	;临时设置其他点击位置，后四个参数范围坐标可不填，默认0,0-分辨率宽高
	
	thepic.info()				;弹窗显示对象预设参数


二、imgMix类-创建图片搜索集体对象：
	首先创建前置img对象：
		thepic1 := new img("img001.png")
		thepic2 := new img("img002.png")
		
	创建imgMix类,唯一参数是对象列表
		theMixpic := new imgMix([thepic1, thepic2])
		
	方法:
	result := theMixpic.gOnce()	;图片集thepic1, thepic2至少找到一次图片,返回result := 1，无找到返回0
	
		反例: if !(theMixpic.gOnce()) --- >此为未找到图片if将执行
		
	result := theMixpic.gAll()	;图片集中的图片都被找到返回result := 1
	
		反例: if !(theMixpic.gAll()) --- >未全部找到图片if 将执行
		
	theMixpic.cliAllF() 		;此方法将点击图片合集中所有找到的图片
	
	
*/


Class imgMix {
	__New(imgobjlist) {
		this.imgObjList := imgobjlist
	}
	gOnce() {	;got once least
		for i in this.imgObjList
		{
			if (this.imgObjList[i].imgRBl())
				return 1
		}
		return 0
	}
	gAll() {	;got all imagine
		for i in this.imgObjList
		{
			if !(this.imgObjList[i].imgRBl())
				return 0
		}
		return 1
	}
	cliAllF() {	;click all imagine found
		for i in this.imgObjList
		{
			this.imgObjList[i].imgCli()
		}		
	}
}

Class img {
	__New(imgfileName, SP_x1 := 0, SP_y1 := 0, SP_x2 := 0, SP_y2 := 0, picDir := 0, slept := 0, searchEx := 0 ,otrvClikP_x := 0, otrvClikP_y := 0) {
		;if Searching range pos (SP_x1, SP_y1) got empty, set them with A_ScreenWidth && A_ScreenHeight
		if !SP_x2
			SP_x2 := A_ScreenWidth
		if !SP_y2
			SP_y2 := A_ScreenHeight
		
		;send msg to user, if they set wrong searching pos
		if if ((SP_x1 >= SP_x2) || (SP_y1 >= SP_y2))
			MsgBox, % this " got wrong `[Searching Pos value`]  in!"
		
		;seting the searching range of the imagine
		this.x1 := SP_x1
		this.y1 := SP_y1
		this.x2 := SP_x2
		this.y2 := SP_y2
		
		;send msg to user, if he didn't set imagine file name
		if !imgfileName
			MsgBox, % this " got none `[imgfileName`] in!"
		this.name := imgfileName
		
		;when imagine file direction got empty, set it in the A_WorkingDir
		if !picDir		
			this.dir := A_WorkingDir
		
		;enhance the searching rule
		if !searchEx	;增强查找
			this.ex := ""

		;using function this.imgCOr() click those two pos
		this.ox := otrvClikP_x
		this.oy := otrvClikP_y
		
		;click wait
		this.slept := slept
	}
	imgRBl() {		;1.imagine search return bool, success got return 1，nothing found return false
		ImageSearch, , , % this.x1, % this.y1, % this.x2, % this.y2, % this.ex this.dir "\" this.name
		if !errorlevel 
			return 1
		else if errorlevel = 2
			msgbox, , % "object " this " warning!", % " Wrong path：`n`[" this.ex this.dir "\" this.name "`]`nnot exist！`n" 
	}
	imgRLs() {		;2.imgine search return list, success got return poslist, nothing found return false
		ImageSearch, _posx, __posy, % this.x1, % this.y1, % this.x2, % this.y2, % this.ex this.dir "\" this.name
		if !errorlevel 
			posList := [_posx, __posy]
		else if errorlevel = 2
			msgbox, , % "object " this " warning!", % " Wrong path：`n`[" this.ex this.dir "\" this.name "`]`nnot exist！`n" 		
		return % posList
	}
	imgMM() {		;3.if found imgine, move to the found pos, return 1
		if (result := this.imgRLs()) {
			MouseMove, % result[1], % result[2], 0
			return 1
		}
	}
	imgCli() {		;4.if found imgine, click the found pos, return 1
		if (result := this.imgRLs()) {
			MouseClick, L, % result[1], % result[2], 1, 0
			sleep, % this.slept
			return 1
		}
	}
	imgCOr() {		;5.if found imgine, click the found pos, return 1
		if (result := this.imgRBl())
			MouseClick, L, % this.ox, % this.oy, 1, 0
			sleep, % this.slept
			return 1
	}
	
	imgSRgRLs(x1, y1, x2, y2) {
		ImageSearch, _posx, __posy, % x1, % y1, % x2, % y2, % this.ex this.dir "\" this.name
		if !errorlevel 
			posList := [_posx, __posy]
		else if errorlevel = 2
			msgbox, , % "object " this " warning!", % " Wrong path：`n`[" this.ex this.dir "\" this.name "`]`nnot exist！`n" 		
		return % posList		
	}
	
	imgSRgCli(x1, y1, x2, y2) {
		if (result := this.imgSRgRLs(x1, y1, x2, y2)) {
			MouseClick, L, % result[1], % result[2], 1, 0
			sleep, % this.slept
			return 1			
		}
	}

	imgCOr2(xx1, yy1,x1 := 0, y1 := 0, x2 := 0, y2 := 0) {		;5.if found imgine, click the found pos, return 1
		if !x2
			x2 := this.x2
		if !y2
			y2 := this.y2
		
		if ((result := this.imgSRgRLs(x1, y1, x2, y2))) {
			MouseClick, L, % xx1, % yy1, 1, 0
			sleep, % this.slept
			return 1
		}
	}
	
	setscr() {		;6.set coormode mouse and pixel effect full screen
		CoordMode, Mouse, screen
		CoordMode, Pixel, screen
		return 1
	}
	setwin() {		;7.set coormode mouse and pixel only effect window
		CoordMode, Mouse, WINDOW
		CoordMode, Pixel, WINDOW
		return 1
	}
	info() {		;8.get img set information
		MsgBox, , % "Imagine object      `[" this "`] searching information", % "1.imagine file name:`n---> " this.name "`n2.direction:`n---> " this.dir "`n3.searching range:`n---> " this.x1 ", " this.y1 " -- " this.x2 "," this.y2 "`n4.Seaching Ex:`n---> " this.ex "`n5.searching other click:`n---> " this.ox "," this.oy
	}
}