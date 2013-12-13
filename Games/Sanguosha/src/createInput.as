import flash.events.*;

private var input:TextField = new TextField();


private function createInput():void
{
	input.type = "input";
	
	//input.textColor = 0xffffff;
	
	var fmt:TextFormat = new TextFormat();
    //fmt.align = TextFormatAlign.CENTER;
    fmt.font = "Lucida Console"
    fmt.color = 0xffffff;
	fmt.size = 14;
	fmt.bold = true;
	input.defaultTextFormat = fmt;	
	input.text = "在这里输入选项[以回车键结束]："
	input.addEventListener(FocusEvent.FOCUS_IN, focusIn);
    input.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
	input.border = true;
	input.borderColor = 0xffffff;
	input.width = stage.stageWidth - 2;
	input.multiline = input.wordWrap = false;
	input.height = 20;
	input.y = stage.stageHeight - 25;
	input.addEventListener(KeyboardEvent.KEY_DOWN, handleInput, false, 0, true);
	addChild(input);
}
private function focusIn(evt:FocusEvent):void
{
if (evt.target.text == "在这里输入选项[以回车键结束]：")	input.text = "";
}
 
private function focusOut(evt:FocusEvent):void
{
if (evt.target.text == "")	input.text = "在这里输入选项[以回车键结束]：";
}
/*
private function onKeyDown(e):void
		{
			gotInput_AS3(e.keyCode);
		}
*/		
private function handleInput(event:KeyboardEvent):void
{
	event.stopImmediatePropagation();
	if (event.keyCode == 13) // Listen for Return key press.
	{
		var str:String = input.text;
		var inputNum:* = parseInt(str, 10);
		
		if (inputNum >= 0)
		{
		gotInput_AS3(inputNum);
		}
		else
		{
		gotInput_AS3( -1);
		}
		input.text = "";
	}
}