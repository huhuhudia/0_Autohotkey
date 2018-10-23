FileReadLine, path_Firefox, C:\Users\UOLO\Desktop\Script_Button_List\Else\火狐浏览器路径.txt, 1
path_Firefox = C:\Users\UOLO\AppData\Local\Mozilla Firefox\firefox.exe

if !WinExist("ahk_class MozillaWindowClass") {
	run, %path_Firefox% "https://www.baidu.com/"
	WinWait, ahk_class MozillaWindowClass
}


WinActivate, ahk_class MozillaWindowClas
Sleep 200
WinMaximize, ahk_class MozillaWindowClass
return

