/**
*Simple Fast Bilinear Color Interpolation
*May 7, 2011
*Bruce Jawn
*http://bruce-lab.blogspot.com

*Copyright (c) <2011> <Bruce Jawn>
*This software is released under the MIT License 
*<http://www.opensource.org/licenses/mit-license.php>
**/
package {
	import flash.display.*;
	[SWF(width="256", height="256", backgroundColor="#000000")]
	public class SFBilinearColorInterpolation extends Sprite {
		public function SFBilinearColorInterpolation() {
			//OutPut
			var OutPutData:BitmapData=new BitmapData(256,256,false,0x000000);
			var OutPut:Bitmap=new Bitmap(OutPutData);
			addChild(OutPut);
			//colors to interpolate
			var c0:uint=0xffffff;var c1:uint=0xff0000;
			var c3:uint=0x0000ff;var c2:uint=0x00ff00;
			//scales
			var sy:Number=1.0/256;
			var sx:Number=1.0/256;
			//color differences: left direction
			var cdy0r:Number=((c3>>16&0xff)-(c0>>16&0xff))*sy;
			var cdy0g:Number=((c3>>8&0xff)-(c0>>8&0xff))*sy;
			var cdy0b:Number=((c3&0xff)-(c0&0xff))*sy;
			//color differences: top direction
			var cdx0r:Number=((c1>>16&0xff)-(c0>>16&0xff))*sx;
			var cdx0g:Number=((c1>>8&0xff)-(c0>>8&0xff))*sx;
			var cdx0b:Number=((c1&0xff)-(c0&0xff))*sx;
			//color differences: down direction
			var cdx1r:Number=((c2>>16&0xff)-(c3>>16&0xff))*sx;
			var cdx1g:Number=((c2>>8&0xff)-(c3>>8&0xff))*sx;
			var cdx1b:Number=((c2&0xff)-(c3&0xff))*sx;
			//difference of two color differences (down-top)
			var cdx10r:Number=(cdx1r-cdx0r)*sy;
			var cdx10g:Number=(cdx1g-cdx0g)*sy;
			var cdx10b:Number=(cdx1b-cdx0b)*sy;
			//x direction colors
			var c0r:uint=c0>>16&0xff;
			var c0g:uint=c0>>8&0xff;
			var c0b:uint=c0&0xff;
			//temp vars
			var cr:Number;
			var cg:Number;
			var cb:Number;
			//
			for (var i:uint=0; i<256; i++) {
				cr=c0r;
				cg=c0g;
				cb=c0b;
				for (var j:uint=0; j<256; j++) {
					OutPutData.setPixel(i,j,cr<<16|cg<<8|cb);
					//interpolation of y direction
					cr+=cdy0r;
					cg+=cdy0g;
					cb+=cdy0b;
				}//end of for j
				//interpolation of x direction
				c0r+=cdx0r;
				c0g+=cdx0g;
				c0b+=cdx0b;
				//update y direction color difference
				cdy0r+=cdx10r;
				cdy0g+=cdx10g;
				cdy0b+=cdx10b;
			}//end of for i
		}//end of function
	}//end of class
}//end of package