 string := "天"
a := RegExmatch(string, "[\x{4E00}-\x{9FA5}]")
MsgBox % a  ;含有中文字符 返回非0数 ，不含中文 ，返回0

