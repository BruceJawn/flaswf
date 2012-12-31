#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int* diffuse;
//int diffuse[512*512];
int* tBuffer;
//int tBuffer[512*512];
int* mLUT;
//int mLUT[1024*1024*3];
int timeStamp;

int resX = 0;
int resY = 0;

int* initializeScreenDiffuseBuffer(int resX, int  resY)
{
	tBuffer = (int*)malloc( resX * resY * sizeof(int) );
	return tBuffer;//&(tBuffer[0]);//return the pointer to the screen buffer
}

int* initializeDiffuseBuffer(int resX, int  resY)
{
	diffuse = (int*)malloc( resX * resY * sizeof(int));
	return diffuse;//return the pointer to the texture buffer
}

void setupLookupTables()
{
	mLUT = (int*)malloc(1024*1024*sizeof(int)*3);
	int k=0;
	int j=0;
	int i=0;
	float u,v,x,y,d,a;
	for(j=0; j < 1024; j++ ){
		for(i=0; i < 1024; i++ )
		{
			x = -1.00f + 2.00f*(float)i/(float)1024;
			y = -1.00f + 2.00f*(float)j/(float)1024;
			d = sqrtf( x*x + y*y );
			a = atan2f( y, x );
			u = 0.02*y+0.03*cos(a*3)/d;
			v = 0.02*x+0.03*sin(a*3)/d;
			mLUT[k++] = ((int)(1024.0f*u)) & 1023;
			mLUT[k++] = ((int)(1024.0f*v)) & 1023;
		}
	}
	return;
}	

void rasterize()
{
	int lpos,u,v,tpos,opos,j,i,jpos,juvpos;
	timeStamp++;
	/*for(j=0; j < resY; j++ ){
	for(i=0; i < resX; i++ ){
	tBuffer[i*512+j] = 0xffffffff*rand();
	}
	}
	return;*/
	int utime = (int)(sin((timeStamp*0.6f)*0.017453292519943295)*resX);
	int vtime = (int)(cos((timeStamp*0.9f)*0.017453292519943295)*resY);
	int xOff = 1024/2 - resX/2;
	int yOff = 1024/2 - resY/2;
	int xtime = (int)(sin((timeStamp*3.2)*0.017453292519943295)*xOff);
	int ytime = (int)(cos((timeStamp*2)*0.017453292519943295)*yOff);
	xOff+=xtime;
	yOff+=ytime;
	for(j=0; j < resY; j++ ){
		jpos = resX*j;
		juvpos = j+yOff;
		for(i=0; i < resX; i++ ){
			lpos = (1024*(juvpos&1023)+((i+xOff)&1023))*2;
			u = mLUT[lpos]+utime;
			v = mLUT[lpos+1]+vtime;
			tpos = (512*(v&511) + (u&511));
			opos = (jpos+i);
			tBuffer[opos] = diffuse[tpos];
		}
	}
	return;
}