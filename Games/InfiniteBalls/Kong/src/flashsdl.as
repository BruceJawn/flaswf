/*
 * Infinite Balls
 * Copyright (C) 2011
 * http://pallove.is-programmer.com/
 * http://bruce-lab.blogspot.com/
 *
 * This file is part of Infinite Balls.
 *
 * Infinite Balls is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published
 * by the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Infinite Balls is distributed in the hope that it will be useful,
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
	import flash.text.*;
	import flash.events.*;
	import flash.system.*;
	
	import sdl.LibSDL;
	import sdl.video.VideoSurface;
	
	//import utils.FPSCounter;
	import flash.net.*;
	import flash.utils.*;
	import flash.ui.*;
	
	import mochi.as3.*;
	
	[SWF(width=640,height=580,frameRate=60,backgroundColor="#FFFFFF")]
	
	public class flashsdl extends Sprite
	{
		
		private var surface:VideoSurface;
		private var surfaceContainer:Sprite;
		
		private var libSDL:LibSDL;
		
		[Embed(source="assets/balls/1.bmp",mimeType="application/octet-stream")]
		public static var b1Class:Class;
		
		[Embed(source="assets/balls/2.bmp",mimeType="application/octet-stream")]
		public static var b2Class:Class;
		
		[Embed(source="assets/balls/3.bmp",mimeType="application/octet-stream")]
		public static var b3Class:Class;
		
		[Embed(source="assets/balls/4.bmp",mimeType="application/octet-stream")]
		public static var b4Class:Class;
		
		[Embed(source="assets/balls/5.bmp",mimeType="application/octet-stream")]
		public static var b5Class:Class;
		
		[Embed(source="assets/balls/6.bmp",mimeType="application/octet-stream")]
		public static var b6Class:Class;
		
		[Embed(source="assets/balls/7.bmp",mimeType="application/octet-stream")]
		public static var b7Class:Class;
		
		[Embed(source="assets/balls/8.bmp",mimeType="application/octet-stream")]
		public static var b8Class:Class;
		
		[Embed(source="assets/balls/9.bmp",mimeType="application/octet-stream")]
		public static var b9Class:Class;
		
		include "UI.as"
		include "Scores.as"
		include "Sound.as"
		include "MouseMenu.as"
		
		public function getMainLoaderInfobs():ByteArray
		{ //trace("getMainLoaderInfobs")
			var loaderInfo:LoaderInfo = root.loaderInfo;
			if (loaderInfo.loader != null)
			{
				return loaderInfo.loader.loaderInfo.bytes;
			}
			return loaderInfo.bytes;
		}
		
		public function flashsdl():void
		{
			if (stage == null)
			{
				this.addEventListener(Event.ADDED_TO_STAGE, init0);
			}
			else
			{
				stage.stageFocusRect = false;
				//stage.frameRate = 60;
				//stage.align=StageAlign.TOP_LEFT;
				//stage.scaleMode=StageScaleMode.NO_SCALE;
				//stage.fullScreenSourceRect=new Rectangle(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
				init0();
			}
		}
		
		private function init0(e:Event = null):void
		{
			var allowed_site:String = "kongregate.com";
			var domain:String = this.root.loaderInfo.url.split("/")[2];
			if (domain.indexOf(allowed_site) >= 0 && domain.indexOf(allowed_site) == (domain.length - allowed_site.length))
			{
				// Everything's okay.  Proceed.
			}
			else
			{
				navigateToURL(new URLRequest("http://adf.ly/821527/banner/http://games.mochiads.com/c/g/infinite-balls/InfiniteBalls_EN.swf"), "_blank");
				return;
					// Nothing's okay.  Go away.
			}
			// Pull the API path from the FlashVars
			var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
			
			// The API path. The "shadow" API will load if testing locally. 
			var apiPath:String = paramObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
			
			// Allow the API access to this SWF
			Security.allowDomain(apiPath);
			
			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);
		}
		
		// Kongregate API reference
		var kongregate:*;
		
		// This function is called when loading is complete
		function loadComplete(event:Event):void
		{
			// Save Kongregate API reference
			kongregate = event.target.content;
			
			// Connect to the back-end
			kongregate.services.connect();
			// Security.allowDomain(kongregate.loaderInfo.url);
			// You can now access the API via:
			// kongregate.services
			// kongregate.user
			// kongregate.scores
			// kongregate.stats
			// etc...
			init();
		}
		
		public function init(e:Event = null):void
		{
			// C Library setup
			this.libSDL = new LibSDL();
			this.libSDL.cLib.init_AS_Main(this);
			
			this.libSDL.cLoader.supplyFile("balls/1.bmp", new b1Class());
			this.libSDL.cLoader.supplyFile("balls/2.bmp", new b2Class());
			this.libSDL.cLoader.supplyFile("balls/3.bmp", new b3Class());
			this.libSDL.cLoader.supplyFile("balls/4.bmp", new b4Class());
			this.libSDL.cLoader.supplyFile("balls/5.bmp", new b5Class());
			this.libSDL.cLoader.supplyFile("balls/6.bmp", new b6Class());
			this.libSDL.cLoader.supplyFile("balls/7.bmp", new b7Class());
			this.libSDL.cLoader.supplyFile("balls/8.bmp", new b8Class());
			this.libSDL.cLoader.supplyFile("balls/9.bmp", new b9Class());
			
			this.surface = libSDL.getSurface(640, 480);
			
			// Monitor FPS performance
			//var fps:FPSCounter = new FPSCounter();
			//addChild(fps);
			if (!DSTRY)
			{
				// Build container for input events
				surfaceContainer = new Sprite();
				surfaceContainer.addChild(surface);
				addChild(surfaceContainer);
				libSDL.setEventTarget(surfaceContainer);
				initUI();
				initMenu();
			}
			else
			{
				surfaceContainer = null;
				surface = null;
				libSDL = null;
			}
		}
		private var DSTRY:Boolean = false;
		
		public function destroy():void
		{
			DSTRY = true;
			//trace("destroy");
		/*
		   stage.removeEventListener(KeyboardEvent.KEY_DOWN,key_pressed);
		   stage.removeEventListener(KeyboardEvent.KEY_UP,key_released);
		   removeEventListener(Event.ENTER_FRAME, enterFrame);
		 */
			 //surface.removeEventListener( Event.ENTER_FRAME, surface.onEnterFrame );
			 //this.removeChild(surfaceContainer);
		/*trace(this.numChildren)
		   while (!this.numChildren)
		   {
		   removeChildAt(0);
		   }
		*/
		}
	
	}
}
