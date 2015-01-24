//void  Line(int x0, int y0, int x1, int y1, int hy, float s, float is,int voxelength){
//=========================
/*
y00065536=-cheight*s65536+MidOut;//(0-cheight)*s+MidOut;

int sHd=cheight-MidOut16Mis[d];//(cheight-(MidOut>>16)*is);//????????????????
int sHt=sHd+resYMis1[d];//sHd+resY*is+1;//(cheight+192*is-MidOut*is);
*/	

int /*h ,*/u0, v0, uv,/* a,*/ b,i;
int y;
unsigned int c;

//float y000/*,y255*/,y0255;
int y000,y0255;
int down,top,height;
//float yf,yc/*,ycf,*//*ddd,crayz*/;
int yf,yc;
int ddd,crayz;
//=========================
y0255=project_s65536_t[d];//s;//(y255-y000)/256//>>8;///256;//256;
y000=(-cheight*y0255+(MidOut<<16));//(int)(-cheight*s/*y0255*/+MidOut);//(0-cheight)*s+MidOut;MidOut*65536
//y255=(255-cheight)*s+MidOut;		    
//=========================		
ddd=project_is65536_t[d];//is;//1/s;//256
//=========================
//int screenHhalf=96*is;///s;
//int sHd=(cheight-screenHhalf-MidOut*is/*/s*/);
//int sHt=(cheight+screenHhalf);//-MidOut/s);
int sHd=cheight-MidOutMis[d]-1;//(cheight-(MidOut>>16)*is);
int sHt=sHd+resYMis1[d];//sHd+resY*is+1;//(cheight+192*is-MidOut*is);

for (i=resX; i--; ) {
	//Compute the xy coordinates; a and b will be the position inside the
	//single map cell (0..255).
	//u0=L(x0>>16);
	//v0=L(y0>>16);
	//uv=u0<<8|v0;
	// Advance to next xy position
	x0+=sx;
	y0+=sy;

	u0=(x0>>16);
	v0=(y0>>16);
	if(u0 <256 && v0 <256 && u0>=0 && v0>=0){	
		//=================================================================
		if(/*columcnt[i]*/!*(columcntP+i)){continue;}
		uv=u0<<8|v0;

		down=*(HMapP+uv);//HMap[uv/*u0<<8|v0*/];//small
		if(down<sHd)down=sHd;//???????????????????????
		top=*(CMapP+uv);//CMap[uv/*u0<<8|v0*/];//big
		if(top>sHt)top=sHt;
		height=top-down;
		if(height<1){continue;}

		yf=((y000+y0255*down)>>16);//y000+((y0255*down));//
		yc=((y000+y0255*top)>>16);//y000+((y0255*down));//
		//==============================
		if(yf>resY1){continue;}
		if(yc<0){continue;}
		if((yc-yf)<1){continue;}

		//ddd=height/ycf;
		crayz=down<<16;
		if(yf<0){crayz=-ddd*(y000>>16)/*down+ddd*(-yf)*/;yf=0;}
		if(yc>resY1){yc=resY1;}

		for(y=yf;y<yc;y++)
		{				 
			c=*(voxdataP+((crayz&0xffff0000)|uv));//voxdata[/*L2((int)(crayz))<<16*/(crayz&0xffff0000)|uv];
			if(c/*>0*/){

				b= ((resY1-y)<<resXB)|i;//+i;//*256
				if(!*(tBufferP+b)/*tBuffer[b]*/)//(tBuffer[b]==0)
				{   *(tBufferP+b)=c;/*tBuffer[b]=c;*/
				//
				*(heightmapP+b)=/*d<<24|*/(crayz&0xffff0000)|uv;//heightmap[b]=(crayz&0xffff0000)|uv;
				//int ca=c>>24&0xff;
				//lightmap[b]=ca<<8|d;
				*(lightmap+b)=d;
				//
				(*(columcntP+i))--;//columcnt[i]++;
				}

			}//end of if(c>0)
			crayz+=ddd;//=ddd;//*65536 fixed point op? yf yc crayz
		}//end of for for(y=yf;y<yc;y++)
		//===============================

	}//end of if(u0 <256 && v0 <256 && u0>=0 && v0>=0)

	else{
#include "OutBound.c"
	}

}//end of  for ( i=0; i<256; i++ )

//}//end of function  Line(x0, y0, x1, y1, hy,s)
