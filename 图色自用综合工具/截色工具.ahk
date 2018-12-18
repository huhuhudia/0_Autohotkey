#SingleInstance force
编辑宽 := 200
gui, +toolwindow +alwaysontop

引号 = "
逗 = ,

gui, add, edit, x0  readonly w%编辑宽% v像素集控件, 像素集名称
gui, add, edit, x0  readonly w%编辑宽% v像素集范围, 
gui, add, edit, x0  readonly w%编辑宽% v像素列表控件,  

gui, add, text,x10 , ctrl+ 0 添加像素集名称
gui, add, text,x10 , ctrl+ 1 截取范围获取坐标列表
gui, add, text,x10 , ctrl+ 2 空格添加颜色入列表
gui, add, text,x10 , alt + v 粘粘像素集对象代码

lb高 := 150
gui, add, listbox, x0 w%编辑宽% H%lb高% v像素盒子
bt高 := 50
gui, add, button , x0 h%bt高% w%编辑宽% g删除色, ctrl + delete`n删除色
gui, add, button , x0 h30 w%编辑宽% g清空控件, 清空控件
显示位置X := (A_ScreenWidth - 600)
显示位置Y := 200

gui, show, X%显示位置X% Y%显示位置Y% w%编辑宽%,截色工具V1.0
像素列表 := []
return

清空控件:
	guicontrol, , 像素集范围, 
	guicontrol, , 像素列表控件, 
	guicontrol, , 像素盒子, |
	像素列表 := []
	return


!v::
	KeyWait, v
	Clipboard :=
	gui, submit, nohide
	Clipboard := %  像素集控件 . " := new 搜色类(" . 像素集范围 . 逗 . " " . 像素列表控件 . ")"
	ClipWait
	send, ^v
	return


^0::
	inputbox, 像素集名
	if 像素集名
		guicontrol, , 像素集控件, % 像素集名
		
	return

^1::
	CoordMode, mouse, screen
	等待按下超时 := 5
	等待弹起超时 := 10
	
	ToolTip, 等待按下鼠标左键`n1秒后超时
	keywait, rbutton, DT%等待按下超时%
	if errorlevel {
		ToolTip
		return
		}
	mousegetpos, 左上起点x, 左上起点y
	
	ToolTip, 长按鼠标移动至选取范围右下角
	keywait, rbutton, T%等待弹起超时%
	if errorlevel {
		traytip, , 超时未选取`n功能失效, 1
		ToolTip
		return
		}
	mousegetpos, 右下终点x, 右下终点y
	
	ToolTip
	gosub, 创建范围
	return

创建范围:
	global 大矩形宽 := % 右下终点x - 左上起点x
	global 大矩形高 := % 右下终点y - 左上起点y
	Gui, 子窗口: new
	Gui, 子窗口: color, 000000, 000000
	GUI, 子窗口: ADD, text, cffffff,Enter回车执行创建小矩形`nEsc退出
	Gui, 子窗口: +hwndtheID_FANWEI -Caption +AlwaysOnTop
	Gui, 子窗口: show, x%左上起点x% y%左上起点y% w%大矩形宽% h%大矩形高% NA, 显示范围
	WinSet, trans, 100, % "ahk_ID " theID_FANWEI
	WinSet, ExStyle, +0x20, % "ahk_ID " theID_FANWEI
	
	return


^2::
	KeyWait, space, DT3
	c := 
	if !errorlevel
	{
		MouseGetPos, x, y
		PixelGetColor, c, %x%, %y%, RGB
		for i in 像素列表
			{
			ddddd := 像素列表[i]
			if (c = ddddd) {
				TrayTip, , % c "已存在于像素列表`n色值将不被录入", 1
				return
				}
			}
		空字符串 := ""
		空字符串 .= c
		像素列表.insert(空字符串)
		gosub, 按像素列表生成像素盒子
	}
	else
		traytip, , 超时未按下空格取色, 1
	return
	
	
删除色:    
	gui, submit, nohide
	lsDV(像素列表, 像素盒子)
	gosub, 按像素列表生成像素盒子
	return
	
按像素列表生成像素盒子:
	guicontrol, , 像素盒子, |
	for i in 像素列表
		guicontrol, , 像素盒子, % 像素列表[i] "||"
	像素控件文本 :=
	for i in 像素列表
		{
		if (i = 1) {
			像素控件文本 := % (引号 像素列表[i] 引号)
		}
		else
			像素控件文本 := % 像素控件文本 "`, " 引号 像素列表[i] 引号
		}
	if 像素控件文本
		GuiControl, , 像素列表控件, % "[" 像素控件文本 "]"
	return
	
lsDV(ByRef lsName, var) {
	for i in lsName
	{
		
		if (lsName[i] == var) {
			gotit := 1
			lsName.Remove(i)
			break
		}
	}
	return gotit
}



#IfWinExist 显示范围
Enter::
	keywait, enter
	WinGetPos, 显x,显y,显w, 显h, % "ahk_ID " theID_FANWEI
	Gui, 子窗口: DESTROY
	mousemove, 2, 2, 0, r
	sleep 100
	MouseGetPos, , , ittt
	WinGetPos, 该x, 该y, , , % "ahk_ID " ittt
	终x1 := (显x - 该x)
	终y1 := (显y - 该y)
	终x2 := (终x1 + 显w)
	终y2 := (终y1 + 显h)
	guicontrol, , 像素集范围, % "[" 终x1 逗 终y1 逗 终x2 逗 终y2 "]"
	return
	
esc::
	Gui, 子窗口: DESTROY
	return