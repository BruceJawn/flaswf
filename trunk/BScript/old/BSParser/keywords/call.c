//call:name()
//setloc: int,0,i+1;
//setloc: int,2,i+1;
//call: Addi;
///*loc_int[2]=loc_int[0]+loc_int[1]*/
#define numFunc 14
void Addf(){loc_flt[2]=loc_flt[0]+loc_flt[1];}
void Subf(){loc_flt[2]=loc_flt[0]-loc_flt[1];}
void Mulf(){loc_flt[2]=loc_flt[0]*loc_flt[1];}
void Divf(){loc_flt[2]=loc_flt[0]/loc_flt[1];}

void Addi(){loc_int[2]=loc_int[0]+loc_int[1];}
void Subi(){loc_int[2]=loc_int[0]-loc_int[1];}
void Muli(){loc_int[2]=loc_int[0]*loc_int[1];}
void Divi(){loc_int[2]=loc_int[0]/loc_int[1];}
void Cmpi(){loc_int[2]=((loc_int[0]==loc_int[1])?1:0);}

void Cats(){
  loc_str_l[2]=loc_str_l[0]+loc_str_l[1];
  loc_str[2]=(unsigned char*)malloc(sizeof(unsigned char*)*loc_str_l[2]);
  memcpy(loc_str[2],loc_str[0],loc_str_l[0]);
  strcat(loc_str[2],loc_str[1]); 
}
void I2s0()
{
  loc_str_l[0]=5;
  loc_str[0]=(unsigned char*)malloc(sizeof(unsigned char*)*loc_str_l[0]);
  sprintf(loc_str[0], "%i", loc_int[0]);
}

void I2s1()
{
  loc_str_l[1]=5;
  loc_str[1]=(unsigned char*)malloc(sizeof(unsigned char*)*loc_str_l[1]);
  sprintf(loc_str[1], "%i", loc_int[1]);
}
void I2s2()
{
  loc_str_l[2]=5;
  loc_str[2]=(unsigned char*)malloc(sizeof(unsigned char*)*loc_str_l[2]);
  sprintf(loc_str[2], "%i", loc_int[2]);
}

int Pfunc(int x, int y, float xf, float yf)
{return (int)((x-y)*(xf-yf));}

//Bind func
void PfBd()
{
  int temp;//get return;
  temp=Pfunc(loc_int[0],loc_int[1],loc_flt[0],loc_flt[1]);
}

void (*funcTable[numFunc])( )={Addi,Subi,Muli,Divi,Cmpi,Addf,Subf,Mulf,Divf,Cats,PfBd,I2s0,I2s1,I2s2};
char *msgTable[numFunc]={"Addi","Subi","Muli","Divi","Cmpi","Addf","Subf","Mulf","Divf","Cats","PfBd","I2s0","I2s1","I2s2"};


int GetFunc(char *name, int name_length)
{
  int j;
  for(j=0;j<numFunc;j++)
    {
      if(!memcmp(msgTable[j],name,name_length))
	{
	  return j;
	}
    }//end of for j
  return -1;
}//end of GetFunc

int Call(unsigned char* buffer,int pointer)
{
  int i=pointer;

  int fname_length=0;
  unsigned char *fnamechar;
  int funcIndex;
   
  i+=4;//call:
  if((buffer[i]==':'))
    {
      fname_length=GetNameLength(buffer+i+1);
      buffer[i]=fname_length;
    }
  else{fname_length=buffer[i];}
  i++;
  fnamechar=(unsigned char*)malloc(sizeof(unsigned char*)*fname_length);
  memcpy(fnamechar,buffer+i,fname_length);
  funcIndex=GetFunc(fnamechar,fname_length);

  if(funcIndex>=0)
    {
      funcTable[funcIndex]();
    }//end of if(funcIndex>=0)

  return i;
	
}//end of Call



