/*
* 功能描述：
	短击设定按键显示功能项目
	长按选择功能
	超时退出

* 主函数：
	KCLable() ：Key Chose Lable
		参1:keyname_str			* 待激活的按键，为字符串
		参2:choscount_dict		* 设定用以统计列表功能选择次数的字典，作全局变量,取任意可用标识符
		参3:lablefunc_strlist 	* 选择标签的列表，为字符串列表
		参4:waitsec_int 		超时未切换或未选择退出，单位为妙，可为浮点数, 默认值2
		参5:chosgototm_int 		长按选择功能时间，单位毫秒, 默认值300
		参6:longkeydown			长按超时自动选择时间,单位秒，默认值0.7
		其他：无返回值
	
	
* 子函数:
	1.LsToStr(lablefunc_list, focusline_int) ：	不可复用，将列表转换为行格式的多行字符串返回，用于tooltip	 
	2.NMsecSubt(tmlsA, tmlsB)： 				可复用，以列表方式时间计算函数，计算系统时间差，用以判断按键按击时间
	3.sortDicToLs(thels, byref __diccount)：	修改后可复用，将字典键的值以从大到小顺序排列为列表，输出该列表
	4.varInlist(var, ls)：						可复用，判断值是否在列表中	

* 参考代码：

	f1::
		KCLable("F1", lbdict_F1, ["消息1", "消息2", "消息3", "消息4", "消息5"])
		return

	f2::	
		KCLable("F2", lbdict_F2, ["消息6", "消息7", "消息8", "消息9"])
		return	

	消息1:
	消息2:
	消息3:
	消息4:
	消息5:
		MsgBox, % A_ThisLabel
		return
		
	消息6:
	消息7:
	消息8:
	消息9:		
		MsgBox, % A_ThisLabel
		return		
		
*/

KCLable(keyname_str, ByRef choscount_dict,lablefunc_strlist, waitsec_int := 1, chosgototm_int := 200, longkeydown := 0.7) {		;主函数
	;* foucs_int每次按键初始焦点位置,为常量
	foucs_int := 1	
	;* sortDicToLs 字典为空，将列表录入字典，字典不为空，将字典键以键值大小降序排列
	lablefunc_strlist := sortDicToLs(lablefunc_strlist, choscount_dict)
	;* LsToStr()函数将列表转换为多行格式字符串显示
	ToolTip, % LsToStr(lablefunc_strlist, foucs_int)
	
	keywait, % keyname_str, T%longkeydown%
	if errorlevel {
		;首次按下不放直接执行首位标签功能
		choscount_dict[lablefunc_strlist[foucs_int]] += 1
		ToolTip
		gosub, % lablefunc_strlist[foucs_int]
		keywait, % keyname_str
		return
	}
	loop {
		;循环等待再次按键按下
		KeyWait, % keyname_str, % "DT" waitsec_int
		if (ErrorLevel) {
			;若超时waitsec_int秒无再次按键，退出循环，取消tooltip显示
			tooltip
			break
		}
		else {
			/* 等待按键松开
			 * NMsecSubt()函数判断按下到松开时长
			 * 超时longkeydown未松开 
			 */
			 ;按键初始记录按下时间
			__noww := [A_Now, A_MSec]
			keywait, % keyname_str, T%longkeydown%
			;长按超过1秒，设定按键时为长按超时值
			if errorlevel {
				__gotPE := (longkeydown * 1000)
			}
			;未超时时，记录按键时长
			else { 
				__gotsince := [A_Now, A_MSec]
				__gotPE := NMsecSubt(__gotsince, __noww)
			}


			/* 以下根据__gotPE时间判定为短击或长击
			 * 长按选择功能
			 * 短击改变焦点
			 */
			 
			if (__gotPE < chosgototm_int) {
				; 短按切换焦点，焦点到尾部则回到顶部，根据焦点改变标签功能显示方式
				foucs_int += 1
				if (foucs_int > lablefunc_strlist.MaxIndex())
					foucs_int := 1
				ToolTip, % LsToStr(lablefunc_strlist, foucs_int)				
			}
			else if (__gotPE >= chosgototm_int) {
				; 按键时长在判定长按区间执行功能，计数标签功能选择次数记录字典
				tooltip
				choscount_dict[lablefunc_strlist[foucs_int]] += 1
				gosub, % lablefunc_strlist[foucs_int]
				keywait, % keyname_str
				return			
			}
		}		
	}
}

LsToStr(lablefunc_list, focusline_int) { 	;将列表设置为某种格式
	rt_str =
	for i in lablefunc_list
	{
		;首行
		if (i == 1) {
			if (i == focusline_int)
				rt_str := % "> " lablefunc_list[i]
			else
				rt_str := % "      " lablefunc_list[i]
		}
		;非首行
		else {
			if (i  == focusline_int)
				rt_str := % rt_str "`n> " lablefunc_list[i]
			else
				rt_str := % rt_str "`n      " lablefunc_list[i]			
		}
	}
	return rt_str
}

NMsecSubt(tmlsA, tmlsB) {					;计算两时间点列表值的差，返回单位毫秒
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % (subSVar * 1000) + (tmlsA[2] - tmlsB[2])
	else
		return % (tmlsA[2] - tmlsB[2])
}

sortDicToLs(thels, byref __diccount) {		;将字典键的值以从大到小顺序排列为列表，输出该列表
	
	for i in __diccount
		i := i
	if (!i) {	;字典为空，创建字典
		__diccount := {}
		for i in thels
			__diccount.Insert(thels[i], 0)
		newls := thels
	}
	else {		;字典不为空，根据字典值，升序排列
		maxit := 
		newls := []
		for thei in thels
		{
			;寻找字典中的最大值
			maxit := 0 ;最大值初始
			
			for keyName in __diccount
			{
				iF !varInlist(keyName, newls)
				{
					if (!maxit)
						maxit := __diccount[keyName]
					if (__diccount[keyName] > maxit)
						maxit := __diccount[keyName]
				}
			}
			;寻找字典中的最大值的首位键
			for theindex in thels
			{
				nowlsindex := thels[theindex] 
				if !varInlist(nowlsindex, newls) ;当前循环到的值不在新列表中
				{
					TT := thels[theindex]
					if (__diccount[TT] == maxit)
					{
						maxkey := thels[theindex]
						break
					}
				}
			}
			newls.Insert(maxkey)
		}
	}
	return newls
}

varInlist(var, ls) {
	;判断var值是否在ls列表中
	for i in ls
	{
		if (ls[i] == var)
			return 1
	}
	return 0
}