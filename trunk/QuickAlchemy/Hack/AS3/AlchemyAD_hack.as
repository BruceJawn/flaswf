/*
[Adobe Alchemy Hacks]
AlchemyAD_hack.as
{Simple example for using inline asm and 
accessing memory in AS3}
By Bruce Jawn (January/23/2011)
[http://bruce-lab.blogspot.com]

To compile this source file with Alchemy: 
cd /cygdrive/f/alchemy/
java -Xms16M -Xmx196M -jar F:/alchemy/bin/asc.jar -AS3 -strict -import F:/alchemy/flashlibs/global.abc -import F:/alchemy/flashlibs/playerglobal.abc -config Alchemy::Debugger=false -config Alchemy::NoDebugger=true -config Alchemy::Shell=false -config Alchemy::NoShell=true -config Alchemy::LogLevel=0 -config Alchemy::Vector=true -config Alchemy::NoVector=false -config Alchemy::SetjmpAbuse=false -swf AlchemyAD_hack,800,600,60 AlchemyAD_hack.as
*/
package
{   	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.system.ApplicationDomain;
	public class AlchemyAD_hack extends Sprite{

public function AlchemyAD_hack () 
{ 
  /*Create the print shell*/
  var MyShell:TextField=new TextField();
  MyShell.height=600;
  addChild(MyShell);
  function print(output:*):void
  {
	  MyShell.appendText(String(output));
	  MyShell.appendText("\n");
  }
  
  /*Test Memory Write*/
  //ByteArray for the test
  var testData:ByteArray = new ByteArray();
  testData.endian = Endian.LITTLE_ENDIAN;
  testData.length=0xffff*4;
  //select testdata in memory
  ApplicationDomain.currentDomain.domainMemory=testData;
  var AdrInt:int=0;
  //the test value we will write into testData via memory
  var testValue:int=123;
  //write the testValue into testData
  ApplicationDomain.currentDomain.domainMemory[0] = testValue;
  //Check if testValue has been written into testData
  print(testData[0]);//should print 123
  
  /*Test Memory Read*/
  var readedValue:int=ApplicationDomain.currentDomain.domainMemory[0];
  print(readedValue);//should print 123 
  
  /*Test Inline ASM*/
  //label and jump
  __asm(jump, target('myLable'));
  print("not jumped!");//this line will be skipped
  __asm(label, lbl('myLable'));
  print("jumped!"); 
  //switch jump
  var myState:int=1;
  __asm(push(myState), switchjump('state0','state1','state2'));
  __asm(lbl('state0'));
  print("This is state0.");
  __asm(lbl('state1'));
  print("This is state1.");
  __asm(lbl('state2'));
  print("This is state2.");
  //iftrue jump
  var temp:int=1;
  __asm(push(temp!=0), iftrue, target('turejump'));
  print("iftrue not jumped!");//this line will be skipped
  __asm(label, lbl('turejump'));
  print("iftrue jumped!"); 
  
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
  __asm(push(654321),push(1000),op(0x3c));
  //Trace the memory
  ApplicationDomain.currentDomain.domainMemory.position=1000;
  print(ApplicationDomain.currentDomain.domainMemory.readInt());//should print 654321
  //Get a 32 bit value at the location 1000 and return as an int
  var temp:int=__xasm<int>(push(1000), op(0x37));
  print(temp);//should print 654321

  /*Test some AVM2 Instructions*/
  //More AVM2 Instructions can be found at:
  //http://www.anotherbigidea.com/javaswf/avm2/AVM2Instructions.html
  
  //test add: 0xA0 
  var var1:int=123;
  var var2:int=321;
  //write (var1+var2)=444 to testData[0] via memory
  //ApplicationDomain.currentDomain.domainMemory.position=AdrInt;
  //ApplicationDomain.currentDomain.domainMemory.writeInt(var1+var2);
  __asm(push(var1), push(var2), op(0xA0), push(AdrInt), op(0x3c));
  testData.position=0;
  print(testData.readInt());//should print 444
  
  //test subtract: 0xA1
  var result:int=__xasm(push(var1), push(var2), op(0xA1));//var result=var1-var2;
  print(result);//should print -198
  //write (var1-var2)=-198 to testData[1] via memory in a different way
  __asm(push(result),push(AdrInt+4),op(0x3c));
  testData.position=4;
  print(testData.readInt());//should print -198
  
}//end of function AlchemyAD_hack

}//end of class
}//end of pacakge
/*
References:
http://labs.adobe.com/wiki/index.php/Alchemy:Documentation:Developing_with_Alchemy:AS3_API
http://unitzeroone.com/blog/2009/05/22/another-scream-on-flash-alchemy-memory-and-compilers/
http://blog.frankula.com/?p=211
http://forums.adobe.com/message/2616985
http://forums.adobe.com/message/3001861
Special thanks to Bernd Paradies (http://forums.adobe.com/people/Bernd%20Paradies)
*/