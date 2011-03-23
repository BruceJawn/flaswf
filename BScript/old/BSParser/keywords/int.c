//setint: newint,oldint;
int GetInt(char *_name, int name_length)
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

  //printf("%s\n","GET INT??????");
  for(j=0;j<ints_num;j++)
    {
      if(!memcmp(ints[j]->name,name,length))
	{
	  return j/*ints[j]->value*/;
	}
    }//end of for j
  return -1;
}//end of GetInt
//====================================================================
int GetIntV(char *_name, int name_length)
{
  int index=GetInt(_name,name_length);
  if(index>=0)
    {
      return ints[index]->value;
    }
  else
    {
      return 0;
    }//end of else
}//end of GetIntV
//====================================================================
int SetInt(unsigned char* buffer,int pointer)
{
  //==========
  int i=pointer;

  int name_length=0;
  int value_length=0;
  unsigned char *namechar;
  unsigned char *valuechar;
  char locindex[1];//
  int tempint;
  int index;
  int index2;
  i+=6;

  if((buffer[i]==':')||(buffer[i]==','))
    {name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }
  else{name_length=buffer[i];}
  //==========
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i+1,name_length);
  i+=name_length+1;
  //==========
  if(buffer[i]==',')
    {value_length=GetNameLength(buffer+i+1);
      buffer[i]=value_length;
    }
  else{value_length=buffer[i];}
  //==========
  valuechar=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  memcpy(valuechar,buffer+i+1,value_length);
  //判断valuechar是否为变量名
  tempint=atoi(valuechar);
  if(tempint==0)
    {
      index2=GetInt(valuechar,value_length);
      if(index2>=0)
	{
	  tempint=ints[index2]->value;
	}
      //loc int setint:myint,loci_0;//must loc int 0
      else if(!memcmp(buffer+i+1,"loci",4))
	{
	  memcpy(locindex,buffer+i+1+5,1);
	  tempint=loc_int[atoi(locindex)];
	}
      else if(!memcmp(buffer+i+1,"locf",4))
	{
	  memcpy(locindex,buffer+i+1+5,1);
	  tempint=(int)loc_flt[atoi(locindex)];
	}
      else
	{
	  //float->int
	  index2=GetFlt(valuechar,value_length);
	  if(index2>=0)
	    {
	      tempint=(int)floats[atoi(locindex)];
	    }
	}//end of else
    }//end of if(tempint<0)
  //==========
  index=GetInt(namechar,name_length);
  if(index>=0)
    {
      ints[index]->value=tempint;
    }
  //==========
  i+=value_length+1;//1,1;
  return i;
}//end of SetInt
//====================================================================

//int NewInt(char *name,int value)不支持变量做初始值！
int NewInt(unsigned char* buffer,int pointer)
{
  //==========
  int i=pointer;

  int name_length=0;
  int value_length=0;
  //unsigned char *namechar;
  unsigned char *valuechar;

  int tempint;
    
  ints = (struct Int **)realloc( ints, (ints_num + 1) * sizeof(struct Int *));
  ints[ints_num] = (struct Int *)malloc(sizeof(struct Int));
    
  i+=6;
  if((buffer[i]==':')||(buffer[i]==','))
    {
      name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
      //printf("%s\n","Print INT??????");
    }
  else{name_length=buffer[i];}
  //namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  //memcpy(namechar,buffer+i+1,name_length);
  ints[ints_num]->name=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  ints[ints_num]->name_length=name_length;
  memcpy(ints[ints_num]->name,buffer+i+1,name_length);//================
  i+=name_length+1;
  //==========
  if(buffer[i]==',')
    {
      value_length=GetNameLength(buffer+i+1);
      buffer[i]=value_length;
    }
  else{value_length=buffer[i];}
  valuechar=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  memcpy(valuechar,buffer+i+1,value_length);
  tempint=atoi(valuechar);
  //==========
  ints[ints_num]->value=tempint;
  ints_num++;
  //==========
  i+=value_length+1;//1,1;
#ifdef _debug_
  printf("%s\n","NEW INT??????");
  printf("%i\n",value_length);
  printf("%i\n",name_length);
  printf("%s\n",valuechar);
  printf("%i\n",tempint);
#endif
  return i;
}//end of NewInt

int DeleteInt(unsigned char* buffer,int pointer)
{
  //deli:myint0;
  //==========
  int i=pointer;

  int name_length=0;
  unsigned char *namechar;
  int index;
    
  i+=4;
  if((buffer[i]==':')||(buffer[i]==','))
    {
      name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }
  else{name_length=buffer[i];}
    
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i+1,name_length);
  i+=name_length+1;

  //==========
  index=GetInt(namechar,name_length);
  if(index>=0)
    {
      ints[index]->value=ints[ints_num-1]->value;
      ints[index]->name_length=ints[ints_num-1]->name_length;
      ints[index]->name=(unsigned char*)malloc(sizeof(unsigned char*)*ints[ints_num-1]->name_length);
      memcpy(ints[index]->name,ints[ints_num-1]->name,ints[index]->name_length);
      free(ints[ints_num-1]);
      ints_num--;
    }//end of if(index>=0)

  return i;
}//end of DeleteInt
