//������ת
//if:loc_0,myif;
//if�ؼ��� :�ָ��� loc_0�����жϱ���, ���>0��ִ����ת myif��ת��Ŀ���ǩ ;һ��ű���ֹ��
int If(unsigned char* buffer,int pointer)
{
  int i=pointer;

  int name_length=0;//��ת��Ŀ���ǩ���Ƴ���
  unsigned char *namechar;//��ת��Ŀ���ǩ��
  int varIndex;//���Ա���, int��local��ʱ����
  char locindex[1];//���Ա�������
  int label_length=0;//
  unsigned char *labelchar;   
  i+=2;//����if�����ֽ�
  //�鿴if�����ֽ�֮����:�����ϴα���Ĳ��Ա������Ƴ���
  if((buffer[i]==':'))
    {
      name_length=GetNameLength(buffer+i+1);//�õ����Ա���������
      buffer[i]=name_length;//������Ա���������
    }
  else{name_length=buffer[i];}
  i++;//�����ֽ�:
  //�õ����Ա�����
  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i,name_length);
  //�������Ա������ֽ�
  i+=name_length;

  //==get label name==
  if((buffer[i]==','))
    {//�õ�Ŀ���ǩ���Ƴ���
      label_length=GetNameLength(buffer+i+1);
      buffer[i]=label_length;
    }//end of if
  else
    {label_length=buffer[i];}//end of else
    
  i++;//����;����ֽ�
  //�õ�Ŀ���ǩ����
  labelchar=(unsigned char*)malloc(sizeof(unsigned char*)*label_length);
  memcpy(labelchar,buffer+i,label_length);
  //==get label name==
  //��ȡ���Ա������ڴ������е�����ֵindex
  varIndex=GetInt(namechar,name_length);
    
  //���Ա����Ƿ�Ϊ�ֲ�����(local)�����Զ������(new)
  if(varIndex>=0)//�Զ������
    {
      //�ж�����
      //if ֻ�ж�int0/1
      if(ints[varIndex]->value)
	{
	  gotoLabel(labelchar,label_length);
	}//end of if(ints[varIndex]->value)
    }//end of if(varIndex>=0)
  else if(!memcmp(namechar,"loc",3))//�ֲ�����
    {
      memcpy(locindex,namechar+1,1);
      if(loc_int[atoi(locindex)])
	{
	  gotoLabel(labelchar,label_length);
	}//end of if(loc_int[atoi(locindex)])
    }//end of else if(!memcmp(namechar,"loc",3))

  i+=label_length;
  //���ص�ǰ����λ��
  return i;
}//end of If
