#Persistent
CoordMode, tooltip, screen
SetTimer, Tool, 1000
return

!q::
Control, ChooseString, PNG, ComboBox3, A
return

Tool:
ToolTip, % "alt+q >> 储存png", 100, 100
return