#SingleInstance force
#Persistent
SetTimer, 变量查看, 500
return

f1::
if (!VAR1)
	VAR1 := 1
else
	VAR1 += 1
return

f2::
if (!VAR2)
	VAR2 := 1
else
	VAR2 += 1
return

变量查看:
showAll({"VAR1" : VAR1, "VAR2" : VAR2})

return


showAll(varDict) {

	global showtex ;唯一文本参数
	global theid
	;无参数时创建参数
	if !winexist("showtheparamsGUI") {
		GUI, __showtheparamsGUI: new
		for varName in varDict
		{
			if (a_INDEX == 1) 
				str := % varName " -> " varDict[varName]
			else
				str := % str "`n" varName " -> " varDict[varName]
		}
		GUI,  __showtheparamsGUI: add, Text, w300 vshowtex, % str
		gui, __showtheparamsGUI:show, x100 y100, showtheparamsGUI
		Gui, __showtheparamsGUI: +Hwndtheid
		return
	}
    for varName in varDict
	{
        if (a_INDEX == 1) 
			str := % varName " -> " varDict[varName]
		else
			str := % str "`n" varName " -> " varDict[varName]
	}
	ControlGetText,texit, Static1, % "ahk_id " theid

	if str != texit 
	{
		ControlSetText, Static1, % str
	}
}
