WinGetPos, , , XX, YY, ahk_class TXGuiFoundation
WinMove, ahk_class TXGuiFoundation, , % A_ScreenWidth / 2 - XX / 2, % A_ScreenHeight / 2 - YY / 2
WinActivate, ahk_exe TIM.exe

return
