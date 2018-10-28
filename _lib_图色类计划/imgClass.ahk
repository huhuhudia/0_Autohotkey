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