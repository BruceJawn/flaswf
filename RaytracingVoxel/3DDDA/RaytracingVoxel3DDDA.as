/**
*Simple Raytracing Voxel Demo with 3D DDA/Bresenham's line algorithm
*November 27, 2011
*Bruce Jawn
*http://bruce-lab.blogspot.com
*
*Copyright (c) <2011> <Bruce Jawn>
*This software is released under the MIT License
*<http://www.opensource.org/licenses/mit-license.php>
**/
package {
    import flash.display.*;
    import flash.events.*;
	[SWF(backgroundColor = 0x0, width = 256, height = 256, frameRate = 30)]
    public class RaytracingVoxel3DDDA extends Sprite {

        var eyeX:int=128;
        var eyeY:int=128;
        var eyeZ:int=-300;

        var rayX:Number;
        var rayY:Number;
        var rayZ:Number;
        var rayLen:Number;

        var color:uint;

        var xx:int=0;
        var yy:int=0;
        var zz:int=0;

        var voxelData:Array=[];

        private var ScreenData:BitmapData=new BitmapData(256,256,false,0xffff00);
        private var Screen:Bitmap=new Bitmap(ScreenData);

        public function RaytracingVoxel3DDDA():void {
            createVoxel();
            addChild(Screen);
            addEventListener(Event.ENTER_FRAME,render);
        }//end of RaytracingVoxel

        private function createVoxel():void {
            //bounding box
            for (var i:int=0; i<256; i++) {
                for (var j:int=0; j<256; j++) {
                    color=0xffffff;
                    voxelData[i<<16|j<<8|255]=color;
                    voxelData[i<<16|255<<8|j]=color;
                    voxelData[255<<16|i<<8|j]=color;
                    voxelData[i<<16|0<<8|j]=color;
                    voxelData[0<<16|i<<8|j]=color;
                }
            }
			//bounding box outline
			for each(var i in [0,1,2,255,254,253]){
				for (var j:int=0; j<256; j++) {
					color=0xff0000;
                    voxelData[i<<16|j<<8|255]=color;
                    voxelData[i<<16|255<<8|j]=color;
                    voxelData[255<<16|i<<8|j]=color;
                    voxelData[i<<16|0<<8|j]=color;
                    voxelData[0<<16|i<<8|j]=color;
				}
			}
			for (var i:int=0; i<256; i++){
				for each(var j in [0,1,2,255,254,253]){
					color=0xff0000;
                    voxelData[i<<16|j<<8|255]=color;
                    voxelData[i<<16|255<<8|j]=color;
                    voxelData[255<<16|i<<8|j]=color;
                    voxelData[i<<16|0<<8|j]=color;
                    voxelData[0<<16|i<<8|j]=color;
				}
			}
			
            //cube
            for (var i:int=2; i<64; i++) {
                for (var j:int=2; j<64; j++) {
                    color=0xff;
                    voxelData[i<<16|63<<8|j]=color;
                    voxelData[63<<16|i<<8|j]=color;
                    voxelData[i<<16|2<<8|j]=color;
                    voxelData[2<<16|i<<8|j]=color;
                    voxelData[i<<16|j<<8|2]=color;
                }
            }
			//cube outline
			for each(var i in [2,3,63,62]){
				for (var j:int=2; j<64; j++) {
					color=0xff0000;
                    voxelData[i<<16|63<<8|j]=color;
                    voxelData[63<<16|i<<8|j]=color;
                    voxelData[i<<16|2<<8|j]=color;
                    voxelData[2<<16|i<<8|j]=color;
                    voxelData[i<<16|j<<8|2]=color;
				}
			}
			for (var i:int=2; i<64; i++){
				for each(var j in [2,3,63,62]){
					color=0xff0000;
                    voxelData[i<<16|63<<8|j]=color;
                    voxelData[63<<16|i<<8|j]=color;
                    voxelData[i<<16|2<<8|j]=color;
                    voxelData[2<<16|i<<8|j]=color;
                    voxelData[i<<16|j<<8|2]=color;
				}
			}
			
            //sphere
            for (var i:int=-64; i<64; i++) {
                for (var j:int=-64; j<64; j++) {
                    for (var k:int=-64; k<64; k++) {
                        if (i*i+j*j+k*k<64*64) {
                            voxelData[(i+128)<<16|(j+128)<<8|(k+64)]=0xff00;
                        }
                    }
                }
            }

        }//end of createVoxel

        private function render(event:Event):void {
            ScreenData.lock();
            
            for (var yy:int =0; yy<256; yy++) {
                rayX=xx-eyeX;
                rayY=yy-eyeY;
                rayZ=- eyeZ;

                rayLen=Math.sqrt(rayX*rayX+rayY*rayY+rayZ*rayZ);
                rayX/=rayLen;
                rayY/=rayLen;
                rayZ/=rayLen;
                color=0xffffff;
				
                //Bresenham's line algorithm in 3D, ported from: [http://www.cobrabytes.com/index.php?topic=1150.0]
				var nx:int, x0:int, x1:int, delta_x:int, step_x:int;//:integer
				var ny:int, y0:int, y1:int, delta_y:int, step_y:int;//:integer
				var nz:int, z0:int, z1:int, delta_z:int, step_z:int;//:integer
				var swap_xy:int, swap_xz:int;//:boolean
				var drift_xy:int, drift_xz:int;//:integer
				var cx:int, cy:int, cz:int;//:integer  
				swap_xy=swap_xz=0;
				x0=xx;y0=yy;z0=0;
				x1=x0+600*rayX;y1=y0+600*rayY;z1=z0+600*rayZ;
				//'steep' xy Line, make longest delta x plane 
				if(Math.abs(y1-y0)>Math.abs(x1-x0))
				{
					var temp:int=x0;
					x0=y0;
					y0=temp;
					temp=x1;
					x1=y1;
					y1=temp;
					swap_xy=1;
				} 
				if(Math.abs(z1-z0)>Math.abs(x1-x0))
				{
					var temp:int=x0;
					x0=z0;
					z0=temp;
					temp=x1;
					x1=z1;
					z1=temp;
					swap_xz=1;
				}
                
				//delta is Length in each plane
				delta_x = Math.abs(x1 - x0);
				delta_y = Math.abs(y1 - y0);
				delta_z = Math.abs(z1 - z0);
				
				//drift controls when to step in 'shallow' planes
				//starting value keeps Line centred
				drift_xy = (delta_x / 2);
				drift_xz = (delta_x / 2);
				
				//direction of line
				step_x = 1;  if (x0 > x1) step_x = -1;
				step_y = 1;  if (y0 > y1) step_y = -1;
				step_z = 1;  if (z0 > z1) step_z = -1;

				//starting point
				ny = y0;
				nz = z0;

				//step through longest delta (which we have swapped to x)
				for (nx = x0; nx!= x1; nx+=step_x)
				{    
					//copy position
					cx = nx;    cy = ny;    cz = nz;

					//unswap (in reverse)
					if (swap_xz) //then Swap(cx, cz)
					{
						var temp:int=cx;
						cx=cz;
						cz=temp;
					}
					if (swap_xy) //then Swap(cx, cy)
					{
						var temp:int=cx;
						cx=cy;
						cy=temp;
					}
					
					//passes through this point
					//debugmsg(":" + cx + ", " + cy + ", " + cz)
					//trace(":" + cx + ", " + cy + ", " + cz);

					//update progress in other planes
					drift_xy = drift_xy - delta_y;
					drift_xz = drift_xz - delta_z;

					//step in y plane
					if (drift_xy < 0 )
					{
						ny = ny + step_y;
						drift_xy = drift_xy + delta_x;
					}  
					
					//same in z
					if (drift_xz < 0 )
					{
						nz = nz + step_z;
						drift_xz = drift_xz + delta_x;
					}

                    if ((x>256)||(y>256)||(z>256)) {
                        break;
                    }
                    if (voxelData[cx<<16|cy<<8|cz]>0) {
                        color=voxelData[cx<<16|cy<<8|cz];
                        break;
                    }

				}//end of for nx
				ScreenData.setPixel(xx,yy,color);
			}//end of for yy
			
            ScreenData.unlock();
            xx++;
            if (xx>256) {
                removeEventListener(Event.ENTER_FRAME,render);
				//(new SavingBitmap(ScreenData)).save("trace.png");
            }
        }

    }//end of class
}//end of package