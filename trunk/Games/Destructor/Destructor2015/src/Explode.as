package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	//[SWF(width=465, height=465, backgroundColor=0x0, frameRate=120)]
	
	public class Explode extends Sprite
	{
		private static const WIND_X:Number = 10;
		private static const WIND_Y:Number = -15
		private static const GRAVITY:Number = 10;
		private static const START_Y:Number = 10;
		
		public var _canvas:BitmapData;
		private var _textBmp:BitmapData;
		private var _glow:BitmapData;
		private var _glowMtx:Matrix;
		public var _snow:Array;
		private var _snow_prepare:Array;
		
		public function Explode():void
		{
			// stage.scaleMode = "noScale";
			_textBmp = new BitmapData(256, 192, true, 0xff000000);
			this._canvas = new BitmapData(256, 192, true, 0x00000000);
			this.addChild(new Bitmap(this._canvas));
			
			this._snow = [];
			this._snow_prepare = [];
		
		/*this._glow = new BitmapData(465 / 4, 465 / 4, false, 0x0); // キラキラを描く用のん。カンバスの 4 分の 1 のサイズ
		   var bm:Bitmap = this.addChild(new Bitmap(this._glow, PixelSnapping.NEVER, true)) as Bitmap; // smoothing を true にして配置
		   //bm.scaleX = bm.scaleY = 4; // 4 倍にする。
		   bm.blendMode = BlendMode.ADD; // 加算モードで合成
		 this._glowMtx = new Matrix(0.25, 0, 0, 0.25);*/
			 //this.init();
		
		}
		
		public function setTexture(tex:BitmapData, x:int, y:int, d:int):void
		{
			_textBmp.fillRect(_textBmp.rect, 0xff000000);
			var scale:int = (200 / (d + 10)) >> 0;
			//trace(d,scale)
			_textBmp.copyPixels(tex, new Rectangle(x - scale, y - scale, scale << 1, scale << 1), new Point(x - scale, y - scale));
			//_textBmp =  tex;//.draw(_text, _text.transform.matrix);
		}
		
		public function init():void
		{
			//_textBmp.draw(_text, _text.transform.matrix);
			//_snow = [];//bad
			//_snow_prepare = [];//bad
			var rect:Rectangle = _textBmp.getColorBoundsRect(0xffffff, 0x0, false);
			for (var x:int = rect.left; x <= rect.right; x++)
			{
				for (var y:int = rect.top; y <= rect.bottom; y++)
				{
					var col:uint = _textBmp.getPixel32(x, y);
					if (col != 0xff000000)
					{
						var p:SnowParticle = new SnowParticle(x, y, col, 0, 0);
						_snow_prepare.push(p);
						_snow.push(p);
					}
				}
			}
			//this.addEventListener(MouseEvent.CLICK, this._onClick);
			this.addEventListener(Event.ENTER_FRAME, this.update);
		}
		
		/*
		   public function _onClick(e:MouseEvent):void {
		   explode(this.stage.mouseX,this.stage.mouseY);
		   }
		 */
		public function explode(x:int, y:int):void
		{
			// emit
			var n:int = this._snow_prepare.length; //Math.min(20, _snow_prepare.length);
			var mx:int = x; //this.stage.mouseX;
			var my:int = y; //this.stage.mouseY;
			for (var i:int = 0; i < n; i++)
			{
//                var index:int = Math.random() * Math.min(30, _snow_prepare.length);
//                var particle:SnowParticle = _snow_prepare[index];
				var p:SnowParticle = this._snow_prepare[i];
				var dx:Number = p.x - mx + Math.random() * 5;
				var dy:Number = p.y - my + Math.random() * 5;
				var d:Number = dx * dx + dy * dy;
				var sqd:Number = Math.sqrt(d);
				var r:Number = Math.random() * 1 + 0.2;
				p.ax = (dx / sqd * r) * -1;
				p.ay = (dy / sqd * r) * -1;
				
				r = Math.random() * 2;
				p.vx = p.ax * r;
				p.vy = p.ay * r;
//                _textBmp.setPixel(p.x, p.y, 0x000000);
			}
			this._snow_prepare = [];
		}
		
		// 雪を動かすよーー
		public function update(e:Event):void
		{
			this._canvas.lock(); // いっぱい setPixel するときは必ず lock しよう
			this._canvas.fillRect(this._canvas.rect, 0x00000000); // カンバスをクリア
//            this._canvas.copyPixels(_textBmp, _textBmp.rect, new Point(0, 0));
			var n:int = this._snow.length;
			var d:Number = 1.0;
//            var wind_x:Number = (Math.random() > .4 ? WIND_X : 0) / 1000;
//            var wind_y:Number = (GRAVITY + (Math.random() > .6 ? WIND_Y : WIND_Y / 2)) / 1000;
			while (n--)
			{
				var p:SnowParticle = this._snow[n];
				p.vx += p.ax;
				p.vy += p.ay + .5;
				p.vx *= 0.99; // 空気抵抗
				p.vy *= 0.99; // y 方向にも
				p.x += p.vx; // 動かす
				p.y += p.vy;
				//p.x = p.x%256; // 動かす
				//p.y = p.y%192;
				this._canvas.setPixel32(p.x, p.y, p.c); // 雪 1 粒描く
				if (p.y < 0 || this.stage.stageHeight < p.y || p.x < 0 || this.stage.stageWidth < p.x)
				{ // もし画面外にでちゃったら
					this._snow.splice(n, 1); // とりのぞく
				}
				/*if (p.vx < 0.1&&p.vy < 0.1) { // もし画面外にでちゃったら
				   this._snow.splice(n, 1); // とりのぞく
				 }*/
			}
			this._canvas.unlock(); // lock したやつは必ず unlock
			//this._glow.draw(this._canvas, this._glowMtx); // キラキラを描く
			
			//
			if (_snow.length == 0)
			{ //<= 2000){
				this.removeEventListener(Event.ENTER_FRAME, this.update); //this.init();
			}
		}
	}
}

class SnowParticle
{
	
	public var x:Number;
	public var y:Number;
	public var vx:Number;
	public var vy:Number;
	public var ax:Number;
	public var ay:Number;
	public var c:int;
	
	public function SnowParticle(x:Number, y:Number, color:uint, vx:Number, vy:Number):void
	{
		this.x = x;
		this.y = y;
		this.vx = vx;
		this.vy = vy;
		this.ax = 0;
		this.ay = 0;
		this.c = color;
	}
}