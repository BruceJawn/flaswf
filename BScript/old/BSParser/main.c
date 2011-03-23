/**
 *BSParser
 *March 16, 2011
 *Bruce Jawn
 *http://bruce-lab.blogspot.com
 
 *Please Note:
 *This project is Deprecated and will NOT be Updated further.
 *Example C codes showing how to parse Bscript, still buggy.
 *The Bscript syntax used in "code.txt" is dated. 
 *For latest spec: [http://code.google.com/p/flaswf/wiki/B_script]
 *Recommend to use the alternative project <BSCompiler/BSVM>.

 *Copyright (c) <2010> <Bruce Jawn>
 *This software is released under the MIT License 
 *<http://www.opensource.org/licenses/mit-license.php>
 **/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "Memory.c"

unsigned char * TextCode;
unsigned char * RawCode;
unsigned char * CompiledCode;
unsigned char * temp;
long RawCodeSize;
long CompiledCodeSize;
/*int  InstructionCmp(unsigned char *buffer,int index,int count,unsigned char *instruction)
  {
  int i;
  for(i=0;i<count;i++)
  { 
  if(buffer[index+i]!=instruction[i])
  {return 0;}
  }//end of for i
  return 1;
  }*/

#include "CompileCode.c"
#include "RunCode.c"

int main()
{
  FILE * file;
  long fileSize;
  int i;
  file =fopen("code.txt","rb");
  fseek (file, 0, SEEK_END);
  fileSize =ftell(file);
  rewind(file);

  TextCode = (unsigned char*) malloc(sizeof(unsigned char)*fileSize);
  fread(TextCode, 1, fileSize, file);
  fclose (file);

  TrimCode(fileSize);
  printf("%s\n",RawCode);
  CompileCode(RawCodeSize);

  for(i=0;i<labels_num;i++)
    {
      printf("%s\n",labels[i]->name);
      printf("%s\n",labels[i]->CodeBuffer);
    }
  printf("%s\n",CompiledCode);
  RunCode(CompiledCode,CompiledCodeSize);
  printf("%f\n",loc_flt[0]);
  printf("%i\n",loc_int[0]);
  RunCode(CompiledCode,CompiledCodeSize);
  //printf("%f\n",loc_flt[0]);
  //printf("%i\n",loc_int[0]);
  return 0;

}

