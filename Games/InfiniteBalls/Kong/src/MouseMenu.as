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
	AddMouseMenu("◇{Bruce's Blog}", false, function menuItemSelectHandler0(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://bruce-lab.blogspot.com/"), "_blank");
		});
	
	AddMouseMenu("◆{More Games}", false, function menuItemSelectHandler1(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://www.mochigames.com/developer/Bruce_Jawn/"), "_blank");
		});
	
	AddMouseMenu("□[Download Source Code]", true, function menuItemSelectHandler2(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://adf.ly/821527/banner/flaswf.googlecode.com/svn/trunk/Games/InfiniteBalls/"), "_blank");
		});
	
	AddMouseMenu("■[More Source Code]", false, function menuItemSelectHandler3(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://adf.ly/821527/banner/code.google.com/p/flaswf/"), "_blank");
		});
	
	AddMouseMenu("〖Submit Scores〗", true, clicksubscore);
	AddMouseMenu("〖Average Scores〗", false, clicksubascore);
	
	AddMouseMenu("【PLAY.FLASWF.TK】", true, function menuItemSelectHandler5(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://play.flaswf.tk"), "_blank");
		});
	AddMouseMenu("Ver0.1-Build20111213A", true);
} //end of function initMenu
