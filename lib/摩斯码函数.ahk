
	
摩斯(timeout =200){ ;by Laszo -> http://www.autohotkey.com/forum/viewtopic.php?t=16951
摩斯码=  ;极其经典的摩斯密码函数;
tout := timeout/1000
key := RegExReplace(A_ThisHotKey,"[<>\*\~\$\#\+\!\^( UP)( Down)]") ;"[<>\*\~\$\#\+\!\^( UP)]"
;~ MsgBox % key
Loop {
t := A_TickCount
KeyWait %key%

摩斯码 .= A_TickCount-t>timeout ;这里用以判断是true(1)还是false(0)
KeyWait %key%,DT%tout%
If (ErrorLevel)
Return 摩斯码
}
Return ;
}
 