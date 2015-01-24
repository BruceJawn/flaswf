//int resX, resY;
#define resX 256//512//256
#define resY 192//384//192
#define resY1 191//383//191
#define resXB 8//9//8
//unsigned int* voxdata;
unsigned int voxdata[0x80ffff];//体素模型数据
unsigned int HMap[256*256];
unsigned int CMap[256*256];
unsigned int groundTex[256*256];
unsigned int heightmap[resX*resY];//unsigned int* heightmap;//
unsigned int lightmap[resX*resY];//unsigned int* lightmap;//
//unsigned int* tBuffer;
unsigned int tBuffer[resX*resY];
int/*char*/ columcnt[resX];

int CameraV[5];
/*int cx0, cy0;
  int cheight;
  int MidOut;//=110*65536;
  int aa;*/

#define FOV 45//=1/2FOV 视角默认90度
#define dmin 0
#define dmax 256//100

#define screenAt 160.0//350.0//160.0//(resY/4.0)*(1.0/dmin-1.0/dmax)/*1/tan(3.14159265358979/4)*160;*/
//depends on resY, 192 -> 160 or 384 ->320//ScreenAt = cos(FOV/2) * (Output->w/2) / sin(FOV/2);

#define L(x) (x&0xff)
/*
  inline int L(int x) {
  return x & 0xff;
  }//end of int L
  inline int L2(int x) {
  return x&(0x80-1);
  }//end of int L
  inline int L3(int x) {
  return x&(resX-1);
  }//end of int L
*/
//int =>> 0;
/*inline int ABS(int x) {
  return (x ^ (x >> 31)) - (x >> 31);
  }*/
//#define ABS(x)   (x ^ (x >> 31)) - (x >> 31)
//#define AVERAGE(a, b)   ( ((((a) ^ (b)) & 0xfffefefeL) >> 1) + ((a) & (b)) )
//======================
