//Prepare the code for analysis
//�ű�Ԥ������-Ԥ����
void TrimCode(long fileSize)
{    
  int i=0;
  int inStr=0;//�Ƿ����ַ�����
  RawCodeSize=0;//�ִ����ű�(raw code)����
	
  for(i=0;i<fileSize;i++)
    {
      //���������ַ���, ��ĳ��"��ʼ, ��һ��"����, �����Զ�ƥ��
      if(TextCode[i]=='"')
	{
	  //����first "
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
	  //����last "
	  RawCode = (unsigned char *)realloc(RawCode,(RawCodeSize+1)*sizeof(unsigned char)); 
	  RawCode[RawCodeSize]=TextCode[i];
	  RawCodeSize++;
	  //i++;
	}
      //����ע��, ע����/*��ʼ, /����
      else if(!memcmp(TextCode+i,"/*",2))
	{
	  i+=2;
	  while(TextCode[i]!='/')
	    {i++;}
	}//end of else if(!memcmp(TextCode+i,"/*",2)) 
	 //���Կո�
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
  //�������Ľ�����־lists:
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
//�ű�������-����
//��ȡlabel
//label������ʽ:
//label:label����{label�ű�} 
//�����, ����":"���ܱ��滻Ϊlabel���ֵĳ���, �Լӿ��´������ٶ�
void CompileCode(long fileSize)
{   //�����ȫ���ڴ����(�μ�Memory.c)
  //label:��������label�Ľṹ������
  //labels_num:����label�ĸ���
  int i;
  int label_nl;//label���ֳ���
  int label_begine;//label��ʼλ��
  int label_end;//label����λ��
  int label_length;//label����
  CompiledCodeSize=0;//�������볤��
  //������i++��for���У�for��i++������block������block��}*��*���´�ѭ������
  for(i=0;i<fileSize;i++)
    {
      //�ַ�����ͬ��memcmp������0
      if(!memcmp(RawCode+i,"label",5))
	{
	  //printf("%s\n","find lable!");
	  i+=6;//jump lable_ ����"label:"��6���ֽ�
	  labels = (struct Label **)realloc( labels, (labels_num + 1) * sizeof(struct Label *));
	  labels[labels_num] = (struct Label *)malloc(sizeof(struct Label));
	  //��ȡlabel����
	  label_nl=GetNameLength(RawCode+i);
	  /*if((RawCode[i-1]==":")||(RawCode[i-1]==","))
	    {label_nl=GetNameLength(RawCode+i);
	    RawCode[i-1]=label_nl;}
	    else{label_nl=RawCode[i-1];}*/
      
	  //����label���ֵ��ڴ�
	  labels[labels_num]->name=(unsigned char*)malloc(sizeof(unsigned char)*label_nl);
	  memcpy(labels[labels_num]->name,RawCode+i,label_nl);
	  i+=label_nl;//jump namename_ ����label����ռ�õ��ֽ�
	  label_begine=i;//��Ϊlabel��ʼ�ֽ�
	  while(RawCode[i]!='}')
	    {i++;}
	  label_end=i;
	  label_length=label_end-label_begine;//��Ϊlabel�����ֽ�
	  labels[labels_num]->length=label_length;//�õ�label���볤��, {��}֮�ڵĽű�����
	  //����label�Ĵ���
	  labels[labels_num]->CodeBuffer= (unsigned char*)malloc(sizeof(unsigned char)*label_length);
	  memcpy(labels[labels_num]->CodeBuffer,RawCode+label_begine,label_length);
	  labels_num++;
	}//end of if
      else
	{
	  //����Raw CodeΪ Compiled Code
	  CompiledCode = (unsigned char *)realloc(CompiledCode,(CompiledCodeSize+1)*sizeof(unsigned char)); 
	  CompiledCode[CompiledCodeSize]=RawCode[i];
	  CompiledCodeSize++;
	}//end of else
    }//end of for
  free(RawCode);
}//end of CompileCode
