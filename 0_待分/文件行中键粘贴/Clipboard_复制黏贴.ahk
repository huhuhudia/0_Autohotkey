/*
关于剪切板的函数
*/

;~ ;给剪切板赋值并黏贴
clip_in(to_clipboard)
{
	clip_change(to_clipboard)
	SendInput, ^v
}

;给剪切板赋值
clip_change(to_clipboard)
{
	Clipboard :=
	Clipboard := % to_clipboard
	ClipWait
}

;复制返回剪切板内容
clip_got()
{
	Clipboard :=
	SendInput, ^c
	ClipWait
	return %Clipboard%
}

