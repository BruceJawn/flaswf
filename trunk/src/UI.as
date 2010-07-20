import com.bit101.components.*;
import flash.net.*;
import flash.text.*;

var AS3EvalDrawL:com.bit101.components.Label;
var LoadCPB:PushButton;
var SaveCPB:PushButton;
var SnapShotPB:PushButton;
var TutorialPB:PushButton;
var About:PushButton;
var CodePB:PushButton;
var CanvasPB:PushButton;
var OutPutPB:PushButton;
var CodeT:codeViewer;
var OutputT:TextArea;
var EvalPB:PushButton;
var StopPB:PushButton;
var dumpAS3PB:PushButton;

function UI():void {

	AS3EvalDrawL=new com.bit101.components.Label(this,260,20,"AS3 Eval Draw");

	LoadCPB=new PushButton(this,40,60,"打开代码",LoadCPB_H);

	SaveCPB=new PushButton(this,180,60,"保存代码",SaveCPB_H);

	SnapShotPB=new PushButton(this,460,60,"截图",SnapShotPB_H);

	TutorialPB=new PushButton(this,320,100,"教程",TutorialPB_H);

	About=new PushButton(this,460,100,"关于",About_H);

	CodePB=new PushButton(this,40,140,"代码编辑器",CodePB_H);

	CanvasPB=new PushButton(this,180,140,"画板",CanvasPB_H);

	OutPutPB=new PushButton(this,320,140,"输出",OutPutPB_H);

	CodeT = new codeViewer();
	addChild(CodeT);
	CodeT.x=40;
	CodeT.y=180;

	OutputT=new TextArea(this,40,180,"");
	OutputT.width=384;
	OutputT.height=384;
	OutputT.visible=false;

	EvalPB=new PushButton(this,40,100,"运行(Eval)",EvalPB_H);
	StopPB=new PushButton(this,180,100,"停止(Stop)",StopPB_H);
	dumpAS3PB=new PushButton(this,320,60,"导出AS3类",dumpAS3PB_H);

}//end of function UI

function LoadCPB_H(event:Event):void {
	var ref:FileReference=new FileReference  ;
	ref.addEventListener(Event.SELECT,txtSelected);
	ref.browse([ new FileFilter("Documents", "*.bs;*.txt")]);
	function txtSelected(e:Event):void {
		ref.addEventListener(Event.COMPLETE,CodeLoaded);
		ref.load();
	}//end of function txtSelected(e:Event)
	trace("LoadCPB_H");
}//end of function LoadCPB_H

function CodeLoaded(event:Event) {
	CodeT.code=String(event.target.data/*event.target.data.readUTFBytes(event.target.data.bytesAvailable)*/).replace(new RegExp("\r\n","ig"),"\n");
}//end of function CodeLoaded

function SaveCPB_H(event:Event):void {
	new FileReference().save(CodeT.code,"mycode.txt");
	trace("SaveCPB_H");
}//end of function SaveCPB_H

function SnapShotPB_H(event:Event):void {
	var out:SavingBitmap=new SavingBitmap(ScreenBuffer);
	out.save("AS3Evaldraw_ScreenPrint.png");
	trace("SnapShotPB_H");
}//end of function SnapShotPB_H

function TutorialPB_H(event:Event):void {
	trace("TutorialPB_H");
	OutputT.visible=true;
	Screen.visible=false;
	CodeT.visible=false;

	var TutorialText:String="";
	var TutorialTextLoader:URLLoader=new URLLoader();
	TutorialTextLoader.addEventListener('complete', TutorialTextLoaded);
	TutorialTextLoader.load(new URLRequest("../Tutorial.txt"));

	function TutorialTextLoaded(event:Event) {
		TutorialText=String(event.target.data);
		traceE(TutorialText);
	}//end of function TutorialText
}//end of function TutorialPB_H

function About_H(event:Event):void {
	trace("About_H");
	OutputT.visible=true;
	Screen.visible=false;
	CodeT.visible=false;

	var AboutText:String="";
	var AboutTextLoader:URLLoader=new URLLoader();
	AboutTextLoader.addEventListener('complete', AboutTextLoaded);
	AboutTextLoader.load(new URLRequest("../About.txt"));

	function AboutTextLoaded(event:Event) {
		AboutText=String(event.target.data);
		traceE(AboutText);
	}//end of function AboutText
	//traceE("<==========关于==========")
	//traceE("*AS3 Evaldraw v0.1\n*July 16, 2010\n*作者: Bruce Jawn (zhoubu1988@gmail.com)\n*Inspired by Ken Silverman's EVALDRAW\n*脚本引擎 - BISE Scripting Engine (AS3)\nby Yoshihiro Shindo and Sean Givan\n*界面组件 - MinimalComps by Keith Peters (BIT-101)\n*代码高亮器 - based on atlas's work");
	//traceE("==========关于==========>")
}//end of function About_H

function CodePB_H(event:Event):void {
	OutputT.visible=false;
	Screen.visible=false;
	CodeT.visible=true;
	trace("CodePB_H");
}//end of function CodePB_H

function CanvasPB_H(event:Event):void {
	OutputT.visible=false;
	Screen.visible=true;
	CodeT.visible=false;
	trace("CanvasPB_H");
}//end of function CanvasPB_H

function OutPutPB_H(event:Event):void {
	OutputT.visible=true;
	Screen.visible=false;
	CodeT.visible=false;
	trace("OutPutPB_H");
}//end of function OutPutPB_H

function EvalPB_H(event:Event):void {
	stop_script();
	run_script();
	trace("EvalPB_H");
}//end of function EvalPB_H

function StopPB_H(event:Event):void {
	stop_script();
	trace("StopPB_H");
}//end of function StopPB_H

function dumpAS3PB_H(event:Event):void {
	dumpAS3();
	trace("dumpAS3PB_H");
}//end of function dumpAS3PB_H