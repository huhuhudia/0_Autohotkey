FileReadLine, bjpath, % A_ScriptDir "\Else\编辑器路径.txt", 1
run, %bjpath% "%A_ScriptFullPath%"
return

/* 时间相关函数
#Include top://Func/Time.ahk	


In_WDay(all_dayNum) 

	;当前系统时间是否在一周某几天，all_dayNum为所需匹配时间，范围1-7
	;匹配成功返回1，失败返回0
	;例：In_WDay("1-2-3-4-5") 

In_TTP(time_Period)

	;当前系统时间是否正在当天某个时间段
	;匹配成功返回1，失败返回0
	;例：In_TTP("0500-2130")

Time_Calc(TiCl_exp, thisTime := 0)

	;对thisTime 进行时间戳计算，默认为A_now
	;返回时间戳
	;例：Time_Calc("+69s") ，当前时间加上69秒
	
*/

