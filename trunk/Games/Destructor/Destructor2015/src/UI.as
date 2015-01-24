import flash.display.Bitmap;
import flash.display.Sprite;

[Embed(source="../res/pic/MainMenu_P.png")]
private static var MainMenu_PClass:Class;
private var MainMenu_P_T:BitmapData = new MainMenu_PClass().bitmapData;

[Embed(source="../res/pic/NewGame_B.png")]
private static var NewGame_BClass:Class;
private var NewGame_B_T:BitmapData = new NewGame_BClass().bitmapData;

[Embed(source="../res/pic/Instruction_B.png")]
private static var Instruction_BClass:Class;
private var Instruction_B_T:BitmapData = new Instruction_BClass().bitmapData;

[Embed(source="../res/pic/Credit_B.png")]
private static var Credit_BClass:Class;
private var Credit_B_T:BitmapData = new Credit_BClass().bitmapData;

[Embed(source="../res/pic/Continue_B.png")]
private static var Continue_BClass:Class;
private var Continue_B_T:BitmapData = new Continue_BClass().bitmapData;

[Embed(source="../res/pic/SubmitScore_B.png")]
private static var SubmitScore_BClass:Class;
private var SubmitScore_B_T:BitmapData = new SubmitScore_BClass().bitmapData;

[Embed(source="../res/pic/Instruction_P.png")]
private static var Instruction_PClass:Class;
private var Instruction_P_T:BitmapData = new Instruction_PClass().bitmapData;

[Embed(source="../res/pic/Credit_P.png")]
private static var Credit_PClass:Class;
private var Credit_P_T:BitmapData = new Credit_PClass().bitmapData;

//[Embed(source="../res/pic/GameOverMenu_P.png")]
//private static var GameOverMenu_PClass:Class;
//private var GameOverMenu_P_T:BitmapData = new GameOverMenu_PClass().bitmapData;

private var NewGame_B:Sprite;
private var Instruction_B:Sprite;
private var Credit_B:Sprite;

private var Continue_B:Sprite;
private var SubmitScore_B:Sprite;

private var Instruction_P:Sprite;
private var Credit_P:Sprite;
private var MainMenu_P:Sprite;
private var PauseMenu_P:Sprite;

//private var GameOverMenu_P:Sprite;

private function initUI():void
{
	//trace("initUI");
	MainMenu_P = new Sprite();
	MainMenu_P.addChild(new Bitmap(MainMenu_P_T));
	NewGame_B = new Sprite();
	NewGame_B.addChild(new Bitmap(NewGame_B_T));
	NewGame_B.addEventListener(MouseEvent.CLICK, onNewGame_B);
	function onNewGame_B(e:Event):void
	{
		CurState = GAME_MENU$RUNNING;
	}
	
	Instruction_P = new Sprite();
	Instruction_P.addChild(new Bitmap(Instruction_P_T));
	Instruction_P.addEventListener(MouseEvent.CLICK, onInstruction_T);
	function onInstruction_T(e:Event):void
	{
		e.target.parent.removeChild(Instruction_P);
	}
	
	Instruction_B = new Sprite();
	Instruction_B.addChild(new Bitmap(Instruction_B_T));
	Instruction_B.addEventListener(MouseEvent.CLICK, onInstruction_B);
	function onInstruction_B(e:Event):void
	{
		if (contains(PauseMenu_P))
			PauseMenu_P.addChild(Instruction_P);
		else
			MainMenu_P.addChild(Instruction_P);
		Instruction_P.x = (512 - Instruction_P.width) / 2;
		Instruction_P.y = (384 - Instruction_P.height) / 2;
	}
	
	Credit_B = new Sprite();
	Credit_B.addChild(new Bitmap(Credit_B_T));
	Credit_B.addEventListener(MouseEvent.CLICK, onCredit_B);
	function onCredit_B(e:Event):void
	{
		MainMenu_P.addChild(Credit_P);
		Credit_P.x = (512 - Credit_P.width) / 2;
		Credit_P.y = (384 - Credit_P.height) / 2;
	}
	
	Credit_P = new Sprite();
	Credit_P.addChild(new Bitmap(Credit_P_T));
	Credit_P.addEventListener(MouseEvent.CLICK, onCredit_P);
	function onCredit_P(e:Event):void
	{
		MainMenu_P.removeChild(Credit_P);
	}
	//
	PauseMenu_P = new Sprite();
	Continue_B = new Sprite();
	Continue_B.addChild(new Bitmap(Continue_B_T));
	Continue_B.addEventListener(MouseEvent.CLICK, onContinue_B);
	function onContinue_B(e:Event):void
	{
		Mouse.hide();
		CurState = GAME_PAUSED$RUNNING;
	}
	SubmitScore_B = new Sprite();
	SubmitScore_B.addChild(new Bitmap(SubmitScore_B_T));
	SubmitScore_B.addEventListener(MouseEvent.CLICK, onSubmitScore_B);
	function onSubmitScore_B(e:Event):void
	{
		SubmitScore_H();
	}
	//
/*
   GameOverMenu_P = new Sprite();
   GameOverMenu_P.addChild(new Bitmap(GameOverMenu_P_T));
 */
}