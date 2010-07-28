/**
 *AS3 Evaldraw
 *July 16, 2010
 *Bruce Jawn
 *http://bruce-lab.blogspot.com
 
 *Inspired by Ken Silverman's EVALDRAW
 *http://www.advsys.net/ken/evaltut/evaldraw_tut.htm
 
 *Scripting Engine - BISE Scripting Engine (AS3) by Yoshihiro Shindo and Sean Givan
 *http://kinsmangames.wordpress.com/bise-scripting-engine/
 
 *User Interface Components - MinimalComps by Keith Peters (BIT-101)
 *http://www.minimalcomps.com/
 
 *Syntax Highlighter based on atlas's work
 *http://www.atlascs.co.uk/blog/2007/02/09/as3-syntax-highlighting-in-as3
 
 *Copyright (c) <2010> <Bruce Jawn>
 *This software is released under the MIT License 
 *<http://www.opensource.org/licenses/mit-license.php>
 **/
package {
	import flash.display.*;
	import flash.events.*;
	import flash.system.System;
	[SWF(backgroundColor=0xeeeeee, width=600, height=700)]
	public class Main extends Sprite {

		var ScreenBuffer:BitmapData=new BitmapData(512,512);
		var Screen:Bitmap=new Bitmap(ScreenBuffer);
		var Canvas:Sprite=new Sprite();
		var Pen:Graphics=Canvas.graphics;

		include "eval_script.as"
		include "UI.as"
		include "dumpAS3.as"

		public function Main():void {
			System.useCodePage=true;
			Screen.x=40;
			Screen.y=180;
			Screen.visible=false;
			addChild(Screen);
			UI();
			var exampleCodeLoader:URLLoader=new URLLoader();
			exampleCodeLoader.addEventListener('complete', CodeLoaded);
			exampleCodeLoader.load(new URLRequest("../Evaldraw_examples/example_basic.txt"));
		}//end of function Main

	}//end of class
}//end of package