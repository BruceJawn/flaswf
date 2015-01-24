import flash.net.*;
private var myMenu:ContextMenu = new ContextMenu();

private function AddMouseMenu(Name:String, Break:Boolean = false, Listener:Function = null):void
{
	var NCMI:ContextMenuItem = new ContextMenuItem(Name, Break);
	myMenu.customItems.push(NCMI);
	if (Listener != null)
		NCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Listener);
} //end of function
private var muteBsound:Boolean = true;
private var muteMsound:Boolean = false;

private function initMouseMenu():void
{
	myMenu.hideBuiltInItems();
	this.contextMenu = myMenu;
	/*
	   AddMouseMenu("☆(Bouncing Sound On)", false, function menuItemSelectHandlerupload(e:ContextMenuEvent):void
	   {
	   muteBsound = !muteBsound;
	   if (muteBsound)
	   myMenu.customItems[0].caption = "☆(Bouncing Sound On)";
	   else
	   myMenu.customItems[0].caption = "☆(Bouncing Sound Off)";
	   });
	
	   AddMouseMenu("☆(Menu Sound Off)", false, function menuItemSelectHandlerupload(e:ContextMenuEvent):void
	   {
	   muteMsound = !muteMsound;
	   if (muteMsound)
	   myMenu.customItems[1].caption = "☆(Menu Sound On)";
	   else
	   myMenu.customItems[1].caption = "☆(Menu Sound Off)";
	   });
	 */
	AddMouseMenu("◆{play.flaswf.tk}", false, function menuItemSelectHandler2(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://play.flaswf.tk/"), "_blank");
		});
	AddMouseMenu("☆{Visit Author}", true, function menuItemSelectHandler0(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://bruce-lab.blogspot.com"), "_blank");
		});
	AddMouseMenu("★{Credits}", false, function menuItemSelectHandler0(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://bruce-lab.blogspot.com/2012/06/destructor-voxel-based-fps-game-power.html"), "_blank");
		});
	/*
	   AddMouseMenu("◇{More Games}", false, function menuItemSelectHandler1(e:ContextMenuEvent):void
	   {
	   navigateToURL(new URLRequest("http://www.mochigames.com/developer/Bruce_Jawn/"), "_blank");
	   });
	 */
	AddMouseMenu("Music on/off [Theme Crystalized by Ove Melaa]", true, function menuItemSelectHandler(e:ContextMenuEvent):void
		{
			/*
			   if (CurState == GAME_PAUSED||CurState == GAME_MENU)
			   return;
			 */
			if (playMusic == true)
			{
				if (musicPlaying)
				{
					lastMPosition = MusicSC.position;
					MusicSC.stop();
				}
				musicPlaying = false;
				playMusic = false;
			}
			else if (playMusic == false)
			{
				if (!musicPlaying)
				{
					MusicSC = Music.play(lastMPosition, int.MAX_VALUE);
					musicPlaying = true;
				}
				playMusic = true;
			}
		});
	AddMouseMenu("On Screen Joystick", false, function menuItemSelectHandler0(e:ContextMenuEvent):void
		{
			if (contains(myOnScreenJoystickDemo))
			{
				removeChild(myOnScreenJoystickDemo);
				myOnScreenJoystickDemo.resizeListener();
			}
			else
			{
				addChild(myOnScreenJoystickDemo);
			}
		});
	AddMouseMenu("Ver0.1-Build20150124E", true);
} //end of function initMenu