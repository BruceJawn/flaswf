package{
	import flash.display.*;
	import flash.events.*;
	[SWF(backgroundColor=0xeeeeee, width=256, height=256, frameRate=30)]
	public class AS3Evaldraw_dump extends Sprite{
		var ScreenBuffer:BitmapData=new BitmapData(512,512);
		var Screen:Bitmap=new Bitmap(ScreenBuffer);
		var Canvas:Sprite=new Sprite();
		var Pen:Graphics=Canvas.graphics;
		public function AS3Evaldraw_dump()
		{
		/*GROUFST2.KC by Ken Silverman
Ported to AS3 Evaldraw by Bruce Jawn
January 4, 2011*/

stage.frameRate=30;

var hei=[4096];
var col=[4096];
var pal=[256];
var posx=0;
var posy=0; 
var posz=40;
var ang=0;
var horiz=-50;
var xres=256;
var yres=256;

var dd = 2/xres;
var de = dd*256;
var temp=3*Math.pow(2,57);
var x;
var y;
var z;

for(z=0;z<64;z++)
{
   pal[z   ] = (z*4)*65536 + (z*4)*256 + (z*2);
   pal[z+64] = (z*2)*65536 + (z*4)*256 + (z*4);
}

var p = 0;
for(y=0;y<64;y++)
   for(x=0;x<64;x++)
      {
      var d = Math.pow(15,2)-Math.pow(((x%32)-16),2)-Math.pow(((y%32)-16),2);
      if ((d > 0) && (((x/32>>0)+(y/32>>0))%2))
         { hei[p] = (64-Math.sqrt(d))>>0; col[p] = ((x+y)*0.5)>>0; }
      else { hei[p] = 64; col[p] = ((Math.cos(x*0.2) + Math.sin(y*0.3))*3 + 88)>>0; }
      p++;
      }

for(var i=0;i<4096;i++) 
{
var color=col[i];
col[i] = pal[color];
}

function onEnterFrame()
{  ScreenBuffer.fillRect(ScreenBuffer.rect,0xffffffff);
   /*horiz = stage.mouseY-yres/2;*/
   var sdz = (yres/2-horiz) * dd;
   var cosang = Math.cos(ang); 
   var sinang = Math.sin(ang);
   var dx = (sinang+cosang)*64; var dxi = -(sinang*dd)*64;
   var dy =  sinang-cosang;     var dyi = cosang*dd;
   for(var sx=0;sx<xres;sx++)
   {
      x = posx<<6; y = posy; z = posz; var dz = sdz; var sy = yres-1;
      for(d=0;d<=de;d+=dd)
      {
         x += dx; y += dy; z += dz;
         i = (x+temp-temp+y)>>0;
         var color=col[i&(4095)]; 
         for(var h=hei[i&(4095)];h<z;z-=d) 
         { 
         ScreenBuffer.setPixel(sx,sy,color);
         sy--; dz -= dd; 
         }
      }
      dx += dxi; dy += dyi;
   }
   posx = posx + cosang * 4;
   posy = posy + sinang * 4;
   ang = ang + 0.02;
}
		
		addChild(Screen)
		addEventListener(Event.ENTER_FRAME,onEF)
		function onEF(event:Event){
			onEnterFrame();
		}//end of function onEF
		
		}//end of function AS3Evaldraw_dump
		
	}//end of class
}//end of package