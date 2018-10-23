FileReadLine, bjpath, % A_ScriptDir "\Else\编辑器路径.txt", 1

filename_ahk := ;ahk文件名
path_ahkfile := ;ahk文件路径

InputBox, filename_ahk, 创建ahk文件, 输入文件名
if errorlevel
	return

if filename_ahk
	path_ahkfile := % A_ScriptDir "\" filename_ahk ".ahk"
else
	path_ahkfile := % A_ScriptDir "\" A_Now ".ahk"

FileAppend, , % path_ahkfile, utf-8

loop {
	if fileexist(path_ahkfile)
		break
}

run,  %bjpath% "%path_ahkfile%" 
return