package
{
	import flash.display.*;
	import flash.events.*;
	import cmodule.Bengine.*
	import flash.filters.*
	import flash.geom.*;
	import flash.utils.ByteArray;
	import flash.media.*
	import BSprite.*
	/**
	 * ...
	 * @author Bruce
	 */
	[SWF(width=512,height=384,frameRate=60,backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	
	public class Main extends MovieClip
	{
		include "Control.as";
		include "MouseMenu.as";
		include "Res.as";
		include "UI.as";
		include "MainLoop.as";
		
		include "Bengine_Init.as";
		include "Camera.as";
		include "Physics.as";
		include "FPS_game.as";
		
		include "score/score.as"
		
		private var Holder:*; //:DisplayObject;
		
		public function Main(Holder:DisplayObject):void
		{
			this.Holder = Holder;
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function getMainLoaderInfobs():ByteArray
		{ //trace("getMainLoaderInfobs")
			var loaderInfo:LoaderInfo = root.loaderInfo;
			if (loaderInfo.loader != null)
			{
				return loaderInfo.loader.loaderInfo.bytes;
			}
			return loaderInfo.bytes;
		}
		
		public function destroy():void
		{ //trace("getMainLoaderInfobs")
			removeChild(screenBitmap);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.EXACT_FIT;//SHOW_ALL;//
			// entry point
			//include "sitelock/flashgamelicenseprotect.as"
			initMouseMenu();
			haxe.initSwc(this);
			addControl();
			initUI();
			Begnine_Init();
			FPS_Game_Init();
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	
	}

}