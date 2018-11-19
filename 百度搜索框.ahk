CoordMode, mouse, screen
F1::
输入查找 := 0
InputBox, 输入查找
if 输入查找
{
	MouseGetPos, xxx, yyy
	Loop 2
		MouseClick, L, 340, 123, 1, 0
	Sleep 200
	Send, {backspace 20}
	sleep 500
	Clipboard := 
	Clipboard :=  % 输入查找 "卦"
	ClipWait
	send, ^v
	sleep 200
	MouseClick, L, % xxx, % yyy, 1, 0
}
return