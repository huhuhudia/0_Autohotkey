;0-255十进制数转16进制字符串
to16(in10) {
	if (in10 > 255) or (in10 < 0) {
		MsgBox, 进制转换函数进参数错误，请取值0-255
		return 0
	}
	if in10 < 16
		return % "0" fivtto16(in10)
	else {
		pos1 := fivtto16(Mod(in10, 16))
		pos2 := fivtto16(Floor(in10 / 16))
		return % pos2 pos1
	}
		
}
;0到15转16进制
fivtto16(in10) {
	if in10 = 10
		return % "a"
	if in10 = 11
		return % "b"
	if in10 = 12
		return % "c"
	if in10 = 13
		return % "d"
	if in10 = 14
		return % "e"
	if in10 = 15
		return % "f"
	else
		return 0
}
