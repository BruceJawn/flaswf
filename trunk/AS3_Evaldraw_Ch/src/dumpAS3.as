function dumpAS3() {
	var AS3code:String="";
	var codeLoader:URLLoader=new URLLoader();
	codeLoader.addEventListener('complete', CodeLoaded);
	codeLoader.load(new URLRequest("../lib/AS3Evaldraw_dump.as"));

	function CodeLoaded(event:Event) {
		AS3code=String(event.target.data);
		AS3code=AS3code.replace("/*init();function onEnterFrame(){}//end of function onEnterFrame*/",
		CodeT.code);
		trace(CodeT.code.search("onEnterFrame")+"CodeT.code.search")
		if (CodeT.code.search("onEnterFrame")<0) {
			AS3code=AS3code.replace("onEnterFrame();","");
		}
		new FileReference().save(AS3code,"AS3Evaldraw_dump.as");
	}//end of function CodeLoader

}//end of function dumpAS3