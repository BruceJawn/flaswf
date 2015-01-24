package
{
	import flash.display.*;
	import flash.events.*;
	import com.iainlobb.gamepad.GamepadB;
	import com.iainlobb.gamepad.GamepadView;
	import com.iainlobb.gamepad.OnScreenJoystickB;
	
	/**
	 * ...
	 * @author Bruce
	 */
	public class OnScreenJoystickDemo extends Sprite
	{
		private var gamePad1:GamepadB;
		private var gamePad2:GamepadB;
		private var gamePadView1:OnScreenJoystickB;
		private var gamePadView2:OnScreenJoystickB;
		
		public function OnScreenJoystickDemo(gP1:GamepadB, gP2:GamepadB):void
		{
			super();
			gamePad1 = gP1;
			gamePad2 = gP2;
			createGamepadViews();
		}
		
		public function reset():void
		{
			while (numChildren > 0)removeChildAt(0);
			gamePadView1.destroy();
			gamePadView2.destroy();
			//removeEventListener(Event.ADDED_TO_STAGE, addresize);
			createGamepadViews();
		}
		
		private function createGamepadViews():void
		{
			var thumb:Sprite = new Sprite();
			thumb.graphics.beginFill(0x669900);
			thumb.graphics.drawCircle(25, 25, 25);
			
			var button1:Sprite = new Sprite();
			button1.graphics.beginFill(0x669900);
			button1.graphics.drawRect(50, 25, 25, 25);
			
			var button2:Sprite = new Sprite();
			button2.graphics.beginFill(0x669900);
			button2.graphics.drawRect(80, 25, 25, 25);
			
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0x669900, 0.3);
			bg.graphics.drawCircle(50, 50, 50);
			
			gamePadView1 = new OnScreenJoystickB();
			gamePadView1.init(gamePad1, 50, thumb, [button1, button2], bg);
			gamePadView1.x = 100;
			gamePadView1.y = 330;
			addChild(gamePadView1);
			
			var thumb2:Sprite = new Sprite();
			thumb2.graphics.beginFill(0xFF6600);
			thumb2.graphics.drawCircle(25, 25, 25);
			bg = new Shape();
			bg.graphics.beginFill(0xFF6600, 0.3);
			bg.graphics.drawCircle(50, 50, 50);
			
			gamePadView2 = new OnScreenJoystickB();
			gamePadView2.init(gamePad2, 50, thumb2, [], bg);
			gamePadView2.x = 400;
			gamePadView2.y = 330;
			addChild(gamePadView2);
			addEventListener(Event.ADDED_TO_STAGE, addresize);
		}
		
		function addresize(e:Event):void
		{
			stage.addEventListener(Event.RESIZE, resizeListener);
		}
		
		public function resizeListener(e:Event = null):void
		{
			reset();//createGamepadViews();
			//gamePadView1.reset();
			//gamePadView2.reset();
			//trace("stageWidth: " + stage.stageWidth + " stageHeight: " + stage.stageHeight);
		}
		
		public function update():void
		{
			gamePadView1.update();
			gamePadView2.update();
		}
	
	}
}