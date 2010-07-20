package{
	import flash.display.*;
	import flash.events.*;
	[SWF(backgroundColor=0xeeeeee, width=512, height=512, frameRate=30)]
	public class AS3Evaldraw_dump extends Sprite{
		var ScreenBuffer:BitmapData=new BitmapData(512,512);
		var Screen:Bitmap=new Bitmap(ScreenBuffer);
		var Canvas:Sprite=new Sprite();
		var Pen:Graphics=Canvas.graphics;
		public function AS3Evaldraw_dump()
		{
		/*Connect The Dots E8: http://actionsnippet.com/?p=2846*/var TWO_PI= Math.PI * 2;var centerX = stage.stageWidth / 2;var centerY = stage.stageHeight / 2-120;function onEnterFrame(){     ScreenBuffer.fillRect(ScreenBuffer.rect,0xffffff);     /*data*/	var points = [];	var i = 0;	var pointNum = Math.max(2,Math.floor(stage.mouseX / 12));	var radius = 200;	var step = TWO_PI / pointNum;	var theta = step / 2;	for (i = 0; i<pointNum; i++){		var xp = centerX + radius * Math.cos(theta);		var yp = centerY + radius * Math.sin(theta);		points[i] = {};            points[i].x=xp;            points[i].y=yp;		theta += step;	}	/*render*/	Pen.clear();     Pen.lineStyle(0,0);     for (i = 0; i<pointNum; i++) {	var a=points[i];	for (var j = i+1; j<pointNum; j++) {		var b=points[j];		Pen.drawCircle(a.x, a.y, 10);		Pen.moveTo(a.x, a.y);		Pen.lineTo(b.x, b.y);	}    }    Pen.drawCircle(a.x, a.y, 10);    ScreenBuffer.draw(Canvas);}
		
		addChild(Screen)
		addEventListener(Event.ENTER_FRAME,onEF)
		function onEF(event:Event){
			onEnterFrame();
		}//end of function onEF
		
		}//end of function AS3Evaldraw_dump
		
	}//end of class
}//end of package