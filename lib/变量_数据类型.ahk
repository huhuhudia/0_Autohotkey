;根据输入的数据，输出数据类型的字符串


typeof(thevar) {
	if ((!thevar) && (thevar!= 0))
		return % "None"
	else if thevar is integer
	{
		if thevar is time
			return % "int|True|Time"
		if thevar
			return % "int|True"
		else
			return % "int|False"
	}

	else if thevar is Float
	{
		if thevar
			return % "float|True"
		else
			return % "float|False"
	}
	else
	{
		if thevar is space
			return % "str_SpaceOnly|True"
		else 
			return % "str|True"
	}
}