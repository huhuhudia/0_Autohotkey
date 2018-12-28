#SingleInstance force

;~ 编辑器文件路径
editorpath_str = C:\Program Files\AutoHotkey\SciTE\SciTE.exe
;~ inputbox高度
inpuheight_str := 139
;~ 文件头
Ecoding_str := "UTF-8"
line1_str = #NoEnv
line2_str = #SingleInstance force

line3_str = #Persistent
line4_str := "SetWorkingDir %A_ScriptDir%"
Text_str :=
loop 4
	Text_str := % Text_str line%A_Index%_str "`r`n"

InputBox, newAHKFileName_str, ,Please input a new file name to ahk. `n esc or close than script will do nothing and exit., , , %inpuheight_str%
if newAHKFileName_str {
	
	newfile_obj := FileOpen(A_Desktop "\" newAHKFileName_str ".ahk", "w", "UTF-8")
	newfile_obj.Encoding := Ecoding_str	;~ 设定文件编码
	newfile_obj.Write(Text_str)			;~ 写入内容
	newfile_obj.Close()
	
	Loop {
		sleep 10
		if fileexist(A_Desktop "\" newAHKFileName_str ".ahk")
			break
		if (a_index > 100)
			break
	}

	;~ 释放对象
	newfile_obj := 
	;~ 用编辑器打开ahk文件
	run, % editorpath_str " " A_Desktop "\" newAHKFileName_str ".ahk"
}
ExitApp