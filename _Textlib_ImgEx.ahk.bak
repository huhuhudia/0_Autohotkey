#NoEnv
#Persistent
#SingleInstance Force
SetWorkingDir %A_ScriptDir%\_Textlib_ImgEx\
#include %A_WorkingDir%\lib\imgEx.ahk
CoordMode, tooltip, screen

gosub, loadImgFile				;加载图片列表
settimer, makeImgSchTT, 500		;循环搜图创建tooltip
return
	
loadImgFile:
	imgFlNmLi := [] 
	Loop, % A_WorkingDir "\*.png"
		imgFlNmLi.Insert(A_LoopFileName)
	return
	
	
makeImgSchTT:
	tipText := 
	Loop, % imgFlNmLi.MaxIndex()	;搜索全屏，所有工作图片文件，生成Tooltip内容
	{
		
		if (foundResult := imgWinRL(imgFlNmLi[A_Index])) {
			if !tipText	;首行无换行符
				tipText := % imgFlNmLi[A_Index] " : x" foundResult[1] " y" foundResult[2]
			else
				tipText := % tipText "`n" imgFlNmLi[A_Index] " : x" foundResult[1] " y" foundResult[2]
		}
	}
	ToolTip, % tipText ? tipText : "nothing found~", 0, 0
	return


