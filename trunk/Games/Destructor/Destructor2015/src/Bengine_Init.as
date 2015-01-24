private static const IMAGE_WIDTH:int = 256; //512;         
private static const IMAGE_HEIGHT:int = 192; //384;

private var alchemyMemory:ByteArray;
public var alchemyState:MemUser;
private var cLibInit:CLibInit;
private var alcLookupLib:Object;

private var alcBitmapPointer:uint;
private var alcvoxPointer:uint;

private var CMAPPointer:uint;
private var HMAPPointer:uint;

private var groundTexPointer:uint;

private var screenBitmapData:BitmapData;
private var screenBitmap:Bitmap;

private var alcLBitmapPointer:uint;
private var screenLBitmapData:BitmapData;

private var alcHBitmapPointer:uint;
public var screenHBitmapData:BitmapData;

private var pos:Array = [];

//lazy rendering
private var reRender:Boolean = false; //dirty flag

//var myactor = new BSActor(18, 18, 8, 64, 64, new BitmapData(64, 64, true, 0xffff0000));

//var myactor2 = new BSprtData(10, 10, 10, 64, 64, new BitmapData(64, 64, true, 0xffffff00));

protected function Begnine_Init():void
{
	initBitmaps();
	initAlchemy();
	//addChild(myactor)
	//addChild(new FPS())
} //end of function init

private function initBitmaps():void
{
	screenBitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT, false, 0);
	screenHBitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT, true, 0);
	screenLBitmapData = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT, false, 0);
	
	screenBitmap = new Bitmap(screenBitmapData);
	addChild(screenBitmap);
	screenBitmap.scaleX = 2;
	screenBitmap.scaleY = 2;
} //end of function initBitmaps

protected function initAlchemy():void
{
	cLibInit = new CLibInit();
	alcLookupLib = cLibInit.init();
	//Retrieve the "Alchemy Memory".
	var ns:Namespace = new Namespace("cmodule.Bengine");
	//var ns:Namespace = new Namespace( "cmodule._avm2_use_memuser");
	alchemyMemory = (ns::gstate).ds;
	alchemyState =   (ns::gstate);
	//Allocate the buffers in Alchemy.
	var Pointers:Array = alcLookupLib.initialize(this); //Setup a screenbuffer of size x,y;,IMAGE_WIDTH, IMAGE_HEIGHT
	//Copy the  texture we'll use to alchemy memory.
	alcvoxPointer = Pointers[0];
	alcBitmapPointer = Pointers[1];
	alcHBitmapPointer = Pointers[2];
	alcLBitmapPointer = Pointers[3]
	CameraVPtr = Pointers[4];
	groundTexPointer = Pointers[5];
	
	initVoxel();
	Pointers = null;
} //end of function initAlchemy

protected function initVoxel():void
{
	alchemyMemory.position = alcvoxPointer;
	var ba:ByteArray = new dataClass();
	ba.uncompress();
	alchemyMemory.writeBytes(ba, 0, ba.length)
	ba.clear();
	ba.length = 0;
	ba = null;
	//
	var groundTex:BitmapData = (new groundTexClass()).bitmapData;
	alchemyMemory.position = groundTexPointer;
	var px:ByteArray = groundTex.getPixels(groundTex.rect);
	alchemyMemory.writeBytes(px, 0, px.length)
	//
	px.clear();
	px.length = 0;
	px = null;
	//
	var Pointers:Array = alcLookupLib.ComputeMap();
	
	HMAPPointer = Pointers[0];
	CMAPPointer = Pointers[1];
	
	Pointers = null;
}

public function setVoxel(Data:ByteArray):void
{
	alchemyMemory.position = alcvoxPointer;
	Data.uncompress();
	alchemyMemory.writeBytes(Data, 0, Data.length);
	//
	var Pointers:Array = alcLookupLib.ComputeMap();
	
	HMAPPointer = Pointers[0];
	CMAPPointer = Pointers[1];
	
	Pointers = null;
}

public function getVoxel():ByteArray
{
	var ba:ByteArray = new ByteArray();
	ba.writeBytes(alchemyMemory, alcvoxPointer, 0x80ffff * 4);
	ba.compress();
	return ba;
}
private var Vfly:int = 0;

private var moveL:Boolean = false;
private var moveR:Boolean = false;
private var moveF:Boolean = false;
private var moveB:Boolean = false;
private var moveU:Boolean = false;
private var moveD:Boolean = false;
private var rotL:Boolean = false;
private var rotR:Boolean = false;

protected function Begnine_RenderLoop():void
{
	moveL = false;
	moveR = false;
	moveF = false;
	moveB = false;
	moveU = false;
	moveD = false;
	rotL = false;
	rotR = false;
	
	if (Vfly > 0)
	{
		Vfly--;
		Cheight += 2;
		if (check_hit_ceil())
			Cheight--;
		moveU = true;
	}
	//////////////////
	
	if (myGamePad.fires[0].isDown) //(Keys[KEY_Spacebar])
	{
		if (Vfly == 0 && OnFloor)
			Vfly = 8;
	}
	if (myGamePad.fires[1].isDown) //(Keys[KEY_Enter])
	{
		CurState = GAME_PAUSED; //Cheight -= 2;
	}
	/*
	   if (myGamePad.fires[4].isDown)
	   {
	   Midout += 4;
	   if (Midout > 178) Midout = 178;
	   else moveU = true;
	   }
	   else if (myGamePad.fires[5].isDown)
	   {
	   Midout -= 4;
	   if (Midout < 82) Midout = 82;
	   else moveD = true;
	   }
	   else
	 */
	{
		Midout = 130 + int(myGamePad2.y * 100);
	}
	
	var rx:Number = myGamePad2.x * 2;
	/*
	   if (myGamePad.fires[2].isDown)//(Keys[KEY_Spacebar])A
	   {
	   rx = -2;
	   }
	   if (myGamePad.fires[3].isDown)//(Keys[KEY_Enter])D
	   {
	   rx = 2;
	   }
	 */
	if (rx > 0)
		rotR = true;
	else if (rx < 0)
		rotL = true;
	Angle += rx;
	if (Angle >= (360))
		Angle -= (360);
	else if (Angle < 0)
		Angle += (360);
	
	var scangle:Number = Angle * Math.PI / 180;
	var yy:Number = myGamePad.y * 2;
	
	var nCx0:int = Cx0 - 2 * 40960 * Math.cos(scangle) * yy;
	var nCy0:int = Cy0 - 2 * 40960 * Math.sin(scangle) * yy;
	gu0 = ((nCx0 >> 16)) & 0xff;
	gv0 = ((nCy0 >> 16)) & 0xff;
	guv = gu0 << 8 | gv0;
	
	if (!check_hit_move())
	{
		Cx0 = nCx0;
		Cy0 = nCy0;
		if (yy > 0)
			moveF = true;
		else if (yy < 0)
			moveB = true;
	}
	var xx:Number = myGamePad.x * 2;
	var strafe:Number = 0;
	if (xx < 0)
		strafe = -Math.PI / 2;
	else if (xx > 0)
		strafe = Math.PI / 2;
	
	nCx0 = Cx0 + 40960 * Math.cos(scangle + strafe) * Math.abs(xx);
	nCy0 = Cy0 + 40960 * Math.sin(scangle + strafe) * Math.abs(xx);
	gu0 = ((nCx0 >> 16)) & 0xff;
	gv0 = ((nCy0 >> 16)) & 0xff;
	guv = gu0 << 8 | gv0;
	
	if (!check_hit_move())
	{
		Cx0 = nCx0;
		Cy0 = nCy0;
		if (xx > 0)
			moveR = true;
		else if (xx < 0)
			moveL = true;
	}
	
	gu0 = ((Cx0 >> 16)) & 0xff;
	gv0 = ((Cy0 >> 16)) & 0xff;
	guv = gu0 << 8 | gv0;
	//////////////////
	
	do_gravity(); //TODO: need to set moveU, moveD
	
	alchemyState._mw32(CameraVPtr, Cx0) //(voxdata[L2(cheight+1-fght)<<16|guv])
	alchemyState._mw32(CameraVPtr + 4, Cy0)
	alchemyState._mw32(CameraVPtr + 8, Angle)
	alchemyState._mw32(CameraVPtr + 12, Cheight)
	alchemyState._mw32(CameraVPtr + 16, Midout)
	alcLookupLib.loop(); //(Cx0),(Cy0),(Aa),(Cheight),(Midout)
	
	alchemyMemory.position = alcBitmapPointer;
	with (screenBitmapData)
	{
		lock();
		setPixels(rect, alchemyMemory);
		unlock();
	}
	
	alchemyMemory.position = alcHBitmapPointer;
	//addChild(new Bitmap(screenHBitmapData))
	with (screenHBitmapData)
	{
		lock();
		setPixels(rect, alchemyMemory);
		unlock();
	}
	
	alchemyMemory.position = alcLBitmapPointer;
	//addChild(new Bitmap(screenHBitmapData))
	with (screenLBitmapData)
	{
		lock();
		setPixels(rect, alchemyMemory);
		unlock();
	}
	
	//removeEventListener(Event.ENTER_FRAME, enterFrame);
	//update()
	/*
	   myactor.render(gu0,gv0,Cheight,Angle,Midout,screenHBitmapData);
	   myactor.x = myactor.px;
	   myactor.y = myactor.py;
	 */
	//?DrawBSD(myactor2);
	updateParticles();
} //end of function enterFrame