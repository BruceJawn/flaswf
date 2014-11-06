package
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Bruce
	 */
	public class Main extends MovieClip
	{
		[Embed(source="UILayout.txt",mimeType="application/octet-stream")]
		private var myUILayoutClass:Class;
		
		[Embed(source="testicon.png")]
		private var testiconClass:Class;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			haxe.initSwc(this);
			var myJGG:JGG = new JGG();
			addChild(myJGG);
			myJGG.x = 400;
			myJGG.y = 300;
			var myUILayout:ByteArray = new myUILayoutClass() as ByteArray;
			myJGG.init(this, this, myUILayout.toString());
		}
		
		public function getIcon(ID:String):Bitmap
		{
			var className:String = 'Main_' + ID.split('.')[0] + 'Class';
			var ClassReference:Class = getDefinitionByName(className) as Class;
			return (new ClassReference());
		}
		
		public function CallBack(event:Event):void
		{
			trace(event.target.name);
		}
	
	}

}