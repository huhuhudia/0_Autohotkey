﻿/*
 MsgBox, % "首次：" . 字符串中文检测(66) 
 MsgBox, % "二次：" . 字符串中文检测("天哪") 
*/
字符串中文检测(检测中文字符串) {
 检测中文结果 := RegExmatch(检测中文字符串, "[\x{4E00}-\x{9FA5}]")
 return % 检测中文结果
}

