private var myMenu:ContextMenu = new ContextMenu();

private function AddMouseMenu(Name:String, Break:Boolean = false, Listener:Function = null):void
{
	var NCMI:ContextMenuItem = new ContextMenuItem(Name, Break);
	myMenu.customItems.push(NCMI);
	if (Listener != null)
		NCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Listener);
} //end of function

private function initMenu():void
{
	myMenu.hideBuiltInItems();
	this.contextMenu = myMenu;
	//upload saved game
	/*AddMouseMenu("☆(上传存档)", false, function menuItemSelectHandlerupload(e:ContextMenuEvent):void
	   {
	   UPLOAD();
	   });
	   //download saved game
	   AddMouseMenu("★(下载存档)", false, menuItemSelectHandlerdownload);
	 */
	AddMouseMenu("◇{拜访作者}", false, function menuItemSelectHandler0(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://hi.baidu.com/jiqing0925"), "_blank");
		});
	
	AddMouseMenu("◆{更多游戏}", false, function menuItemSelectHandler1(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://www.mochigames.com/developer/Bruce_Jawn/"), "_blank");
		});
	
	/*AddMouseMenu("□[下载源代码]", true, function menuItemSelectHandler2(e:ContextMenuEvent):void
	   {
	   DownloadSourceCode();
	   });
	
	   AddMouseMenu("■[更多源代码]", false, function menuItemSelectHandler3(e:ContextMenuEvent):void
	   {
	   navigateToURL(new URLRequest("http://code.google.com/p/flaswf/"), "_blank");
	   });
	 */
	AddMouseMenu("〖提交积分〗", true, menuItemSelectHandler4);
	AddMouseMenu("〖高分排行〗", false, ViewScore);
	
	AddMouseMenu("【越女剑¤攻略|论坛】", true, function menuItemSelectHandler5(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://flaswf.freeforums.org/forum-f36.html"), "_blank");
		});
	AddMouseMenu("Ver0.6-Build20110917B", true);
} //end of function initMenu

private function menuItemSelectHandler4(e:ContextMenuEvent):void
{
	SubmitScore(libSDL.cLib.Score_flash());
} //end of function menuItemSelectHandler4

/*
   private function DownloadSourceCode():void
   {
   new FileReference().save(new SourceCodeClass(), "ConsoleRPGFlash.zip");
   } //end of function DownloadSourceCode
   //
 */