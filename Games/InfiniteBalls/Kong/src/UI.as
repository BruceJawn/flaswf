
[Embed(source="assets/ui/subscore.PNG")]
public static var subscoreClass:Class;

[Embed(source="assets/ui/subascore.PNG")]
public static var subascoreClass:Class;

[Embed(source="assets/ui/newgame.PNG")]
public static var newgameClass:Class;

[Embed(source="assets/ui/intro.PNG")]
public static var introClass:Class;

private var time:int = 0;
private var score:int = 0;
private var avscore:int = 0;

private var TimeText:TextField = new TextField();
private var ScoreText:TextField = new TextField();
private var AVScoreText:TextField = new TextField();
private var format:TextFormat = new TextFormat();

private function initUI():void
{
	format.size = 22;
	format.bold = true;
	
	ScoreText.text = "0";
	ScoreText.width = 200;
	ScoreText.height = 50;
	ScoreText.selectable = false;
	addChild(ScoreText);
	ScoreText.x = 10;
	ScoreText.y = 480;
	
	TimeText.text = "0";
	TimeText.width = 200;
	TimeText.height = 50;
	TimeText.selectable = false;
	addChild(TimeText);
	TimeText.x = 215;
	TimeText.y = 480
	
	AVScoreText.text = "0";
	AVScoreText.width = 250;
	AVScoreText.height = 50;
	AVScoreText.selectable = false;
	addChild(AVScoreText);
	AVScoreText.x = 420;
	AVScoreText.y = 480
	
	addUI(this, 0, 520, new subscoreClass(), "subscore", clicksubscore);
	addUI(this, 210, 520, new newgameClass(), "newgame", clicknewgame);
	addUI(this, 420, 520, new subascoreClass(), "subascore", clicksubascore);
	addUI(this, 0, 0, new introClass(), "intro", clickintro);
	addEventListener(Event.ENTER_FRAME, update)
}

private function update(event:Event):void
{
	time++;
	score = this.libSDL.cLib.Score_flash();
	avscore = (score * 1000 / time) >> 0;
	
	ScoreText.text = "Total Score: " + score;
	TimeText.text = "Total Time: " + time;
	AVScoreText.text = "Average Score: " + avscore;
	ScoreText.setTextFormat(format);
	TimeText.setTextFormat(format);
	AVScoreText.setTextFormat(format);
}

private function addUI(prnt:Sprite, x:int, y:int, tex:Bitmap, nm:String, onclick:Function = null):void
{
	var temp:Sprite = new Sprite();
	temp.addChild(tex);
	if (onclick != null)
	{
		temp.addEventListener(MouseEvent.CLICK, onclick);
		temp.buttonMode = true;
	}
	prnt.addChild(temp);
	temp.x = x;
	temp.y = y;
	temp.name = nm;
} //end of addUI

private function clickintro(event:Event):void
{
	removeChild(getChildByName("intro"));
}

private function clicknewgame(event:Event):void
{
	time = 0;
	score = 0;
	avscore = 0;
	this.libSDL.cLib.Restart_flash();
}

private function clicksubscore(event:Event):void
{
	SubmitScore(score);
}

private function clicksubascore(event:Event):void
{
	SubmitAScore(avscore);
}