;双击右键按住不放，输入b,松开鼠标右键发送box

#SingleInstance FORCE
;以下两个必须参数，不可舍，不可调换位置
global isfirstRuning_bool := true
global 按键字典 := {}

/*=======================================================
 * 基本代码格式说明
========================================================= 

标签名:
if LB("启用输入,  "标签名") {
    ....代码块
    return
}
*/

;=========================================================
;功能代码块此处开始
;=========================================================
box:
if LB("c", "box") {
    /*
    Send ^{f}
    Clipboard=box
    Send ^{v}
    Send {down}
    Send `n
    */
    MsgBox, 1
    return
}

功能2:
if LB("b" ,"功能2") 
{
    msgbox, 666
    return
}

;=========================================================
;功能代码块此处结束
;=========================================================
isfirstRuning_bool := false
return











/*========================================
 *按键功能代码块
==========================================
*/

~Rbutton up::
    WinClose, myRun
    return

;#IfWinActive Untitled - Autodesk 3ds Max 2018    

RButton::
    KeyWait, RButton  
    keyWait, RButton, D T0.1

    If ErrorLevel ;如果超时，就是单击，否则就是双击
    {
     Click, Right
    }
    Else {
        showgui()
        return
    }
    Return


GuiClose:
    gui,Submit
    dicttolable(cmd)
    Destroygui()        
    return

dicttolable(the_key) {
    if !the_key
        return
    aaa := 按键字典[the_key]
    if !aaa
    {
        traytip, , % "命令" the_key "不在命令列表中", 1
    }
    else
        gosub, % 按键字典[the_key]
    return
}

LB(theintokey_str, intodictlable_str) {
	if isfirstRuning_bool
	{
		按键字典[theintokey_str] := intodictlable_str
		return 0
	}
	else
		return 1
}


showgui() {
    
    global
    WIDTH := 600
    Gui,Destroy
    gui, font, s200 cFFFFFF
    gui, color, 000000, 000000
    Gui,add,edit, +BackgroundTrans vCmd x0 y0 w%WIDTH% h300
    Gui -Caption  ; 如果它不是 默认窗口, 则使用 Gui, GuiName:-Caption.
    Gui, +hwndaaaaa
    Gui, Show,  h300 w%WIDTH%, myRun
   
    WinSet , trans, 100, % "ahk_id " aaaaa
    ;OutputDebug,"show"
} 

Destroygui() {
    Gui,Destroy
}
    