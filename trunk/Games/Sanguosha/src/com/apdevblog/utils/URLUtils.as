package com.apdevblog.utils
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	
	/**
	 * Collection of URL util functions.
	 *
	 * ActionScript 3.0 / Flash 9
	 *
	 * Update: 2012-01-06 By Bruce Jawn [http://bruce-lab.blogspot.com]
	 *
	 * @package    com.apdevblog.utils
	 * @author     Philipp Kyeck / phil@apdevblog.com
	 * @copyright  2008 apdevblog.com
	 * @version    SVN: $Id: URLUtils.as 17 2008-04-08 09:13:30Z phil $
	 *
	 * based on script by
	 * @author Sergey Kovalyov
	 * @see http://skovalyov.blogspot.com/2007/01/how-to-prevent-pop-up-blocking-in.html
	 *
	 * and based on script by
	 * @author Jason the Saj
	 * @see http://thesaj.wordpress.com/2008/02/12/the-nightmare-that-is-_blank-part-ii-help
	 */
	public class URLUtils
	{
		protected static const WINDOW_OPEN_FUNCTION:String = "window.open";
		
		/**
		 * Open a new browser window and prevent browser from blocking it.
		 *
		 * @param url        url to be opened
		 * @param window     window target
		 * @param features   additional features for window.open function
		 */
		public static function openWindow(url:String, window:String = "_blank", features:String = ""):void
		{
			var browserName:String = getBrowserName();
			
			if (browserName == "Firefox")
			{
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			//If IE, 
			else if (browserName == "IE")
			{
				ExternalInterface.call("function setWMWindow() {window.open('" + url + "');}");
			}
			//If Safari 
			else if (browserName == "Safari")
			{
				navigateToURL(new URLRequest(url), window);
			}
			//If Opera 
			else if (browserName == "Opera")
			{
				navigateToURL(new URLRequest(url), window);
			}
			//Otherwise, use Flash's native 'navigateToURL()' function to pop-window. 
			//This is necessary because Safari 3 no longer works with the above ExternalInterface work-a-round.
			else
			{
				navigateToURL(new URLRequest(url), window);
			}
		}
		
		/**
		 * return current browser name.
		 */
		private static function getBrowserName():String
		{
			var browser:String;
			
			//Uses external interface to reach out to browser and grab browser useragent info.
			var browserAgent:String = "";
			if (ExternalInterface.available)
			{
				browserAgent = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
			}
			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if (browserAgent != null && browserAgent.indexOf("Firefox") >= 0)
			{
				browser = "Firefox";
			}
			else if (browserAgent != null && browserAgent.indexOf("Safari") >= 0)
			{
				browser = "Safari";
			}
			else if (browserAgent == null || browserAgent.indexOf("MSIE") >= 0)
			{
				browser = "IE";
			}
			else if (browserAgent != null && browserAgent.indexOf("Opera") >= 0)
			{
				browser = "Opera";
			}
			else
			{
				browser = "Undefined";
			}
			return (browser);
		}
	}
}
