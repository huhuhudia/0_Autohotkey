	ProExit("AutoHotkey.exe")
	run, % a_workingdir "\MainControl-主控端.ahk"
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