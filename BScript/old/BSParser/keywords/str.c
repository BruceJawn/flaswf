//chars�ڴ��������ҵ�����Ϊname(����name_length)���ַ���
//���ظ��ַ�������������ֵ, ��û�ҵ��򷵻�-1
int GetStr(char *name, int name_length)
{
  /*
  //��ѭ����
  int strindex=GetStr(_name,name_length);
  unsigned char *name;
  int length;
  //�ж��Ƿ��Ǳ�����
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
//chars�ڴ��������ҵ�����Ϊname(����name_length)���ַ���
//���ظ��ַ���, ��û�ҵ��򷵻�0
char* GetStrV(char *_name, int name_length)
{
  //����GetStr�������chars�ڴ���������ֵ
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
//mychar0: ���޸��ַ���������
//mychar1: ���ַ������������
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
  i+=6;//����setstr��6���ֽ�
  //��ñ�����mychar0�ĳ���
  if((buffer[i]==':')||(buffer[i]==','))
    {name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }
  else{name_length=buffer[i];}
  //==========
  //���Ʊ�����mychar0
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i+1,name_length);
  i+=name_length+1;//����:�ͱ�����mychar0�⼸���ֽ�
  //==========
  //��ñ�����mychar1�ĳ���
  if(buffer[i]==',')
    {value_length=GetNameLength(buffer+i+1);
      buffer[i]=value_length;
    }
  else{value_length=buffer[i];}
  //==========
  valuechar=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
  //�ж�mychar1���ַ���(�Ա�־"��ͷ)���Ǳ�����
  //mychar1���ַ���
  if(buffer[i+1]=='"')
    {
      value_length-=1;
      memcpy(valuechar,buffer+i+2,value_length-1);
      tempstr=(unsigned char*)malloc(sizeof(unsigned char*)*(value_length-1));
      memcpy(tempstr,valuechar,value_length-1);
    }
  //mychar1�Ǳ�����
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
  //�ж�valuechar�Ƿ�Ϊ������???
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
  //�ж�valuechar�Ƿ�Ϊ������???better
  //�õ�������mychar0ָ��ı�������
  //==========
  index=GetStr(namechar,name_length);
  //�޸ı���
  if(index>=0)
    {
      chars[index]->value=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
      memcpy(chars[index]->value,tempstr,value_length);
    }//end of if 
  //==========
  i+=value_length;//����mychar0�⼸���ֽ�, ��������;����ֽ�
  return i;
}//end of SetStr
//====================================================================

//����һ���µ��ַ���
//newstr: myCharName,"myCharValue";
int NewStr(unsigned char* buffer,int pointer)
{
  //==========
  int i=pointer;

  int name_length=0;//�µ��ַ������ֳ���
  int value_length=0;//�µ��ַ�������
  //unsigned char *namechar;
  //unsigned char *valuechar;
    
  chars = (struct Char **)realloc( chars, (chars_num + 1) * sizeof(struct Char *));
  chars[chars_num] = (struct Char *)malloc(sizeof(struct Char));

  i+=6;//����newstr�⼸���ֽ�
  if((buffer[i]==':')||(buffer[i]==','))
    {name_length=GetNameLength(buffer+i+1);
      buffer[i]=name_length;
    }//end of if 
  else{name_length=buffer[i];}
  //namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  //memcpy(namechar,buffer+i+1,name_length);
  //chars�������һ��Char�ͽṹ��
  chars[chars_num]->name=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(chars[chars_num]->name,buffer+i+1,name_length);
  i+=name_length+1;//����:myCharName
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
  //chars���鳤������1
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

  int name_length=0;//��ɾ���ַ������Ƴ���=length(mystr0)
  unsigned char *namechar;//��ɾ���ַ���mystr0
  int index;//��ɾ���ַ������ڴ������е�����
    
  i+=4;//����dels�⼸���ֽ�
  if((buffer[i]==':')||(buffer[i]==','))
    {
      name_length=GetNameLength(buffer+i+1);//�õ�Ҫɾ���ַ��������Ƴ���
      buffer[i]=name_length;
    }//end of if 
  else{name_length=buffer[i];}//end of else
    
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);//��ȡҪɾ���ַ������ƴ洢�ռ�
  memcpy(namechar,buffer+i+1,name_length);//����Ҫɾ���ַ�������
  i+=name_length+1;//����,����ֽ�
  //==========
  index=GetStr(namechar,name_length);//�ڴ��������ҳ�Ҫɾ���ַ���������
  if(index>=0)
    {
      //ɾ������:���ڴ������������ַ�����Ҫɾ���ַ�����������ս�������������ַ���ռ�õ��ڴ�ռ�
      chars[index]->value=(unsigned char*)malloc(sizeof(unsigned char*)*chars[chars_num-1]->length);
      memcpy(chars[index]->value,chars[chars_num-1]->value,chars[chars_num-1]->length);
      chars[index]->length=chars[chars_num-1]->length;
      chars[index]->name_length=chars[chars_num-1]->name_length;
      chars[index]->name=(unsigned char*)malloc(sizeof(unsigned char*)*chars[chars_num-1]->name_length);
      memcpy(chars[index]->name,chars[chars_num-1]->name,chars[index]->name_length);
      free(chars[chars_num-1]);
      //���ַ�������һ
      chars_num--;
    }//end of if(index>=0)

  return i;
}//end of DeleteStr
