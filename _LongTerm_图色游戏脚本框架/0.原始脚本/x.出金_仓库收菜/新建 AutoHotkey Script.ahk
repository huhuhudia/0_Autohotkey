da := delFStr(a_workingdir, 10)
msgbox, % da
return

delFStr(inputvar,countx := 0, rol := "R")
{
	rightx := "R"
	leftx := "L"
	if rol = % rightx
	{
		StringTrimRight, ca, inputvar, % Countx
		return % ca
	}
	else if rol = % leftx
	{
		StringTrimLeft, ca, inputvar, % Countx
		return % ca
	}
}