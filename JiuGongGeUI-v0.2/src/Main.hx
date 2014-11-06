package ;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.events.Event;
import flash.Lib;
import openfl.Assets;

/**
 * ...
 * @author Bruce
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		var myJGG:JGG = new JGG();
		addChild(myJGG);
		myJGG.init(this,this,Assets.getText("assets/UILayout.txt"));
		myJGG.x = 400;
		myJGG.y = 240;
	}
    public function getIcon(ID:String):Bitmap
	{   
		return new Bitmap(Assets.getBitmapData("assets/" + ID));
	}
	
	public function CallBack(event:Event):Void
	{   
		trace(event.target.name);
	}
	/* SETUP */

	public function new():Void 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main():Void
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}