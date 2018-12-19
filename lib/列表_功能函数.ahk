
/* 
数组方法加强
	>> 增
		1.自带方法
			listName.insert(添加值)					>> 末尾添加元素 	
			listName.insert(位, 插入值)				>> 插入单个元素
			listName.insert(位, 插入值1, 插入值2)      >> 插入多个元素
			
		2.功能函数 
			lsExtend_pro(<1>列表名称, <2>添加列表)				>> 列表末尾添加整个列表,无返回值
			lsInserE_pro(<1>列表名称, <2>插入位置, <3>添加列表)	>> 列表末尾添加整个列表,无返回值
			lsRange_rtLs(起始点, 终点)							>> 类似range()函数返回范围列表
		
	>> 删：
		1.自带方法
			listName.remove(index)			>> 删除列表中index位值
			
		2.功能函数
			lsDV_rtBool(列表名, 删除的值)		>> 删除列表中首位值，成功删除返回1, 无删除返回0
			lsDVall_rtInt(列表名, 删除的值)	>> 删除所有查找值, 成功返回删除元素的个数,  无删除返回0
	
	>> 查
		1.自带方法
			listName.MaxIndex() 			>> 该方法返回列表长度
			
		2. 功能函数
			islist_rtBool(审查元素)			>> 查询传入元素是否为列表
			lsmaxi_rtInt(列表名)				>> 返回最大值
			lsmini_rtInt(列表名)				>> 返回最小值
			
	>> 改
		1.一般方法
			listName[位] := 替换成该元素
			
		2.功能函数
			lsinsteadall_rtInt(查询列表, 查找的值, 替换的值)
*/

A := [2, 2, "2", 6]
msgbox, % lsinstead_all(A, 2, 3)
msgbox, % lstostr_rtStr(A)
return




lsinsteadall_rtInt(lsName, searchfor, insteadto) {
	;返回替换次数，无替换时返回0
	insteadtimes := 0
	for i in lsName
		{
		if (lsName[i] == searchfor) {
			insteadtimes += 1
			lsName[i] := insteadto
			}
		}
	return insteadtimes
	}


lstostr_rtStr(lsName) {
	;传入参数为0或空,返回0,
	;为真非数组返回-1
	;为数组时返回带括号的字符串
	if !lsName				;为假或为空时
		return 0
	if !islist_rtBool(lsName) 	;为真，非数组时
		return -1
	临时字符串 := 
	for i in lsName
		{
		if (i = 1)
			临时字符串 := lsName[i]
		else
			临时字符串 := % 临时字符串 . ", " . lsName[i]
		}
	临时字符串 := % "[" 临时字符串 "]"
	return 临时字符串
	
	}

islist_rtBool(lsName) {
	;判断是否为列表，是列表返回1，否则返回0
	lsName.insert(1)
	if (!lsName.MaxIndex())
		return 0
	else {
		lsName.Remove(lsName.MaxIndex())
		return 1
		}
	}

lsRange_rtLs(startpoin, stoppoin) {
	;生成有序列表，步进1
	newls := []
	loop, % (stoppoin - startpoin + 1) 
		newls.Insert(startpoin + A_Index - 1)
	return newls
	}
	


lsmaxi_rtInt(lsName) {
	;查找列表中最大值
	if !maxit
		maxit := lsName[1]
	for i in lsName
		{
		if (lsName[i] >= maxit) 
			maxit := lsName[i]
		}
	return % maxit
	}



lsmini_rtInt(lsName) {
	;查找列表中的最小值
	if !minit
		minit := lsName[1]
	for i in lsName
		{
		if (lsName[i] <= minit) 
			minit := lsName[i]
		}
	return % minit
	}

lsExtend_pro(lsName, insertList) {
	;在列表末尾添加一个列表的所有元素
	for i in insertList
		lsName.insert(insertList[i]) 
	}

lsInserE_pro(lsName, index, insertList) {
	;在列表中段插入一个列表的所有元素
	for i in insertList
		lsName.insert(index + i - 1, insertList[i]) 
	}


lsDV_rtBool(lsName, var) {
	;成功删除返回1，无删除返回0
	for i in lsName
		{
		if (lsName[i] == var) {
			gotit := 1
			lsName.Remove(i)
			break
			}
		}
	if gotit
		return 1
	else
		return 0
	}

lsDVall_rtInt(byref lsName, var) {
	;返回成功删除元素个数，无删除返回0
	gotit := 0
	Loop {
		for i in lsName
			{
			if (lsName[i] == var)
				有元素 := 1
			}
		if (!有元素 or !lsName.MaxIndex())
			break
		for i in lsName
			{
			if (lsName[i] == var) {
				gotit += 1
				lsName.Remove(i)
				break
				}
			}
		}
	return gotit
	}