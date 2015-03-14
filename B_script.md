# B-script #

Simple script engine.

## Status: ##

|_Beta_|
|:-----|

## Description: ##
Assembly-like Script Engine for Flash games.
Programming Language designed to be simple and portable.
Also see [BTVM](http://code.google.com/p/flaswf/wiki/BTVM).
## Features: ##

## Todos: ##
  * final clean up, add comments.
  * conditional compiling #if, debug print to file, i+information.
  * visual flow editor
  * parameter collector
  * cbs dynamic link(dll) load into labels

## License: ##

|Unknown|
|:------|
|~~Open Source/MIT~~|
|~~Closed Source/Free~~|

## Labels: ##
  * languages C, AS3, HaXe
  * tools Alchemy, HaXe
## Pics: ##

## Demo: ##

## Source: ##

## DOC: ##

This page is still under construction.

This doc is released under _[Creative Commons Attribution 3.0 License](http://creativecommons.org/licenses/by/3.0/)._

Todos:
use "" to indicate variable name string when declaring/setting.
no "" means a variable. First time must use ""!
### BScript: ###
The scripting/programming language.
#### Symbols: ####
  * |:|
|:|
  1. **Description:** Bytecode indicator.
  1. **Usage:**
```
newint:"MyInt",+1234;
```

  * |,|
|:|
  1. **Description:** Parameters seperator.
  1. **Usage:**
```
newint:"MyInt",+1234;
```

  * |;|
|:|
  1. **Description:** End of a bytecode.
  1. **Usage:**
```
newint:"MyInt",+1234;
```

  * |"|'|
|:|:|
  1. **Description:** Begine/End of a string.
  1. **Usage:**
```
"This Is A String";
'This Is A String';
```

  * |.|
|:|
  1. **Description:** Fractal part indicator of float number.
  1. **Usage:**
```
setlocf:0,-123.456;
```

  * |+|
|:|
  1. **Description:** Positive number indicator.(can be omitted)
  1. **Usage:**
```
newint:"MyPInt",+1234;
newint:"MyPInt",1234;
```

  * |-|
|:|
  1. **Description:** Negative number indicator.
  1. **Usage:**
```
newflt:"MyNFlt",-1234.4321;
```

  * |{|
|:|
  1. **Description:** Begine of a label block.
  1. **Usage:**
```
label:MyLabelName
{
/*Some Codes Here.*/
}
```

  * |}|
|:|
  1. **Description:** End of a label block.
  1. **Usage:**
```
label:MyLabelName
{
/*Some Codes Here.*/
}
```

  * |`/*`|
|:---|
  1. **Description:** Begine of a comment.
  1. **Usage:**
```
/*This is a comment*/
```

  * |`*/`|
|:---|
  1. **Description:** End of a comment.
  1. **Usage:**
```
/*This is 
a comment*/
```

#### KeyWords: ####
  * |newint|
|:-----|
  1. **Description:** Declare a new int type variable.
  1. input(2):
    1. para0: the string of the variable name
> > > or a string type variable which contains an int type variable name
> > > as the new delcared int type variable name
    1. para1: an int number or an int type variable
> > > or a string which is an int type variable name
> > > or a string type variable which contains an int type variable name
  1. **Usage:**
```
newint:"MyInt",+1234;
```
  * |setint|
  1. **Description:** Set values of int type variable.
  1. Input(2):
    1. para0: an int type variable
> > > or the string of the variable name
> > > or a string type variable which contains an int type variable name
    1. para1: an int number or an int type variable
> > > or a string which is an int type variable name
> > > or a string type variable which contains an int type
  1. **Usage:**
```
setint:MyInt,-4321;
```
  * |delint|
  1. **Description:** Delete an int type variable.
  1. **Usage:**
```
delint:MyInt;
```

  * |newflt|
|:-----|
  1. **Description:** Declare a float type variable.
  1. **Usage:**
```
newflt:"MyFlt",12.34;
```

  * |setflt|
|:-----|
  1. **Description:** Set values of a float type variable.
  1. **Usage:**
```
setflt:MyFlt,-43.21;
```

  * |delflt|
|:-----|
  1. **Description:** Delete a float type variable.
  1. **Usage:**
```
delflt:MyFlt;
```

  * |newstr|
|:-----|
  1. **Description:** Declare a string type variable.
  1. **Usage:**
```
newstr:"MyStr","This is a string.";
```

  * |setstr|
|:-----|
  1. **Description:** Set values of a string type variable.
  1. **Usage:**
```
setstr:MyStr,"MyStr changed!";
```

  * |delstr|
|:-----|
  1. **Description:** Delete a string type variable.
  1. **Usage:**
```
delstr:MyStr;
```

There are 9 build in local variables that you can use directly without declaration.

The variables are:
|Int type(3)|loci0:Use as input|loci1:Use as the second parameter|loci2: Use as output  or flag|
|:----------|:-----------------|:--------------------------------|:----------------------------|

|Float type(3)|locf0:Use as input|locf1:Use as the second parameter/input|locf2: Use as output  or flag|
|:------------|:-----------------|:--------------------------------------|:----------------------------|

|String type(3)|locs0:Use as input|locs1:Use as the second parameter/input|locs2: Use as output  or flag|
|:-------------|:-----------------|:--------------------------------------|:----------------------------|

  * |setloci|
|:------|
  1. **Description:** Set the vaule of a local int type variable.
  1. **Usage:**
```
setloci:0,123;
```

  * |setlocf|
|:------|
  1. **Description:** Set the vaule of a local float type variable.
  1. **Usage:**
```
setlocf:1,123.456;
```

  * |setlocs|
|:------|
  1. **Description:** Set the vaule of a local string type variable.
  1. **Usage:**
```
setlocs:2,"MyString";
```

  * |label|
|:----|
  1. **Description:** Declare a label.
  1. **Usage:**
```
label:MyLabelName
{
setlocs:2,locs1;
}
```

  * |goto|
|:---|
  1. **Description:** Jump to a specific label.
  1. **Usage:**
```
goto:"MyLabelName";
goto:MyLabel;/*MyLabel is a string type variable*/
```

  * |ifto|
|:---|
  1. **Description:** If the flag loci2>0, jump to a specific label.
  1. **Usage:**
```
setloci:2,+1;
ifto:"MyLabelName";
```

There are some build in functions which can be called by "call:function".
The build in functions can be extended by user.

Some build in functions are:
|addi|subi|muli|divi|
|:---|:---|:---|:---|
|addf|subf|mulf|divf|
|itof|ftoi|itos|stoi|
|cat|cmp|
|print|

  * |call|
|:---|
  1. **Description:** Call a build in function.
The first parameter is locint0 or locflt0 or locstr0,

the second one is locint1 or locflt1 or locstr1,

and the returned value will be stored in locint2 or locflt2 or locstr2.


  1. **Usage:**
```
/*Pass +1 as the first parameter for function add*/
setloci:0,+1;
/*Pass +1 as the second parameter for function add*/
setloci:1,+1;
/*return locint2=locint0+locint1*/
call:add;
/*
Pass +0 as the second parameter for function print,
which means print a int type local variable.
*/
setloci:0,+0;
/*
Pass +2 as the second parameter for function print,
which means print the int type local variable locint2.
*/
setloci:1,+2;
/*It should print 2.*/
call:print;
```
```
/*Use a string as input*/
call:"add";
```
```
/*Use a string variable as input*/
setlocs:0,"add";
call:locstr0;
```

### Advanced Topics: ###
  * Flexiable variable names:
  1. There are 3 ways of calling a int or a float variable.
  1. 0: use the variable (name). `MyInt`
  1. 1: use the variable name string. `"MyInt"`
  1. 2: use a string type variable which contains a variable name string. `setstr:mystr,"MyInt"; mystr`
  1. The only way to call a string type variable is to use its name.
  * Emulate if condition:
  1. Pseudo Code:
```
if(rand()<0.5)
{
print("The random number is less than 0.5!");
}
else
{
print("The random number is greater than 0.5!");
}
```
  1. BScript:
```
call:rand;
setlocf:0,0.5;
setlocf:1,locf2;
call:subf;
/*emulate if*/
ifto:MyLabel0;
label:MyLabel0
{
setlocs0:"The random number is less than 0.5!";
call:print;
}
/*emulate else*/
setlocf:0,0.0;
setlocf:1,locf2;
call:subf;
ifto:MyLabel1;
label:MyLabel1
{
setlocs0:"The random number is greater than 0.5!";
call:print;
}
```
  * Emulate for/while loop:
  1. Pseudo Code:
```
for(int i=0; i<100; i++)
{
print(i);
}
/*or*/
int i=100;
while(i--)
{
print(i);
}
```
  1. BScript:
```
setloci:0,100;
goto:Loop
label:Loop{
setloci:0,loci2;
setloci:1,0;
call:print;
setloci:1,1;
call:sub;
ifto:Loop;
}
```

  * Emulate Array:
  1. Pseudo Code:
```
var MyArray=[];
for(int i=0; i<100; i++)
{
MyArray[i]=i;
}
```
  1. BScript:
```
setloci:0,100;/*length of array*/
setloci:1,1;/**/

goto:Loop
label:Loop{
setloci:0,loci2;/*put the subed length(current array index) from loci2 to loci0*/
call:itos;/*conver loci0(current array index) to string*/

setlocs:0,MyArray;/*Array name*/
setlocs:1,locstr2;
call:cat;/*NewArrayChildName=MyArray+index*/

newint:locs2,loci0;/*MyArray+index=loci0*/
call:sub;/*loci2=loci0-loci1=loci0--*/
ifto:Loop;
```

  * Emulate Functions:
  1. Pseudo Code:
```
function Myfunction(para0:int,para1:int,para2:float):float
{
float output=(float)(para0+para1)*para2;
return output;
}
int myp0=1;
int myp1=2;
float myp2=3.3;
float varout=Myfunction(myp0,myp1,myp2);
```
  1. BScript:
    1. The direct way:
```
newint:"myp0",1;
newint:"myp1",2;
newflt:"myp2",3.3;
newflt:"varout",0.0;

setloci:0,myp0;
setloci:1,myp1;
setlocf:0,myp2;
goto:Myfunction;
label:Myfunction
{
call:addi;
setloci:0,locint2;
call:itof;
setlocf:1:locflt2;
call:mutf;
}
setflt:varout,locflt2;
```
    1. The indirect way:
```
newint:"myp0",1;
newint:"myp1",2;
newflt:"myp2",3.3;
newflt:"varout",0.0;

newstr:"OutputName","";
setstr:OutputName,"varout";

setlocs:0,"myp0";
setlocs:1,"myp1";
setlocs:2,"myp2";

goto:Myfunction;
label:Myfunction
{
setloci:0,locstr0;
setloci:1,locstr1;
setlocf:0,locstr2;

call:addi;
setloci:0,locint2;
call:itof;
setlocf:1:locflt2;
call:mutf;

setflt:OutputName,locflt2;
}
```
### ~~BSParser:~~ ###
(**Deprecated.**)

Evaluate `*`.bs source code without compilation.

Source Code:
https://flaswf.googlecode.com/svn/trunk/BScript/old/BSParser
### BSCompiler: ###
The compiler for BScript. It compiles `*`.bs- BScript source files to `*`.bsc- bytecodes for BScript Virtual Machine.
#### The `*`.bs file format: ####
Source files of BScript, generally a text file.
#### The `*`.bsc file format: ####
Compiled `*`.bs file in binary bytes format.

The structure:
```
Constant Pool
{
   ConstInts
   {
   ConstIntsCNT:Int4;

   ConstInt0:Int;
   ConstInt1:Int;
   ...
   }
   ConstFlts
   {
   ConstFlsCNT:Int4;

   ConstFlt0:Float;
   ConstFlt1:Float;
   ...
   }
   ConstStrs
   {
   ConstStrsCNT:Int4;

   ConstStrLength0:Int4;
   ConstStr0:String;
   
   ConstStrLength1:Int4;
   ConstStr1:String;
   ...
   } 
}
Labels
{
   LabelsCNT:Int4;
   TheMainLabel
   {
      LabelNameIndex:Int4;
      LabelLength:Int4;
      ByteCodes
      {   
          ByteCode0:Char;
          Parameter0Type:Char;
          /*0:ConstInt,1:ConstFlt,2:ConstStr,3:Variable Name*/
          Parameter0Index:Int4;  
          (Parameter1Type:Char;
          Parameter1Index:Int4;)

          ByteCode1:Char;
          Parameter0Type:Char;
          Parameter0Index:Int4;  
          (Parameter1Type:Char;
          Parameter1Index:Int4;)
          ...
      }
   }  
   SubLabel0
   {
      LabelNameIndex:Int4;
      LabelLength:Int4;
      ByteCodes
      {
      }
   }
   SubLabel1
   {
      ByteCodes
      {
      }
   }
   ...
}
```
The ByteCodes:
```
#define BC_newint 0x00
#define BC_delint 0x01
#define BC_setint 0x02

#define BC_newflt 0x10
#define BC_delflt 0x11
#define BC_setflt 0x12

#define BC_newstr 0x20
#define BC_delstr 0x21
#define BC_setstr 0x22

#define BC_setloci 0x30
#define BC_setlocf 0x31
#define BC_setlocs 0x32

#define BC_itof 0x40
#define BC_ftoi 0x41
#define BC_stoi 0x42
#define BC_itos 0x43

#define BC_goto 0x50
#define BC_ifto 0x51
#define BC_call 0x52
```
The Compiling Process:
```
```
### BSVM: ###
The Virtual Machine of BScript, which can execute `*`.bsc bytecodes.
  * |Static Memory|
|:------------|
```
/*ConstPool*/

```
  * |Dynamic Memory|
```
/*Local variables and variables delcared on the fly*/
```
  * |Find the Variable|
```
1. Read the ParameterType;
/*0:ConstInt,1:ConstFlt,2:ConstStr,3:Variable Name*/
2. Read the ParameterIndex; 
3. switch(ParameterType)
case 0: Get the ConstInt from the const pool;

case 1: Get the ConstFlt from the const pool;

case 2: Get the ConstStr from the const pool;
            switch(Currentbytecode.ParameterType)
            case int: Get DynamicInt from the Dynamic Memory;
            case flt: Get DynamicFlt from the Dynamic Memory;
            case str: /*done, since the only way to call a string variable is use its name.*/

case 3:
          Get the ConstStr from the const pool;
          switch(Currentbytecode.ParameterType)
          case int: 
          Get DynamicInt from the const pool;
          if(cannot find DynamicInt with the name)
          {
          Get DynamicStr(name) from the Dynamic Memory;
          Get DynamicInt(name) from the Dynamic Memory;
          }
          case flt: 
          Get DynamicFlt from the const pool;
          if(cannot find DynamicFlt with the name)
          {
          Get DynamicStr(name) from the Dynamic Memory;
          Get DynamicFlt(name) from the Dynamic Memory;
          }
          case str: 
          Get DynamicStr from the Dynamic Memory;
}
```
  * |Position|
  * |Pause:State|
```
/*can't pause in a sublabel, only pause in the main label.*/
Run=false;
```
  * |Run:State|
```
Run=true;
/*if(Run)
Position++;*/
```
  * |Stop:State|
```
Run=false;
Position=0;
```

## Blog Posts: ##

## Links: ##