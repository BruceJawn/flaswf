#include "lookupeffect.c"
#include <stdlib.h>
#include "AS3/AS3.h"

// Mark the functions declaration with a GCC attribute specifying the
// AS3 signature we want it to have in the generated SWC. The functions will
// be located in the FlasCCTest.lookupeffect namespace.

void initializeScreenDiffuseBuffer_AS3() __attribute__((used,
	annotate("as3sig:public function initializeScreenDiffuseBuffer_AS3(resX0:int,resY0:int):uint"),
	annotate("as3package:FlasCCTest.lookupeffect")));

void initializeScreenDiffuseBuffer_AS3()
{
	int* result;
	//copy the AS3 resolution variables resX0, resY0 (parameters of the swc function initializeScreenDiffuseBuffer_AS3) 
	//to C variables resX, resY in lookupeffect.c
	AS3_GetScalarFromVar(resX,resX0);
	AS3_GetScalarFromVar(resY,resY0);
	//get the pointer of the screen buffer
	result = initializeScreenDiffuseBuffer(resX,resY);
	// return the result (using an AS3 return rather than a C/C++ return)
	AS3_Return(result);
}

void initializeDiffuseBuffer_AS3() __attribute__((used,
	annotate("as3sig:public function initializeDiffuseBuffer_AS3(resX1:int,resY1:int):uint"),
	annotate("as3package:FlasCCTest.lookupeffect")));

void initializeDiffuseBuffer_AS3()
{
	int* result;
	//get the pointer of the texture buffer
	result = initializeDiffuseBuffer(resX,resY);
	// return the result (using an AS3 return rather than a C/C++ return)
	AS3_Return(result);
}

void rasterize_AS3() __attribute__((used,
	annotate("as3sig:public function rasterize_AS3():void"),
	annotate("as3package:FlasCCTest.lookupeffect")));

void rasterize_AS3()
{
	rasterize();
}

void setupLookupTables_AS3() __attribute__((used,
	annotate("as3sig:public function setupLookupTables_AS3():void"),
	annotate("as3package:FlasCCTest.lookupeffect")));

void setupLookupTables_AS3()
{
	setupLookupTables();
}