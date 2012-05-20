/*
Dirty and Slow AS3 Port of http://lodev.org/cgtutor/tunnel.html
by Bruce Jawn (May/20/2012)
http://bruce-lab.blogspot.com
*/
package {
	import flash.display.*;
	import flash.events.*;
	public class Tunnel extends Sprite {
		var texWidth:int=256;
		var texHeight:int=256;
		var screenWidth:int=256;
		var screenHeight:int=256;
		var texture:BitmapData;//[texWidth][texHeight];

		//Make the tables twice as big as the screen. The center of the buffers is now the position (w,h).
		var distanceTable;//[2 * screenWidth][2 * screenHeight];
		var angleTable;//[2 * screenWidth][2 * screenHeight];

		var buffer:BitmapData;//[screenWidth][screenHeight];  
		var animation:Number=0;
		var w:int=256;
		var h:int=256;
		public function Tunnel():void {
			texture=new BitmapData(screenWidth,screenHeight,false,0xffffff);
			texture.perlinNoise( screenWidth,screenHeight, 8, 95, true, true, 4, false);
			distanceTable=Array2(2*screenWidth,2*screenHeight);
			angleTable=Array2(2*screenWidth,2*screenHeight);
			buffer=new BitmapData(screenWidth,screenHeight,false,0xffffff);
			init();
		}//end of function
		function init():void {

			//generate non-linear transformation table, now for the bigger buffers (twice as big)
			for (var x:int = 0; x < w * 2; x++) {
				for (var y:int = 0; y < h * 2; y++) {
					var angle:uint,distance:uint;
					var ratio:Number=32.0;
					//these formulas are changed to work with the new center of the tables
					distance = uint(ratio * texHeight / Math.sqrt((x - w) * (x - w) + (y - h) * (y - h))) % texHeight;
					angle = (uint)(0.5 * texWidth * Math.atan2(y - h, x - w) / 3.1416);
					distanceTable[x][y]=distance;
					angleTable[x][y]=angle;
				}
			}
			addEventListener(Event.ENTER_FRAME,loop);
			addChild(new Bitmap(buffer));
		}
		function loop(event:Event):void {
			//begin the loop

			animation+=0.05;

			//calculate the shift values out of the animation value
			var shiftX:int=int(texWidth*1.0*animation);
			var shiftY:int=int(texHeight*0.25*animation);
			//calculate the look values out of the animation value
			//by using sine functions, it'll alternate between looking left/right and up/down
			//make sure that x + shiftLookX never goes outside the dimensions of the table, same for y
			var shiftLookX:int=w/2+int(w/2*Math.sin(animation));
			var shiftLookY:int=h/2+int(h/2*Math.sin(animation*2.0));

			for (var x:int = 0; x < w; x++) {
				for (var y:int = 0; y < h; y++) {
					//get the texel from the texture by using the tables, shifted with the animation variable
					//now, x and y are shifted as well with the "look" animation values
					var color:uint = texture.getPixel((uint)(distanceTable[x + shiftLookX][y + shiftLookY] + shiftX)  % texWidth,
					                               (uint)(angleTable[x + shiftLookX][y + shiftLookY]+ shiftY) % texHeight);

					buffer.setPixel(x,y,color);
				}

			}
		}//end of function loop

		function Array2(gridSize1:int,gridSize2:int) {
			var a:Array=new Array(gridSize1);
			for (var i:int= 0; i < gridSize1; i++) {
				a[i]=new Array(gridSize2);
				for (var j:int = 0; j < gridSize2; j++) {
					a[i][j]="["+i+"]["+j+"]";
				}//end of for1
			}//end of for2
			return a;
		}//end of function Array2

	}//end of class
}//end of package