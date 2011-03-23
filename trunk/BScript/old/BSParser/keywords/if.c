//条件跳转
//if:loc_0,myif;
//if关键字 :分隔符 loc_0条件判断变量, 如果>0则执行跳转 myif跳转的目标标签 ;一句脚本终止符
int If(unsigned char* buffer,int pointer)
{
  int i=pointer;

  int name_length=0;//跳转的目标标签名称长度
  unsigned char *namechar;//跳转的目标标签名
  int varIndex;//测试变量, int型local临时变量
  char locindex[1];//测试变量名称
  int label_length=0;//
  unsigned char *labelchar;   
  i+=2;//跳过if这两字节
  //查看if这两字节之后是:还是上次保存的测试变量名称长度
  if((buffer[i]==':'))
    {
      name_length=GetNameLength(buffer+i+1);//得到测试变量名长度
      buffer[i]=name_length;//保存测试变量名长度
    }
  else{name_length=buffer[i];}
  i++;//跳过字节:
  //得到测试变量名
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i,name_length);
  //跳过测试变量名字节
  i+=name_length;

  //==get label name==
  if((buffer[i]==','))
    {//得到目标标签名称长度
      label_length=GetNameLength(buffer+i+1);
      buffer[i]=label_length;
    }//end of if
  else
    {label_length=buffer[i];}//end of else
    
  i++;//跳过;这个字节
  //得到目标标签名称
  labelchar=(unsigned char*)malloc(sizeof(unsigned char*)*label_length);
  memcpy(labelchar,buffer+i,label_length);
  //==get label name==
  //提取测试变量在内存数组中的索引值index
  varIndex=GetInt(namechar,name_length);
    
  //测试变量是否为局部变量(local)还是自定义变量(new)
  if(varIndex>=0)//自定义变量
    {
      //判断条件
      //if 只判断int0/1
      if(ints[varIndex]->value)
	{
	  gotoLabel(labelchar,label_length);
	}//end of if(ints[varIndex]->value)
    }//end of if(varIndex>=0)
  else if(!memcmp(namechar,"loc",3))//局部变量
    {
      memcpy(locindex,namechar+1,1);
      if(loc_int[atoi(locindex)])
	{
	  gotoLabel(labelchar,label_length);
	}//end of if(loc_int[atoi(locindex)])
    }//end of else if(!memcmp(namechar,"loc",3))

  i+=label_length;
  //返回当前代码位置
  return i;
}//end of If
