
Line_HEadd(head_a, end_a)
{
	Clipboard := 
	Send, {end}+{home}
	Send, ^c
	ClipWait
	CL := % head_a Clipboard end_a
	clip_change(CL)
	Send, ^v
}
word_HEadd(head_a, end_a)
{
	send, {shift down}{ctrl down}{left}{shift up}{ctrl up}	;选取所需范围
	clip_got()	;复制选区范围，获得所需clipboard变量
	to := % head_a Clipboard end_a	;添加所需字符串
	clip_change(to)	;给剪切板赋值
	Send, ^v	;发送黏贴
}
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
