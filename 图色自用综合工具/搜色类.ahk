class 搜色对象集 {
	__New(像素对象列表) { 
		this.像素对象列表 := 像素对象列表
		this.对象个数 := 像素对象个数.MaxIndex()
		}
	探返布尔() {
		;至少找到1个返回1，全都未找到返回0
		for i in this.像素对象列表
			{
			if (this.像素对象列表[i].探返布尔())
				return 1
			}
		return 0
		}
	
	探返布尔_苛() {
		;全数找到返回1，有一个未找到返回0
		找到次数 := 0
		for i in this.像素对象列表
			{
			if (this.像素对象列表[i].探返布尔())
				找到次数 += 1
			}
		if (找到次数 = this.对象个数)
			return 1
		return 0
		}
	timeNotGetPielx(times) {
		;连续秒内未出现这些像素集
		nowgettime := [A_Now, A_MSec]
		loop {
			if (this.探返布尔())
				return 0
			if (__NMsecSubtforP([A_Now,A_MSec], nowgettime) >= times)
				return 1
			}		
	}
	
		
}

class 搜色类 {
	;像素列表 := ["0xffffff" ]
	__New(范围列表, 像素列表, 统一模糊渐变 := 8) {
		this.x1 := 范围列表[1]
		this.y1 := 范围列表[2]
		this.x2 := 范围列表[3]
		this.y2 := 范围列表[4]
		this.像素列表 := 像素列表
		this.渐变 := 统一模糊渐变
	}
	
	探返布尔() {
		总搜索需要数 := this.像素列表.MaxIndex()
		初始计数 := 0
		for i in this.像素列表
			{
			PixelSearch, , , % this.x1, % this.y1, % this.x2, % this.y2, % this.像素列表[i] , % this.渐变, rgb Fast
			if !errorlevel
				初始计数 += 1
			}
		if (初始计数 = 总搜索需要数)
			return 1
		else
			return 0
		}
	探返点击() {
		总搜索需要数 := this.像素列表.MaxIndex()
		初始计数 := 0
		for i in this.像素列表
			{
			PixelSearch, 一次性x, 一次性y, % this.x1, % this.y1, % this.x2, % this.y2, % this.像素列表[i] , % this.渐变, rgb Fast
			if !errorlevel
				初始计数 += 1
			}
		if (初始计数 = 总搜索需要数)
			mouseclick, L, % 一次性x, % 一次性y, 1, 0
		}
	探返击键(击键字符串) {
		总搜索需要数 := this.像素列表.MaxIndex()
		初始计数 := 0
		for i in this.像素列表
			{
			PixelSearch, 一次性x, 一次性y, % this.x1, % this.y1, % this.x2, % this.y2, % this.像素列表[i] , % this.渐变, rgb Fast
			if !errorlevel
				初始计数 += 1
			}
		if (初始计数 = 总搜索需要数)
			send, % 击键字符串	
		}
		
	timeNotGetPielx(times) {
		;连续秒内未出现这些像素集
		nowgettime := [A_Now, A_MSec]
		loop {
			if (this.探返布尔())
				return 0
			if (__NMsecSubtforP([A_Now,A_MSec], nowgettime) >= times)
				return 1
			}
		
		}
	
	
}

__NMsecSubtforP(tmlsA, tmlsB) {					;计算两时间点列表值的差，返回单位毫秒
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % (subSVar * 1000) + (tmlsA[2] - tmlsB[2])
	else
		return % (tmlsA[2] - tmlsB[2])
}