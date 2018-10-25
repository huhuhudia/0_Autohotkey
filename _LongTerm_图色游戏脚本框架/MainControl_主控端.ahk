/* 
	脚本名称：MainControl_主控端
	作者：虚荣_CUSong
	完成日期:2018-10-23

	功能概要：
		1.ListBox控件列表列出子功能脚本，以双击控件启动子脚本，子脚本所在文件夹名称作为控件名称
		2.账号数量统计【可省】最初仅主线与日常账号，后添加其他账号类型，账号类型数量可改作listview控件视图
		3.考虑到多机器移植，添加了注册大漠插件按钮
		4.以创建文件的方法传递雷电模拟器路径参数于子脚本
		
	其他：
		1.最初为操作便用以SmartGUI软件写成该脚本与其余子脚本GUI视图，导致GUI相关代码累赘，图省事保留原来UI代码。
		2.MainControl_主控端 脚本最初用以按钮控件管理子脚本，由于子脚本数量增加，改用列表控件管理启动子脚本，这是该项目中最终版本
*/

#NoEnv
#Persistent
#SingleInstance force
SetWorkingDir %A_SCRIPTDIR%

	gosub, Cre_MainList				;1.声明必要列表，用于Gui_Cre(), accFolder_Cre(accFolderName)2两个函数
	accFolder_Cre(accFolderName) 	;2.查询创建账号文件夹，账号由注册脚本生成，由游戏子脚本分类，accFolderName为列表
	Gui_Cre()						;3.创建GUI，附带以下3个功能控件标签：
		;GuiEvLab_list_DoubleCli:		=>列表控件事件标签，单击获取脚本修改日期，双击执行启动子脚本
		;GuiEvLab_button_ChosLDPath:	=>按钮控件事件标签，单击选择雷电文件夹路径，创建日志文本文件
		;GuiEvLab_button_ZCDM:			=>按钮控件事件标签，手动单机按钮注册大漠插件，只运行大漠文件夹下的注册脚本文件
	Gui_FirstGot()					;4.完善GUI控件显示
	settimer, Get_AccNum, 2000		;5.间隔2s循环检测账号数量
	return

/*
注1：根目录文件TotalReload.exe关联性：
	!Esc:: 功能键alt+esc启动关闭所有ahk程序并重启主控端

注2：根目录文件LD_path.path关联性：
	1.GuiEvLab_button_ChosLDPath: GUI按钮控件事件标签  
	2.Gui_CLDPathEdit() 函数
	3.文件名称赋值于LDFileLongPath变量，为子脚本传递路径参数

注3：根目录文件夹DM_Plugin
	1.DM_Plugin为大漠3.1233免费版，保留所有文件
	2.为保证使用子脚本正常使用大漠插件，运行大漠自带注册脚本，注册系统接口对象，设定 [注册大漠插件] 按钮，对应GuiEvLab_button_ZCDM:标签

*/

;●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

Cre_MainList:	;创建主要脚本全局列表及全局变量

	;与 accFolder_Cre()函数 及 Gui_GotText()函数关联
	;添加新账号类型时，需要 1.添加GUI控件，记录v标签、2.添加GUI变量说明、3.修改Gui_ChangeAccText()函数
	global accFolderName := ["Acc1_主线"
							,"Acc2_日常小号"
							,"Acc3_日常成号"
							,"Acc4_日常变身"] 
		
	;关联当前主要目录下的子脚本文件，保持子脚本所在文件夹与
	global subScriptList := {"SubS0_注册账号" : "Main_LogUp.ahk"
							,"SubS1_主线起号" : "Main_ZX.ahk"
							,"SubS2_日常出金" : "Main_RC.ahk" 
							,"SubS3_摆摊上架" : "Main_BT.ahk"
							,"SubS4_仓库收菜" : "Main_SC.ahk"}
	return

;●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
;查询创建账号文件夹，根据列表创建文件夹，若文件夹存在则跳过
accFolder_Cre(folderList) {	
	for i in folderList
	{
		thisfilename := % folderList[i]
		IfNotExist, % A_Scriptdir "\" thisfilename
			FileCreateDir, % A_Scriptdir "\" thisfilename
		loop {
			IfExist, % A_Scriptdir "\" thisfilename
				break
		}
	}
}

;●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
/* GUI变量说明：

	GUITex_Status 		=> 脚本状态

	GUIEdit_LeiPath 	=> 雷电路径，与路径文件关联
	GUITex_MDFCTionDate => 子脚本修改日期，获取该脚本次行字符串

	GUITex_AccNum_All		=> Num of 所有类型账号总数
	GUITex_AccNum_ZX		=> Num of 主线账号 【所有账号来自注册脚本，所有账号文件移动通过子脚本游戏进程中判断移动】
	GUITex_AccNum_RC		=> Num of 日常账号 【50级以上的账号，由日常脚本】
	GUITex_AccNum_CP		=> Num of 成品账号 【78级以上账号】
	GUITex_AccNum_BS		=> Num of 变身账号 【完成变身嫦娥的账号】

	GUIList_SubScriFil	=> List of 子脚本 
	*/

/* GUI标签说明：
	GuiEvLab_list_DoubleCli:		=>列表事件，双击执行，启动子脚本
	GuiEvLab_button_ChosLDPath		=>按钮事件，单击选择雷电文件夹路径
	GuiEvLab_button_ZCDM:			=>按钮事件，手动单机按钮注册大漠插件，只运行大漠文件夹下的注册脚本文件
	*/

Gui_Cre() {	;创建GUI控件
	
	global GUITex_Status
	global GUIEdit_LeiPath
	global GUITex_MDFCTionDate
	
	global GUITex_AccNum_All
	global GUITex_AccNum_ZX
	global GUITex_AccNum_RC
	global GUITex_AccNum_CP
	global GUITex_AccNum_BS
	
	global GUIList_SubScriFil
	
	;--------------------------------------------------
	;1.说明类文本控件
	;--------------------------------------------------	
	Gui, Add, Text, % "x16  y7   w120 h20" , % "[游戏名]脚本列表："
	Gui, Add, Text, % "x16  y207 w80  h20" , % "模拟器路径："
	Gui, Add, Text, % "x156 y17  w60  h20" , % "账号数量："
	Gui, Add, Text, % "x16  y237 w130 h15" , % "注1: 双击列表脚本启动"
	Gui, Add, Text, % "x166 y237 w130 h15" , % "注2: Alt+Esc关闭脚本"
	Gui, Add, Text, % "x16  y257 w140 h20" , % "注3: 确保ahk版本为32位"
	Gui, Add, Text, % "x166 y122 w60  h20" , % "账号总数："
	Gui, Add, Text, % "x166 y102 w50  h20" , % "变身号："
	Gui, Add, Text, % "x166 y42  w50  h20" , % "主线号："
	Gui, Add, Text, % "x166 y62  w50  h20" , % "日常号："
	Gui, Add, Text, % "x166 y82  w50  h20" , % "成品号："
	;Gui, Add, Text, x156 y152 w140 h20 , 当前脚本最后修改日期：				;对应下方
	
	;--------------------------------------------------
	;2.参数变化类型控件
	;--------------------------------------------------
	Gui, Add, Edit, % "vGUIEdit_LeiPath      x96  y207 w180 h20 ReadOnly"	, % "None"	;模拟器路径
	Gui, Add, Text, % "vGUITex_AccNum_All    x226 y122 w40  h20"			, 0			;账号总数
	Gui, Add, Text, % "vGUITex_AccNum_ZX     x216 y42  w40  h20"			, 0			;主线号数
	Gui, Add, Text, % "vGUITex_AccNum_RC     x216 y62  w40  h20"			, 0			;日常号数
	Gui, Add, Text, % "vGUITex_AccNum_CP     x216 y82  w40  h20"			, 0			;成品号数
	Gui, Add, Text, % "vGUITex_AccNum_BS     x216 y102 w40  h20"			, 0			;变身号数
	;Gui, Add, Text, vGUITex_MDFCTionDate  x166 y172 w90  h20				, Date Modified	;脚本最后修改日期.取子脚本文件第二位
	
	;--------------------------------------------------
	;3.功能类控件
	;--------------------------------------------------	
	Gui, Add, ListBox, % "	gGuiEvLab_list_DoubleCli	vGUIList_SubScriFil 		x16  y27  w120 h180 Choose1"	, % "None"			;列表
	Gui, Add, Button , % "	gGuiEvLab_button_ChosLDPath								x276 y207 w20  h20" 			, % "+"				;路径改变按钮
	Gui, Add, Button , % "	gGuiEvLab_button_ZCDM									x166 y257 w130 h20" 			, % "注册大漠插件"	;注册大漠插件按钮

	
	Gui, % "+AlwaysOnTop"
	Gui, Show, % "x1580 y666 h292 w315", % "[游戏名]脚本主控端"
}

;---------------------
;子脚本控制列表控件事件	
;---------------------
GuiEvLab_list_DoubleCli: 	
if (A_GuiEvent = "DoubleClick") {
	GuiControlGet, Script_chos, , GUIList_SubScriFil
	GoScript := subScriptList[Script_chos]
	run, % A_ScriptDir "\" Script_chos "\" GoScript
}
return

;-----------------------------------------------
;+号按钮单击事件，添加或修改雷电路径文件，并修改控件
;LDFileLongPath为全局变量，为雷电模拟器长路径
;-----------------------------------------------
GuiEvLab_button_ChosLDPath:
	if fileexist(LDFileLongPath) { ;若原来存在路径文件，弹窗警告
		MsgBox, 4100, 警告, 已存在雷电模拟器路径文件，是否覆盖？
		IfMsgBox Yes
			FileSelectFolder, LDpath_x, *%A_workingdir%
		else
			return
	}
	else
		FileSelectFolder, LDpath_x, % "*" A_workingdir


	if (LDpath_x) {	;若选项有效
		
		GuiControl, , GUIEdit_LeiPath, % LDpath_x
		if FILEEXIST(LDFileLongPath) {			;存在旧文件则删除
			FileDelete, % LDFileLongPath
			loop {
				if !FILEEXIST(LDFileLongPath)
					break
			}
		}
		FileAppend, %LDpath_x%, % LDFileLongPath 
	}
	return

;-----------------------------------
;注册大漠插件按钮事件
;-----------------------------------
GuiEvLab_button_ZCDM: 
	SetWorkingDir %A_ScriptDir%\DM_plugin
	run, % "注册大漠插件到系统.bat"
	return

;●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

;初次完善GUI控件
Gui_FirstGot() {	
	Gui_GotList()			;1完善控件 列表-子脚本文件夹名称
	Gui_CAccText()			;2改变账号数量相关控件
	Gui_CLDPathEdit()		;3获取编辑控件路径参数
	;以下为更新GUI账号文件数量
}


;完善列表，子脚本
Gui_GotList() {	
	chr_XG := "\"	;斜杠出错
	guicontrol, , GUIList_SubScriFil, |	;清空列表
	for Key_FoderName in subScriptList
	{
		SubScrFilName :=  subScriptList[Key_FoderName]
		if fileexist(A_ScriptDir "\" Key_FoderName "\" SubScrFilName)
			guicontrol, , GUIList_SubScriFil, % Key_FoderName	;清空列表
		else
			MsgBox, , 警告, % "%A_ScriptDir%" chr_XG Key_FoderName chr_XG SubScrFilName  "路径不存在`n请核对子脚本文件路径与subScriptList列表"
	}
	
}

;完善控件 文本-账号数量-主线
Gui_CAccText() {
	global Num_Acc1 := % Gui_GotText("Acc0_主线" , "GUITex_AccNum_ZX")			;完善控件 文本-账号数量-主线
	global Num_Acc2 := % Gui_GotText("Acc1_日常小号" , "GUITex_AccNum_RC")		;~
	global Num_Acc3 := % Gui_GotText("Acc2_日常成号" , "GUITex_AccNum_CP")		;~	
	global Num_Acc4 := % Gui_GotText("Acc3_日常变身" , "GUITex_AccNum_BS")		;~
	
	;下3行代码为获取账号总数
	Num_Acc_All := 0
	loop 4
		GuiControl, , GUITex_AccNum_All, % Num_Acc_All += Num_Acc%A_Index%			
}


Gui_GotText(FoderName, controlName, FileEX := "acc") { ;完善文本，账号数量
	Num_Acc := % FileIndex(FoderName, FileEX)
	GuiControl, , %controlName%, % Num_Acc
	return % Num_Acc
}

;获取同后缀文件，递归文件夹
FileIndex(FoderName, FileEX) { 
	NumofFile := 0
	loop, % A_ScriptDir "\" FoderName "\*." FileEX, 0, 1
		NumofFile := A_Index
	return % NumofFile
}


Gui_CLDPathEdit() { ;雷电路径Edit控件
	global LDFileLongPath := %  A_ScriptDir "\LD_path.path"	
	if fileexist(LDFileLongPath) {
		FileRead, LDpath, % LDFileLongPath		;读取路径文件文件内容
		guicontrol, , GUIEdit_LeiPath, % LDpath	;写入GUIEdit_LeiPath控件
	}
	else {	;若无该文件
		MsgBox, 4100, 未设置模拟器路径, % "请确认您已安装雷神模拟器！`n是否选择雷神模拟器文件夹？", 5
		IfMsgBox, Yes	;执行GuiEvLab_button_ChosLDPath:标签，设置雷电路径
			gosub, GuiEvLab_button_ChosLDPath
	}
}

;●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
;settimer标签，间隔2s循环检测账号数量
Get_AccNum:		
	Gui_CAccText()		;改变数量相关控件
	return
;●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

!Esc::
	Run, TotalReload.exe
	return
	/* -------------------------------------------------------
	热键运行TotalReload.exe，为已编译的脚本，源码参照TotalReload.ahk
	TotalReload.ahk源代码如下：
	-------------------------------------------------------
	ProExit("AutoHotkey.exe")
	run, % a_workingdir "\MainControl-主控端.ahk"
	ExitApp

	ProExit(proName) {	;关闭所有同名进程
		loop
		{
			Process, Exist, % proName
			if ErrorLevel
				Process, Close, % proName
			else
				break

		}
	}
	------------------------------------------------------- */