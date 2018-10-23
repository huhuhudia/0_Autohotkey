

/*
例 In_WDay("1-2-3-4-5")
;计算当前时间是否在一周某天，all_dayNum 为字符串 
*/


In_WDay(all_dayNum) {
	WDay := ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期天"]
	Loop, Parse, all_dayNum, -
	{
		CL := % WDay[A_LoopField]	;A_LoopField为当前检测的字符段，在数组中为定位
		if CL = % A_DDDD
			return 1
	}
	return 0
}

/*
例 In_TTP("1230-1260")
;计算当前时间是否在一周某天，time_Period 为字符串 
*/

In_TTP(time_Period) {
	Loop, Parse, time_Period, -
	{
		
		if (a_INDEX = 1) {
			time_start := % A_YYYY A_MM A_DD A_LoopField "00"

		}
		else if (A_INDEX = 2) {
			time_end := % A_YYYY A_MM A_DD A_LoopField "00"
		}
		
	}
	if (A_NOW >= time_start) && (A_NOW <= time_end)
		return 1
	else
		return 0
}

/*
时间加减
;计算时间戳加减时间单位长度，返回时间戳
*/

Time_Calc(TiCl_exp, thisTime := 0) {

	if !thisTime
		thisTime := % A_Now
		
	TC_mark := SubStr(TiCl_exp, 1 , 1)
	TC_unit := SubStr(TiCl_exp, 0 , 1)
	StringTrimLeft, TiCl_exp, TiCl_exp, 1
	StringTrimRight, TiCl_exp, TiCl_exp, 1
	
	if TC_mark = +
		plus := 1
	else if TC_mark = -
		minus := 1
	else
		msgbox, 时间计算函数符号错误`n应为+或-
	
	
	
	if TC_unit = s
		Calc_S := 1
	
	else if TC_unit = m
		Calc_M := 1
	
	else if TC_unit = h
		Calc_H := 1
	
	else if TC_unit = d
		Calc_D := 1
	
	else
		msgbox, 时间计算函数单位错误`n应为s/m/h/d
		
		
		
	;Seconds, Minutes, Hours 或 Days 
	
	if Calc_S && plus
	{
		thisTime += TiCl_exp, s
		return, % thisTime
	}
	if Calc_S && minus
	{
		thisTime += -TiCl_exp, s
		return, % thisTime
	}
	
	if Calc_M && plus
	{
		thisTime += TiCl_exp, m
		return, % thisTime
	}		
	if Calc_M && minus
	{
		thisTime += -TiCl_exp, m
		return, % thisTime
	}				
	if Calc_H && plus
	{
		thisTime += TiCl_exp, h
		return, % thisTime
	}				
	if Calc_H && minus
	{
		thisTime += -TiCl_exp, h
		return, % thisTime
	}				
	if Calc_D && plus
	{
		thisTime += TiCl_exp, d
		return, % thisTime
	}			
	if Calc_D && minus
	{
		thisTime += -TiCl_exp, d
		return, % thisTime
	}			
	else
		msgbox, 时间函参数数据错误
		
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