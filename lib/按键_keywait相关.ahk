
/* 
 * keyWaitUp(keyname_string) 
	无限等待F1弹起状态（长按后弹起时为松开）或 未按下F1 继续运行代码流程
		
 * keywaitDown(keyname_string) 
	无限等待F1被按下，或F1已经被按下时 继续运行代码流程
	
 * keyWaitUp_T(keyname_string, times := 1) 
	times时间内等待F1弹起状态
	times时间内未检测到松开状态返回 0
	若按键没有按下或按键按下后弹起时返回 1
	
	
 * keywaitDown_T(keyname_string, times := 1) 
	times时间内等待F1按下状态
	times时间内未检测到松开状态返回0
	若按键没有按下或按键按下后弹起时返回1
 
 * KWRTtimes(keyname_string) 
	无限等待按键被按下
	在松开时返回按键时间，单位毫秒
	

 * KWRTtimesEX(keyname_string, downwait := 1, longtaptimewait := 1) 
		downwait时间内等待按键按下，时间内未按下返回0
		longtaptimewait时间内松开按键 返回按键长按毫秒时间
		超过时间未松开返回-1
		
		示例代码:
		
		result := KWRTtimesEX("F1", 3, 2)
		if !result
			msgbox, 3秒内未按下F1键
		else if (result == -1)
			msgbox, f1键长按时间超过2秒，消息弹窗
		else
			msgbox, % "f1键按键时间为" result "毫秒"
	
	
 */
 
keyWaitUp(thetabkey) {
	;等待检测到按键松开状态, 无限等待,无返回值 --- 未被按下即松开状态
	;唯一参数：键位名称
	keywait, % thetabkey	
}

keywaitDown(thetabkey) {
	;等待检测到按键按下状态, 无限等待，无返回值 
	;唯一参数：键位名称
	keywait, % thetabkey, D
}


keyWaitUp_T(thetabkey, times := 1) {
	;等待检测到按键松开状态, 超时时间默认1秒，超时未弹起返回0，时间段内弹起返回1
	;参1:键位名称
	;参2: 超时等待时间
	keywait, % thetabkey, % "T" times
	if errorlevel
		return 0
	else
		return 1
}

keyWaitDown_T(thetabkey, times := 1) {
	;等待检测到按键按键状态, 超时时间默认1秒，超时未弹起返回0，时间段内弹起返回1
	;参1:键位名称
	;参2: 超时等待时间
	keywait, % thetabkey, % "D T" times
	if errorlevel
		return 0
	else
		return 1
}

KWRTtimes(thetabkey) {
	;无限等待按键被按下并在松开时返回按键时间,单位毫秒
	keywaitDown(thetabkey)
	DOWNTIME := [A_Now, A_MSec]
	keyWaitUp(thetabkey)
	return % NMsecSubt([A_Now, A_MSec], DOWNTIME)
}

KWRTtimesEX(thetabkey, downwait := 1, longtaptimewait := 1) {
	;检测按键
	;一定时间内未按下按键返回0
	;长按时间超过设定longtaptimewait秒数返回-1
	;其他按键时间返回按键按击毫秒数
	if (!keyWaitDown_T(thetabkey, downwait)) 
		return 0 ;downwait秒内按键未被按下
	DOWNTIME := [A_Now, A_MSec]
	if !(keyWaitUp_T(thetabkey, longtaptimewait))
		return -1 ;长按时间超过longtaptimewait
	else
		return % NMsecSubt([A_Now, A_MSec], DOWNTIME)
}

NMsecSubt(tmlsA, tmlsB) {
	;计算两时间点列表值的差，返回单位毫秒
	;参1：被减列表
	;参2：减列表
	subSVar := tmlsA[1]
	subSVar -= tmlsB[1], s	;两数相减的秒数
	if (subVar != 0) 
		return % (subSVar * 1000) + (tmlsA[2] - tmlsB[2])
	else
		return % (tmlsA[2] - tmlsB[2])
}