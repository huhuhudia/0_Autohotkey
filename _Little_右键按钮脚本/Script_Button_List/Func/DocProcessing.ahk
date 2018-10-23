DEAL_EMP(filLP)
{
	loop, read, % filLP
	{
		if !A_LoopReadLine
			continue
		fileappend, % a_loopreadline "`n", % a_scriptdir "\b.txt"
	}
}