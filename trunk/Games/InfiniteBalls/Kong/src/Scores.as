
private function SubmitScore(USER_SCORE:int):void
{
	EB.play();
	kongregate.stats.submit("HighScores",USER_SCORE);
} //end of SubmitScore

private function SubmitAScore(USER_SCORE:int):void
{
	EB.play();
	kongregate.stats.submit("BestPlayers",USER_SCORE);
} //end of ViewScore
