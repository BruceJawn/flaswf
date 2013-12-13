import flash.ui.*;
import flash.net.*;
import com.apdevblog.utils.*;
//import flash.external.ExternalInterface;

private var myMenu:ContextMenu;

private function AddMouseMenu(Name:String, Break:Boolean = false, Listener:Function = null):void
{
	var NCMI:ContextMenuItem = new ContextMenuItem(Name, Break);
	myMenu.customItems.push(NCMI);
	if(Listener!=null)
	NCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Listener);
} //end of function

private function initMenu():void
{
	myMenu = new ContextMenu();
	myMenu.hideBuiltInItems();
	this.contextMenu = myMenu;
	
	AddMouseMenu("◇{拜访作者}", true, function menuItemSelectHandler0(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://bruce-lab.blogspot.com"), "_blank");
			URLUtils.openWindow("http://bruce-lab.blogspot.com");
		});
	
	AddMouseMenu("◆{更多游戏}", false, function menuItemSelectHandler1(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://www.mochigames.com/developer/Bruce_Jawn/"), "_blank");
			URLUtils.openWindow("http://www.mochigames.com/developer/Bruce_Jawn/");
		});
	
	AddMouseMenu("□[下载源代码]", true, function menuItemSelectHandler2(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://adf.ly/821527/flaswf.googlecode.com/svn/trunk/Games/Sanguosha/"), "_blank");
			URLUtils.openWindow("http://adf.ly/821527/flaswf.googlecode.com/svn/trunk/Games/Sanguosha/");
		});
	
	AddMouseMenu("■[更多源代码]", false, function menuItemSelectHandler3(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://adf.ly/821527/http://code.google.com/p/flaswf/"), "_blank");
			URLUtils.openWindow("http://adf.ly/821527/http://code.google.com/p/flaswf/");
			//tracex(URLUtils.getBrowserName(), 0xff0000);
			//tracex(ExternalInterface.call("function getBrowser(){return navigator.userAgent;}"), 0xff0000);
		});
	
	AddMouseMenu("〖三国杀世界总排名〗", false, menuItemSelectHandler4_0);
	
	AddMouseMenu("【Play.FLASWF.TK】", true, function menuItemSelectHandler5(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://Play.FLASWF.TK"), "_blank");
			URLUtils.openWindow("http://Play.FLASWF.TK");
		});
    AddMouseMenu("【官方网站】", true, function menuItemSelectHandler5(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://flaswf.tk/play/archive/Sanguosha.html"), "_blank");
			URLUtils.openWindow("http://flaswf.tk/play/archive/Sanguosha.html");
		});
    AddMouseMenu("Ver0.1-Build20131213D", true);
} //end of function initMenu

private function menuItemSelectHandler4_0(e:ContextMenuEvent):void
{
	submitScore(getScore_AS3());
} //end of function menuItemSelectHandler4