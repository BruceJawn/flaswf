import mochi.as3.*;

private function SubmitScore(USER_SCORE:int):void
{
	var o:Object = {n: [12, 5, 3, 1, 15, 9, 14, 12, 11, 7, 8, 11, 3, 7, 12, 5], f: function(i:Number, s:String):String
		{
			if (s.length == 16)
				return s;
			return this.f(i + 1, s + this.n[i].toString(16));
		}};
	var boardID:String = o.f(0, "");
	MochiScores.showLeaderboard({boardID: boardID, score: USER_SCORE});
} //end of SubmitScore

private function ViewScore(e:Event):void
{
	var o:Object = {n: [12, 5, 3, 1, 15, 9, 14, 12, 11, 7, 8, 11, 3, 7, 12, 5], f: function(i:Number, s:String):String
		{
			if (s.length == 16)
				return s;
			return this.f(i + 1, s + this.n[i].toString(16));
		}};
	var boardID:String = o.f(0, "");
	MochiScores.showLeaderboard({boardID: boardID});
} //end of ViewScore
