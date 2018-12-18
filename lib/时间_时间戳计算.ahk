

NMsecSubt(tmlsA, tmlsB) {	;计算两时间点列表值的差,单位秒
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % subSVar + ((tmlsA[2] - tmlsB[2]) / 1000)
	else
		return % (tmlsA[2] - tmlsB[2]) / 1000
}

/*
例 In_TTP("1230-1260")
;计算当前时间是否在一周某天，time_Period 为字符串 
*/

In_TTP(time_Period) {
	Loop, Parse, time_Period, -
	{
		if a_INDEX = 1) 
			time_start := % A_YYYY A_MM A_DD A_LoopField "00"

		else if A_INDEX = 2) 
			time_end := % A_YYYY A_MM A_DD A_LoopField "00"
	}
	if (A_NOW >= time_start) && (A_NOW <= time_end)
		return 1
	else
		return 0
}


/*
休眠一阵停止
2位数为秒
所需时间-当前时间=等待时间
*/

Time_Sleep(time_ST) {
	anow := % A_Now		;程序起始时间
	
	lenOfT := % StrLen(time_ST)
	if lenOfT between 1 and 2
	{
		EnvAdd, anow, % time_ST, seconds
		loop
		{
			tl := anow
			EnvSub, tl, % A_NOW , Seconds	;
			IF tl > 0
				ToolTip, % tl "秒后结束等待"
			else
				return
		}
			
	}
}