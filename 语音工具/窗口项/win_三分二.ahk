﻿#NoTrayIcon
#singleinstance force
FileReadLine, MENUID, % a_scriptdir "\win_ini\winmenu.txt" , 1	
MENUID := "ahk_ID " MENUID

