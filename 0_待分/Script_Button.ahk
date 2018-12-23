




^rButton:: ;ctrl + 右键 显示/隐藏按键界面
	;一、设定鼠标坐标全屏，作为界面显示窗口坐标
	CoordMode, mouse, screen	
	MouseGetPos, MPosX, MPosY
	;二、创建GUI
	if (soh := !soh) {
		
		
		;2.创建GUI按钮，按钮事件皆设定[A_Button]标签
		for fileName in Array_File
			gui,add, BUTTON, % "gButton_Event", % fileName
		
		;3.设定GUI始终置顶,显示GUI
			Gui, % "-SysMenu -Caption +AlwaysOnTop"
			gui, show, % "x" MPosX " y" MPosY
	}
	;三、销毁GUI
	else 
		gui, % "Destroy"
return

Button_Event:	;文件名按钮事件
	Run, % Array_File[A_GuiControl]		;1.运行子脚本，A_guicontrol内置变量为当前执行脚本承载的文本
	gui, % "Destroy"					;2.销毁窗口
	soh :=								;3.赋空soh,使下回快捷启动显示GUI
return

/* ===========================
        主脚本按键功能项
==============================
*/ #If (soh) ;-> 仅当GUI显示时 |

RButton::							;GUI界面存在时，右键也执行销毁界面功能
	gui, % "Destroy"
	soh := !soh
return



	
