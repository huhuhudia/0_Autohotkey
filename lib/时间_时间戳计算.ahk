/* 函数说明
sectimetoF_rtStr(1000)	--> 将秒数时间转换为天时分秒的格式
NSecSubt_rtFloat([A_now, A_Msec], anotherTimeList)  --> 将两个时间戳列表相减，返回浮点数，单位秒
NMsecSubt_rtInt([A_now, A_Msec], anotherTimeList)	--> 将两个时间戳列表相减，返回整形数，单位毫秒

*/




;* 示例代码： MsgBox, % sectimetoF_rtStr(864000)
sectimetoF_rtStr(sectime_int, sec_str := "s", min_str := "m",  hour_str := "h", day_str := "d") {
	;将秒数转换为时分秒天的格式
	thissec_str := % Mod(sectime_int, 60) sec_str
	if (!(sectime_int // 60))
		;~ 剩余分钟数无余
		return % thissec_str
	
	lastmin_int := sectime_int // 60
	thismin_str := % Mod(lastmin_int, 60) min_str
	if (!(lastmin_int // 60))
		;~ 剩余小时数无余
		return % thismin_str thissec_str

	lasthour_int := lastmin_int // 60
	thishour_str := % Mod(lasthour_int, 24) hour_str
	if (!(lasthour_int // 24))
		return % thishour_str thismin_str thissec_str
	
	lastday_int := lasthour_int // 24
	thisday_str := % lastday_int day_str
	return % thisday_str thishour_str thismin_str thissec_str
	
}


NSecSubt_rtFloat(tmlsA, tmlsB) {	;计算两时间点列表值的差,单位秒
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % subSVar + ((tmlsA[2] - tmlsB[2]) / 1000)
	else
		return % (tmlsA[2] - tmlsB[2]) / 1000
}

NMsecSubt_rtInt(tmlsA, tmlsB) {	;计算两时间点列表值的差,单位毫秒
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % subSVar * 1000 + (tmlsA[2] - tmlsB[2])
	else
		return % tmlsA[2] - tmlsB[2]
}