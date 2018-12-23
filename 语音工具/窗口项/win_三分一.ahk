#NoTrayIcon
#singleinstance force
FileReadLine, MENUID, % a_scriptdir "\win_ini\winmenu.txt," ,1		;此为读取识别窗口ID
MENUID := % "ahk_ID "  MENUID
