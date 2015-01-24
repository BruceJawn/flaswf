import flash.display.*;
import flash.events.*;
import flash.filters.*;
import flash.geom.*;
import com.boostworthy.animation.easing.Transitions;
import com.boostworthy.animation.management.AnimationManager;
import com.boostworthy.animation.rendering.RenderMethod;
import com.boostworthy.core.EnhancedSprite;
[Embed(source="../res/FPSEngine/pics/gun.png")]
private var gunClass:Class;
[Embed(source="../res/FPSEngine/pics/gunfire.png")]
private var gunfireClass:Class;
[Embed(source="../res/FPSEngine/pics/aim.png")]
private var aimClass:Class;
[Embed(source="../res/FPSEngine/sounds/gun.mp3")]
private var firesoundClass:Class;

private var HUD_UI:Sprite = new Sprite();

private var gun:Sprite;
private var gunfire:Sprite;
private var gungunfireH:Sprite;
private var aim:Sprite;
private var firesound:Sound;

private var m_objAnimationManager:AnimationManager = new AnimationManager();
private var myExplode:Explode = new Explode();

//50 / stage.stageWidth;
private function FPS_Game_Init():void
{
	
	//var firesoundClass=myLib.getSoundClass("gun_gun1")
	firesound = new firesoundClass(); /*as Sound*/
	gun = new Sprite();
	var guns:* /*:gunClass*/ = new gunClass(); //new Bitmap(myLib.getBitmapData("gun"))//myLib.get//(new gunClass());
	gun.addChild(guns);
	guns.width = -guns.width;
	guns.height = -guns.height;
	var gunfire1:* /*:gunfireClass*/ = new gunfireClass(); //new Bitmap(myLib.getBitmapData("gunfire"))//(new gunfireClass());
	gunfire = new Sprite();
	gunfire.addChild(gunfire1);
	gunfire1.x = -gunfire1.width / 2;
	gunfire1.y = -gunfire1.height / 2;
	
	aim = new Sprite();
	var aim1:* /*:aimClass*/ = new aimClass(); //new Bitmap(myLib.getBitmapData("aim"))//(new aimClass());
	aim.addChild(aim1);
	aim1.x = -aim1.width / 2;
	aim1.y = -aim1.height / 2;
	
	//removeChild(screenBitmap);
	//screenBitmap.visible=0;
	
	HUD_UI.addChild(myExplode);
	myExplode.scaleX = myExplode.scaleY = 2;
	HUD_UI.addChild(aim);
	gungunfireH = new Sprite();
	gungunfireH.addChild(gunfire);
	gunfire.x = 80;
	gunfire.y = 30;
	gunfire.alpha = 0;
	gungunfireH.addChild(gun);
	HUD_UI.addChild(gungunfireH);
	gungunfireH.x = mouseX / 1.500000E+000 + 100;
	gungunfireH.y = mouseY / 10 + 240;
	FPS_Game_Enable();
	HUD_UI.mouseChildren = false;
	HUD_UI.mouseEnabled = false;
}

private function FPS_Game_Enable():void
{
	stage.addEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
	stage.addEventListener(MouseEvent.MOUSE_DOWN, onmousedown);
	stage.addEventListener(MouseEvent.MOUSE_UP, onmouseup);
	stage.addEventListener(KeyboardEvent.KEY_DOWN, onmousedownK);
	stage.addEventListener(KeyboardEvent.KEY_UP, onmouseupK);
	addChild(HUD_UI);
}

private function FPS_Game_Disable():void
{
	stage.removeEventListener(MouseEvent.MOUSE_MOVE, onmousemove);
	stage.removeEventListener(MouseEvent.MOUSE_DOWN, onmousedown);
	stage.removeEventListener(MouseEvent.MOUSE_UP, onmouseup);
	stage.removeEventListener(KeyboardEvent.KEY_DOWN, onmousedownK);
	stage.removeEventListener(KeyboardEvent.KEY_UP, onmouseupK);
	removeChild(HUD_UI);
	Mouse.show();
}

private function onmousedownK(event:KeyboardEvent):void
{
	if (event.keyCode == KEY_Control)
		onmousedown();
}

private function onmouseupK(event:KeyboardEvent):void
{
	if (event.keyCode == KEY_Control)
		onmouseup();
}

private function onmousedown(event:MouseEvent = null):void
{
	/*gunfire.x=gun.x+80;
	   gunfire.y=gun.y+30;
	   gunfire.visible=1;
	   firesound.play();
	 trace(stage.mouseX)*/
	//alcLookupLib.screen_voxel(int(stage.mouseX/2),int(stage.mouseY/2));
	
	/*gunfire.rotation+=5;
	   gunfire.scaleX=gunfire.scaleY=1+Math.random();
	   gunfire.scaleX+=0.1;
	 gunfire.scaleY+=0.1;*/
	
	//var info:int = screenHBitmapData.getPixel((screenBitmap.mouseX+.5>>0),(screenBitmap.mouseY+.5>>0));
	//var info:int = screenHBitmapData.getPixel32(int(stage.mouseX/2),int(stage.mouseY/2));
	//z, u x,v y
	var uv:int = (screenBitmap.mouseY + .5 >> 0) << 8 | (screenBitmap.mouseX + .5 >> 0);
	var info:int = alchemyState._mr32(alcHBitmapPointer + (uv << 2));
	var zz:int = info >> 16 & 0xff;
	var xx:int = info >> 8 & 0xff;
	var yy:int = info & 0xff;
	//
	myExplode.setTexture(screenBitmapData, screenBitmap.mouseX, screenBitmap.mouseY, info >> 24 & 0xff);
	myExplode.init();
	myExplode.explode(screenBitmap.mouseX, screenBitmap.mouseY);
	//trace(screenBitmap.mouseX, screenBitmap.mouseY, zz, xx, yy);
	var pos:int;
	for (var i:int = -2; i < 3; i++)
		for (var j:int = -2; j < 3; j++)
			for (var k:int = -2; k < 3; k++)
			{
				if (Math.random() < 0.4) //alchemyState._mr32
				{
					
					pos = (zz + k) << 16 | (xx + i) << 8 | (yy + j);
					//trace(pos.toString(16))
					pos = pos % (0x80ffff);
					//pos = (uint(zz + k)&0xff) << 16 | (uint(xx + i)&0xff) << 8 | (uint(yy + j)&0xff);
					alchemyState._mw32(alcvoxPointer + (pos << 2), 0);
						//alchemyState._mw32(alcvoxPointer + (pos << 2)+1, 0);
						//alchemyState._mw32(alcvoxPointer + (pos << 2)+2, 0);
						//alchemyState._mw32(alcvoxPointer + (pos << 2)+3, 0);
				}
			}
}

private function onmouseup(event:MouseEvent = null):void
{
	//gunfire.x=gun.x//+80;
	//gunfire.y=gun.y//+30;
	gunfire.alpha = 1;
	gunfire.rotation = 0;
	gunfire.scaleX = gunfire.scaleY = 1;
	
	m_objAnimationManager.alpha(gunfire, 0, 500, Transitions.CUBIC_OUT, RenderMethod.TIMER);
	m_objAnimationManager.rotation(gunfire, 360, 500);
	m_objAnimationManager.scale(gunfire, 3, 3, 500);
	m_objAnimationManager.move(gunfire, 80 + 36, 30 + 36, 50);
	m_objAnimationManager.move(gun, 36, 36, 50);
	m_objAnimationManager.addEventListener("animationFinish", TweenBack);
	//gunfire.rotation=Math.random()*360;
	
	firesound.play();
	//m_objAnimationManager.remove(gun);	
	//gunfire.visible=0;
}

private function TweenBack(e:Event):void
{
	m_objAnimationManager.removeEventListener("animationFinish", TweenBack);
	m_objAnimationManager.move(gun, 0, 0, 50);
	m_objAnimationManager.move(gunfire, 80, 30, 50);
}

private function onmousemove(event:MouseEvent):void
{
	//gunfire.x=gun.x//+80;
	//gunfire.y=gun.y//+30;
	aim.x = mouseX;
	aim.y = mouseY;
	
	gungunfireH.rotation = mouseX / 10 - mouseY / 10;
	gungunfireH.x = mouseX / 1.500000E+000 + 100;
	gungunfireH.y = mouseY / 10 + 240;
}

private function updateParticles():void
{
	var p:*;
	var n:int;
	if (moveL)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.x += 2;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
	}
	else if (moveR)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.x -= 2;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
	}
	else if (rotL)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.x += 3 / 360 * 256;
			p.x = p.x % 256;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
	}
	else if (rotR)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.x -= 3 / 360 * 256;
			p.x = p.x % 256;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
	}
	else if (moveF)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.x -= p.vx / 2;
			p.y -= p.vy / 2;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
	}
	else if (moveB)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.x += p.vx / 2;
			p.y += p.vy / 2;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
	}
	else if (moveU)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.y += 2;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
		
	}
	else if (moveD)
	{
		myExplode._canvas.fillRect(myExplode._canvas.rect, 0x00000000);
		n = myExplode._snow.length;
		while (n--)
		{
			p = myExplode._snow[n];
			p.y -= 2;
			myExplode._canvas.setPixel32(p.x, p.y, p.c);
		}
	}
}