#Persistent
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%

	gosub, FirstDeclare		;1.声明全局变量
	GUI_Cre()				;2.创建GUI
	KeyWait, enter, D
	pic_instead("backG", "fightUI.jpg")
	return



;声明变量
FirstDeclare:
	global pic_Path := % A_WorkingDir "\pic"
	global backG	;背景图片_初始背景
	return
	
;创建GUI	
GUI_Cre() {
	pic_add("backG", 0, 0, 720, -1, "start.jpg")
	gui, -SysMenu -Caption
	Gui, show, h720 w720, Hexagon	
}


;增加图片元素
pic_add(picVname, x, y, w, h, picFileName) {
	gui,add, picture, v%picVname% x%x% y%y% w%w% h-1, % pic_Path "\" picFileName
}

;图片替换
pic_instead(picV, insteadpicName) {
	GuiControl, , % picV, % pic_Path "\" insteadpicName
}




~Esc::
ExitApp


