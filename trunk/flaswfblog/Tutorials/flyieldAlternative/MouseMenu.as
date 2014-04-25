import flash.ui.*;
import flash.net.*;
import flash.events.*;
import flash.system.*;
//import flash.external.ExternalInterface;

private var myMenu:ContextMenu

private function AddMouseMenu(Name:String, Break:Boolean = false, Listener:Function = null):void
{
	var NCMI:ContextMenuItem = new ContextMenuItem(Name, Break);
	myMenu.customItems.push(NCMI);
	if (Listener != null)
		NCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Listener);
} //end of function

private function initMenu():void
{
	//Security.allowDomain('*');
	myMenu = new ContextMenu();
	myMenu.hideBuiltInItems();
	this.contextMenu = myMenu;
	
	AddMouseMenu("◇{Visit Author}", true, function menuItemSelectHandler0(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://bruce-lab.blogspot.com"), "_blank");
		//URLUtils.openWindow("http://bruce-lab.blogspot.com");
		});
	
	AddMouseMenu("◆{More Games}", false, function menuItemSelectHandler1(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://www.mochigames.com/developer/Bruce_Jawn/"), "_blank");
		//URLUtils.openWindow("http://www.mochigames.com/developer/Bruce_Jawn/");
		});
	
	AddMouseMenu("■[More Code]", false, function menuItemSelectHandler3(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://adf.ly/821527/http://code.google.com/p/flaswf/"), "_blank");
		//URLUtils.openWindow("http://adf.ly/821527/http://code.google.com/p/flaswf/");
		//tracex(URLUtils.getBrowserName(), 0xff0000);
		//tracex(ExternalInterface.call("function getBrowser(){return navigator.userAgent;}"), 0xff0000);
		});
	
	AddMouseMenu("【Play.FLASWF.TK】", true, function menuItemSelectHandler5(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://Play.FLASWF.TK"), "_blank");
		//URLUtils.openWindow("http://Play.FLASWF.TK");
		});
	AddMouseMenu("Ver0.1-Build20131112A", true);
} //end of function initMenu