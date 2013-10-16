package 
{
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author Bruce
	 */
	[SWF(backgroundColor=0xeeeeee,width=800,height=600)]
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(new HTMLWebCreator());
		}

	}

}