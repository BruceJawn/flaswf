	/*
	* Girl Sword Flash
	* 
  * Copyright (C) 2011 
  * Bruce Jawn [bruce-lab.blogspot.com]
  *
	*
	* Girl Sword Flash is free software; you can redistribute it and/or modify
	* it under the terms of the GNU Lesser General Public License as published
	* by the Free Software Foundation; either version 3 of the License, or
	* (at your option) any later version.
	*
	* Girl Sword Flash is distributed in the hope that it will be useful,
	* but WITHOUT ANY WARRANTY; without even the implied warranty of
	* MERCHANTABILITY or FITNESS FOR A PARTIMACULAR PURPOSE.  See the
	* GNU Lesser General Public License for more details.
	*
	* You should have received a copy of the GNU Lesser General Public License
	* along with this program.  If not, see <http://www.gnu.org/licenses/>.
	*
	*/
package
{
	import flash.display.*;
	import flash.events.*;
	
	import sdl.LibSDL;
	import sdl.video.VideoSurface;
	
	import utils.FPSCounter;
	import flash.utils.*;
	import flash.net.*;
	import flash.system.*;
	import flash.ui.*;
	import flash.geom.*;
	
	[SWF(width=480,height=320,frameRate=12)]
	
	public class flashsdl extends Sprite
	{
		var _mochiads_game_id:String = "5d7cecab0c630914";
		
		private var surface:VideoSurface;
		private var surfaceContainer:Sprite;
		
		private var libSDL:LibSDL;
		
		[Embed(source="pic/aqing.bmp",mimeType="application/octet-stream")]
		public static var aqingClass:Class; //1
		
		[Embed(source="pic/dlg.bmp",mimeType="application/octet-stream")]
		public static var dlgClass:Class; //2
		
		[Embed(source="pic/end.bmp",mimeType="application/octet-stream")]
		public static var endClass:Class; //3
		
		[Embed(source="pic/fanli.bmp",mimeType="application/octet-stream")]
		public static var fanliClass:Class; //4
		
		[Embed(source="pic/fight.bmp",mimeType="application/octet-stream")]
		public static var fightClass:Class; //5
		
		[Embed(source="pic/grass.bmp",mimeType="application/octet-stream")]
		public static var grassClass:Class; //6
		
		[Embed(source="pic/info.bmp",mimeType="application/octet-stream")]
		public static var infoClass:Class; //7
		
		[Embed(source="pic/item.bmp",mimeType="application/octet-stream")]
		public static var itemClass:Class; //8
		
		[Embed(source="pic/landscape.bmp",mimeType="application/octet-stream")]
		public static var landscapeClass:Class; //9
		
		[Embed(source="pic/maptile.bmp",mimeType="application/octet-stream")]
		public static var maptileClass:Class; //10
		
		[Embed(source="pic/menu.bmp",mimeType="application/octet-stream")]
		public static var menuClass:Class; //11
		
		[Embed(source="pic/other.bmp",mimeType="application/octet-stream")]
		public static var otherClass:Class; //12
		
		[Embed(source="pic/palace.bmp",mimeType="application/octet-stream")]
		public static var palaceClass:Class; //13
		
		[Embed(source="pic/sheep.bmp",mimeType="application/octet-stream")]
		public static var sheepClass:Class; //14
		
		[Embed(source="pic/state.bmp",mimeType="application/octet-stream")]
		public static var stateClass:Class; //15
		
		[Embed(source="pic/title.bmp",mimeType="application/octet-stream")]
		public static var titleClass:Class; //16
		
		[Embed(source="pic/troop.bmp",mimeType="application/octet-stream")]
		public static var troopClass:Class; //17
		
		[Embed(source="pic/xishi.bmp",mimeType="application/octet-stream")]
		public static var xishiClass:Class; //18
		//
		/*
		   [Embed(source="save/1.sav", mimeType = "application/octet-stream")]
		   public static var s1Class:Class;
		
		   [Embed(source="save/2.sav", mimeType = "application/octet-stream")]
		   public static var s2Class:Class;
		
		   [Embed(source="save/3.sav", mimeType = "application/octet-stream")]
		   public static var s3Class:Class;
		 */
		//[Embed(source = "pic/STSONG.TTF", mimeType = "application/octet-stream")]
		
		[Embed(source="FZLTXHJW.TTF",mimeType="application/octet-stream")]
		public static var fontClass:Class;
		
		include "Sound.as"
		include "Save_Load.as"
		include "scores.as"
		include "MouseMenu.as"
		
		public function getMainLoaderInfobs():ByteArray
		{   //trace("getMainLoaderInfobs")
			var loaderInfo:LoaderInfo = root.loaderInfo;
			if (loaderInfo.loader != null)
			{
				return loaderInfo.loader.loaderInfo.bytes;
			}
			return loaderInfo.bytes;
		}
		
		public function flashsdl()
		{
			Security.allowDomain("http://games.mochiads.com");
			MochiServices.connect("5d7cecab0c630914", root);
			if (stage == null)
			{
				this.addEventListener(Event.ADDED_TO_STAGE, init);
			}
			else
			{
				stage.stageFocusRect = false;
				//stage.frameRate = 60;
				//stage.align=StageAlign.TOP_LEFT;
				//stage.scaleMode=StageScaleMode.NO_SCALE;
				//stage.fullScreenSourceRect=new Rectangle(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
				init();
			}
		}
		
		public function init(e:Event = null)
		{
			initMenu();
			// C Library setup
			this.libSDL = new LibSDL();
			this.libSDL.cLib.init_AS_Main(this);
			
			this.libSDL.cLoader.supplyFile("pic/aqing.bmp", new aqingClass()); //1
			this.libSDL.cLoader.supplyFile("pic/dlg.bmp", new dlgClass()); //2
			this.libSDL.cLoader.supplyFile("pic/end.bmp", new endClass()); //3
			this.libSDL.cLoader.supplyFile("pic/fanli.bmp", new fanliClass()); //4
			this.libSDL.cLoader.supplyFile("pic/fight.bmp", new fightClass()); //5
			this.libSDL.cLoader.supplyFile("pic/grass.bmp", new grassClass()); //6
			this.libSDL.cLoader.supplyFile("pic/info.bmp", new infoClass()); //7
			this.libSDL.cLoader.supplyFile("pic/item.bmp", new itemClass()); //8
			this.libSDL.cLoader.supplyFile("pic/landscape.bmp", new landscapeClass()); //9
			this.libSDL.cLoader.supplyFile("pic/maptile.bmp", new maptileClass()); //10
			this.libSDL.cLoader.supplyFile("pic/menu.bmp", new menuClass()); //11
			this.libSDL.cLoader.supplyFile("pic/other.bmp", new otherClass()); //12
			this.libSDL.cLoader.supplyFile("pic/palace.bmp", new palaceClass()); //13
			this.libSDL.cLoader.supplyFile("pic/sheep.bmp", new sheepClass()); //14
			this.libSDL.cLoader.supplyFile("pic/state.bmp", new stateClass()); //15
			this.libSDL.cLoader.supplyFile("pic/title.bmp", new titleClass()); //16
			this.libSDL.cLoader.supplyFile("pic/troop.bmp", new troopClass()); //17
			this.libSDL.cLoader.supplyFile("pic/xishi.bmp", new xishiClass()); //18
			/*
			   this.libSDL.cLoader.supplyFile("save/1.sav", new s1Class());
			   this.libSDL.cLoader.supplyFile("save/2.sav", new s2Class());
			   this.libSDL.cLoader.supplyFile("save/3.sav", new s3Class());
			 */
			this.libSDL.cLoader.supplyFile("font.ttf", new fontClass());
			
			this.surface = libSDL.getSurface(480, 320);
			
			// Build container for input events
			surfaceContainer = new Sprite();
			surfaceContainer.addChild(surface);
			addChild(surfaceContainer);
			libSDL.setEventTarget(surfaceContainer);
		
			// Monitor FPS performance
			//var fps:FPSCounter = new FPSCounter();
			//addChild(fps);
		}
		
		public function destroy()
		{
		    //trace("destroy");
			/*
			   stage.removeEventListener(KeyboardEvent.KEY_DOWN,key_pressed);
			   stage.removeEventListener(KeyboardEvent.KEY_UP,key_released);
			   removeEventListener(Event.ENTER_FRAME, enterFrame);
			 */
			//surface.removeEventListener( Event.ENTER_FRAME, surface.onEnterFrame );
			removeChild(surfaceContainer);
			surfaceContainer = null;
			surface = null;
			libSDL = null;
		}
	
	}
}
