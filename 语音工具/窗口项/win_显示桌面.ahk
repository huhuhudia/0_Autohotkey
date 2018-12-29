FileReadLine, titleofdesktop_str, % a_scriptdir "\Win_ini\desktop.txt" , 1
WinShow, % titleofdesktop_str
WinActivate, % titleofdesktop_str
BlockInput,On
Send, #d
BlockInput,Off