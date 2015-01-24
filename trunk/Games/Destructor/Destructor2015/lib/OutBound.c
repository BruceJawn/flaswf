if(/*columcnt[i]*/!*(columcntP+i)){continue;}
uv=u0<<8|v0;

down=0;//small
if(down<sHd)down=sHd;//???????????????????????
top=1;//big
if(top>sHt)top=sHt;
height=top-down;
if(height<1){continue;}

yf=((y000)>>16)-2;//yf=((y000+y0255*down)>>16)-2;//y000+((y0255*down));//
yc=((y000+y0255)>>16);//yc=((y000+y0255*top)>>16);//y000+((y0255*down));//
//==============================
if(yf>resY1){continue;}
if(yc<0){continue;}
if((yc-yf)<1){continue;}

//ddd=height/ycf;
crayz=0;//crayz=down<<16;
if(yf<0){crayz=-ddd*(y000>>16)/*down+ddd*(-yf)*/;yf=0;}
if(yc>resY1){yc=resY1;}

for(y=yf;y<yc;y++)
{				 
	c=*(groundTexP+(L(u0)<<8|L(v0)));/*groundTex[L(u0)<<8|L(v0)];*///[uv&(0xffff-1)];//voxdata[/*L2((int)(crayz))<<16*/(crayz&0xffff0000)|uv];
	if(c/*>0*/){

		b= ((resY1-y)<<resXB)|i;//+i;//*256
		if(!*(tBufferP+b)/*tBuffer[b]*/)//(tBuffer[b]==0)
		{/*tBuffer[b]*/*(tBufferP+b)=c;
		*(heightmapP+b)=/*d<<24|*/(crayz&0xffff0000)|uv;//heightmap[b]=(crayz&0xffff0000)|uv;
		/*columcnt[i]*/(*(columcntP+i))--;
		*(lightmap+b)=d;
		}

	}//end of if(c>0)
	crayz+=ddd;//=ddd;//*65536 fixed point op? yf yc crayz
}//end of for for(y=yf;y<yc;y++)
//===============================
