picOnlyAlphaGUI_rtStr(guiName_str :=  "picOnlyAlphaGUI", picLP_str := false, guiPos_list := false, alphaV_int := 150, guicolorTrans_str := "ffffff",guiDisable_bool := true) {
	global
	;创建带透明度的纯图片GUI
	;参1：gui名称，取变量名同等名称
	;参2 : 唯一图片长路径
	;参3 : gui位置列表, 如[0, 0]
	;参4 : 透明度, 默认无透明度,优先于颜色透明
	;参5: 设定某颜色为透明 ,默认白色
	;参6 : 是否禁用窗口且点击穿透,默认禁用
	
	if !WinExist(guiName_str) {
		syswinadwid_int := 6
		syswinadhei_int := 26
		Gui, %guiName_str%:new
		;GUI选项
		Gui, %guiName_str%: +AlwaysOnTop   +ToolWindow +Hwnd%guiName_str%_ID ;+Disabled
		if  (picLP_str) && fileexist(picLP_str){
			;存在图片时
			Gui, %guiName_str%:Add, Picture, v%guiName_str%picName x0 y0, %picLP_str%
			GuiControlGet, %guiName_str%picName, Pos
		}
		else {
			;不存在图片时
			MsgBox, picture doesnt exist！`ngui will being Destroy
			gui, %guiName_str%:Destroy
			return false
		}
		;此为图片宽高获取
		__PICWW := % guiName_str "picNameW"
		__PICHH := % guiName_str "picNameH"
		__PICWW := % %__PICWW% - syswinadwid_int
		__PICHH := % %__PICHH% 
		if not guiPos_list 
			;无设定坐标时, 居中
			Gui, %guiName_str%: Show,  % " w" .  __PICWW " h" .  __PICHH " Center NA", %guiName_str%
		else {
			;有设定坐标时，不居中
			__GUIXXX := guiPos_list[1]
			__GUIYYY := guiPos_list[2]
			guiGpos_str := % " x" __GUIXXX " y" __GUIYYY  " w" .  __PICWW " h" .  __PICHH " NA"
			Gui, %guiName_str%: Show,  %guiGpos_str%, %guiName_str%
		}
		;此为新窗口id
		__theid2 := % guiName_str . "_ID"
		__theid := % "ahk_ID " %__theid2%
		;透明度参数

		;取消边框，调整窗口位置
		gui, %guiName_str%: -caption -toolwindow
		__PICWW += syswinadwid_int
		
		if (guiPos_list = false) 
			Gui, %guiName_str%: Show,  % " w" .  __PICWW " h" .  __PICHH " Center NA", %guiName_str%
		else
			Gui, %guiName_str%: Show,  % guiGpos_str, %guiName_str%
		if guicolorTrans_str
			WinSet, TransColor, % guicolorTrans_str , %guiName_str%
		if alphaV_int
			winset, Transparent, %alphaV_int%, % __theid
		
		;设定点击穿透
		if guiDisable_bool {
			Gui, %guiName_str%: +Disabled
			WinSet, ExStyle, +0x20, % __theid
			}
	}
	;返回gui名称和可用窗口id
	return  % { "name" : guiName_str, "id" : __theid}
}