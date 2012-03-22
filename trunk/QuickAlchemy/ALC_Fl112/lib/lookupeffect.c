#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "AS3.h"

int* diffuse;
int* tBuffer;
int* nBuffer;
int* mLUT;
int timeStamp;

int resX = 0;
int resY = 0;

AS3_Val initializeScreenDiffuseBuffer(void* self, AS3_Val args)
{
	AS3_ArrayValue(args, "IntType, IntType", &resX, &resY);
	tBuffer = malloc( resX * resY * sizeof(int) );
	return AS3_Ptr( tBuffer );
}

AS3_Val initializeDiffuseBuffer(void* self, AS3_Val args)
{
	diffuse = malloc( 512 * 512 * sizeof(int));
	return AS3_Ptr( diffuse );
}

AS3_Val setupLookupTables(void* self, AS3_Val args)
{
	mLUT = malloc(1024*1024*sizeof(int)*3);
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
	return 0;
}	

AS3_Val rasterize( void* self, AS3_Val args )
{
	int lpos,u,v,tpos,opos,j,i,jpos,juvpos;
	timeStamp++;
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
	return 0;
}
 
int main()
{
	AS3_Val initializeScreenDiffuseBufferMethod = AS3_Function( NULL, initializeScreenDiffuseBuffer );
	AS3_Val rasterizeMethod = AS3_Function( NULL, rasterize );
	AS3_Val setupLookupTablesMethod = AS3_Function(NULL, setupLookupTables);
	AS3_Val initializeDiffuseBufferMethod = AS3_Function(NULL, initializeDiffuseBuffer);
	AS3_Val result = AS3_Object("initializeScreenDiffuseBuffer: AS3ValType, rasterize:AS3ValType,setupLookupTables:AS3ValType,initializeDiffuseBuffer:AS3ValType"
								,initializeScreenDiffuseBufferMethod, rasterizeMethod,setupLookupTablesMethod,initializeDiffuseBufferMethod);
	AS3_Release( initializeScreenDiffuseBufferMethod );
	AS3_Release( rasterizeMethod );
	AS3_Release( setupLookupTablesMethod );
	AS3_Release( initializeDiffuseBufferMethod );
	AS3_LibInit( result );
	return 0;
}
