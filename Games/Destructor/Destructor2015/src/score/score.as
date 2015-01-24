private function SubmitScore_H(_arg1:MouseEvent = null):void
{
	//removeEventListener(Event.ENTER_FRAME, startGame);
	CurState = GAME_SCORING;
	Holder.SubmitScore(calculateVoxelLeft());
}

private function calculateVoxelLeft():int
{
	var cnt:int = 0;
	for (var i:int = 0; i < 0x80ffff; i++)
	{
		if (alchemyState._mr32(alcvoxPointer + (i << 2)) != 0)
			cnt++;
	}
	return cnt;
}