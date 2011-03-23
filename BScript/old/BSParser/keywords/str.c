//chars内存数组中找到名称为name(长度name_length)的字符串
//返回该字符串的数组索引值, 若没找到则返回-1
int GetStr(char *name, int name_length)
{
  /*
  //死循环！
  int strindex=GetStr(_name,name_length);
  unsigned char *name;
  int length;
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
  */
  int j;
  for(j=0;j<chars_num;j++)
    {
      if(!memcmp(chars[j]->name,name,name_length))
	{
	  return j;
	}//end of if
    }//end of for j
  return -1;
}

//====================================================================
//chars内存数组中找到名称为name(长度name_length)的字符串
//返回该字符串, 若没找到则返回0
char* GetStrV(char *_name, int name_length)
{
  //调用GetStr获得其在chars内存数组索引值
  int index=GetStr(_name,name_length);
  if(index>=0)
    {
      return chars[index]->value;
    }//end of if 
  else
    {
      return 0;
    }//end of else
}//end of GetStrV
//====================================================================

//setstr: mychar0,mychar1;
//mychar0: 待修改字符串变量名
//mychar1: 新字符串或其变量名
int SetStr(unsigned char* buffer,int pointer)
{
  //==========
  int i=pointer;

  int name_length=0;//
  int value_length=0;//
  unsigned char *namechar;//
  unsigned char *valuechar;//

  char* tempstr;//
  int index;//
  int index2;//
  i+=6;//跳过setstr这6个字节
  //获得变量名mychar0的长度
  if((buffer[i]==':')||(buffer[i]==','))
    {name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }
  else{name_length=buffer[i];}
  //==========
  //复制变量名mychar0
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i+1,name_length);
  i+=name_length+1;//跳过:和变量名mychar0这几个字节
  //==========
  //获得变量名mychar1的长度
  if(buffer[i]==',')
    {value_length=GetNameLength(buffer+i+1);
      buffer[i]=value_length;
    }
  else{value_length=buffer[i];}
  //==========
  valuechar=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  //判断mychar1是字符串(以标志"开头)还是变量名
  //mychar1是字符串
  if(buffer[i+1]=='"')
    {
      value_length-=1;
      memcpy(valuechar,buffer+i+2,value_length-1);
      tempstr=(unsigned char*)malloc(sizeof(unsigned char*)*(value_length-1));
      memcpy(tempstr,valuechar,value_length-1);
    }
  //mychar1是变量名
  else
    {
      //printf("%s\n",buffer+i+1);
      memcpy(valuechar,buffer+i+1,value_length);
      index2=GetStr(valuechar,value_length);
      value_length=chars[index2]->length;
      tempstr=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
      memcpy(tempstr,chars[index2]->value,value_length);
    }
  /*
  //判断valuechar是否为变量名???
  index2=GetStr(valuechar,value_length);
  if(index2>=0)
  {
  value_length=chars[index2]->length;
  tempstr=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  memcpy(tempstr,chars[index2]->value,value_length);//tempstr=ints[index2]->value;
  }
  else
  {
  tempstr=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  memcpy(tempstr,valuechar,value_length);//tempstr=atoi(valuechar);
  }
  */
  //判断valuechar是否为变量名???better
  //得到变量名mychar0指向的变量索引
  //==========
  index=GetStr(namechar,name_length);
  //修改变量
  if(index>=0)
    {
      chars[index]->value=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
      memcpy(chars[index]->value,tempstr,value_length);
    }//end of if 
  //==========
  i+=value_length;//跳过mychar0这几个字节, 而不跳过;这个字节
  return i;
}//end of SetStr
//====================================================================

//声明一个新的字符串
//newstr: myCharName,"myCharValue";
int NewStr(unsigned char* buffer,int pointer)
{
  //==========
  int i=pointer;

  int name_length=0;//新的字符串名字长度
  int value_length=0;//新的字符串长度
  //unsigned char *namechar;
  //unsigned char *valuechar;
    
  chars = (struct Char **)realloc( chars, (chars_num + 1) * sizeof(struct Char *));
  chars[chars_num] = (struct Char *)malloc(sizeof(struct Char));

  i+=6;//跳过newstr这几个字节
  if((buffer[i]==':')||(buffer[i]==','))
    {name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }//end of if 
  else{name_length=buffer[i];}
  //namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  //memcpy(namechar,buffer+i+1,name_length);
  //chars数组添加一个Char型结构体
  chars[chars_num]->name=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(chars[chars_num]->name,buffer+i+1,name_length);
  i+=name_length+1;//跳过:myCharName
  //==========
  if(buffer[i]==',')
    {value_length=GetNameLength(buffer+i+1);
      buffer[i]=value_length;
    }
  else{value_length=buffer[i];}
  chars[chars_num]->value=(unsigned char*)malloc(sizeof(unsigned char*)*(value_length-2));//-2 for ""
  memcpy(chars[chars_num]->value,buffer+i+2,value_length-2);
  chars[chars_num]->length=value_length-2;
  //==========
  //chars数组长度增加1
  chars_num++;
  //==========
  i+=value_length+1;
  //printf("%i\n",value_length);
  //printf("%i\n",name_length);
  //printf("%s\n",valuechar);
  return i;
}//end of NewStr

int DeleteStr(unsigned char* buffer,int pointer)
{
  //dels:mystr0;
  //==========
  int i=pointer;

  int name_length=0;//被删除字符串名称长度=length(mystr0)
  unsigned char *namechar;//被删除字符串mystr0
  int index;//被删除字符串在内存数组中的索引
    
  i+=4;//跳过dels这几个字节
  if((buffer[i]==':')||(buffer[i]==','))
    {
      name_length=GetNameLength(buffer+i+1);//得到要删除字符串的名称长度
      buffer[i]=name_length;
    }//end of if 
  else{name_length=buffer[i];}//end of else
    
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);//索取要删除字符串名称存储空间
  memcpy(namechar,buffer+i+1,name_length);//复制要删除字符串名称
  i+=name_length+1;//跳过,这个字节
  //==========
  index=GetStr(namechar,name_length);//内存数组中找出要删除字符串的索引
  if(index>=0)
    {
      //删除方法:将内存数组最后面的字符串与要删除字符串交换并清空交换后的最后面的字符串占用的内存空间
      chars[index]->value=(unsigned char*)malloc(sizeof(unsigned char*)*chars[chars_num-1]->length);
      memcpy(chars[index]->value,chars[chars_num-1]->value,chars[chars_num-1]->length);
      chars[index]->length=chars[chars_num-1]->length;
      chars[index]->name_length=chars[chars_num-1]->name_length;
      chars[index]->name=(unsigned char*)malloc(sizeof(unsigned char*)*chars[chars_num-1]->name_length);
      memcpy(chars[index]->name,chars[chars_num-1]->name,chars[index]->name_length);
      free(chars[chars_num-1]);
      //总字符串数减一
      chars_num--;
    }//end of if(index>=0)

  return i;
}//end of DeleteStr
