//Prepare the code for analysis
//脚本预处理工作-预编译
void TrimCode(long fileSize)
{    
  int i=0;
  int inStr=0;//是否在字符串内
  RawCodeSize=0;//粗处理后脚本(raw code)长度
	
  for(i=0;i<fileSize;i++)
    {
      //完整复制字符串, 以某个"开始, 另一个"结束, 引号自动匹配
      if(TextCode[i]=='"')
	{
	  //复制first "
	  RawCode = (unsigned char *)realloc(RawCode,(RawCodeSize+1)*sizeof(unsigned char)); 
	  RawCode[RawCodeSize]=TextCode[i];
	  RawCodeSize++;
	  i++;
	  //printf("%s\n",TextCode+i-1);//debug print
	  while(TextCode[i]!='"')
	    {
	      //printf("%s\n",TextCode[i]);//debug print
	      RawCode = (unsigned char *)realloc(RawCode,(RawCodeSize+1)*sizeof(unsigned char)); 
	      RawCode[RawCodeSize]=TextCode[i];
	      RawCodeSize++;
	      i++;
	    }
	  //复制last "
	  RawCode = (unsigned char *)realloc(RawCode,(RawCodeSize+1)*sizeof(unsigned char)); 
	  RawCode[RawCodeSize]=TextCode[i];
	  RawCodeSize++;
	  //i++;
	}
      //忽略注释, 注释以/*开始, /结束
      else if(!memcmp(TextCode+i,"/*",2))
	{
	  i+=2;
	  while(TextCode[i]!='/')
	    {i++;}
	}//end of else if(!memcmp(TextCode+i,"/*",2)) 
	 //忽略空格
      else if((TextCode[i]!=' ')&&(TextCode[i]!='\n')&&(TextCode[i]!='\r')||(inStr))
	{
	  RawCode = (unsigned char *)realloc(RawCode,(RawCodeSize+1)*sizeof(unsigned char)); 
	  RawCode[RawCodeSize]=TextCode[i];
	  RawCodeSize++;
	}//end of else if((TextCode[i]!=' ')&&(TextCode[i]!='\n')&&(TextCode[i]!='\r')||(inStr)) 

    }//end of for i
  free(TextCode);
}//end of TrimCode

//Tool function, get the name length of a variable
int GetNameLength(unsigned char* buffer)
{
  int i=0;//variable length
  //变量名的结束标志lists:
  //,
  //;
  //{
  //(
  //=
  while((buffer[i]!=',')&&(buffer[i]!=';')&&(buffer[i]!='{')&&(buffer[i]!='(')&&(buffer[i]!='='/*&&(buffer[i]!=')'*/))
    {i++;}
  //printf("%s\n","label_nl=");
  //printf("%i\n",i);
  return i;
}//end of GetNameLength

//Compile the script
//脚本精处理-编译
//提取label
//label声明格式:
//label:label名称{label脚本} 
//编译后, 符号":"可能被替换为label名字的长度, 以加快下次运行速度
void CompileCode(long fileSize)
{   //虚拟机全局内存变量(参见Memory.c)
  //label:储存所有label的结构体数组
  //labels_num:所有label的个数
  int i;
  int label_nl;//label名字长度
  int label_begine;//label开始位置
  int label_end;//label结束位置
  int label_length;//label长度
  CompiledCodeSize=0;//编译后代码长度
  //正常的i++由for进行，for内i++是跳过block，跳至block的}*，*由下次循环跳至
  for(i=0;i<fileSize;i++)
    {
      //字符块相同，memcmp将返回0
      if(!memcmp(RawCode+i,"label",5))
	{
	  //printf("%s\n","find lable!");
	  i+=6;//jump lable_ 跳过"label:"这6个字节
	  labels = (struct Label **)realloc( labels, (labels_num + 1) * sizeof(struct Label *));
	  labels[labels_num] = (struct Label *)malloc(sizeof(struct Label));
	  //读取label长度
	  label_nl=GetNameLength(RawCode+i);
	  /*if((RawCode[i-1]==":")||(RawCode[i-1]==","))
	    {label_nl=GetNameLength(RawCode+i);
	    RawCode[i-1]=label_nl;}
	    else{label_nl=RawCode[i-1];}*/
      
	  //复制label名字到内存
	  labels[labels_num]->name=(unsigned char*)malloc(sizeof(unsigned char)*label_nl);
	  memcpy(labels[labels_num]->name,RawCode+i,label_nl);
	  i+=label_nl;//jump namename_ 跳过label名字占用的字节
	  label_begine=i;//此为label开始字节
	  while(RawCode[i]!='}')
	    {i++;}
	  label_end=i;
	  label_length=label_end-label_begine;//此为label结束字节
	  labels[labels_num]->length=label_length;//得到label代码长度, {和}之内的脚本长度
	  //复制label的代码
	  labels[labels_num]->CodeBuffer= (unsigned char*)malloc(sizeof(unsigned char)*label_length);
	  memcpy(labels[labels_num]->CodeBuffer,RawCode+label_begine,label_length);
	  labels_num++;
	}//end of if
      else
	{
	  //复制Raw Code为 Compiled Code
	  CompiledCode = (unsigned char *)realloc(CompiledCode,(CompiledCodeSize+1)*sizeof(unsigned char)); 
	  CompiledCode[CompiledCodeSize]=RawCode[i];
	  CompiledCodeSize++;
	}//end of else
    }//end of for
  free(RawCode);
}//end of CompileCode
