if !winexist("AutoHotkey 中文帮助")
	Run, % a_scriptdir "\Else\AHK_帮助文档.chm"
WinWait, AutoHotkey 中文帮助
WinActivate, AutoHotkey 中文帮助
sleep 200
WinMaximize, AutoHotkey 中文帮助
return