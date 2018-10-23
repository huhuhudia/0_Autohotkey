#NoEnv
#Persistent
#SingleInstance force
setworkingdir %a_scriptdir%

Gui, Add, Text, x6 y7 w70 h20 , 切号窗口：
Gui, Add, Edit, ReadOnly vgoforctrl x76 y4 w60 h20 , None
Gui, Show, x1551 y416 h34 w145, Ctrl助手
SetTimer, 检查是否需要登录, 10
Return

GuiClose:
ExitApp

检查是否需要登录:
if !fileexist(A_WorkingDir "\NowgoZX*.log")
	GuiControl, , goforctrl, None
if fileexist(A_WorkingDir "\NowgoZX*.log")
{
	Loop, % A_WorkingDir "\NowgoZX*.log"
	{
		bl := % A_LoopFileLongPath
		gotS := % getL(bl)
		send, {ctrl down}
		sleep 1500
		GuiControl, , goforctrl, % gotS
		Loop
		{
			if GetKeyState("numlock", "P")
			{
				send, {ctrl up}
				return
			}
			sleep 100
			if !fileexist(bl) {
				GuiControl, , goforctrl, None
				sleep 1000
				send, {ctrl up}
				return
			}
		}
	}
}
return


getL(filLP, linenum := 1) {
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

Ad_ToLL(filLP, tex)
{
	FileRead, ca, % filLP
	if ca
	{
		FileAppend, % "`n" tex, % filLP ,UTF-8
		Loop
		{
			loop, read, % filLP
			{
				lastline := % A_LoopReadLine
			}
			if lastline = % tex
				break
		}
	}
	else
	{
		FileAppend, % tex, % filLP ,UTF-8
		Loop
		{
			loop,read, % filLP
			{
				lastline := % A_LoopReadLine
			}
			if lastline = % tex
				break
		}
	}
}

;删除文件直到区确定无该文件
Del_F(filLP)
{
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}
}