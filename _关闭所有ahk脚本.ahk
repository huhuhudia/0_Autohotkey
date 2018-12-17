ProExit("AutoHotkey.exe")
ExitApp


ProExit(proName) {	;关闭所有同名进程
	loop
	{
		Process, Exist, % proName
		if ErrorLevel
			Process, Close, % proName
		else
			break

	}
}
return