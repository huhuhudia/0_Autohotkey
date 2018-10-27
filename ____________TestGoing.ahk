#NoEnv
#Persistent
#SingleInstance force
/*	由此行以上皆被复制到文件头
9
*/

;---------------------------------------------------------------------------------------
run, % a_scriptdir "\_Auxiliary_删除bak临时文件.ahk"
#Include %a_scriptdir%\lib\FileWorkEx.ahk
	
	wriToFil := % A_ScriptDir "\________TestRunning.ahk"
	Cre_AftDel(wriToFil)
	
	loop % a_scriptdir "\lib\*.ahk"
		FileAppend, % "`#include %A_ScriptDir%\lib\" A_LoopFileName "`n", % wriToFil, UTF-8
	
	;写入此脚本行首几行
	lineList := []
	Loop, read, % A_ScriptFullPath
	{
		if A_LoopReadLine = 9
			break
		lineList.Insert(A_LoopReadLine)
	}
	Loop, % lineList.MaxIndex() - 1
		FileAppend, % lineList[A_Index] "`n", % wriToFil, UTF-8
	;写入主要文件
	FileRead, latestTex, % a_scriptdir "\_________________Testlib.ahk"
	FileAppend, % "`n" latestTex, % wriToFil, UTF-8

	Loop {
		if fileexist(wriToFil)
			break
	}
	sleep 200
	Run, % wriToFil
	ExitApp

	
	