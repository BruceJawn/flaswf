private var _mochiads_game_id:String = "cf15f86cb503408c";
private var submit:TextField = new TextField();
private var submitSprite:Sprite = new Sprite();

private function createSubmit():void
{
	//input.type = "input";
	
	//input.textColor = 0xffffff;
	
	var fmt:TextFormat = new TextFormat();
    //fmt.align = TextFormatAlign.CENTER;
    fmt.font = "Microsoft JhengHei"
    fmt.color = 0xffffff;
	fmt.size = 14;
	fmt.bold = true;
	submit.defaultTextFormat = fmt;	
	submit.text = "提交得分!"
	
	submit.border = true;
	submit.borderColor = 0xffffff;
	submit.width = 65;
	submit.selectable = false;
	submit.multiline = input.wordWrap = false;
	submit.height = 22;
	
	submitSprite.addChild(submit);
	addChild(submitSprite);
	submitSprite.buttonMode = true;
    submitSprite.mouseChildren = false;
	submitSprite.x = stage.stageWidth - 67;
	submitSprite.y = 2;
	submitSprite.addEventListener(MouseEvent.CLICK, onClick);
}

private function onClick(e)
{
	submitScore(getScore_AS3());
}
public function submitScore(scoreValue:int=0):void
{
	//consoleWrite("submit");
	var o:Object = { n: [7, 12, 10, 15, 3, 0, 6, 10, 4, 6, 13, 8, 6, 3, 7, 10], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
    var boardID:String = o.f(0,"");
    MochiScores.showLeaderboard({boardID: boardID, score: scoreValue});
}