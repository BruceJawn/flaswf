package {
	/*
	  NEWVOX.C-C
	  Andrea "6502" Griffini, programmer
	  agriff@ix.netcom.com
	  http://vv.val.net/~agriffini
	  
	  voxel Class v1.0-ActionScript3.0
	  Sept. 30, 2008
	  Bruce Jawn
	  http://www.geocities.com/zhoubu1988
	  
	  Copyright (c) <2008> <Bruce Jawn>
	  This software is released under the MIT License 
	  <http://www.opensource.org/licenses/mit-license.php>
	  
	  Special thanks to FengYun 
	  http://www.fengyun.org/
	  //--------------------------------------------------
	  Notes on  Nov. 5, 2011
	  
	  How to make the background transparent without affecting shadows:
	  1. use the bitmapData with transparent color
	  2. every time when initializing the video buffer "Video", use some number (like 257) to indicate transparent part 
	  3. test whether screen pixel is indicated as transparent before setting the pixel
	  Source code changes marked with comment "//@@@@@@//"
	  There may be better solutions.
	  
	  Optimization:
	  1. use ByteArray/Vector, setPixels/setVector instead of setPixel
	  2. eliminate 2D arrays, use 1D only
      ...
	  
	  Add texture to terrain:
	  you need (generate/load) another texture map with RGB colors,
	  instead of setting grey colors "this.bitmapData.setPixel32(p,t,0xff<<24|cc<<16|cc<<8|cc);",
	  Use "cc" as the brightness for shading R,G,B channels separately and then combine them "0xff<<24|R<<16|G<<8|B"
 	*/
	import flash.display.*;
	import flash.events.*;
	public class voxel extends Bitmap {

		var HMap=Array2(256,256);//Height field
		var CMap=Array2(256,256);//Color map
		var Video:Array=new Array(320*200);//Off-screen buffer
		var r:uint;
		var i:int,k:int;
		var ss:Number,sa:Number,a:Number,s:Number;
		var x0:int,y0:int;

		var lasty:Array=[];//Last pixel drawn on a given column
		var lastc:Array=[];//Color of last pixel on a column
		var FOV:Number=3.141592654/4;//half of the xy field of view

		function L(x:Number):Number {
			return x & 0xff;
		}

		//Reduces a value to 0..255 (used in height field computation)
		function Clamp(x:Number):Number {
			return x < 0?0:x > 255?255:x;
		}

		function Array2(gridSize1:int,gridSize2:int) {
			var a:Array=new Array(gridSize1);
			for (var i:int= 0; i < gridSize1; i++) {
				a[i] = new Array(gridSize2);
				for (var j:int = 0; j < gridSize2; j++) {
					a[i][j] = "[" + i + "][" + j + "]";
				}//end of for1
			}//end of for2
			return a;
		}//end of function Array2

		//Heightfield and colormap computation
		function ComputeMap():void {
			var p:int,i:int,j:int,k:int,k2:int,p2:int;
			//Start from a plasma clouds fractal
			HMap[0][0]=128;
			for (p=256; p>1; p=p2) {
				p2=p/2;
				k=p*8+20;
				k2=k/2;
				for (i=0; i<256; i+=p) {
					for (j=0; j<256; j+=p) {
						var a:int,b:int,c:int,d:int;
						a=HMap[i][j];
						b=HMap[ L(i+p) ][j];
						c=HMap[i][ L(j+p) ];
						d=HMap[ L(i+p)][ L(j+p) ];
						HMap[i][ L(j+p2) ]=                        
						      Clamp(((a+c)>>1)+(Math.random()*k-k2));//create random height
						HMap[ L(i+p2) ][ L(j+p2) ]=        
						      Clamp(((a+b+c+d)>>2)+(Math.random()*k-k2));
						HMap[ L(i+p2) ][j]=                
						      Clamp(((a+b)>>1)+(Math.random()*k-k2));
					}//end of for1
				}//end of for2
			}//end of for3

			//Smoothing
			for (k=0; k<3; k++) {
				for (i=0; i<256; i++) {
					for (j=0; j<256; j++) {
						HMap[i][j]=(HMap[ L(i+1) ][j]+HMap[i][ L(j+1) ]+  
						           HMap[ L(i-1) ][j]+HMap[i][ L(j-1) ])/4;
					}
				}
			}//end of for3
			
			//Color computation (derivative of the height field)
			for (i=0; i<256; i++) {
				for (j=0; j<256; j++) {
					k=128+(HMap[ L(i+1) ][ L(j+1) ]-HMap[i][j])*4;
					CMap[i][j]=Clamp(k);
				}//end of for1
			}//end of for2
			
		}//end of ComputeMap()

		//Draw a "section" of the landscape; x0,y0 and x1,y1 and the xy coordinates
		//on the height field, hy is the viewpoint height, s is the scaling factor
		//for the distance. x0,y0,x1,y1 are 16.16 fixed point numbers and the
		//scaling factor is a 16.8 fixed point value.
		function Line(x0:int, y0:int, x1:int, y1:int, hy:int, s:int):void {
			var i:int,sx:int,sy:int;
			//Compute xy speed
			sx=(x1-x0)/320;
			sy=(y1-y0)/320;
			for (i=0; i<320; i++) {
				var c:int,y:int,h:int,u0:int,v0:int,u1:int,v1:int,a:int,b:int,h0:int,h1:int,h2:int,h3:int;
				//Compute the xy coordinates; a and b will be the position inside the
				//single map cell (0..255).
				u0=L(x0>>16);
				a=L(x0>>8);
				v0=L(y0>>16);
				b=L(y0>>8);
				u1=L(u0+1);
				v1=L(v0+1);
				//Fetch the height at the four corners of the square the point is in
				h0=HMap[v0][u0];
				h2=HMap[v1][u0];
				h1=HMap[v0][u1];
				h3=HMap[v1][u1];
				//Compute the height using bilinear interpolation
				h0=(h0<<8)+a*(h1-h0);
				h2=(h2<<8)+a*(h3-h2);
				h=((h0<<8)+b*(h2-h0))>>16;
				//Fetch the color at the four corners of the square the point is in
				h0=CMap[v0][u0];
				h2=CMap[v1][u0];
				h1=CMap[v0][u1];
				h3=CMap[v1][u1];
				//Compute the color using bilinear interpolation (in 16.16)
				h0=(h0<<8)+a*(h1-h0);
				h2=(h2<<8)+a*(h3-h2);
				c= (h0<<8)+b*(h2-h0);
				//Compute screen height using the scaling factor
				y=(((h-hy)*s)>>11)+100;
				// Draw the column
				a=lasty[i];
				var b:int=a*320+i;
				if ( y<(a) ) {
					var sc:int,cc:int;
					if ( lastc[i]==-1 ) {
						lastc[i]=c;
					}
					sc=(c-lastc[i])/(a-y);
					
					cc=lastc[i];
					if ( a>199 ) {
						b-=(a-199)*320;
						cc+=(a-199)*sc;
						a=199;
					}
					if ( y<0 ) {
						y=0;
					}
					while ( y<a ) {
						Video[b]=cc>>18;
						cc+=sc;
						b-=320;
						a--;
					}//end of while ( y<a )
					lasty[i]=y;
				}//end of if ( y<(a) )
				lastc[i]=c;
				// Advance to next xy position
				x0+=sx;
				y0+=sy;
			}//end of  for ( i=0; i<320; i++ )
		}//end of function  Line(x0, y0, x1, y1, hy,s)

		//Draw the view from the point x0,y0 (16.16) looking at angle a
		function View( x0:int, y0:int, aa:Number):void {
			var d:int;
			var a:int,b:int,h:int,u0:int,v0:int,u1:int,v1:int,h0:int,h1:int,h2:int,h3:int;
			// Clear offscreen buffer
			Video=new Array(320*200);
			for(d=0;d<320*200;d++)//@@@@@@//
			{
				Video[d] = 257;//@@@@@@//
			}
			// Initialize last-y and last-color arrays
			for (d=0; d<320; d++) {
				lasty[d]=200;
				lastc[d]=-1;
			}//end of for ( d=0; d<320; d++ )

			// Compute viewpoint height value

			//Compute the xy coordinates; a and b will be the position inside the
			// single map cell (0..255).
			u0=(x0>>16)&0xFF;
			a=(x0>>8)&255;
			v0=(y0>>16)&0xFF;
			b=(y0>>8)&255;
			u1=(u0+1)&0xFF;
			v1=(v0+1)&0xFF;
			//Fetch the height at the four corners of the square the point is in
			h0=HMap[v0][u0];
			h2=HMap[v1][u0];
			h1=HMap[v0][u1];
			h3=HMap[v1][u1];
			//Compute the height using bilinear interpolation
			h0=(h0<<8)+a*(h1-h0);
			h2=(h2<<8)+a*(h3-h2);
			h=((h0<<8)+b*(h2-h0))>>16;
			// Draw the landscape from near to far without overdraw
			for (d=0; d<100; d+=1+(d>>6)) {
				Line(x0+d*65536*Math.cos(aa-FOV),y0+d*65536*Math.sin(aa-FOV),
				         x0+d*65536*Math.cos(aa+FOV),y0+d*65536*Math.sin(aa+FOV),
				         h-30,100*256/(d+1));
			}//end of for ( d=0; d<100; d+=1+(d>>6) )
			//Blit the final image to the screen
			this.bitmapData.lock();
			this.bitmapData.fillRect(this.bitmapData.rect,0x00ffffff);//@@@@@@//
			for (var t:int=0; t<200; t++) {
				for (var p:int=0; p<320; p++) {
					var cc=Video[t*320+p];
					//this.bitmapData.setPixel(p,t,cc<<16|cc<<8|cc);
					if(cc!=257)//@@@@@@//
					this.bitmapData.setPixel32(p,t,0xff<<24|cc<<16|cc<<8|cc);//@@@@@@//
				}//end of for1
			}//end of for2
			this.bitmapData.unlock();

		}//end of function View

		public function voxel():void {
			//this.bitmapData=new BitmapData(320,200,false,0x000000);
			this.bitmapData=new BitmapData(320,200,true,0x00ffffff);//@@@@@@//
			// Compute the height map
			ComputeMap();
			// Main loop
			//
			//   a     = angle
			//   x0,y0 = current position
			//   s     = speed constant
			//   ss    = current forward/backward speed
			//   sa    = angular speed
			a=0;
			k=x0=y0=0;
			s=4096;
			ss=0;
			sa=0;
			//// Draw the frame
			View(0,0,0);
		}//end of public function  main()
		
		public function onkeydown(event:KeyboardEvent):void {
			// User input
			sa=0;
			ss=0;
			if (event.keyCode==37 && sa > -10 ) {
				sa -= 0.05;
			}
			if (event.keyCode==39 && sa <  10) {
				sa += 0.05;
			}
			if (event.keyCode==40) {
				ss -= 40960;
			}
			if (event.keyCode==38) {
				ss += 40960;
			}// Update position/angle
			a += sa;

			var vx:Number = Math.cos ( a );
			var vy:Number = Math.sin ( a );

			x0 += ss * vx;
			y0 += ss * vy;

			View(x0,y0,a);
		}//end of function onkeydown(event)

	}//end of calss

}//end of package