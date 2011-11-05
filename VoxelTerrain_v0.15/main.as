package {
	import flash.display.*;
	import flash.events.*;
	//[SWF(backgroundColor="#000000", frameRate="12", width="640", height="400")]
	[SWF(backgroundColor="#0000ff", frameRate="30", width="640", height="400")]//@@@@@@//
	public class main extends Sprite {
		public function main():void {
			var myvoxel:voxel=new voxel();
			myvoxel.scaleX=myvoxel.scaleY=2;
			addChild(myvoxel);
			stage.focus=this;
			addEventListener(KeyboardEvent.KEY_DOWN,myvoxel.onkeydown);
			addEventListener(Event.ENTER_FRAME,setfocus);
		}//end of function
		private function setfocus(event:Event):void {
			stage.focus=this;
		}//end of function 
	}//end of class
}//end of package