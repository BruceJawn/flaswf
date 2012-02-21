package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.filters.*;
	import flash.geom.*;
	
	[SWF(width = 500, height = 500, backgroundColor = 0x000000, frameRate = 12)]
	
	public class Particles extends Sprite
	{
		public function Particles():void
		{
			
			/**
			 * 25-Line ActionScript Contest Entry
			 *
			 * Project: Particles-101
			 * Author:  Bruce Jawn   (http://bruce-lab.blogspot.com/)
			 * Date:    2008-11-15
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
			//[SWF(width=500,height=500,backgroundColor=0x000000,frameRate=12)]
			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
// 25 lines begins here!
			var trail_map:Bitmap = new Bitmap(new BitmapData(500, 500, false, 0));
			addChild(trail_map);
			trail_map.filters = [new BlurFilter(2, 2, 1)];
			var particles_container:Sprite = new Sprite();
			addChild(particles_container);
			particles_container.x = 250;
			particles_container.y = 240;
			var particles:Array = new Array(101);
			for (var i:int = 0; i < 101; i++)
			{
				particles[i] = new TextField();
				particles_container.addChild(particles[i]);
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			var cnt:int = 0;
			var color:uint = 0x00ff00;
			function onEnterFrame(event:Event)
			{
				particles_container.rotationY = cnt * mouseX / 1000;
				particles_container.rotationX = cnt * mouseY / 1000;
				for (var i:int = 0; i < 101; i++)
				{
					particles[i].textColor = color;
					particles[i].text = Math.round(Math.random()) + ' ';
					particles[i].x = Math.sin(i / (5000) * Math.PI * cnt) * i * 2;
					particles[i].y = Math.cos(i / (5000) * Math.PI * cnt) * i * 2;
				}
				trail_map.bitmapData.draw(stage);
				cnt++;
				if ((cnt) % 50 == 0)
				{
					color = Math.random() * 0xffffff;
				}
			}
// 25 lines ends here!
		
		} //end of function
	} //end of class
} //end of package

