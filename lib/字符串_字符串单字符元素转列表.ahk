mkstrtols_rtLs(inputstr_str) {
	;将字符串解析为列表
	strls_ls := []
	Loop, Parse, inputstr_str
	{
		strls_ls.Insert(A_LoopField)
	}
	if strls_ls.MaxIndex()
		return strls_ls
	else
		return false
}

mklstostr_rtStr(input_ls) {
	;将列表拼接为字符串
	ddstr := ""
	for i in input_ls
	{
		ddstr .= input_ls[i]
	}
}