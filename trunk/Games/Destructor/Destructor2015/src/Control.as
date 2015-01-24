import flash.ui.*;
import com.iainlobb.gamepad.*;
//
public var mouseClickX:int = 0;
public var mouseClickY:int = 0;
//
private var myGamePad:GamepadB;
private var myGamePad2:GamepadB;
private var myOnScreenJoystickDemo:OnScreenJoystickDemo;

//
private function addControl():void
{
	myGamePad = new GamepadB(stage, true, null, null, 6, false, false);
	//myGamePad.useControlSpace(false);
	myGamePad.mapFireButtons([KEY_Spacebar, KEY_Enter, KEY_A, KEY_D, KEY_Z, KEY_X]);
	myGamePad.mapDirection(KEY_W, KEY_S, KEY_Q, KEY_E, true);
	//myGamePad.useWASD(true);
	myGamePad.useVirtual(false); //no use
	
	myGamePad2 = new GamepadB(stage, false, null, null, 0, false, false);
	myGamePad2.useArrows(true);
	myGamePad2.mapDirection(KEY_Z, KEY_X, KEY_A, KEY_D, false);
	myGamePad2.useVirtual(false); //no use
	
	myOnScreenJoystickDemo = new OnScreenJoystickDemo(myGamePad, myGamePad2);
	//addChild(myOnScreenJoystickDemo);
	//stage.addEventListener(Event.RESIZE, resizeListener);
}

/*
   function resizeListener(e:Event):void {
   trace("stageWidth: " + stage.stageWidth + " stageHeight: " + stage.stageHeight);
 }*/

private function removeControl():void
{

}

include "KeyCodes.as"