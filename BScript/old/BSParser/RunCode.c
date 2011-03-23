#include"keywords/setloc.c"
#include"keywords/str.c" 
#include"keywords/int.c" 
#include"keywords/flt.c" 
#include"keywords/call.c"
#include"keywords/goto.c"
#include"keywords/if.c" 
#include"keywords/print.c" 
//运行代码
void RunCode(unsigned char* buffer,int CodeLength)
{
  int i=0;
  //遍历bytecode, 解析代码
  for(i=0;i<CodeLength;i++)
    {
      //setloc
      //=============================
      if(!memcmp(buffer+i,"setloc",6))
	{
	  i=setloc(buffer,i);
	  //----------------------------- 
	}//end of if(!memcmp(buffer+i,"setloc",6))
      //=============================
      //setloc

      //goto
      //=============================
      else if(!memcmp(buffer+i,"goto",4))
	{
	  i=_goto(buffer,i);
	}//end of else if
      //=============================
      //goto

      //print
      else if(!memcmp(buffer+i,"print",5))
	{
	  i=print(buffer,i);
	}//end of else if
      //print

      //newint
      else if(!memcmp(buffer+i,"newint",6))
	{
	  i=NewInt(buffer,i);
	}//end of else if
      //=============================
      //newint

      //newflt
      else if(!memcmp(buffer+i,"newflt",6))
	{
	  i=NewFlt(buffer,i);
	}//end of else if
      //=============================
      //newflt
        
      //newstr
      else if(!memcmp(buffer+i,"newstr",6))
	{
	  i=NewStr(buffer,i);//??????
	}//end of else if
      //=============================
      //newstr

      //setint
      else if(!memcmp(buffer+i,"setint",6))
	{
	  i=SetInt(buffer,i);
	}//end of else if
      //=============================
      //setint
        
      //setflt
      else if(!memcmp(buffer+i,"setflt",6))
	{
	  i=SetFlt(buffer,i);
	}//end of else if
      //=============================
      //setflt
        
      //setstr
      else if(!memcmp(buffer+i,"setstr",6))
	{
	  i=SetStr(buffer,i);
	}//end of else if
      //=============================
      //setstr
        
      //call
      else if(!memcmp(buffer+i,"call",4))
	{
	  i=Call(buffer,i);
	}//end of else if
      //=============================
      //call
        
      //if
      else if(!memcmp(buffer+i,"if",2))
	{
	  i=If(buffer,i);
	}//end of else if
      //=============================
      //if

      else if(!memcmp(buffer+i,"deli",4))
	{
	  i=DeleteInt(buffer,i);
	}
      else if(!memcmp(buffer+i,"delf",4))
	{
	  i=DeleteFlt(buffer,i);
	}
      else if(!memcmp(buffer+i,"dels",4))
	{
	  i=DeleteStr(buffer,i);
	}

    }//end of for
}//end of RunCode




