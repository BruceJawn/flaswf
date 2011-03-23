int GetFlt(char *_name, int name_length)
{
  int strindex=GetStr(_name,name_length);
  unsigned char *name;
  int length;
  int j;
  //判断是否是变量名
  if(strindex>=0)
    {
      length=chars[strindex]->length;
      name=(unsigned char*)malloc(sizeof(unsigned char*)*(length));
      memcpy(name,chars[strindex]->value,length);
    }
  else
    {
      length=name_length;
      name=(unsigned char*)malloc(sizeof(unsigned char*)*(length));
      memcpy(name,_name,length);
    }//end of else

  //printf("%s\n","GET FLT??????");
  for(j=0;j<floats_num;j++)
    {
      if(!memcmp(floats[j]->name,name, length))
	{
	  return j/*floats[j]->value*/;
	}
    }//end of for j
  return -1/*0*/;
}
//int GetFlt(char *name,int value)
//====================================================================
float GetFltV(char *_name, int name_length)
{
  int index=GetFlt(_name,name_length);
  if(index>=0)
    {
      return floats[index]->value;
    }
  else
    {
      return 0;
    }//end of else
}//end of GetFltV
//====================================================================
int SetFlt(unsigned char* buffer,int pointer)
{
  //==========
  int i=pointer;

  int name_length=0;
  int value_length=0;
  unsigned char *namechar;
  unsigned char *valuechar;

  char locindex[1];

  float tempflt;
  int index;
  int index2;
  i+=6;

  if((buffer[i]==':')||(buffer[i]==','))
    {
      name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }
  else{name_length=buffer[i];}
  //==========
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i+1,name_length);
  i+=name_length+1;
  //==========
  if(buffer[i]==',')
    {
      value_length=GetNameLength(buffer+i+1);
      buffer[i]=value_length;
    }
  else{value_length=buffer[i];}
  //==========
  valuechar=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  memcpy(valuechar,buffer+i+1,value_length);
  //判断valuechar是否为变量名
  tempflt=(float)atof(valuechar);
  if(tempflt==0)
    {
      index2=GetFlt(valuechar,value_length);
      if(index2>=0)
	{
	  tempflt=floats[index2]->value;
	}//end of if(index2>=0) 
      //loc int setint:myint,loci_0;//must loc int 0
      else if(!memcmp(buffer+i+1,"locf",4))
	{
	  memcpy(locindex,buffer+i+1+5,1);
	  tempflt=loc_flt[atoi(locindex)];
	}//end of else if(!memcmp(buffer+i+1,"locf",4))
      else if(!memcmp(buffer+i+1,"loci",4))
	{
	  memcpy(locindex,buffer+i+1+5,1);
	  tempflt=(float)loc_int[atoi(locindex)];
	}//end of else if(!memcmp(buffer+i+1,"loci",4))
      else
	{
	  //int->float
	  index2=GetInt(valuechar,value_length);
	  if(index2>=0)
	    {
	      tempflt=(float)ints[atoi(locindex)]->value;
	    }//end of if(index2>=0) 
	}//end of else
    }//end of if(tempflt==0)
     //==========
  index=GetFlt(namechar,name_length);
  if(index>=0)
    {
      floats[index]->value=tempflt;
    }//end of if(index>=0) 
     //==========
  i+=value_length+1;//1,1;
  return i;
}//end of SetFlt
//====================================================================

int NewFlt(unsigned char* buffer,int pointer)
{
  //==========
  int i=pointer;

  int name_length=0;
  int value_length=0;
  //unsigned char *namechar;
  unsigned char *valuechar;

  float tempfloat;
    
  floats = (struct Float **)realloc( floats, (floats_num + 1) * sizeof(struct Float *));
  floats[floats_num] = (struct Float *)malloc(sizeof(struct Float));


  i+=6;
  if((buffer[i]==':')||(buffer[i]==','))
    {name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
      //printf("%s\n","Print INT??????");
    }
  else{name_length=buffer[i];}
  //namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  //memcpy(namechar,buffer+i+1,name_length);
  floats[floats_num]->name=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  floats[floats_num]->name_length=name_length;
  memcpy(floats[floats_num]->name,buffer+i+1,name_length/*8*/);//================??????8888888
  i+=name_length+1;

  //==========
  if(buffer[i]==',')
    {value_length=GetNameLength(buffer+i+1);
      buffer[i]=value_length;
    }
  else{value_length=buffer[i];}
  valuechar=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  memcpy(valuechar,buffer+i+1,value_length);
  tempfloat=(float)atof(valuechar);
  //==========
  floats[floats_num]->value=tempfloat;
  floats_num++;
  //==========
  i+=value_length+1;//1,1;
#ifdef _debug_
  printf("%s\n","NEW FlT??????");
  printf("%i\n",value_length);
  printf("%i\n",name_length);
  printf("%s\n",valuechar);
  printf("%i\n",tempfloat);
#endif
  return i;
}//end of NewFlt

int DeleteFlt(unsigned char* buffer,int pointer)
{
  //deli:myint0;
  //==========
  int i=pointer;

  int name_length=0;
  unsigned char *namechar;
  int index;
    
  i+=4;
  if((buffer[i]==':')||(buffer[i]==','))
    {name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }
  else{name_length=buffer[i];}
    
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i+1,name_length);
  i+=name_length+1;

  //==========
  index=GetFlt(namechar,name_length);
  if(index>=0)
    {
      floats[index]->value=floats[floats_num-1]->value;
      floats[index]->name_length=floats[floats_num-1]->name_length;
      floats[index]->name=(unsigned char*)malloc(sizeof(unsigned char*)*floats[floats_num-1]->name_length);
      memcpy(floats[index]->name,floats[floats_num-1]->name,floats[index]->name_length);
      free(floats[floats_num-1]);
      floats_num--;
    }//end of if(index>=0)

  return i;
}//end of DeleteFlt
