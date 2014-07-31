/*
* Copyright (c) <2014> <Bruce Jawn> [http://bruce-lab.blogspot.com]
* This software is released under the MIT License
* <http://www.opensource.org/licenses/mit-license.php>
*/

#include <stdio.h>
#include <iostream>
#include <fstream>
#include "AS3/AS3.h"
#include <Flash++.h>
using namespace std;
//using namespace AS3::local;

int main(int argc, char **argv)
{	
    AS3_GoAsync();
    return 0;
}

AS3::local::var AS3Main;//=AS3::local::internal::new_undefined();//AS3::local::var
//AS3::ui::var callAS3func;
void passMain_AS3() __attribute__((used,
	annotate("as3sig:public function passMain_AS3(MyAS3Main:*):void"),
	annotate("as3package:com.adobe.flascc")));

void passMain_AS3()
{
	//AS3_GetVarxxFromVar(AS3Main,MyAS3Main);//not work, AS3Main not defined?
    //AS3_Trace(callAS3func);
	inline_as3(
				"AS3Main=MyAS3Main;\n"
				//"AS3Main.callAS3func(123456);\n"
				::
				);
			
    /*inline_as3(
				"%0 = MyAS3Main;\n"
                : "=r"(AS3Main) : 
				);*///not work, AS3Main not defined?
				
}

void testMain_AS3() __attribute__((used,
	annotate("as3sig:public function testMain_AS3():void"),
	annotate("as3package:com.adobe.flascc")));

void testMain_AS3()
{
    printf("fun Method 1: pass 'this' ref to C var, call from C var ref\n");
	inline_as3(
				"AS3Main.callAS3func(123456);\n"
				::
				);	
	
	printf("\n fun Method 2: \n");
	inline_as3(
				"CModule.activeConsole.callAS3func(123456);\n"
				::
				);	
	
	printf("\n fun Method 3: \n");
	inline_as3(
				"CModule.rootSprite.callAS3func(123456);\n"//must no preloader(-no-swf-preloader), otherwise ref points to it 
				::
				);

    printf("\n fun Method 4: \n");
	inline_as3(
				//"CModule.vfs.console.callAS3func(123456);\n"//not work
				::
				);

	printf("\n fun Method 5: \n");
	AS3::ui::flash::display::Stage stage = AS3::ui::internal::get_Stage();
	inline_as3(
				"var my = %0;\n"
				"trace(my);\n"
				//"my.callAS3func(123456);\n"//not work
                : : "r"(&stage)  
				);
	
	printf("\n fun Method 6: \n");
	// demonstrate how to call a function of that object from C++
    AS3::local::var functionName = AS3::local::internal::new_String("callAS3func");
    // first get the property of the object called "toString" which is a Function var
	inline_as3(
		"trace(AS3Main);\n"
				: : 
	);
	//AS3Main->callAS3func(123);//not compile
    //AS3::local::var function1 = AS3::local::internal::getproperty(AS3Main, functionName);//runtime error
    //AS3_Trace(function);
	inline_as3(
		"trace(AS3Main);\n"
		//"trace(function1);\n"
				: : 
	);
	// create some AS3 arguments to pass to the function
    AS3::local::var x1 = AS3::local::internal::new_int(123456);
    AS3::local::var nums[1] = {x1};
    // then call that Function object (in this case it takes no parameters)
    //AS3::local::var output =
	//AS3::local::internal::call(function1, AS3Main, 1, nums);
}


//passing a function reference
AS3::local::var AS3Func;//=AS3::local::internal::new_undefined();
void passFunc_AS3() __attribute__((used,
	annotate("as3sig:public function passFunc_AS3(MyAS3Func:*):void"),
	annotate("as3package:com.adobe.flascc")));

void passFunc_AS3()
{
	printf("\n fun Method: call()\n");
	inline_as3(
				"AS3Func=MyAS3Func;\n"
				"AS3Func.call(AS3Func.constructor,654321);\n"
				::
				);
	AS3::local::var x1 = AS3::local::internal::new_int(5);
    AS3::local::var x2 = AS3::local::internal::new_int(6);
    AS3::local::var nums[1] = {x1};
	//call the Function
    //AS3::local::var rcv = AS3::local::internal::_null;
	//AS3::local::var output = AS3::local::internal::call(AS3Func, rcv, 1, nums);//not work
	///*AS3::local::var output = */AS3::local::internal::call(AS3Func, AS3Main, 1, nums);//not work
	AS3::local::var functionconStr = AS3::local::internal::new_String("constructor");
    //AS3::local::var functioncon = AS3::local::internal::getproperty(AS3Func, functionconStr);//runtime error
	inline_as3(
				//"trace(functioncon)\n"
				::
				);
	///*AS3::local::var output = */AS3::local::internal::call(AS3Func, functioncon, 1, nums);//not work
}