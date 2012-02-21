package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.filters.*;
	import flash.geom.*;
	
	[SWF(width=500,height=500,backgroundColor=0xffffff,frameRate=24)]
	
	public class shock extends Sprite
	{
		public function shock():void
		{
			
			/**
			 * 25-Line ActionScript Contest Entry
			 *
			 * Project: 101-shock
			 * Author:  Bruce Jawn   (http://bruce-lab.blogspot.com/)
			 * Date:    2009-1-1
			 *
			 * Permission is hereby granted, free of charge, to any person obtaining a copy
			 * of this software and associated documentation files (the "Software"), to deal
			 * in the Software without restriction, including without limitation the rights
			 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
			 * copies of the Software, and to permit persons to whom the Software is
			 * furnished to do so, subject to the following conditions:
			 *
			 * The above copyright notice and this permission notice shall be included in
			 * all copies or substantial portions of the Software.
			 *
			 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
			 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
			 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
			 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
			 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
			 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
			 * THE SOFTWARE.
			 */
			
// 3 free lines! Alter the parameters of the following lines or remove them.
// Do not substitute other code for the three lines in this section
			//[SWF(width=500, height=500, backgroundColor=0xffffff, frameRate=24)]
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
// 25 lines begins here!
			var trail:Bitmap = new Bitmap(new BitmapData(500, 500, false, 0));
			trail.filters = [new BlurFilter()];
			addChild(trail);
			var ovals:Array = new Array(101);
			var color:uint = 0xffffff * Math.random();
			for (var t:int = 0; t < 101; t++)
			{
				ovals[t] = new Sprite();
				var p:TextField = new TextField();
				ovals[t].addChild(p);
				addChild(ovals[t]);
			}
			ovals[0].y = -2 * t * Math.sin(mouseY / 200 - 0.5) + 250;
			var cnt:int = 0;
			addEventListener(Event.ENTER_FRAME, function(event:Event):void
				{
					cnt++;
					trail.bitmapData.draw(stage);
					for (var t = 1; t < 101; t++)
					{
						ovals[t].getChildAt(0).x = Math.sin(t / (5000) * Math.PI * cnt) * t * 2;
						ovals[t].getChildAt(0).y = Math.cos(t / (5000) * Math.PI * cnt) * t * 2;
						ovals[t].getChildAt(0).text = Math.round(Math.random());
						ovals[t].getChildAt(0).textColor = color;
						ovals[t].x += (ovals[t - 1].x - ovals[t].x) * 0.65;
						ovals[t].scaleY = Math.cos(mouseY / 200 - 0.5);
						ovals[t].y = -2 * t * Math.sin(mouseY / 200 - 0.5) + 250;
					}
					ovals[0].x = mouseX;
					if ((cnt) % 50 == 0)
					{
						color = Math.random() * 0xffffff;
					}
				});
// 25 lines ends here!
		
		} //end of function
	} //end of class
} //end of package

