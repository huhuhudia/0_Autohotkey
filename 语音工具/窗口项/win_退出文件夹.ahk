#SingleInstance force

wintts_list := ["ahk_Class CabinetWClass"
, "ahk_Class #32770"
, "ahk_exe taskmgr.exe"]

closeall(wintts_list)
ExitApp

closeall(wins_list) {
	Loop {
		for i in wins_list
		{
			winclose, % wins_list[i]
		}
		allit := 0
		for i in wins_list
		{
			if winexist(wins_list[i])
				allit += 1
		}
		if (!allit)
			break
	}
}
