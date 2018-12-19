#Include %a_scriptdir%\winInfo_窗口信息获取函数集.ahk
#Include %a_scriptdir%\Clipboard_复制黏贴.ahk

!1::	;绑定记事本
wid := mgID()
return

!2::
ControlSendRaw, Edit1, % "`n" clip_got() , % wid
return

