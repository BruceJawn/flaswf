#include "AS3.h"

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "VarsDef.c"
#include "ComputeMap.c"
#include "RayCaster.c"

AS3_Val AS_Main;

AS3_Val initialize(void* self, AS3_Val args)
{
  AS3_ArrayValue(args,"AS3ValType",&AS_Main);
  //#include "mochiprotect.c"
  Build_sct_table();
  Build_ray_table();

  //tBuffer = (unsigned int*) malloc( resX * resY * sizeof(unsigned int) );
  //heightmap = (unsigned int*) malloc( resX * resY * sizeof(unsigned int) );
  //lightmap = (unsigned int*) malloc( resX * resY * sizeof(unsigned int) );
  //voxdata = (unsigned int*) malloc(0x80ffff * sizeof(unsigned int));	
  //two malloc won't work!

  AS3_Val Ptrs = AS3_Array("AS3ValType,AS3ValType,AS3ValType,AS3ValType,AS3ValType,AS3ValType",
			   AS3_Ptr(voxdata),AS3_Ptr(tBuffer),AS3_Ptr(heightmap),AS3_Ptr(lightmap),AS3_Ptr(CameraV),AS3_Ptr(groundTex));
  return Ptrs;
}

AS3_Val loop( void* self, AS3_Val args)
{
  /*AS3_Trace(args);
    AS3_ArrayValue(args,"IntType,IntType,IntType,IntType,IntType",&cx0,&cy0,&aa,&cheight,&MidOut);
  */
  View(CameraV[0],CameraV[1],CameraV[2],CameraV[3],CameraV[4]);
  return 0;
}//end of AS3_Val loop


int main()
{
  AS3_Val initializeMethod = AS3_Function( NULL, initialize);

  AS3_Val ComputeMapMethod = AS3_Function( NULL, ComputeMap);

  AS3_Val loopMethod = AS3_Function( NULL, loop);
 
  AS3_Val result = AS3_Object("initialize:AS3ValType,ComputeMap:AS3ValType,loop:AS3ValType",
			      initializeMethod, ComputeMapMethod, loopMethod);// 


  AS3_Release( initializeMethod );

  AS3_Release( ComputeMapMethod );

  AS3_Release( loopMethod );

  AS3_LibInit( result );
  return 0;
}//end of int main
