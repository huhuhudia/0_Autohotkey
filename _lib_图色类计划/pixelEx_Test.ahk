
SetWorkingDir %a_scriptdir%
#Include %a_scriptdir%\imgClass.ahk

桌面部分 := new img("1.png")
桌面部分2 := new img("2.png")
以上两个图片 := new imgMix([桌面部分, 桌面部分2])
return

F1::
桌面部分.setscr()
以上两个图片.cliAllF()

/*
桌面部分 := new img("1540731904(1).png")
桌面部分.info()
桌面部分.imgRBl()
桌面部分.imgMM()
*/
return