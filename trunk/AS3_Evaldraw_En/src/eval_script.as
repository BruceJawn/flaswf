import scripting.*;
import flash.geom.*;

var Compiled:Boolean=false;
var vm:VirtualMachine;
var s:Scanner;
var p:Parser;

function stop_script():void {
	//trace(Compiled);
	removeEventListener(Event.ENTER_FRAME,onEnterFrame);
	//Screen.visible=false;
	Compiled=false;
}//end of function stop_script

function run_script():void {
	//Canvas.visible=true;
	ScreenBuffer.fillRect(new Rectangle(0,0,512,512),0xFFFFFFFF);
	Pen.clear();
	s=new Scanner(CodeT.code);
	p=new Parser(s);
	vm=new VirtualMachine();
	vm.getGlobalObject().Math=Math;
	vm.getGlobalObject().stage=stage;
	vm.getGlobalObject().trace=traceE;
	vm.getGlobalObject().Pen=Pen;
	vm.getGlobalObject().Canvas=Canvas;
	vm.getGlobalObject().ScreenBuffer=ScreenBuffer;
	try {
		vm.setByteCode(p.parse());
	} catch (vme:VMSyntaxError) {
		traceE(vme.message);
	}
	var result=vm.execute();
	Compiled=true;
	addEventListener(Event.ENTER_FRAME,onEnterFrame);
}//end of function runscript

function onEnterFrame(e:Event):void {
	if (vm.getGlobalObject().onEnterFrame) {
		vm.getGlobalObject().onEnterFrame();
	}//end of else if
}//end of function onEnterFrame

function traceE(s) {
	trace(s);
	OutputT.textField.appendText(s.toString()+"\n");//(String(s));
}//end of function traceE