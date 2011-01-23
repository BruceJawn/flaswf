/*
[Adobe Alchemy Hacks]
AlchemyVM_hack.c
{Simple example for using inline asm and 
accessing memory of Alchemy Virtual Machine in C}
By Bruce Jawn (January/14/2011)
[http://bruce-lab.blogspot.com]

To compile this source file with Alchemy: 
cd /cygdrive/f/alchemy/
source /cygdrive/f/alchemy/alchemy-setup
alc-on
gcc AlchemyVM_hack.c -O3 -Wall -swf -o AlchemyVM_hack.swf
*/
#include <stdio.h>
#include <AS3.h>
//get the Alchemy C Virtual Machine memory
//use asm to embed AS3 code
asm("var ALCVM_Memory:ByteArray = gstate.ds;");
int main () 
{ 
  /*Test Memory Write*/
  //array of int for the test
  int* testData = malloc(0xff * sizeof(int));
  //get the address of testdata in memory
  AS3_Val Adr=AS3_Ptr(testData);
  int AdrInt=AS3_IntValue(Adr);
  //the test value we will write into testData via memory
  int testValue=123;
  //write the testValue into testData
  //gcc AT&T inline assembly used here
  asm("ALCVM_Memory[%0] = %1;" : : "r"(AdrInt), "r"(testValue)); //ALCVM_Memory[AdrInt] = testValue;
  //Check if testValue has been written into testData
  printf("%d\n",testData[0]);//should print 123
  
  /*Test Memory Read*/
  int readedValue;
  asm("%0 ALCVM_Memory[%1];" : "=r"(readedValue) : "r"(AdrInt));
  printf("%d\n",readedValue);//should print 123
  
  /*Test Inline ASM*/
  //label and jump
  asm("__asm(jump, target('myLable'))");
  printf("%s\n","not jumped!");//this line will be skipped
  asm("__asm(label, lbl('myLable'))");
  printf("%s\n","jumped!"); 
  //switch jump
  asm("var myState:int=1;");
  asm("__asm(push(myState), switchjump('state0','state1','state2'));");
  asm("__asm(lbl('state0'))");
  printf("%s\n","This is state0.");
  asm("__asm(lbl('state1'))");
  printf("%s\n","This is state1.");
  asm("__asm(lbl('state2'))");
  printf("%s\n","This is state2.");
  //iftrue jump
  asm("var temp:int=1;");
  asm("__asm(push(temp!=0), iftrue, target('turejump'));");
  printf("%s\n","iftrue not jumped!");//this line will be skipped
  asm("__asm(label, lbl('turejump'))");
  printf("%s\n","iftrue jumped!"); 
  
  /*Test Alchemy Memory Instructions*/
  //All memory opcodes listed here:
  /*
  Get a 32 bit value at the location addr and return as an int:
  _mr32(addr:int):int{ return __xasm<int>(push(addr), op(0x37)); }

  Get a 16 bit unsigned value at the location addr and return as an int:. 
  _mru16(addr:int):int { return __xasm<int>(push(addr), op(0x36)); }

  Get a 16 bit signed value at the location addr and return as an int: 
  _mrs16(addr:int):int { return __xasm<int>(push(addr), op(0x36)); } // li16

  Get a 8 bit value at the location addr and return as an int:
  _mru8(addr:int):int { return __xasm<int>(push(addr), op(0x35)); }
  
  Get a 8 bit value at the location addr and return as an int: 
  _mrs8(addr:int):int { return __xasm<int>(push(addr), op(0x35)); }

  Get a float value at the location addr and return as an Number:
  _mrf(addr:int):Number { return __xasm<int>(push(addr), op(0x38)); }

  Get a double value at the location addr and return as an Number:
  _mrd(addr:int):Number { return __xasm<int>(push(addr), op(0x39)); }

  Write an int as a 32 bit value at the location addr: 
  _mw32(addr:int, val:int):void { __asm(push(val), push(addr), op(0x3c)); }

  Write an int as a 16 bit value at the location addr: 
  _mw16(addr:int, val:int):void { __asm(push(val), push(addr), op(0x3b)); }

  Write an int as a 8 bit value at the location addr: 
  _mw8(addr:int, val:int):void { __asm(push(val), push(addr), op(0x3a)); }

  Write a Number as a float at the location addr: 
  _mwf(addr:int, val:Number):void { __asm(push(val), push(addr), op(0x3d)); }

  Write a Number as a double at the location addr:
  _mwd(addr:int, val:Number):void { __asm(push(val), push(addr), op(0x3e)); }
  */

  //Write an int 654321 as a 32 bit value at the location 1000
  asm("__asm(push(654321),push(1000),op(0x3c));");
  //Trace the memory
  asm("ALCVM_Memory.position=1000");
  asm("trace(ALCVM_Memory.readInt());");//should trace 654321 in flashlog.txt
  //Get a 32 bit value at the location 1000 and return as an int
  asm("var temp:int=__xasm<int>(push(1000), op(0x37));");
  asm("trace(temp)");//should trace 654321 in flashlog.txt

  /*Test some AVM2 Instructions*/
  //More AVM2 Instructions can be found at:
  //http://www.anotherbigidea.com/javaswf/avm2/AVM2Instructions.html
  
  //test add: 0xA0 
  int var1=123;
  int var2=321;
  //write (var1+var2)=444 to testData[0] via memory
  //ALCVM_Memory.position=AdrInt;
  //ALCVM_Memory.writeInt(var1+var2);
  asm("__asm(push(%0), push(%1), op(0xA0), push(%2), op(0x3c))" : : "r"(var1), "r"(var2), "r"(AdrInt));
  printf("%d\n",testData[0]);//should print 444

  //test subtract: 0xA1  
  asm("var result:int=__xasm(push(%0), push(%1), op(0xA1));" : : "r"(var1), "r"(var2));//var result=var1-var2;
  //write (var1-var2)=-198 to testData[1] via memory in a different way
  asm("__asm(push(result),push(%0),op(0x3c));":: "r"(AdrInt+4));
  printf("%d\n",testData[1]);//should print -198

  return 0;
} 
/*
References:
http://labs.adobe.com/wiki/index.php/Alchemy:Documentation:Developing_with_Alchemy:AS3_API
http://blog.frankula.com/?p=211
http://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
http://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html
http://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html
Special thanks to zazzo9 (http://forums.adobe.com/people/zazzo9)
http://forums.adobe.com/thread/660099
http://forums.adobe.com/message/2101303
http://forums.adobe.com/message/1059161
http://forums.adobe.com/message/1915605
http://forums.adobe.com/message/2101405
http://forums.adobe.com/message/1914780
*/