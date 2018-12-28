Gui, Font, q5, consolas

Gui, Add, ListView, x132 y20 w460 h310 , ListView
Gui, Add, Text, x2 y0 w120 h20 , Memory List
Gui, Add, Text, x132 y0 w120 h20 , Message List
Gui, Add, Button, x2 y340 w120 h30 , 过滤选中成员
Gui, Add, Button, x2 y380 w120 h30 , 过滤非选中成员
Gui, Add, Text, x2 y160 w120 h20 , Filtrated List
Gui, Add, Radio, x272 y0 w110 h20 , Changing list
Gui, Add, Radio, x422 y0 w110 h20 , Original list
Gui, Add, ListBox, x2 y20 w120 h140 , ListBox
Gui, Add, ListBox, x2 y180 w120 h150 , ListBox
Gui, Add, Button, x2 y420 w120 h30 , 复制qq号到剪切板
Gui, Add, Button, x452 y340 w140 h110 , 导出处理文件
Gui, Add, Button, x132 y340 w130 h30 , 过滤选中以上信息
Gui, Add, Button, x132 y380 w130 h30 , 过滤选中以下信息
; Generated using SmartGUI Creator 4.0
Gui, Show, x550 y173 h468 w608, New GUI Window
Return

GuiClose:
ExitApp