#SingleInstance force

;~ 编辑器文件路径
editorpath_str = notepad
;~ inputbox高度
inpuheight_str := 139
ex_str = .txt

InputBox, newAHKFileName_str, ,Please input a new file name to txt. `n esc or close than script will do nothing and exit., , , %inpuheight_str%
if newAHKFileName_str {
	
	newfile_obj := FileOpen(A_Desktop "\" newAHKFileName_str ex_str, "w", "UTF-8")
	newfile_obj.Encoding := Ecoding_str	;~ 设定文件编码
	newfile_obj.Write(Text_str)			;~ 写入内容
	newfile_obj.Close()
	
	Loop {
		sleep 10
		if fileexist(A_Desktop "\" newAHKFileName_str ex_str)
			break
		if (a_index > 100)
			break
	}

	;~ 释放对象
	newfile_obj := 
	;~ 用编辑器打开ahk文件
	run, % editorpath_str " " A_Desktop "\" newAHKFileName_str ex_str
}
ExitApp