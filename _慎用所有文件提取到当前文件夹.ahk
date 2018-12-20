递归移动文件(A_ScriptDir, A_ScriptDir)

递归移动文件(fromdir, todir) {
	;将一个文件夹下的所有文件(递归)，移动到另一个文件夹
	Loop, % fromdir . "\*", , 1
		{
			FileMove, % A_LOOPFILELONGPATH , % todir . "\" . A_Index . "-" . A_LoopFileName
		}
	}
