package ;

import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Rectangle;
import nme.utils.ByteArray;
import nme.utils.Endian;
import nme.Vector;
import nme.Memory;
/**
 * ...
 * @author Bruce
 * 2013/03/16, Ported to HaXe NME from the Alchemy example by
 * Ralph Hauwert: http://unitzeroone.com/blog/2009/04/06/more-play-with-alchemy-lookup-table-effects/
 * Ref: http://stackoverflow.com/questions/10157787/haxe-nme-fastest-method-for-per-pixel-bitmap-manipulation
 */

class Main extends Sprite
{
    var ScreenData:BitmapData;
    var Screen:Bitmap;
    var rect:Rectangle;
    var timeStamp:Int;
    var resX:Int; 
    var resY:Int;
    //table
    var mLUT:Array<Int>;
  
    function setupLookupTables():Void
    {
	var k:Int=0;
	var u:Float,v:Float,x:Float,y:Float,d:Float,a:Float;
	for(j in 0...1024){
	    for(i in 0...1024)
		{
		    x = -1.00 + 2.00*i/1024;
		    y = -1.00 + 2.00*j/1024;
		    d = Math.sqrt( x*x + y*y );
		    a = Math.atan2( y, x );
		    u = 0.02*y+0.03*Math.cos(a*3)/d;
		    v = 0.02*x+0.03*Math.sin(a*3)/d;
		    mLUT[k++] = (Std.int(1024.0*u)) & 1023;
		    mLUT[k++] = (Std.int(1024.0*v)) & 1023;
		}
	}
    }

    public function new() 
	{
	    super();
	    timeStamp = 0;
	    resX = 512;
	    resY = 512;
	    mLUT = [];
	    ScreenData = new BitmapData(resX, resY, false, 0x0);
	    Screen = new Bitmap(ScreenData);
	    rect = ScreenData.rect;
	    start();
    }
    var Data:ByteArray;
    var VirtualRAM:ByteArray;
    function initializeDiffuseBuffer():Void
    {
	// Get the pixels data
	Data = (Assets.getBitmapData("assets/img/diffuse.jpg")).getPixels(rect);
	
	// The virtual memory space, for screen buffer (0-resX*resY) and texture data (resX*resY-)
	VirtualRAM = new ByteArray();
	// 32bits integer = 4 bytes
	// CPP does not support setting the length property directly
	#if (cpp) VirtualRAM.setLength((resX*resY + resX*resY) * 4);
	#else VirtualRAM.length = (resX*resY + resX*resY) * 4;
	#end
	    // Write the texture data into RAM
	    VirtualRAM.position = resX*resY*4;
	VirtualRAM.writeBytes(Data, 0, Data.length);
	#if (flash) Data.clear();
	#end
	    // Select the memory space (call it once, not every frame)
	    // "Selecting different memory blocks in cycles may lead to a performance loss!"
	    Memory.select(VirtualRAM);
    }
		
    public function start() {
	initializeDiffuseBuffer();
	addChild(Screen);
	setupLookupTables();
	addEventListener(Event.ENTER_FRAME, rasterize);
    }
	
    function rasterize(event:Event):Void
    {
    
	// Clear the RAM space for Screen Buffer
	for (zz in 0...resX*resY) {
	    Memory.setI32(zz*4, 0x0);
	}
	
	var lpos:Int,u:Int,v:Int,tpos:Int,opos:Int,j:Int,i:Int,jpos:Int,juvpos:Int;
	timeStamp++;

	var utime:Int = Std.int(Math.sin((timeStamp*0.6)*0.017453292519943295)*resX);
	var vtime:Int = Std.int(Math.cos((timeStamp*0.9)*0.017453292519943295)*resY);
	var xOff:Int = Std.int(1024/2 - resX/2);
	var yOff:Int = Std.int(1024/2 - resY/2);
	var xtime:Int = Std.int(Math.sin((timeStamp*3.2)*0.017453292519943295)*xOff);
	var ytime:Int = Std.int(Math.cos((timeStamp*2)*0.017453292519943295)*yOff);
	xOff+=xtime;
	yOff+=ytime;
	for(j in 0...resY){
	    jpos = resX*j;
	    juvpos = j+yOff;
	    for(i in 0...resX){
		lpos = (1024*(juvpos&1023)+((i+xOff)&1023))*2;
		u = mLUT[lpos]+utime;
		v = mLUT[lpos+1]+vtime;
		tpos = (512*(v&511) + (u&511));
		opos = (jpos + i);
		// Get the color from the RAM, offset/address for texture data block is 512 * 512, the length of screen buffer data block
		var color:Int = Memory.getI32((tpos + 512 * 512) << 2);
		// Set the color.
		// Color is in BGRA mode, nme.Memory can only be used in little endian mode.
		Memory.setI32(opos*4, color);
	    }
	}
	// Render the BitmapData
	ScreenData.lock();
	VirtualRAM.position = 0;
	ScreenData.setPixels(rect, VirtualRAM);
	ScreenData.unlock();	
    }
	
}
