package
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
    
	[SWF(width = 640, height = 580, frameRate = 60, backgroundColor = "#FFFFFF")]
	
	public class Preloading extends MovieClip
	{
		private var infotext:TextField = new TextField();
		private var newFormat:TextFormat = new TextFormat();
		public function Preloading():void
		{
			infotext.width = 640;
			infotext.height = 256;
			infotext.text = "GAME Initializing...\n0%\nCompleted..."

			newFormat.font = "Lucida Console";
			newFormat.bold = "true";
			newFormat.size =  20;
			newFormat.color = 0x000000;//0xEEEE00;
			newFormat.align = "center";
			//newFormat.leading=-2;
			//newFormat.letterSpacing = 1;
			//newFormat.kerning=true;
			infotext.setTextFormat(newFormat);
			infotext.x = 0;
			infotext.y = 128;

			stop();
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			//clicktest.addEventListener(MouseEvent.CLICK, playgame);
			//playgame(null)
			//
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addChild(infotext);
		}

		public function onEnterFrame(event:Event):void
		{
			graphics.clear();
			if(framesLoaded == totalFrames)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeChild(infotext);
				infotext  = null;
                newFormat = null;
				nextFrame();
				init();
			}
			else
			{   
				var percent:Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
                graphics.lineStyle(1,0xffffff);
                graphics.drawRect(0, 640 / 2 + 100, 640 , 20);
				graphics.beginFill(0xffffff);
				//graphics.drawRect(0, stage.stageHeight / 2 - 10, stage.stageWidth * percent, 20);
				graphics.drawRect(0, 640 / 2 + 100, 640 * percent, 20);
				graphics.endFill();
				infotext.text = "GAME Initializing...\n" + int(percent * 100) + "%\n" + "Completed...";
				infotext.setTextFormat(newFormat);
			}
		}

		private function init():void
		{
			var mainClass:Class = Class(getDefinitionByName("flashsdl"));
			if(mainClass)
			{
				var app:Object = new mainClass();
				addChild(app as DisplayObject);
			}
		}

	}
}