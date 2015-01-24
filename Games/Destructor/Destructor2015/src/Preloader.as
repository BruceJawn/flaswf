package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Bruce
	 */
	public class Preloader extends MovieClip
	{
		include "sitelock/AD.as";
		private var InfoTF:TextField = new TextField();
		private var newFormat:TextFormat = new TextFormat();
		private var GameInitInfoStr:String = "Game Initializing...";
		private var LoadingBarWidth:int = 300;
		private var LoadingBarHeight:int = 20;
		private var LoadingBarX:int = 0;
		private var LoadingBarY:int = 256;
		
		public function Preloader():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			if (e != null)
				removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			chooseAD();
			initAPI();
			stage.scaleMode = StageScaleMode.EXACT_FIT;//.SHOW_ALL;//.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			LoadingBarX = (stage.stageWidth - LoadingBarWidth) >> 1;
			InfoTF.width = stage.stageWidth;
			InfoTF.height = stage.stageHeight;
			InfoTF.text = GameInitInfoStr + "\n0%\nCompleted...";
			newFormat.font = "Lucida Console";
			newFormat.bold = "true";
			newFormat.size = 20;
			newFormat.color = 0xffffff;
			newFormat.align = "center";
			//newFormat.leading = -2;
			//newFormat.letterSpacing = 1;
			//newFormat.kerning = true;
			InfoTF.setTextFormat(newFormat);
			InfoTF.x = 0;
			InfoTF.y = 100;
			addChild(InfoTF);
			//
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		}
		
		private function ioError(e:IOErrorEvent):void
		{
			//trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void
		{
			// TODO update loader
		}
		
		private function checkFrame(e:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
			else
			{
				graphics.clear();
				graphics.beginFill(0x000000);
				graphics.drawRect(0, 0, stage.stageWidth - 1, stage.stageHeight - 1);
				graphics.endFill();
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				graphics.beginFill(0xffffff);
				graphics.drawRect(LoadingBarX, LoadingBarY, LoadingBarWidth * percent, LoadingBarHeight);
				graphics.endFill();
				graphics.lineStyle(1, 0xffffff);
				graphics.drawRect(LoadingBarX, LoadingBarY, LoadingBarWidth, LoadingBarHeight);
				
				InfoTF.text = GameInitInfoStr + "\n" + int(percent * 100) + "%\n" + "Completed...";
				InfoTF.setTextFormat(newFormat);
			}
		}
		
		private function loadingFinished():void
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			graphics.clear();
			removeChild(InfoTF);
			InfoTF = null;
			newFormat = null;
			GameInitInfoStr = null;
			LoadingBarWidth = null;
			LoadingBarHeight = null;
			LoadingBarX = null;
			LoadingBarY = null;
			// TODO hide loader
			startup();
			//var mainClass:Class = getDefinitionByName("Main") as Class;
			//gameMain = new mainClass(this) as DisplayObject;
			//gameMain.preinit();
		}
		
		//private var gameMain;
		private function startup():void
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass(this) as DisplayObject);
			//addChild(gameMain);
		}
	
	} //end of class

} //end of package