#SingleInstance force
#Persistent
;字符赋值
char1 := "非常"
char2 := % "极度"
char3 = 十分

char4 = "
char5 = ,
char6 = ``	;转义符生效
char7 = 512351
char8 = `r666`r123
char9 = 666`n123
char10 = `r"人生`n寂寞如雪啊"

;查看字符变量赋值成果
loop, % (10)	
	msgbox, % "char" a_index " 为：`r " char%a_index% ""




