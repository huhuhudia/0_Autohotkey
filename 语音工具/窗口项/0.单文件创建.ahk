loop, read, %A_ScriptDir%\1.txt
{
	文件名 := "win_" A_LoopReadLine  ".ahk"
	FileAppend, % "#singleinstance force", % A_ScriptDir  "\" 文件名
	
}