package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.filters.*;
	import flash.geom.*;
	
	[SWF(width=256,height=256,backgroundColor=0xffffff,frameRate=50)]
	
	public class WaterOrFire extends Sprite
	{
		public function WaterOrFire():void
		{
			
			/**
			 * 25-Line ActionScript Contest Entry
			 *
			 * Project: Water Or Fire ?
			 * Author:  Bruce Jawn   (http://bruce-lab.blogspot.com/)
			 * Date:    2009-1-10
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
//[SWF(width=256, height=256, backgroundColor=0xffffff, frameRate=50)]
			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
// 25 lines begins here!
			var cnt:int = 0;
			var Result:BitmapData = new BitmapData(256, 256, false, 128);
			var Buffer:BitmapData = new BitmapData(256, 256, false, 128);
			this.addChild(new Bitmap(new BitmapData(256, 256, true, 128)));
			var Bruning:BitmapData = new BitmapData(256, 256, false, 0x0);
			var points:Array = [new Point(0, 0), new Point(0, 0), new Point(0, 0), new Point((Math.random() * 2 - 1) / 3, Math.random() * 3 + 2), new Point(Math.random() * 2 - 1, Math.random() * 6 + 2), new Point(Math.random() * 2 - 1, Math.random() * 6 + 2)];
			var fire:Sprite = new Sprite();
			fire.graphics.beginGradientFill(GradientType.LINEAR, [0, 0xA20000, 0xFFF122, 0xFFFFFF, 0xF8FF1B, 0xC53C05, 0x000000], [0, 1, 1, 1, 1, 1, 1], [0, 64, 132, 186, 220, 250, 255], new Matrix(1.8686010037572895e-17, 0.1556396484375, -0.30517578125, 9.529865119162177e-18, 250, 127.5), SpreadMethod.PAD);
			fire.graphics.drawRect(0, 0, 256, 256);
			this.addEventListener(Event.ENTER_FRAME, function(event:Event):void
				{
					var canvas:BitmapData = new BitmapData(256, 256, false, 0x0);
					canvas.draw(fire);
					var Sourcemap:BitmapData = Result.clone();
					if (++cnt % 10 == 1)
					{
						Sourcemap.fillRect(new Rectangle(Math.random() * 256, Math.random() * 256, 6, 6), 255);
					}
					Result.applyFilter(Sourcemap, Result.rect, new Point(), new ConvolutionFilter(3, 3, [1, 1, 1, 1, 1, 1, 1, 1, 1], 9, 0));
					Result.draw(Result, new Matrix(), null, "add");
					Result.draw(Buffer, new Matrix(), null, "difference");
					Result.draw(Result, new Matrix(), new ColorTransform(0, 0, 0.9960937, 1, 0, 0, 2, 0));
					Result.merge(new BitmapData(256, 256, false, 128), Result.rect, new Point(), 0, 0, 1, 0);
					event.target.getChildAt(0).bitmapData.applyFilter(canvas, Result.rect, new Point(), new DisplacementMapFilter(Result, new Point(), 4, 4, 32, 32));
					Buffer = Sourcemap;
					for (var i:int = 0; i < 3; i++)
					{
						points[i].offset(points[i + 3].x, points[i + 3].y);
					}
					Bruning.perlinNoise(30, 50, 3, 5, false, false, 1, true, [points[0], points[1], points[2]]);
					fire.filters = [new DisplacementMapFilter(Bruning, new Point(0, 0), 1, 1, 10, 200, "clamp")];
					stage.addEventListener(MouseEvent.MOUSE_MOVE, function(event:MouseEvent):void
						{
							Sourcemap.fillRect(new flash.geom.Rectangle(mouseX - 4, mouseY - 4, 8, 8), 255);
						});
				});
// 25 lines ends here!
		
		} //end of function
	} //end of class
} //end of package

