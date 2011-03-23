int print(unsigned char* buffer,int pointer)
{
  int i=pointer;
  int name_length=0;//与setloc不同，统一用此长度跳过
  int j=0;
   
  i+=5;
  //==========
  //print number int
  //==========
  //printf("%s\n","Print INT??????");
  //printf("%s\n",buffer+i);
  if(buffer[i+1]=='i')
    {
      unsigned char *tempintc;
      int tempint;
      printf("%s\n","Print INT%%%%%%%");
      //printf("%s\n",buffer+(i-1));
      printf("%c\n",':');
      printf("%c\n",buffer[i-1]);
      printf("%c\n",buffer[i]);
      printf("%c\n",buffer[i+1]);
      printf("%c\n",buffer[i+2]);
      if((buffer[i]==':')||(buffer[i]==','))
	{
	  name_length=GetNameLength(buffer+i+1);
	  buffer[i]=name_length;
	  printf("%s\n","Print INT??????");}
      else{name_length=buffer[i];}
      //name_length=GetNameLength(buffer+i);
      tempintc=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
      memcpy(tempintc,buffer+i+2,name_length);
      tempint=atoi(tempintc);
      printf("%s\n","---------------");
      printf("%s\n","Engine Print:tempint");
      printf("%s\n","---------------");
      printf("%i\n",tempint);
      printf("%s\n","===============");
    }//end of if(buffer[i+1]=='i')
  //==========
  //print number int
  //==========

  //==========
  //print number flt
  //==========
  else if(buffer[i+1]=='f')
    {
      unsigned char *tempfltc;
      float tempflt;
      //printf("%s\n","Print FLT%%%%%%%");
      //printf("%c\n",':');
      //printf("%c\n",buffer[i-1]);
      //printf("%c\n",buffer[i]);
      //printf("%c\n",buffer[i+1]);
      //printf("%c\n",buffer[i+2]);
      if((buffer[i]==':')||(buffer[i]==','))
	{
	  name_length=GetNameLength(buffer+i+1);
	  buffer[i]=name_length;
	  //printf("%s\n","Print INT??????");
	}
      else{name_length=buffer[i];}
      //name_length=GetNameLength(buffer+i);
      tempfltc=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
      memcpy(tempfltc,buffer+i+2,name_length);
      tempflt=(float)atof(tempfltc);
      printf("%s\n","---------------");
      printf("%s\n","Engine Print:tempflt");
      printf("%s\n","---------------");
      printf("%f\n",tempflt);
      printf("%s\n","===============");
    }//end of if(buffer[i+1]=='f')
  //==========
  //print number flt
  //==========

      
  //==========
  //print number str
  //==========
  else if(buffer[i+1]=='"')
    //else if(buffer[i+1]=="\"")
    {  
      unsigned char *tempstr;
  
      if((buffer[i]==':')||(buffer[i]==','))
	{
	  name_length=GetNameLength(buffer+i+2);//1+1 for"
	  buffer[i]=name_length;
	}
      else{name_length=buffer[i];}
      printf("%s\n","Engine find str");
      printf("%i\n",name_length);
      tempstr=(unsigned char*)malloc(sizeof(unsigned char*)*(name_length-1));//-1 for right"
      memcpy(tempstr,buffer+i+2,name_length-1);
      printf("%s\n","---------------");
      printf("%s\n","Engine Print:tempstr");
      printf("%s\n","---------------");
      printf("%s\n",tempstr);
      printf("%s\n","===============");
    }//end of if(buffer[i+1]=="\"")
  //==========
  //print number str
  //==========

  //==========
  //print var
  //==========
  else
    {
      unsigned char *tempname;
      int varindex;
      //int tempint;
      //float tempflt;
      //char* tempstr;
	   
      //得到变量名长度或已得到
      if((buffer[i]==':')||(buffer[i]==','))
	{name_length=GetNameLength(buffer+i+1);
	  buffer[i]=name_length;
	}
      else{name_length=buffer[i];}

      tempname=(unsigned char*)malloc(sizeof(unsigned char*)*name_length);
      memcpy(tempname,buffer+i+1,name_length);
      varindex/*tempint*/=GetInt(tempname,name_length);
      if(/*tempint*/varindex>=0)
	{
	  printf("%s\n","---------------");
	  printf("%s\n","Engine Print:varint");
	  printf("%s\n","---------------");
	  printf("%i\n",ints[varindex]->value/*tempint*/);
	  printf("%s\n","===============");
	}//end of if(tempint)
      else
	{
	  varindex/*tempflt*/=GetFlt(tempname,name_length);
	  if(varindex>=0)
	    {
	      printf("%s\n","---------------");
	      printf("%s\n","Engine Print:varflt");
	      printf("%s\n","---------------");
	      printf("%f\n",floats[varindex]->value/*tempflt*/);
	      printf("%s\n","===============");
	    }//end of if(tempflt)
	  else
	    {varindex/*tempstr*/=GetStr(tempname,name_length);//malloc tempstr get return index?
	      if(varindex>=0)
		{
		  printf("%s\n","---------------");
		  printf("%s\n","Engine Print:varstr");
		  printf("%s\n","---------------");
		  printf("%s\n",chars[varindex]->value);
		  printf("%s\n","===============");
		}
	      else printf("%i\n",0);
	    }//end of if(tempflt) else
	}//end of if(tempint) else 

    }
  //==========
  //print var
  //==========
  i+=name_length;//太统一，分别处理更快！
  return i;
}//end of print
