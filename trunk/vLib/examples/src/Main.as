package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import Lib.*;
	
	/**
	 * ...
	 * @author Bruce
	 */
	public class Main extends Sprite
	{
		[Embed(source="../bin/DataFiles/myLib.vLib",mimeType="application/octet-stream")]
		private static const DataFiles_Class:Class;
		
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
			var myLib:Lib = new Lib();
			myLib.init0("./DataFiles/Lib.xml");
			//myLib.XML2AS("./DataFiles/Lib.xml", "myLibT" /*, "myPackageT"*/);
			//myLib.init1("./DataFiles/myLib.vLib");
			myLib.addEventListener(Event.COMPLETE, Libloaded);
			function Libloaded(event:Event):void
			{
				test();
			}
			/*myLib.load(new DataFiles_Class());
			test();*/
			function test():void
			{
			myLib.load(new DataFiles_Class());
			addChild(myLib.getSwf("enemyfire"));
			var test = myLib.getSwf("enemydead");
			addChild(test);
			test.x = 100;
			
			trace(myLib.getXML("Xmlfile_0"));
			trace(myLib.getXML("Xmlfile_1"));
			
			trace(myLib.getText("Textfile_0"));
			trace(myLib.getText("Textfile_1"));
			
			trace(myLib.getBin("Binaryfile_0"));
			trace(myLib.getBin("Binaryfile_1").length);
			
			addChild(new Bitmap(myLib.getBitmapData("PNGfile")));
			}//end of test
		}
	
	}

}