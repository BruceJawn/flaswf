/*
GROUFST2.KC ported from GROUFST2.BAS by Ken Silverman (09/28/2006)
GROUFST2.KC ported to AS3 by Bruce Jawn (January/4/2011)
http://bruce-lab.blogspot.com
Happy Coding 2011!
*/
package {
	import flash.display.*;
	import flash.events.*;
	[SWF(backgroundColor = 0x0, width = 256, height = 256, frameRate = 30)]
	public class groufst2AS3 extends Sprite {
		var ScreenBuffer:BitmapData=new BitmapData(512,512,false);
		var Screen:Bitmap=new Bitmap(ScreenBuffer);
		var hei:Array=[4096];//64x64 height map
		var col:Array=[4096];//64x64 color map
		var pal:Array=[256];
		//Initialize starting position
		var posx:int=0;
		var posy:int=0;
		var posz:int=40;
		var ang:Number=0;
		var horiz:int=-50;
		var xres:int=256;
		var yres:int=256;

		var bstatus:Boolean=false;
		var dd:Number=2/xres;//Increment size
		var de:int=dd*256;//Scan out 256 units
		var temp=3*Math.pow(2,57);

		public function groufst2AS3() {
            //Generate palette
			for (var z:int=0; z<64; z++) {
				pal[z]=z*4*65536+z*4*256+z*2;
				pal[z+64]=z*2*65536+z*4*256+z*4;
			}
            //Generate interesting height & color maps
			var p:int=0;
			for (var y:int=0; y<64; y++) {
				for (var x:int=0; x<64; x++) {
					var d:int=Math.pow(15,2)-Math.pow(x%32-16,2)-Math.pow(y%32-16,2);
					if ((d>0)&&((x/32>>0+y/32>>0)%2)) {
						hei[p]=(64-Math.sqrt(d))>>0;
						col[p]=(x+y)*0.5>>0;
					} else {
						hei[p]=64;
						col[p]=(Math.cos(x*0.2)+Math.sin(y*0.3))*3+88>>0;
					}
					p++;
				}
			}

			for (var i:int=0; i<4096; i++) {
				var color:uint=col[i];
				col[i]=pal[color];
			}

			addChild(Screen);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}//end of function groufst2AS3

		function onMouseDown(event:MouseEvent) {
			bstatus=true;
		}//end of function onMouseDown
		function onMouseUp(event:MouseEvent) {
			bstatus=false;
		}//end of function onMouseUp

		function onEnterFrame(event:Event) {
			ScreenBuffer.fillRect(ScreenBuffer.rect,0x0);
			horiz=stage.mouseY-yres/2;
			var sdz:Number=(yres/2-horiz)*dd;
			var cosang:Number=Math.cos(ang);
			var sinang:Number=Math.sin(ang);
			var dx:Number=(sinang+cosang)*64;
			var dxi:Number=-sinang*dd*64;
			var dy:Number=sinang-cosang;
			var dyi:Number=cosang*dd;
			//For each column...
			for (var sx:int=0; sx<xres; sx++) {
				var x:Number=posx<<6;
				var y:Number=posy;
				var z:Number=posz;
				var dz:Number=sdz;
				var sy:int=yres-1;
				//Fast ray trace! No *'s or /'s in here
				for (var d=0; d<=de; d+=dd) {
					x+=dx;
					y+=dy;
					z+=dz;
					var i=(x+temp-temp+y)>>0;
					var color=col[i&4095];
					for (var h=hei[i&4095]; h<z; z-=d) {
						ScreenBuffer.setPixel(sx,sy,color);
						sy--;
						dz-=dd;
					}
				}
				dx+=dxi;
				dy+=dyi;
			}
			//Move position & angle
			var f:int=(stage.mouseY-yres/2)*0.2;
			if (bstatus) {
				posz=Math.min(Math.max(posz+f,-48),48);
			} else {
				posx-=cosang*f;
				posy-=sinang*f;
			}
			ang+=(stage.mouseX-xres/2)/xres*4*0.1;
		}//end of function onEnterFrame

	}//end of class
}//end of package