//unsigned char* loc_str[3]
//setloc:str,"name"/mystr;//#include in setloc
//Cats
//I2s0/1/2 sprintf()sprintf(str, "%f", num); "%i"
//#include <stdio.h> 
//#include <string.h> 
if(!memcmp(buffer+i,"str",3))
  {
    int value_length=0;//Ҫ�ĳɵ��ַ�������
    unsigned char *valuechar;//Ҫ�ĳɵ��ַ���
    //char* tempstr;

    char index[1];//
    int index2;//
    i+=4;//setloc:str,0 ����str,�⼸���ֽ�

    //==========
    memcpy(index,buffer+i,1);//����Ҫ�޸ĵľֲ��ַ�������
    //index=atoi(buffer[i]);
    i++;//,"
    //==========
    //�õ�Ҫ�ĳɵ��ַ�������
    if(buffer[i]==',')
      {
	value_length=GetNameLength(buffer+i+1);
	buffer[i]=value_length;
      }//end of if(buffer[i]==',')
    else{value_length=buffer[i];}
    //==========
    valuechar=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
    //Ҫ�ĳɵ�����ʽ�ַ���
    if(buffer[i+1]=='"')
      {
	value_length-=1;
	memcpy(valuechar,buffer+i+2,value_length-1);
	loc_str[atoi(index)]=(unsigned char*)malloc(sizeof(unsigned char*)*(value_length-1));
	memcpy(loc_str[atoi(index)],valuechar,value_length-1);//tempstr=atoi(valuechar);
	loc_str_l[atoi(index)]=value_length-1;
      }
    //Ŀ���Ǳ�������
    else
      {
	//printf("%s\n","index2asdasdasdas");
	//printf("%s\n",buffer+i+1);
	memcpy(valuechar,buffer+i+1,value_length);
	index2=GetStr(valuechar,value_length);
	value_length=chars[index2]->length;
	loc_str[atoi(index)]=(unsigned char*)malloc(sizeof(unsigned char*)*value_length);
	memcpy(loc_str[atoi(index)],chars[index2]->value,value_length);//tempstr=ints[index2]->value;
	loc_str_l[atoi(index)]=value_length;
      }
    //==========
    //������;
    i+=2+value_length;
  }//end of if(!memcmp(buffer+i,"str",3))

