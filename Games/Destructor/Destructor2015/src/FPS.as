package
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPS extends TextField
	{
		private var fs:int;
		private var ms:int;
		
		public function FPS()
		{
			var format:TextFormat = new TextFormat();
			
			format.color = 0xff0000;
			format.size = 12;
			format.bold = true;
			format.font = 'Verdana';
			
			textColor = 0xcecece;
			autoSize = "left";
			defaultTextFormat = format;
			
			ms = getTimer();
			fs = 0;
			addEventListener(Event.ADDED, onAdded);
			addEventListener(Event.REMOVED, onRemoved);
		}
		
		private function onAdded(event:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onRemoved(event:Event):void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			if (getTimer() - 1000 > ms)
			{
				ms = getTimer();
				text = fs.toString();
				fs = 0;
			}
			else
			{
				++fs;
			}
		}
	}
}