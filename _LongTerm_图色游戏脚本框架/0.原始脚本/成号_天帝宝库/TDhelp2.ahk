#NoEnv
#Persistent
#SingleInstance force
#NoTrayIcon
SetWorkingDir %a_scriptdir%
hlt001tdic := % "*10 " a_workingdir "\picture\hlt001tdic.png"
SetTimer, 点击天帝icon, 20
return

点击天帝icon:
sleep 3000
cliI(hlt001tdic, 690, 119, 703, 131)
return

;---1.图片点击函数
cliI(thePathi, cx1, cy1, cx2, cy2)
{
	ImageSearch, xx, yy, %cx1%, %cy1%, %cx2%, %cy2%, % thePathi
	if errorlevel = 0
	{
		MouseClick, L, %xx%, %yy%, 1, 0
	}
	else if errorlevel = 2
	{
		msgbox, 错误`nCliI图片不存在
	}
}