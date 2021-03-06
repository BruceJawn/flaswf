BISE is licensed under the MIT license.

---

Copyright (c) 2008 Yoshihiro Shindo and Sean Givan

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

---

History of Changes from the original AS2 version by Yoshihiro Shindo (http://be-interactive.org)



Version 1.0: Dec 14, 2008



* Ported from AS2 to AS3 - Sean Givan

* Jan 4 2008: Added the assembly code GETMV, to fix a bug where a member lookup of a simple variable was mistaken for a literal - Sean Givan

* Nov 20 2008: Bugfix for an error where an implied return for functions was not being compiled in, if the function ended with an if/while/do/for block - Sean Givan

* Nov 23 2008: Changed the ARG instruction to also collect parameter information about the function being called - Sean Givan

* Dec 11 2008: Bugfix for nested ?:, ||, or && statements which would cause inaccurate results - Sean Givan

* Dec 13 2008: Translated syntax errors from Japanese to English - Sean Givan



Version 1.01: Dec 15, 2008



* No changes, except to report a Known Bug: 

Complex return statements that include assignments and/or function calls can sometimes cause inaccurate results.

This fibbonaci function, for instance, will give wrong results:

var fmemo = [];
function fib (n)
{
	if (fmemo [n]) 
		return fmemo [n];
	if (n > 1) 
	{
		return fmemo [n] = (fib (n-1)) + (fib (n-2));
	}
	else 
		return 1;
}


The current workaround is to simplify your return statements if they are causing inaccurate results.

var fmemo = [];
function fib (n)
{
	if (fmemo [n]) 
		return fmemo [n];
	if (n > 1) 
	{
  		var fibn1n2 = (fib (n-1)) + (fib (n-2));
  		return fmemo[n] = fibn1n2;	
	}
	else 
		return 1;
}



Version 1.02: Dec 16, 2008



* Added optimization.  If Parser.parse() is given an optional argument - the VirtualMachine it is targeting, it will optimize the array of bytecodes for that specific virtual machine.  The resulting array cannot be used in any other VM, but the code gets an estimated 40% speed boost.

Version 1.03: Apr 13, 2009

* Fixed some errors in the documentation.

Version 1.04: Nov 28, 2009

* Formalized the code, adding return values and variable types in various places.  Code can now compile under stricter compilers such as the FlashDevelop IDE.


-Sean Givan (http://kinsmangames.com)