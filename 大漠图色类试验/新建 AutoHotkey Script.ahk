#Include %a_scriptdir%\dmClass.ahk
go := new dmClass(dm)
TE := new dmClass(dm)
return
	


f1::
ls := go.HDLS(gdmWHD())
for i in ls
	cl := % cl "`{" ls[i] "`}"
MsgBox, % cl
return






f2::
clip_got()
clip_change("this.dm." clip_got())
ToolTip, % Clipboard
SetTimer, xiaoshi, -1000
return

f3::
;~ Send, ^v
return
!r::
Reload

xiaoshi:
ToolTip
return
	
	:*:/dm:: this.dm.
	
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