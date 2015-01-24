//¼ÆËãHMap0¡ª¡µ256ºÍCMap256¡ª¡µ0
//Hmap: Height
//CMap: Ceil
AS3_Val ComputeMap(void* self, AS3_Val args) {
  int i, j, k;
  for (i=0; i<256; i++) {
    for (j=0; j<256; j++) {
      for(k=0; k<128; k++)
	{if(voxdata[k<<16|i<<8|j]>0){HMap[i<<8|j]=k;break;}}
      //HMap[i<<8|j]=0;
      for(k=128; k>-1; k--)
	{if(voxdata[k<<16|i<<8|j]>0){CMap[i<<8|j]=k+1;break;}}
      //CMap[i<<8|j]=128;
    }//end of for1
  }//end of for2
  //lightmap =  malloc(resX * resY  * sizeof(unsigned int));
  AS3_Val HCPtrs = AS3_Array("AS3ValType,AS3ValType",AS3_Ptr(HMap),AS3_Ptr(CMap));
  return HCPtrs;
  //return 0;
}//end of ComputeMap()
