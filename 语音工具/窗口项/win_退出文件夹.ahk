#NoTrayIcon
#SingleInstance force
winclass_str := "ahk_Class CabinetWClass"

Loop {
	if winexist(winclass_str)
		WinClose, % winclass_str
	else
		break
}
