#NoTrayIcon
#SingleInstance force
FileReadLine, MENUID, % a_scriptdir "\win_ini\winmenu.txt" , 1	
WinShow, %MENUID%