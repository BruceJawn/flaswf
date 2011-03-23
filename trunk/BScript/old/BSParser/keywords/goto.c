void RunCode(unsigned char* buffer,int CodeLength);
//////////// 
//跳转的指定标签(标签名称, 标签长度)
void gotoLabel(unsigned char* name, int name_length)
{
  int j;
  for(j=0;j<labels_num;j++)
    {
      //printf("%s\n",labels[j]->name);
      //遍历标签内存数组, 通过比较标签名称找到要跳转的标签
      if(!memcmp(name,labels[j]->name,name_length))
	{
	  printf("%s\n","=====");
	  printf("%s\n","_goto");
	  printf("%s\n","=====");
	  //递归调用RunCode, 运行该标签内的代码
	  RunCode(labels[j]->CodeBuffer,labels[j]->length);
	  break;
	}//end of if
    }//end of for
}//end of gotoLabel

//解析跳转后面的代码, 以解析得到的标签名称和标签长度作参数调用gotoLabel函数
//goto: myLabelName;
//buffer: 源脚本缓存
//pointer: 源脚本当前运行位置
int _goto(unsigned char* buffer,int pointer)
{
  int i=pointer;
  int name_length;//要解析标签名称长度
  char* namechar;//要解析标签名称
  
  i+=5;//跳过"goto:"这5个字节
  //判断"goto"这4个字节后面是":"或","还是上次运行解析出的标签名称长度
  if((buffer[i-1]==':')||(buffer[i-1]==','))
    {name_length=GetNameLength(buffer+i);
      //将":"这个字节替换为解析出的标签名称长度来保存解析出的标签名称长度, 以加快下次解析速度
      buffer[i-1]=name_length;}//end of if
  else{name_length=buffer[i-1];}//end of else

  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i,name_length);
  //调用gotoLabel
  gotoLabel(namechar,name_length);
  //跳过"goto:"这5个字节后面的标签名称字节
  i+=name_length;
  //返回当前代码位置
  return i;
}//end of _goto
