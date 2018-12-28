#SingleInstance force
#NoEnv

gui, font, , consolas
dfwd_int := A_ScreenWidth - 200
dfhe_int := A_ScreenHeight - 500

gui, DF:new
gui, DF:add, ListView,  vmsglist_control w%dfwd_int% h%dfhe_int%, No.|间隔|昵称|消息内容|时间|QQ号|
gui, DF:show, , QQ消息文本处理工具

;一般消息格式{"time" : 时间戳_int, "qqnum" : qq号_int, "name" : 名字_str, "msg" : 按行分列表_list}
totalmsg_list := gotqqmsginfo_rtLs("acfun美食交流协会.txt")
for i in totalmsg_list
{
	序号 := i
	
	if (i = 1)
		消息间隔 := 0
	else {
		本次消息时间 := totalmsg_list[i]["time"]
		上次消息时间 := totalmsg_list[i - 1]["time"]
		本次消息时间 -= 上次消息时间, s
		消息间隔 := 本次消息时间
	}
	
	
	昵称 := totalmsg_list[i]["name"]
	
	消息内容 := totalmsg_list[i]["msg"]
	消息内容 := mklstostr_rtStr(消息内容, "</>")
	
	时间 := totalmsg_list[i]["time"]
	
	QQ号码 := totalmsg_list[i]["qqnum"]
	
	LV_Add(, 序号, 消息间隔, 昵称, 消息内容, 时间, QQ号码)
	LV_ModifyCol(1, "Integer Center AutoHdr")
	LV_ModifyCol(2, "Integer Center AutoHdr")
	LV_ModifyCol(3, "right AutoHdr")
	LV_ModifyCol(4, "left 800")
	LV_ModifyCol(5, "Integer Center AutoHdr")
	LV_ModifyCol(6, "Center AutoHdr")
}
return



gotqqmsginfo_rtLs(fileLP_str) {
	/*  将qq列表信息转化为字典元素单位的列表
	  *  一般消息格式{"time" : 时间戳_int, "qqnum" : qq号_int, "name" : 名字_str, "msg" : 按行分列表_list}
	  */
	  
	;~ 将文件中所有行数转为列表
	TotalLine_list := filelinetols(fileLP_str)
	;~ 删除列表中空行
	lsdelnone_rtBool(TotalLine_list) 
	;~ 最终输出列表
	qqmsgdict_list := []
	;~ 文件中所有行数
	lsmaxIndex_int := TotalLine_list.MaxIndex()
	;~ 下一轮消息坐标
	nextStarHead_int := false
	for I in TotalLine_list
	{
		if ((!nextStarHead_int) || (nextStarHead_int && (nextStarHead_int = i))) {
			nowline_str := TotalLine_list[I]
			if RegExMatch(nowline_str, "(*UCP)^\d{4}-\d{2}-\d{2}\s\d{1,2}:\d{2}:\d{2}\s.*\(\d+\)$") {
				;~ mHeadPos_int 消息头坐标 
				mHeadPos_int := i
				;~ dicttime_str 获得消息时间戳
				RegExMatch(nowline_str, "(*UCP)^(\d{4}-\d{2}-\d{2}\s\d{1,2}:\d{2}:\d{2})\s.*\(\d+\)$", nowTT_str)
				dicttime_str := clearqqmsgtime_rtInt(nowTT_str1)
				if (StrLen (dicttime_str) = 13) {
					LSIT := mkstrtols_rtLs(nowTT_str1)
					LSIT.Insert(9, "0")
					dicttime_str := mklstostr_rtStr(LSIT)
				}
				;~ dictQnum_int 获得qq号
				RegExMatch(nowline_str, "(*UCP)^\d{4}-\d{2}-\d{2}\s\d{1,2}:\d{2}:\d{2}\s.*\((\d+)\)$", nowQQnum_int)
				dictQnum_int := nowQQnum_int1
				;~ dictname_str 获得昵称
				if RegExMatch(nowline_str, "(*UCP)^\d{4}-\d{2}-\d{2}\s\d{1,2}:\d{2}:\d{2}\s(.*)\(\d+\)$", NAME_int)
					dictname_str := NAME_int1
				else
					dictname_str := ""
				
				msgNow_ls := []
				loop {
					;~ 获取信息字符串
					nowIndexFromMsg_int := I + A_Index
					nowSearchingLine_str := TotalLine_list[nowIndexFromMsg_int]
					if RegExMatch(nowSearchingLine_str, "(*UCP)^\d{4}-\d{2}-\d{2}\s\d{1,2}:\d{2}:\d{2}\s.*\(\d+\)$") 
					{	;~ r若当前行为消息头，跳过
						nextStarHead_int := nowIndexFromMsg_int
						break
					}
					else
						msgNow_ls.insert(nowSearchingLine_str)
					if (nowIndexFromMsg_int = lsmaxIndex_int)
						;~ 如果当前到达列表末尾，退出
						break
				}
				;组成字典信息
				qqmsgdict_list.Insert({"time" : dicttime_str,"qqnum" :  dictQnum_int, "name" :  dictname_str, "msg" :  msgNow_ls})
			}
		}
	}
	return qqmsgdict_list
}

mklstostr_rtStr(input_ls, deli_str := "") {
	;将列表拼接为字符串
	if input_ls.MaxIndex() {
		ddstr := ""
		if deli_str {
			for i in input_ls
			{
				if (i = 1)
					ddstr .= input_ls[i]
				else
					ddstr := % ddstr deli_str input_ls[i]
			}
		}
		else {
			for i in input_ls
				ddstr .= input_ls[i]
		}
		return ddstr
	}
	return false
}

mkstrtols_rtLs(inputstr_str) {
	;将字符串解析为列表
	strls_ls := []
	Loop, Parse, inputstr_str
		strls_ls.Insert(A_LoopField)
	if strls_ls.MaxIndex()
		return strls_ls
	else
		return false
}

clearqqmsgtime_rtInt(InputVar) {
	InputVar := RegExReplace(InputVar, "-" )
	InputVar := RegExReplace(InputVar, ":" )
	InputVar := RegExReplace(InputVar, "\s" )
	return InputVar
}

lsdelnone_rtBool(lsName) {
	;删除列表中所有空值元素
	lsLen_int:= lsName.MaxIndex()
	loop, % (lsLen_int) 
	{
		nowIndex_int := (lsLen_int - A_Index + 1)	;当前查找
		nowLoopVar := lsName[nowIndex_int]		;当前查找
		if ((!nowLoopVar) && (nowLoopVar != 0)) {
			lsName.Remove(nowIndex_int)
			existNone_Bool := 1
			}
	}
	ToolTip
	return existNone_Bool
}

filelinetols(fileLP) {
	nowls := []
	loop, read, % fileLP
		nowls.insert(A_LoopReadLine)
	return nowls
}

GuiDropFiles:
MsgBox, % a_GuiEvent
return