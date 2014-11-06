package
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Bruce
	 */
	public class Main_TP extends MovieClip
	{
		[Embed(source="UILayout.txt",mimeType="application/octet-stream")]
		private var myUILayoutClass:Class;
		
		public function Main_TP():void
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
			var myUILayout:ByteArray = new myUILayoutClass() as ByteArray;
			var myTextParser:TextParser = new TextParser(myUILayout.toString());
			while (!myTextParser.EndofFile())
			{
				
				var Name:String = myTextParser.ReadString();
				trace(Name);
				if (Name == "#") //comment line
				{
					myTextParser.GotoNextLine();
					continue;
				}
				var CallBackStr:String = myTextParser.ReadString();
				trace(CallBackStr);
				var IconStr:String = myTextParser.ReadString();
				trace(IconStr);
				var Color:uint = myTextParser.ReadInteger();
				trace(Color);
				var Label:String = myTextParser.ReadString();
				trace(Label);
				var LevelStr:String = myTextParser.ReadString();
				trace(LevelStr);
				myTextParser.GotoNextLine();
			}
		
		}
	
	}

}