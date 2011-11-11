/*
  GROUFST2.KC ported from GROUFST2.BAS by Ken Silverman (09/28/2006)
  GROUFST2.KC ported to AS3 by Bruce Jawn (January/4/2011)
  GROUFST2NME.HX ported from GROUFST2AS3.AS by Bruce Jawn (April/3/2011)
  Updated to support HTML5  (11/11/2011)
  http://bruce-lab.blogspot.com

  Original source code can be found at Ken's website:
  Qbasic: http://www.advsys.net/ken/voxlap.htm (GROUFST2.BAS)
  EVALDRAW: http://www.advsys.net/ken/download.htm (evaldraw.zip\demos\groufst2b.kc)
  
  Still buggy.
  Can be optimized using setVector/setPixels.
  Happy Coding 2011!
*/
import flash.Lib;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.geom.Point;

class Groufst2NME extends Sprite{
      	
  var ScreenBuffer:BitmapData;
  var ScreenBuffer2:BitmapData;//double buffer: in flash we don't need this, but for sdl it is necessary!
  var Screen:Bitmap;

  var hei:Array<Int>;
  var col:Array<Int>;
  var pal:Array<Int>;

  var posx:Int;
  var posy:Int;
  var posz:Int;
  var ang:Float;
  var horiz:Int;
  var xres:Int;
  var yres:Int;

  var bstatus:Bool;
  var dd:Float;
  var de:Int;
  var temp:Float;

  public static function main() { 
    Lib.current.addChild (new Groufst2NME());
  }

  public function new() {
    super();
    Lib.current.stage.frameRate = 60;
    ScreenBuffer =new flash.display.BitmapData(256,256,false,0xff000000);
    ScreenBuffer2 =new flash.display.BitmapData(256,256,false,0xff000000);
    Screen =new flash.display.Bitmap(ScreenBuffer);
    hei =new Array();//[4096];//64x64 height map
    col =new Array();//[4096];//64x64 color map
    pal =new Array();//[256];
    //Initialize starting position
    posx =0;
    posy =0;
    posz =40;
    ang =0;
    horiz =-50;
    xres =256;
    yres =256;
    bstatus =false;
    dd =2/xres;//Increment size
    de =Std.int(dd*256);//Scan out 256 units
    temp =3*Math.pow(2,57);
    //Generate palette
    for (z in 0...64) {
      pal[z]=z*4*65536+z*4*256+z*2;
      pal[z+64]=z*2*65536+z*4*256+z*4;
    }
    //Generate interesting height & color maps
    var p:Int=0;
    for (y in 0...64) {
      for (x in 0...64) {
	var d:Int=Std.int(Math.pow(15,2)-Math.pow(x%32-16,2)-Math.pow(y%32-16,2));
	if ((d>0)&&((Std.int(x/32)+Std.int(y/32))%2==0)) {
	  hei[p]=Std.int(64-Math.sqrt(d));
	  col[p]=Std.int((x+y)*0.5);
	} else {
	  hei[p]=64;
	  col[p]=Std.int((Math.cos(x*0.2)+Math.sin(y*0.3))*3+88);
	}
	p++;
      }
    }

    for (i in 0...4096) {
      var color:Int=col[i];
      col[i]=pal[color];
    }
                      
    addChild(Screen);
    Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
    Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
    Lib.current.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
  }//end of function groufst2AS3

  function onMouseDown(event) {
    bstatus=true;
  }//end of function onMouseDown
  function onMouseUp(event) {
    bstatus=false;
  }//end of function onMouseUp

  function onEnterFrame(event) {
    ScreenBuffer2.fillRect(ScreenBuffer.rect,0xff000000);
    horiz=Std.int(stage.mouseY-yres/2);
    var sdz:Float=(yres/2-horiz)*dd;
    var cosang:Float=Math.cos(ang);
    var sinang:Float=Math.sin(ang);
    var dx:Float=(sinang+cosang)*64;
    var dxi:Float=-sinang*dd*64;
    var dy:Float=sinang-cosang;
    var dyi:Float=cosang*dd;
    //For each column...
    for (sx in 0...xres) {
      var x:Float=posx*64;
      var y:Float=posy;
      var z:Float=posz;
      var dz:Float=sdz;
      var sy:Int=yres-1;
      //Fast ray trace! No *'s or /'s in here
      var d:Float=0;
      while (d<=de) {
	x+=dx;
	y+=dy;
	z+=dz;
	var i:Int=Std.int(x+temp-temp+y);
	var color:Int=col[i&4095];
	var h:Int=hei[i&4095];
	while (h<z) {
	  ScreenBuffer2.setPixel(sx,sy,color);
	  sy--;
	  dz-=dd;
	  z-=d;
	}
	d+=dd;
      }
      dx+=dxi;
      dy+=dyi;
    }
    //Move position & angle
    var f:Int=Std.int((stage.mouseY-yres/2)*0.2);
    if (bstatus) {
      posz=Std.int(Math.min(Math.max(posz+f,-48),48));
    } else {
      posx-=Std.int(cosang*f);
      posy-=Std.int(sinang*f);
    }
    ang+=(stage.mouseX-xres/2)/xres*4*0.1;
    ScreenBuffer.copyPixels(ScreenBuffer2,ScreenBuffer2.rect,new Point(0,0));
  }//end of function onEnterFrame

}//end of class