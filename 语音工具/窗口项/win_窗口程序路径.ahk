;�򿪵�ǰ����ڵĳ���·��

#singleinstance force

WinGet, pathx, ProcessPath , A 
run, % strFulltDir(pathx) 



strFulltDir(STRIN) {
	;��ȡ�ļ�·��
	FL := []
	Loop, Parse, % STRIN, `\
		FL.Insert(A_LoopField)
	FL.Remove(FL.MaxIndex())
	for I in FL
	{
		if A_Index = 1
			Dir := % FL[A_Index]
		else
			Dir := % Dir "\" FL[A_Index]
	}
	return % Dir
}