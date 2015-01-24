int Sin_LUT[360];
int Cos_LUT[360];
//float Tan_LUT[360];

void Build_sct_table(void)
{
  int angle;
  float rad;
  for(angle=0;angle<360;angle++)
    {
      rad=angle*0.017453;
      Sin_LUT[angle]=(int)((sin(rad))*65536);
      Cos_LUT[angle]=(int)((cos(rad))*65536);
      //Tan_LUT[angle]=tan(rad);
    }//end of for
}//end of void Build_sct_table

//======================
//ray tables
//float project_s_t[128];//100=view distance;
//float project_is_t[128];
int   project_s65536_t[dmax];
int   project_is65536_t[dmax];

//int   dscreen1_t[128];
//int   dscreen65536_t[128];
int   resYMis1[dmax];
//======================
void  Build_ray_table()
{
  register unsigned int d=0;
  for (d=dmin; d<dmax; d+=1+(d>>6)) {				       
    project_s65536_t[d]=(int)(screenAt/d*65536);
    project_is65536_t[d]=(int)(d/screenAt*65536);
    //project_s_t[d]=(screenAt/d);//(int)(screenAt/d+1);
    //project_is_t[d]=d/screenAt;
    //dscreen1_t[d]=(int)((float)resX/(d+d)+1);//(int)((float)resX/(d+d)+1);//voxelength=d+d;
    //dscreen65536_t[d]=(int)((float)resX/(d+d)*65536);//voxelength=d+d;
    resYMis1[d] = (int)(resY*d/screenAt)+1;//(int)(resY*project_is_t[d])+1;//(int)(resY*project_is_t[d])+1;
  }//end of for ( d=0; d<100; d+=1+(d>>6) )
}//end of void  init_raytable
//======================
//mid tables
//this table depends on MidOut,
//so must be updated when change the value of MidOut on the fly.
int   MidOutMis[dmax];
int   LastMidOut;
//======================
void  Build_mid_table(int MidOut)
{
  register unsigned int d=0;
  for (d=dmin; d<dmax; d+=1+(d>>6)) {				       
    MidOutMis[d] = (int)((MidOut)*d/screenAt);//(int)((MidOut)*project_is_t[d]);
  }//end of for ( d=0; d<100; d+=1+(d>>6) )
}//end of void  init_mistable
//======================
