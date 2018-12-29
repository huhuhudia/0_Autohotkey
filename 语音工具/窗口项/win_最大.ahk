#NoTrayIcon
#singleinstance force
WinGet, theid, id, a
theid := % "ahk_id " theid
WinRestore, % theid
WinMaximize, % theid