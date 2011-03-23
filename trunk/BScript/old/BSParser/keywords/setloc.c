int setloc(unsigned char* buffer,int pointer)
{       //setloc: int,0,+1234567;
        //setloc: flt,0,-123.654321;
  int i=pointer;
#ifdef _debug_ 
  printf("%s\n","find setloc"); 
#endif
  i+=7;//跳过setloc:这几个字节
  //-----------------------------
  if(!memcmp(buffer+i,"int",3))
    {
      i+=4;//跳过int,这几个字节
      //if(!memcmp(buffer+i+2,"i",1))
      {
	unsigned char *tempint;//要改成的值的变量名
	int tempintvalue;//要改成的值
	char index[1];//待修改值变量在内存数组中的索引0,1,2
	int index2;//要改成的值的变量名索引
	int number_length;//要改成的值数字字符长度或要改成的值的变量名长度
#ifdef _debug_ 
	printf("%s\n","find setloc int"); 
#endif
	//printf("%s\n",buffer+i+1);
	//对于数字跳过i/f标志i+1=, i+2=i i+3=+/-/number
	//得到数字字符串的长度
	if((buffer[i+1]==':')||(buffer[i+1]==','))
	  {number_length=GetNameLength(buffer+i+2);
	    //printf("%i\n",number_length);
	    buffer[i+1]=number_length;}
	else{number_length=buffer[i+1];}
  
#ifdef _debug_
	printf("%i\n",number_length); 
#endif
	//要改成的值变量的变量名
	tempint=(unsigned char*)malloc(sizeof(unsigned char*)*number_length);
	memcpy(tempint,buffer+i+2,number_length);//atoi(buffer[i])
	memcpy(index,buffer+i,1);//待修改的局部变量索引

	//判断tempint是否为变量名,setloc:int,0,?(loci_0)
	tempintvalue=atoi(tempint);
	//如果tempint是否为变量名
	if(tempintvalue==0)
	  { 
	    index2=GetInt(tempint,number_length);//得到tempint在内存数组中的索引
	    if(index2>=0)
	      {
		tempintvalue=ints[index2]->value;//获得要改成的值
	      }//end of if(index2>=0)
	    //loc int setint:myint,loci_0;//must loc int 0
	    else if(!memcmp(buffer+i+2,"loci",4))//cmp tempint!要改成的值变量为局部变量
	      {
		memcpy(index,buffer+i+2+5,1);//获得要改成局部变量的索引
		tempintvalue=loc_int[atoi(index)];//获得要改成的局部变量值
	      }
	    else if(!memcmp(buffer+i+2,"locf",4))
	      {
		memcpy(index,buffer+i+2+5,1);//获得要改成局部变量的索引
		tempintvalue=(int)loc_flt[atoi(index)];//获得要改成的局部变量值
	      }
	    else
	      {
		//float->int
		index2=GetFlt(tempint,number_length);//在float型内存数组中查找改成的值对应变量
		if(index2>=0)
		  {
		    tempintvalue=(int)floats[atoi(index)];//获得要改成的值
		  }
	      }//end of else
	  }//end of if(tempintvalue==0)
		  
	loc_int[atoi(index)]=tempintvalue;//修改局部变量值
	//==========
	//跳过至;
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
	unsigned char *tempflt;//要改成的值的变量名或值的字符串表示
	float tempfltvalue;//要改成的值的值
	char index[1];//局部变量索引
	int  index2;//要改成的值的值变量的索引
	int  number_length;//要改成的值的值长度或值的字符串表示的长度
	//setloc_flt_0_i*
	//得到要改成的值的值长度或值的字符串表示的长度
	if((buffer[i+1]==':')||(buffer[i+1]==','))
	  {
	    number_length=GetNameLength(buffer+i+2);
	    buffer[i+1]=number_length;}
	else{number_length=buffer[i+1];}
	//number_length=GetNameLength(buffer+i+3);
	//复制要改成的值的变量名或值的字符串表示
	tempflt=(unsigned char*)malloc(sizeof(unsigned char*)*number_length);
	memcpy(tempflt,buffer+i+2,number_length);
	memcpy(index,buffer+i,1);

	//判断tempflt是否为变量名,setloc:flt,0,?(loci_0)
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
	i+=2+number_length;//跳过字节
      }
      //else GetFlt
      //else
      //{
      //}
    }//end of if(!memcmp(buffer+i,"flt",3))
#include"locstr.c"
  return i;
}//end of setloc 
