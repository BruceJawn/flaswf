void RunCode(unsigned char* buffer,int CodeLength);
//////////// 
//��ת��ָ����ǩ(��ǩ����, ��ǩ����)
void gotoLabel(unsigned char* name, int name_length)
{
  int j;
  for(j=0;j<labels_num;j++)
    {
      //printf("%s\n",labels[j]->name);
      //������ǩ�ڴ�����, ͨ���Ƚϱ�ǩ�����ҵ�Ҫ��ת�ı�ǩ
      if(!memcmp(name,labels[j]->name,name_length))
	{
	  printf("%s\n","=====");
	  printf("%s\n","_goto");
	  printf("%s\n","=====");
	  //�ݹ����RunCode, ���иñ�ǩ�ڵĴ���
	  RunCode(labels[j]->CodeBuffer,labels[j]->length);
	  break;
	}//end of if
    }//end of for
}//end of gotoLabel

//������ת����Ĵ���, �Խ����õ��ı�ǩ���ƺͱ�ǩ��������������gotoLabel����
//goto: myLabelName;
//buffer: Դ�ű�����
//pointer: Դ�ű���ǰ����λ��
int _goto(unsigned char* buffer,int pointer)
{
  int i=pointer;
  int name_length;//Ҫ������ǩ���Ƴ���
  char* namechar;//Ҫ������ǩ����
  
  i+=5;//����"goto:"��5���ֽ�
  //�ж�"goto"��4���ֽں�����":"��","�����ϴ����н������ı�ǩ���Ƴ���
  if((buffer[i-1]==':')||(buffer[i-1]==','))
    {name_length=GetNameLength(buffer+i);
      //��":"����ֽ��滻Ϊ�������ı�ǩ���Ƴ���������������ı�ǩ���Ƴ���, �Լӿ��´ν����ٶ�
      buffer[i-1]=name_length;}//end of if
  else{name_length=buffer[i-1];}//end of else

  namechar=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
  memcpy(namechar,buffer+i,name_length);
  //����gotoLabel
  gotoLabel(namechar,name_length);
  //����"goto:"��5���ֽں���ı�ǩ�����ֽ�
  i+=name_length;
  //���ص�ǰ����λ��
  return i;
}//end of _goto
