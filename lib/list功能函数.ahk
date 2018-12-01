
/* 
数组方法加强
	增加元素：
		1. 末尾添加元素
			listName.insert(VAR)
			
		2. 列表中插入元素
			listName.insert(index, VAR)			插入单个元素
			listName.insert(index, VAR1, VAR2) 插入多个元素
			
		3. *** 列表末尾添加整个列表,无返回值
			lsExtend(listName, insertList)
			
		4. *** 列表中某位插入列表
			lsInserE(ByRef lsName, index, insertList)
		
		5. ***  类似range列表生成
			lsRange(0, 5)
		
	删除元素：
		1.按编号删除元素
			listName.remove(index)
			
		2. *** 按值删除首位元素 **
			结果 := lsDV(列表名, 删除的值)
			
		3. *** 按值删除所有元素
			删除结果 := lsDVall(列表名, 删除的值)
	
	查询元素
		1.列表长度
			列表长度 := % listName.MaxIndex() 该方法返回列表长度
			
		2. *** 查找列表中的最大值/最小值,纯数型元素列表中使用
			最大值 := % lsMax(lsName)
			最小值 := % lsMin(lsName)
			
		3. *** 将数组输出字符串，不判断类型，适用于数型和字符型数组
			msgbox, % lsShowStr(lsName)
			
		4. *** 将数组输出字符串，不判断类型，适用于数型和字符型数组
			msgbox, % lsmkStr(lsName, div := "") 
*/



lsmkStr(thelist, div := "") 
{
	str := 
	for i in thelist
	{
		if (i == 1)
			str := % thelist[i]
		else
			str := % str div thelist[i]
	}
	return % str
}


;将列表输出为特殊格式的字符串
lsShowStr(lsName) {
	str := 
	for i in lsName
	{
		if (i == 1)
			str := % i " - 【" lsName[i] "】"
		else
			str := % str "`n" i " - 【" lsName[i] "】"
	}
	return % str
}

;生成有序列表
lsRange(startpoin, stoppoin) {
	newls := []
	loop, % (stoppoin - startpoin + 1) 
	{
		newls.Insert(startpoin + A_Index - 1)
	}
	return newls
}
;查找列表中最大值
lsMax(lsName) {
	if !maxit
		maxit := lsName[1]
	for i in lsName
	{
		if (lsName[i] >= maxit) 
			maxit := lsName[i]
	}
	return % maxit
}
;查找列表中最小值
lsMin(lsName) {
	if !minit
		minit := lsName[1]
	for i in lsName
	{
		if (lsName[i] <= minit) 
			minit := lsName[i]
	}
	return % minit
}


;在列表末尾添加一个列表的所有元素
lsExtend(ByRef lsName, insertList) {
	for i in insertList
		lsName.insert(insertList[i]) 
}

;在列表中段插入一个列表的所有元素
lsInserE(ByRef lsName, index, insertList) {
	for i in insertList
	{
		lsName.insert(index + i - 1, insertList[i]) 
	}
}


;按值删除首位元素,成功删除返回1
lsDV(ByRef lsName, var) {
	for i in lsName
	{
		
		if (lsName[i] == var) {
			gotit := 1
			lsName.Remove(i)
			break
		}
	}
	return gotit
}

;按值删除所有元素,有删除值返回1
lsDVall(ByRef lsName, var) {
	Loop {
		gotit := 
		for i in lsName
		{
			if (lsName[i] == var) {
				gotit := 1
				gotit2 := 1
				lsName.Remove(i)
				break
			}
		}
		if (!gotit)
			break
	}
	return gotit2
}