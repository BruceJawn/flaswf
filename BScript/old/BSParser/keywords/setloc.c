int setloc(unsigned char* buffer,int pointer)
{       //setloc: int,0,+1234567;
        //setloc: flt,0,-123.654321;
  int i=pointer;
#ifdef _debug_ 
  printf("%s\n","find setloc"); 
#endif
  i+=7;//����setloc:�⼸���ֽ�
  //-----------------------------
  if(!memcmp(buffer+i,"int",3))
    {
      i+=4;//����int,�⼸���ֽ�
      //if(!memcmp(buffer+i+2,"i",1))
      {
	unsigned char *tempint;//Ҫ�ĳɵ�ֵ�ı�����
	int tempintvalue;//Ҫ�ĳɵ�ֵ
	char index[1];//���޸�ֵ�������ڴ������е�����0,1,2
	int index2;//Ҫ�ĳɵ�ֵ�ı���������
	int number_length;//Ҫ�ĳɵ�ֵ�����ַ����Ȼ�Ҫ�ĳɵ�ֵ�ı���������
#ifdef _debug_ 
	printf("%s\n","find setloc int"); 
#endif
	//printf("%s\n",buffer+i+1);
	//������������i/f��־i+1=, i+2=i i+3=+/-/number
	//�õ������ַ����ĳ���
	if((buffer[i+1]==':')||(buffer[i+1]==','))
	  {number_length=GetNameLength(buffer+i+2);
	    //printf("%i\n",number_length);
	    buffer[i+1]=number_length;}
	else{number_length=buffer[i+1];}
  
#ifdef _debug_
	printf("%i\n",number_length); 
#endif
	//Ҫ�ĳɵ�ֵ�����ı�����
	tempint=(unsigned char*)malloc(sizeof(unsigned char*)*number_length);
	memcpy(tempint,buffer+i+2,number_length);//atoi(buffer[i])
	memcpy(index,buffer+i,1);//���޸ĵľֲ���������

	//�ж�tempint�Ƿ�Ϊ������,setloc:int,0,?(loci_0)
	tempintvalue=atoi(tempint);
	//���tempint�Ƿ�Ϊ������
	if(tempintvalue==0)
	  { 
	    index2=GetInt(tempint,number_length);//�õ�tempint���ڴ������е�����
	    if(index2>=0)
	      {
		tempintvalue=ints[index2]->value;//���Ҫ�ĳɵ�ֵ
	      }//end of if(index2>=0)
	    //loc int setint:myint,loci_0;//must loc int 0
	    else if(!memcmp(buffer+i+2,"loci",4))//cmp tempint!Ҫ�ĳɵ�ֵ����Ϊ�ֲ�����
	      {
		memcpy(index,buffer+i+2+5,1);//���Ҫ�ĳɾֲ�����������
		tempintvalue=loc_int[atoi(index)];//���Ҫ�ĳɵľֲ�����ֵ
	      }
	    else if(!memcmp(buffer+i+2,"locf",4))
	      {
		memcpy(index,buffer+i+2+5,1);//���Ҫ�ĳɾֲ�����������
		tempintvalue=(int)loc_flt[atoi(index)];//���Ҫ�ĳɵľֲ�����ֵ
	      }
	    else
	      {
		//float->int
		index2=GetFlt(tempint,number_length);//��float���ڴ������в��Ҹĳɵ�ֵ��Ӧ����
		if(index2>=0)
		  {
		    tempintvalue=(int)floats[atoi(index)];//���Ҫ�ĳɵ�ֵ
		  }
	      }//end of else
	  }//end of if(tempintvalue==0)
		  
	loc_int[atoi(index)]=tempintvalue;//�޸ľֲ�����ֵ
	//==========
	//������;
	i+=2+number_length;
#ifdef _debug_ 
	printf("%s\n","tempint=");
	printf("%s\n",tempint);
	printf("%i\n",atoi(tempint));
#endif
      }//end of if(!memcmp(buffer+i+2,"i",1))
      //else GetInt
      /*else
	{
	}*/
    }//end of if(!memcmp(buffer+i,"int",3))
	   
           
  //-----------------------------
  //float
  //-----------------------------
  if(!memcmp(buffer+i,"flt",3))
    {
      i+=4;//setloc_flt_*
      //if(!memcmp(buffer+i+2,"f",1))
      {
	unsigned char *tempflt;//Ҫ�ĳɵ�ֵ�ı�������ֵ���ַ�����ʾ
	float tempfltvalue;//Ҫ�ĳɵ�ֵ��ֵ
	char index[1];//�ֲ���������
	int  index2;//Ҫ�ĳɵ�ֵ��ֵ����������
	int  number_length;//Ҫ�ĳɵ�ֵ��ֵ���Ȼ�ֵ���ַ�����ʾ�ĳ���
	//setloc_flt_0_i*
	//�õ�Ҫ�ĳɵ�ֵ��ֵ���Ȼ�ֵ���ַ�����ʾ�ĳ���
	if((buffer[i+1]==':')||(buffer[i+1]==','))
	  {
	    number_length=GetNameLength(buffer+i+2);
	    buffer[i+1]=number_length;}
	else{number_length=buffer[i+1];}
	//number_length=GetNameLength(buffer+i+3);
	//����Ҫ�ĳɵ�ֵ�ı�������ֵ���ַ�����ʾ
	tempflt=(unsigned char*)malloc(sizeof(unsigned char*)*number_length);
	memcpy(tempflt,buffer+i+2,number_length);
	memcpy(index,buffer+i,1);

	//�ж�tempflt�Ƿ�Ϊ������,setloc:flt,0,?(loci_0)
	tempfltvalue=(float)atof(tempflt);
	if(tempfltvalue==0)
	  { 
	    index2=GetFlt(tempflt,number_length);
	    if(index2>=0)
	      {
		tempfltvalue=floats[index2]->value;
	      }//end of if(index2>=0)
	    //loc int setint:myint,loci_0;//must loc int 0
	    else if(!memcmp(buffer+i+2,"loci",4))//cmp tempint!
	      {
		memcpy(index,buffer+i+2+5,1);
		tempfltvalue=(float)loc_int[atoi(index)];
	      }//end of else if(!memcmp(buffer+i+2,"loci",4))
	    else if(!memcmp(buffer+i+2,"locf",4))
	      {
		memcpy(index,buffer+i+2+5,1);
		tempfltvalue=loc_flt[atoi(index)];
	      }//end of else if(!memcmp(buffer+i+2,"locf",4))
	    else
	      {
		//int->float
		index2=GetInt(tempflt,number_length);
		if(index2>=0)
		  {
		    tempfltvalue=(float)ints[atoi(index)]->value;
		  }//end of if(index2>=0)
	      }//end of else
	  }//end of if(tempfltvalue==0)
	loc_flt[atoi(index)]=tempfltvalue;
	//==========
#ifdef _debug_
	printf("%i\n",atof(tempflt));
#endif
	i+=2+number_length;//�����ֽ�
      }
      //else GetFlt
      //else
      //{
      //}
    }//end of if(!memcmp(buffer+i,"flt",3))
#include"locstr.c"
  return i;
}//end of setloc 
