package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.filters.*;
	import flash.geom.*;
	
	[SWF(width=500,height=500,backgroundColor=0x000000,frameRate=20)]
	
	public class Terrain extends Sprite
	{
		public function Terrain():void
		{
			
			/**
			 * 25-Line ActionScript Contest Entry
			 *
			 * Project: Extruding Terrain
			 * Author:  Bruce Jawn   (http://bruce-lab.blogspot.com/)
			 * Date:    2009-2-5
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
//[SWF(width=500,height=500,backgroundColor=0x0,frameRate=20)]
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
// 25 lines begins here!
			var paletteMap:Array = [0, 4279770439, 4279770439, 4279770439, 4279770439, 4279639367, 4279639367, 4279574087, 4279574087, 4279377478, 4279443271, 4279509577, 4279575370, 4279641420, 4279707213, 4279642190, 4279642449, 4279643740, 4279578719, 4279644770, 4279645540, 4279711592, 4279646828, 4279712880, 4279582322, 4279911800, 4279781245, 4279715968, 4279716994, 4279849096, 4280046733, 4280244114, 4280179350, 4280049306, 4279984028, 4280247715, 4280576937, 4280315050, 4280184493, 4280448692, 4280910524, 4281635528, 4282097100, 4282822102, 4283547357, 4284271844, 4284733673, 4285391855, 4286702825, 4289520869, 4291553494, 4289643153, 4284512567, 4279648521, 4279651077, 4281032730, 4282611492, 4280571392, 4279914240, 4281760275, 4281696517, 4283735336, 4283274533, 4283998508, 4283801631, 4282092545, 4283474448, 4283803163, 4282092544, 4282618121, 4284197405, 4282354696, 4282946827, 4280841216, 4283472920, 4282353415, 4283537689, 4283734045, 4283207952, 4280576256, 4283075600, 4283140631, 4282943252, 4280311040, 4280771072, 4280704768, 4281230592, 4281822726, 4281887243, 4281886475, 4282741269, 4282214165, 4283726634, 4284120881, 4281686287, 4281093633, 4281422347, 4282145560, 4281684755, 4281618713, 4282408480, 4282671401, 4280895243, 4285500502, 4281289496, 4282934321, 4280236808, 4281355038, 4281815843, 4282473519, 4280170764, 4281420835, 4282539314, 4281354789, 4282078765, 4281289249, 4281486373, 4281091617, 4279644173, 4279578380, 4280565275, 4280236310, 4282210098, 4280959781, 4280236059, 4280630563, 4280630817, 4279972884, 4279512336, 4279906842, 4279775256, 4279446293, 4279314705, 4280170016, 4280893484, 4279051280, 4279380247, 4280498728, 4280038177, 4279248663, 4283525208, 4283195989, 4281156406, 4282867025, 4282603853, 4289445042, 4286681478, 4281091378, 4287471507, 4286288514, 4289115820, 4288720292, 4289707187, 4290299323, 4288916901, 4291746000, 4290956484, 4293324262, 4292995296, 4294179058, 4285560175, 4294573048, 4294375158, 4294375671, 4294704636, 4292007123, 4294967295, 4293717741, 4294901759, 4294901502, 4294901759, 4294901502, 4294967295, 4294967295, 4294901502, 4294835709, 4294901759, 4294967295, 4294967295, 4294967295, 4294901502, 4291809231, 4294704123, 4294111986, 4294967295, 4294967295, 4294835709, 4294967295, 4294967295, 4294967295, 4294901502, 4294967295, 4294901502, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294901502, 4294967295, 4294967295, 4294967295, 4294901502, 4294967295, 4294901502, 4294901502, 4294901502, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295];
			var heightmap:BitmapData = new BitmapData(256, 256, true);
			heightmap.perlinNoise(150, 100, 3, 5, true, false, BitmapDataChannel.BLUE, true, [new Point(Math.random() * 256, 0), new Point(Math.random() * 256, 0), new Point(Math.random() * 256, 0)]);
			var output:Bitmap = new Bitmap(new BitmapData(500, 500, true, 0x0));
			addChild(output);
			var origintex:BitmapData = heightmap.clone();
			origintex.paletteMap(origintex, origintex.rect, new Point(), paletteMap, [], []);
			var bdNoise:BitmapData = new BitmapData(256, 256, true);
			bdNoise.perlinNoise(5, 5, 1, 5, false, true, 7, true, [new Point(Math.random() * 256, 0), new Point(Math.random() * 256, 0), new Point(Math.random() * 256, 0)]);
			origintex.draw(bdNoise, null, new ColorTransform(1, 1, 1, 0.5), BlendMode.OVERLAY);
			var canvas:Sprite = new Sprite();
			addChild(canvas);
			var cnt:int = 0;
			addEventListener(Event.ENTER_FRAME, function Extrude(event):void
				{
					var ctex:BitmapData = origintex.clone();
					ctex.threshold(heightmap, heightmap.rect, new Point(), "<", cnt, 0, 0xFF);
					canvas.graphics.clear();
					canvas.graphics.beginBitmapFill(ctex);
					canvas.graphics.drawRect(0, -256, 256, 256);
					canvas.x = 128;
					canvas.rotationX = 45;
					canvas.y = 480 - cnt++;
					output.bitmapData.draw(stage, new Matrix(), new ColorTransform(1, 1, 1, 1), null, null, true);
					if (cnt >= 200)
					{
						removeEventListener(Event.ENTER_FRAME, Extrude)
					}
					;
				});
// 25 lines ends here!
		
		} //end of function
	} //end of class
} //end of package

