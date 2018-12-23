#NoTrayIcon
#NoTrayIcon
loop, %A_ScriptDir%\*.ahk
{
	FileRead, NowFILED, % A_LoopFileName
	nowjob := FileOpen(A_LoopFileLongPath, "w", "UTF-8")
	NowFILED := % "#NoTrayIcon`r`n" NowFILED
	nowjob.Write(NowFILED)
}