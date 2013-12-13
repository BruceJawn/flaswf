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
		private var InfoTF:TextField = new TextField();
		private var newFormat:TextFormat = new TextFormat();
		private var GameInitInfoStr:String = "Console Initializing...";
		private var LoadingBarWidth:int = 500;
		private var LoadingBarHeight:int = 20;
		private var LoadingBarX:int = 0;
		private var LoadingBarY:int = 300;
		
		public function Preloader():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			if(e!=null)removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			LoadingBarX = (stage.stageWidth - LoadingBarWidth)>>1;
			InfoTF.width = stage.stageWidth;
			InfoTF.height = stage.stageHeight;
			InfoTF.text = GameInitInfoStr + "\n0%\nCompleted...";
			newFormat.font = "Lucida Console";
			newFormat.bold = "true";
			newFormat.size = 20;
			newFormat.color = 0x000000;
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
				graphics.beginFill(0xffffff);
				graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				graphics.lineStyle(1, 0xffffff);
				graphics.drawRect(LoadingBarX, LoadingBarY, LoadingBarWidth, LoadingBarHeight);
				graphics.beginFill(0x000000);
				graphics.drawRect(LoadingBarX, LoadingBarY, LoadingBarWidth * percent, LoadingBarHeight);
				graphics.endFill();
				
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
		}
		var main 
		private function startup():void
		{
			//trace("startup");
			
			
			var mainClass:Class = getDefinitionByName("Console") as Class;
			main = new mainClass();
			
			addChild(main as DisplayObject);
			
			//initMenu();
		}
	
	}//end of class

}//end of package