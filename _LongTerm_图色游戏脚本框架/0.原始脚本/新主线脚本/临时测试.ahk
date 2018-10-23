dm := ComObjCreate( "dm.dmsoft")
Del_F(A_WorkingDir "\NowgoZX1.log")
Clipboard :=
sleep 2000
Clipboard := "read"
ClipWait
sleep 500
daa := "ZX1"
Cr_AfterDel("ZX1", A_WorkingDir "\NowgoZX1.log")
Loop
{
	ControlGetText, gotext, Edit1, Ctrl助手
	if gotext = % daa
	{
		dm.KeyDown(86)
		sleep 100
		dm.KeyUp(86)
		sleep 100		
		Del_F(A_WorkingDir "\NowgoZX1.log")
		return
	}
}
return

;流程
;1.创建文件	F7
;2.发送v		F8
;3.写入1		F5


Ad_ToLL(filLP, tex)
{
	FileRead, ca, % filLP
	if ca
	{
		FileAppend, % "`n" tex, % filLP ,UTF-8
		Loop
		{
			loop, read, % filLP
			{
				lastline := % A_LoopReadLine
			}
			if lastline = % tex
				break
		}
	}
	else
	{
		FileAppend, % tex, % filLP ,UTF-8
		Loop
		{
			loop,read, % filLP
			{
				lastline := % A_LoopReadLine
			}
			if lastline = % tex
				break
		}
	}
}


;删除文件直到区确定无该文件
Del_F(filLP)
{
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
			break
	}
}

;创建文件前删除该文件确认后写入首行文本，确认首行文本后完成
Cr_AfterDel(tex, filLP)
{
	Loop
	{
		IfExist, % filLP
		{
			FileDelete, % filLP
			sleep 10
		}
		IfNotExist, % filLP
		{
			break
		}
	}	
	FileAppend, % tex, % filLP ,UTF-8
	Loop
	{
		IfNotExist, % filLP	
			Sleep 10
		Else 
		break
	}
	Loop
	{	
		FileReadLine, caa, % filLP, 1
		if caa = % tex
			break
	}
}

getLastL(filLP)
{
	IfExist, % filLP
	{
		loop, read, % filLP
		{
			lastline := % A_LoopReadLine
		}
		if lastline
			return % lastline
		else
			return 0
	}
	else
		return 0
}
