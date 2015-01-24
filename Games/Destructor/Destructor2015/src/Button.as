package
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.text.*;
	
	//create simple button to handle user input
	public class Button extends Sprite
	{
		var bgColor:uint = 0xCCCCCC; //background color
		var size:uint = 80; //button size
		var backg:Sprite = new Sprite(); //button
		var outline:Sprite = new Sprite(); //button outline
		
		public function Button(text:String, x:int, y:int):void
		{
			draw(); //draw the button
			backg.filters = [getBitmapFilter()]; //add filter
			//set mouse shape
			this.buttonMode = true;
			this.useHandCursor = true;
			//mouse over - show outline
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			showlabel(text, x, y);
		} //end of function Button
		
		//add label text to button
		public function showlabel(text:String, x:int, y:int):void
		{
			var label:TextField = new TextField();
			addChild(label);
			label.htmlText = "<b>" + text + "</b>";
			label.x = x; //(80-label.width)/2+15
			label.y = y; //(30-label.height)/2+40;
			label.selectable = false;
			label.mouseEnabled = false;
			//label.filters=[new GlowFilter()]
		} //end of function showlabel
		
		//create filter for button
		private function getBitmapFilter():BevelFilter
		{
			var distance:int = 5;
			var angleInDegrees:int = 45;
			var highlightColor:uint = 0x8c8c8c;
			var highlightAlpha:Number = 0.8;
			var shadowColor:uint = 0xffffff;
			var shadowAlpha:Number = 0.8;
			var blurX:int = 5;
			var blurY:int = 5;
			var strength:int = 5;
			var quality:int = BitmapFilterQuality.HIGH;
			var type:String = BitmapFilterType.INNER;
			var knockout:Boolean = false;
			
			return new BevelFilter(distance, angleInDegrees, highlightColor, highlightAlpha, shadowColor, shadowAlpha, blurX, blurY, strength, quality, type, knockout);
		} //end of function getBitmapFilter
		
		//draw button
		private function draw():void
		{
			with (backg.graphics)
			{
				beginFill(bgColor);
				drawRoundRect(0, 0, size, 30, 10, 10);
				endFill();
			} //end of with (backg.graphics)
			addChild(backg);
			addChild(outline);
			with (outline.graphics)
			{
				lineStyle(5, 0x0000ff);
				drawRoundRect(0, 0, size, 30, 10, 10);
			} //end of with (outline.graphics)
			outline.visible = 0; //hide outline 
		} //end of function draw
		
		//handle mouse event
		private function mouseOverHandler(event:MouseEvent):void
		{
			outline.visible = 1; //show outline 
		} //end of function mouseOverHandler
		
		private function mouseOutHandler(event:MouseEvent):void
		{
			outline.visible = 0; //hide outline
		} //end of function mouseOutHandler
	
	} //end of class
} //end of package