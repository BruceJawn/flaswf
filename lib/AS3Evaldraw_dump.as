package{
	import flash.display.*;
	import flash.events.*;
	[SWF(backgroundColor=0xeeeeee, width=512, height=512, frameRate=30)]
	public class AS3Evaldraw_dump extends Sprite{
		var ScreenBuffer:BitmapData=new BitmapData(512,512);
		var Screen:Bitmap=new Bitmap(ScreenBuffer);
		var Canvas:Sprite=new Sprite();
		var Pen:Graphics=Canvas.graphics;
		public function AS3Evaldraw_dump()
		{
		/*init();function onEnterFrame(){}//end of function onEnterFrame*/
		
		addChild(Screen)
		addEventListener(Event.ENTER_FRAME,onEF)
		function onEF(event:Event){
			onEnterFrame();
		}//end of function onEF
		
		}//end of function AS3Evaldraw_dump
		
	}//end of class
}//end of package