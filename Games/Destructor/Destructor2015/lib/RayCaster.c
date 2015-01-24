//#include <string.h>//memset
#include "LookupTable.c"
//int earlybreakcnt;

void View( int cx0, int cy0, int angle, int cheight, int MidOut) {
  ///////////////////////////
  //Bind global??
  ///////////////////////////
  unsigned int * tBufferP = tBuffer;
  unsigned int * voxdataP = voxdata;
  unsigned int * heightmapP=heightmap;
  unsigned int * lightmapP =lightmap;
  unsigned int * groundTexP=groundTex;

  unsigned int * HMapP =HMap;
  unsigned int * CMapP =CMap;
  int * columcntP =columcnt;
  /*register unsigned*/ int d;//index variable
  // Draw the landscape from near to far without overdraw
  int a_F=angle-FOV;
  if(a_F<0)a_F+=360;
  //if(a_F>360)a_F-=360;
  int aF=angle+FOV;
  //if(aF<0)aF+=360;
  if(aF>360)aF-=360;

  int cosa_F=Cos_LUT[(a_F)];
  int sina_F=Sin_LUT[(a_F)];
				
  int cosaF=Cos_LUT[(aF)];
  int sinaF=Sin_LUT[(aF)];

  //update MidOutTable
  if(LastMidOut!=MidOut)
    {
      Build_mid_table(MidOut);
      LastMidOut = MidOut;
    }
  //
  //memset is slow!
  //memset(tBuffer, 0, 196608/*resX * resY * sizeof(unsigned int)*/);
  //memset(columcnt, 0, 1024/*resX*sizeof(int)*/);//sizeof(int)=4;
  //memset(heightmap, 0, 196608/*resX * resY * sizeof(unsigned int)*/);
  //memset(lightmap, 0, 196608/*resX * resY * sizeof(unsigned int)*/);
  for(d=resX*resY;d--;)//
    {
      *(tBufferP+d)=0;//tBuffer[d]=0;//memset(tBuffer, 0, 196608);
      *(heightmap+d)=0;//heightmap[d]=0;//memset(heightmap, 0, 196608);
      *(lightmap+d)=0;//lightmap[d]=0;//memset(lightmap, 0, 196608);
    }
  for(d=resX;d--;)
    {
      *(columcntP+d)=resY1;//columcnt[d]=0;//memset(columcnt, 0, 1024);//sizeof(int)=4;
    }
  //memset(columcnt, 0, 1024);
  
  //use LOD
  for (d=dmin; d<dmax; d+=1+(d>>6)) {
    int dMcosaF=d*cosaF;
    int dMsinaF=d*sinaF;

    int x0=cx0+dMcosaF;
    int y0=cy0+dMsinaF;
    //line speed dx,dy
    int sx= (int)(d*cosa_F-dMcosaF)>>resXB;
    int sy= (int)(d*sina_F-dMsinaF)>>resXB;
    //no LOD
    /*
      int dMcosa_F=0;
      int dMsina_F=0;
      int dMcosaF=0;
      int dMsinaF=0;
      for (d=dmin; d<dmax; d++) {
      dMcosa_F+=cosa_F;
      dMsina_F+=sina_F;
      dMcosaF+=cosaF;
      dMsinaF+=sinaF;
      //int dMcosa_F=d*cosa_F;
      //int dMsina_F=d*sina_F;
      //Line(x0p+dMcosa_F,y0p+dMsina_F, 0.5*(float)(cosaF-cosa_F), 0.5*(float)(sinaF-sina_F),d,project_s_t[d],project_is_t[d],voxelength);
      //old function params binding
      //================================
      //================================
      int x0=cx0+dMcosa_F;
      int y0=cy0+dMsina_F;
      //line speed dx,dy
      //int sx= (int)(d*cosaF-dMcosa_F)>>resXB;
      //int sy= (int)(d*sinaF-dMsina_F)>>resXB;
      int sx= (int)(dMcosaF-dMcosa_F)>>resXB;
      int sy= (int)(dMsinaF-dMsina_F)>>resXB;
      //float   s=project_s_t[d];
      //int   s65536=project_s65536_t[d];
      //float   is=project_is_t[d];
      //int voxelength=d+d;//2*d;
      */
#include"Line.c"
    //================================
    //================================
  }//end of for ( d=0; d<100; d+=1+(d>>6) )
}//end of void View
