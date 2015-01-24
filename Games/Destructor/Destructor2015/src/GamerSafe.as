package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	
	public class GamerSafe extends Sprite
	{
		
		public static const version:String = "01";
		// Singleton pattern:
		protected static var _instance:GamerSafe = null;
		
		// Private variables
		private var _status:String = "Loading";
		private var _loaded:Boolean = false;
		private var _stageWidth:Number = 550;
		private var _stageHeight:Number = 400;
		private var _inUse:Boolean = false;
		private var _tmpSkin:Object = {};
		private var _tmpAchievementSkin:Object = {};
		
		private var _levelVaultTempAttributes:Object = {};
		private var _levelVaultLastError:String = "";
		
		// GamerSafe Loader:
		private var _referrer:String = "";
		private var _loader:Loader = new Loader();
		private var _context:LoaderContext = new LoaderContext(true);
		private var _request:URLRequest = new URLRequest("http://components.gamersafe.com/GamerSafe." + version + ".swf");
		
		// Event handling functions
		private var _evt_networkingError:Function = null;
		private var _evt_accountChange:Function = null;
		private var _evt_login:Function = null;
		private var _evt_loginFailed:Function = null;
		private var _evt_autoLoginFailed:Function = null;
		private var _evt_beginSession:Function = null;
		private var _evt_beginSessionFailed:Function = null;
		private var _evt_itemPurchase:Function = null;
		private var _evt_itemPurchaseCanceled:Function = null;
		private var _evt_itemPurchaseFailed:Function = null;
		private var _evt_apiReady:Function = null;
		private var _evt_confYes:Function = null;
		private var _evt_confNo:Function = null;
		private var _evt_useStarted:Function = null;
		private var _evt_useEnded:Function = null;
		private var _evt_useChanged:Function = null;
		private var _evt_onScoreboardError:Function = null;
		private var _evt_onScoreboardRecieved:Function = null;
		private var _evt_onScoreSubmitted:Function = null;
		private var _evt_onUnregisteredName:Function = null;
		private var _evt_onConsumptionCompleted:Function = null;
		private var _evt_onRegistrationFormClosed:Function = null;
		private var _evt_onLoginFormClosed:Function = null;
		private var _evt_onOtherGameProfileReceived:Function = null;
		private var _evt_onBridgeSuccess:Function = null;
		private var _evt_onBridgeError:Function = null;
		private var _evt_onPaymentPanelShown:Function = null;
		private var _evt_onPaymentPanelHidden:Function = null;
		private var _evt_onStatusBarMouseOver:Function = null;
		private var _evt_onStatusBarMouseOut:Function = null;
		
		// Level Vault Events:
		private var _evt_onLevelVaultGotLevel:Function = null;
		private var _evt_onLevelVaultGotLevels:Function = null;
		private var _evt_onLevelVaultGotIndex:Function = null;
		private var _evt_onLevelVaultGotNumLevels:Function = null;
		private var _evt_onLevelVaultGotLevelRanking:Function = null;
		private var _evt_onLevelVaultLevelAttributesChanged:Function = null;
		private var _evt_onLevelVaultLevelCreated:Function = null;
		private var _evt_onLevelVaultLevelEdited:Function = null;
		private var _evt_onLevelVaultLevelDeleted:Function = null;
		private var _evt_onLevelVaultLevelFlagged:Function = null;
		private var _evt_onLevelVaultLevelRated:Function = null;
		private var _evt_onLevelVaultLevelNumericsIncremented:Function = null;
		private var _evt_onLevelVaultLevelNumericsSet:Function = null;
		private var _evt_onLevelVaultLevelStringsSet:Function = null;
		
		// Facebook Events:
		private var _evt_onFacebookConnected:Function = null;
		private var _evt_onFacebookGotFriends:Function = null;
		private var _evt_onFacebookGotLocalUser:Function = null;
		private var _evt_onFacebookLoginFailed:Function = null;
		private var _evt_onFacebookWallPostSuccess:Function = null;
		private var _evt_onFacebookWallPostFailed:Function = null;
		private var _evt_onFacebookPromptClosed:Function = null;
		
		// Twitter Events:
		private var _evt_onTwitterConnected:Function = null;
		private var _evt_onTwitterLoginFailed:Function = null;
		private var _evt_onTwitterGotUser:Function = null;
		private var _evt_onTwitterPostSuccess:Function = null;
		private var _evt_onTwitterPostFailed:Function = null;
		private var _evt_onTwitterPromptClosed:Function = null;
		
		// Event types:
		public static const EVT_NETWORKING_ERROR:String = 			"networking_error";
		public static const EVT_ACCOUNT_CHANGE:String = 			"account_change";
		public static const EVT_LOGIN:String = 						"login";
		public static const EVT_LOGIN_FAILED:String = 				"login_failed";
		public static const EVT_AUTO_LOGIN_FAILED:String =			"auto_login_failed"; 			
		public static const EVT_BEGIN_SESSION:String = 				"begin_session";
		public static const EVT_BEGIN_SESSION_FAILED:String =		"begin_session_failed";
		public static const EVT_ITEM_PURCHASE:String = 				"item_purchase";
		public static const EVT_ITEM_PURCHASE_CANCELED:String = 	"item_purchase_canceled";
		public static const EVT_ITEM_PURCHASE_FAILED:String =		"item_purchase_failed";
		public static const EVT_SCOREBOARD_ENTRIES_RECEIVED:String ="scoreboard_entries_received";
		public static const EVT_SCOREBOARD_ENTRIES_ERROR:String =	"scoreboard_entries_error";
		public static const EVT_SCOREBOARD_ENTRY_SUBMITTED:String =	"scoreboard_entry_submitted";
		public static const EVT_OTHER_GAME_PROFILE_RECEIVED:String ="other_game_profile_received";
		public static const EVT_UNREGISTERED_NAME:String = 			"unregistered_name";
		public static const EVT_CONSUMPTION_COMPLETED:String =      "consumption_completed";
		public static const EVT_REGISTRATION_FORM_CLOSED:String =   "register_close";
		public static const EVT_LOGIN_FORM_CLOSED:String =   		"login_close";
		public static const EVT_BRIDGE_SUCCESS:String = 			"bridge_success";
		public static const EVT_BRIDGE_ERROR:String = 				"bridge_error";		
		public static const EVT_PAYMENT_PANEL_SHOWN:String = 		"payment_panel_shown";
		public static const EVT_PAYMENT_PANEL_HIDDEN:String = 		"payment_panel_hidden";
		public static const EVT_USERNAME_FETCHED:String =			"username_fetched";
		public static const EVT_AVATAR_FETCHED:String =				"avatar_fetched";
		public static const EVT_INUSE_STARTED:String = 				"inUseStarted";
		public static const EVT_INUSE_ENDED:String = 				"inUseEnded";
		public static const EVT_INUSE_CHANGED:String = 				"inUseChanged";
		public static const EVT_STATUSBAR_MOUSEOVER:String = 		"statusbar_mouseover";
		public static const EVT_STATUSBAR_MOUSEOUT:String = 		"statusbar_mouseout";
		
		// Objects
		private var _gamerSafe:Object = null;
		private var _stage:Stage;
		
		// Level Vault API Events:
		public static const EVT_LEVELVAULT_LEVEL_CREATED:String = 				"level_created";
		public static const EVT_LEVELVAULT_LEVEL_EDITED:String = 				"level_edited";
		public static const EVT_LEVELVAULT_LEVEL_NUMERICS_SET:String = 			"level_numerics_set";
		public static const EVT_LEVELVAULT_LEVEL_STRINGS_SET:String = 			"level_strings_set";
		public static const EVT_LEVELVAULT_LEVEL_RATED:String = 				"level_rated";
		public static const EVT_LEVELVAULT_LEVEL_NUMERICS_INCREMENTED:String = 	"level_numerics_incremented";
		public static const EVT_LEVELVAULT_LEVEL_FLAGGED:String = 				"level_flagged";
		public static const EVT_LEVELVAULT_LEVEL_DELETED:String = 				"level_deleted";
		public static const EVT_LEVELVAULT_GOT_SINGLE_LEVEL:String = 			"got_level";
		public static const EVT_LEVELVAULT_GOT_LEVELS:String = 					"got_levels";
		public static const EVT_LEVELVAULT_GOT_NUM_LEVELS:String = 				"got_num_levels";
		public static const EVT_LEVELVAULT_GOT_LEVEL_RANKING:String = 			"got_level_ranking";
		public static const EVT_LEVELVAULT_GOT_INDEX:String = 					"got_index";
		
		// Facebook API Events:
		public static const EVT_FACEBOOK_CONNECTED:String = 					"fb_connected";
		public static const EVT_FACEBOOK_LOGIN_FAILED:String = 					"fb_login_failed";
		public static const EVT_FACEBOOK_GOT_USER:String = 						"fb_got_user";
		public static const EVT_FACEBOOK_GOT_FRIENDS:String = 					"fb_got_friends";
		public static const EVT_FACEBOOK_WALL_POST_SUCCESS:String = 			"fb_wallpost_success";
		public static const EVT_FACEBOOK_WALL_POST_FAILED:String = 				"fb_wallpost_fail";
		public static const EVT_FACEBOOK_PROMPT_CLOSED:String = 				"fb_prompt_closed";
		
		// Twitter API Events:
		public static const EVT_TWITTER_CONNECTED:String 			= "twit_connected";
		public static const EVT_TWITTER_LOGIN_FAILED:String 		= "twit_login_failed";
		public static const EVT_TWITTER_GOT_USER:String 			= "twit_got_user";
		public static const EVT_TWITTER_POST_SUCCESS:String 		= "twit_post_success";
		public static const EVT_TWITTER_POST_FAILED:String  		= "twit_post_fail";
		
		
		public function get applicationDomain():ApplicationDomain {
			return _loader.contentLoaderInfo.applicationDomain;
		}
		
		
		public function get loaded():Boolean {
			return _loaded;
		}
		
		
		public function get status():String {
			return _status;
		}
		
		private function get sprite():Sprite {
			if(_loaded == false) return null;
			return _gamerSafe.sprite;
		}
		
		
		public function get inSession():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.inSession;
		}
		
		
		public function get failed():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.failed;
		}
		
		
		public function get loggedIn():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.loggedIn;
		}
		
		
		public function get username():String {
			if(_loaded == false) return "GamerSafe";
			return _gamerSafe.username;
		}
		
		
		public function get account():Object {
			if(_loaded == false) return null;
			return _gamerSafe.account;
		}
		
		
		public function get gamerGold():uint {
			if(_loaded == false) return 0;
			return _gamerSafe.gamerGold;
		}
		
		
		public function get gamerPoints():uint {
			if(_loaded == false) return 0;
			return _gamerSafe.gamerPoints;
		}
		
		
		public function get gamerXP():uint {
			if(_loaded == false) return 0;
			return _gamerSafe.gamerXP;
		}
		
		
		public function get gamerTestMode():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.gamerTestMode;
		}
		
		
		public function get autoLogin():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.autoLogin;
		}
		
		public function set autoLogin(value:Boolean):void {
			if(_loaded == false) return;
			_gamerSafe.autoLogin = value;
		}
				
		
		public function get unregisteredName():String {
			if(_loaded == false) return "";
			return _gamerSafe.unregisteredName;
		}
		
		private function beginSession(gamePasscode:String, gameHashseed:String):Boolean {
			if(_loaded == false){
				return false;
			}
			_gamerSafe.beginSession(gamePasscode, gameHashseed, _referrer);
			return true;
		}
		
		
		public function bestowAchievement(achievementId:uint):Boolean {
			if(_loaded == false) return false;
			_gamerSafe.bestowAchievement(achievementId);
			return true;
		}
	
		
		public function bestowFreeItem(itemID:int):Boolean {
			if(_loaded == false) return false;
			_gamerSafe.bestowFreeItem(itemID);
			return true;
		}

		
		public function purchaseItem(itemID:int, priceID:int = 0):Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.purchaseItem(itemID, priceID);
		}
		
		
		public function flashBar():void {
			if(_loaded == false) return;
			_gamerSafe.flashBar();
		}
		
		
		public function showAchievements(configuration:Object = null):void {
			if(_loaded == false) return;
			_gamerSafe.showAchievements(configuration);
		}

		
		
		public function set achievementPopupPosition(point:Point):void {
			if(_loaded == false) return;
			_gamerSafe.achievementPopupPosition = point;
		}

		public function get achievementPopupPosition():Point {
			if(_loaded == false) return new Point(0, 0);
			return _gamerSafe.achievementPopupPosition;
		}
		
		
		
		public function showLogin(configuration:Object = null):void {
			if(_loaded == false) return;
			_gamerSafe.showLogin(configuration);
		}
		
		
		public function login(username:String, password:String, rememberMe:Boolean = false):void {
			if(_loaded == false) return;
			_gamerSafe.login(username, password, rememberMe);
		}
		
		
		public function showRegistrationForm():void {
			if(_loaded == false) return;
			_gamerSafe.showRegistrationForm();
		}

				
		public function logout():void {
			if(_loaded == false) return;
			_gamerSafe.logout();
		}		
		
		
		public function showShop(configuration:Object = null):void {
			if(_loaded == false) return;
			_gamerSafe.showShop(configuration);
		}
		
		
		
		public function hideShopButton(disable:Boolean = true):void {
			if(_loaded == false) return;
			_gamerSafe.hideShopButton(disable);
		}
		
		
		
		public function closeShop():void {
			if(_loaded == false) return;
			_gamerSafe.closeShop();
		}
		
		
		public function setShopCategoryVisible(category:int, visible:Boolean):void {
			if(_loaded == false) return;
			_gamerSafe.setShopCategoryVisible(category, visible);
		}
		
		
		public function showPopup(text:String, configuration:Object = null):void {
			if(_loaded == false) return;
			_gamerSafe.showPopup(text, configuration);
		}
		
		
		public function showStatusBar(configuration:Object = null):void {
			if(_loaded == false) return;
			_gamerSafe.showStatusBar(configuration);
		}
		
		
		public function hideStatusBar():void {
			if(_loaded == false) return;
			_gamerSafe.hideStatusBar();
		}
				
		
		public function tryAutoLogin():void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.tryAutoLogin();
		}
		
		
		public function set savedGame(save:String):void {
			if(_loaded == false) return;
			_gamerSafe.savedGame = save;
		}
		
		
		public function get savedGame():String {
			if(_loaded == false) return "";
			if(_gamerSafe.savedGame == null) return "";
			return _gamerSafe.savedGame;
		}
		
		
		public function getSavedGame(idx:int = 0):String {
			if(_loaded == false) return null;
			return _gamerSafe.getSavedGame(idx);
		}
		
		

		public function setSavedGame(save:String, idx:int = 0):void {
			if(_loaded == false) return;
			_gamerSafe.setSavedGame(save, idx);
		}
		
		
		public function hasAchievement(achievementId:int):Boolean {
			if(_loaded == false) return false;
			if(inSession == false) return false;
			return _gamerSafe.hasAchievement(achievementId);
		}
		
		
		public function hasItem(itemId:int):Boolean {
			if(_loaded == false) return false;
			if(inSession == false) return false;
			return _gamerSafe.hasItem(itemId);
		}
		
		
		public function get highScore():Number {
			if(_loaded == false) return 0;
			if(inSession == false) return 0;
			return _gamerSafe.highScore;
		}
		
		
		public function set highScore(value:Number):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.highScore = value;
		}
		
		
		public function get countryCode():String {
			if(_loaded == false) return "";
			if(inSession == false) return "";
			return _gamerSafe.countryCode;
		}
		
		
		public function get startingTime():Date {
			if(_loaded == false) return null;
			if(inSession == false) return null;
			return _gamerSafe.startingTime;
		}
				
		
		public function get achievements():Array {
			if(_loaded == false) return [];
			if(inSession == false) return [];
			return _gamerSafe.achievementList;
		}
		
		
		public function get items():Array {
			if(_loaded == false) return [];
			if(inSession == false) return [];
			return _gamerSafe.itemList;
		}
		
		
		public function getItemById(item_id:int):Object {
			if(_loaded == false) return null;
			if(inSession == false) return null;
			var _items:Array = items;
			for each(var i:Object in _items){
				if(i.id == item_id){
					return i;
				}
			}
			return null;
		}

				
		public function get iconUrl():String {
			if(_loaded == false) return "";
			return _gamerSafe.iconUrl;
		}
		
		
		public function get signupUrl():String {
			if(_loaded == false) return "";
			return _gamerSafe.signupUrl;
		}		
		
		
		public function get paymentUrl():String {
			if(_loaded == false) return "";
			return _gamerSafe.paymentUrl;
		}		
		
		
		public function get FAQUrl():String {
			if(_loaded == false) return "";
			return _gamerSafe.FAQUrl;
		}		
		
		
		public function get wantsNewsletter():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.wantsNewsletter;
		}
		
		public function set wantsNewsletter(wants:Boolean):void {
			if(_loaded == true) _gamerSafe.wantsNewsletter = wants;
		} 
				
		
		public function get isGamerGoldPurchaseDisabled():Boolean {
			if(_loaded == false) return true;
			return _gamerSafe.isGamerGoldPurchaseDisabled;
		}

				
		
		public function showMessageBox(title:String, text:String, isConfirm:Boolean = true):void {
			if(_loaded == false) return;
			_gamerSafe.messageBox(title, text, isConfirm);
		}
		
		
		public function get inUse():Boolean {
			return _inUse;
		}
		
		
		public function get latestItemPurchaseInfo():Object {
			if (_loaded == false) return null;
			return _gamerSafe.getLatestItemPurchaseInfo(); 
		} 
		
		
		public function get latestItemConsumptionInfo():Object {
			if (_loaded == false) return null;
			return _gamerSafe.getLatestItemConsumptionInfo(); 
		}	
		
		
		public function get latestOtherGameProfile():Object {
			if (_loaded == false) return null;
			return _gamerSafe.getLatestOtherGameProfile();
		}
		
		
		public function showScoreboard(scoreboardId:int = -1):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.showScoreboard(scoreboardId);
		}
		
		
		public function showFriendsScoreboard(scoreboardId:int = -1):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.showFriendsScoreboard(scoreboardId);
		}
		
				
		public function showSmallScoreboard(scoreboardId:int = -1):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.showSmallScoreboard(scoreboardId);			
		}
		
		
		public function closeScoreboard():void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.closeScoreboard();	
		}
		
		
		public function saveToScoreboard(score:Number, extra:String, scoreboardID:int = -1, unregistered_name:String = ""):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.saveToScoreboard(score, extra, scoreboardID, unregistered_name);
		}
		
		
		public function showScoreSubmit(score:Number, extra:String, showAsTime:Boolean = false, scoreboardID:int = -1):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.showScoreSubmitPrompt(score, extra, scoreboardID, showAsTime);
		}

		
		public function showSmallScoreSubmit(score:Number, extra:String, showAsTime:Boolean = false, scoreboardID:int = -1):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.showSmallScoreSubmitPrompt(score, extra, scoreboardID, showAsTime);
		}
		
		
		public function requestScoreboardEntries(scoreboardID:int = -1):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.requestScoreboardEntries(scoreboardID);
		}
		
		
		public function get latestScoreboardEntries():Object {
		   if(_loaded == false) return null;
    		return _gamerSafe.getLatestScoreboardEntries();
		}

		
		
		public function purchaseItemInterface(itemId:int, priceID:int = 0):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.purchaseItemInterface(itemId, priceID);
		}
		
		
		public function closeItemInterface():void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.closeItemInterface();
		}
		
		
		public function setStyle(name:String, value:*):void {
			if(_loaded == false){
				_tmpSkin[name] = value;
				return;
			}
			var o:Object = new Object();
			o[name] = value;
			_gamerSafe.setSkin(o);
		}
		
		
		
		public function getSkin():Object {
			if(_loaded == false) return null;
			return _gamerSafe.getSkin();
		}
		
		
		public function setAchievementStyle(name:String, value:*):void {
			if(_loaded == false){
				_tmpAchievementSkin[name] = value;
				return;
			}	
			var o:Object = new Object();
			o[name] = value;
			_gamerSafe.setAchievementSkin(o);
		}
		
		
		public function getAchievementSkin():Object {
			if(_loaded == false) return null; 
			return _gamerSafe.getAchievementSkin();
		}
		
		
		public function requestUnregisteredName():void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.requestUnregisteredUserName();
		}
		
		// 5th November 2009:
		
		
		public function set partner(partner:String):void {
			if(_loaded == false) return;
			_gamerSafe.setPartner(partner);
		}
		
		// Consumables:
		
		public function getConsumptionsAvailable(itemId:int):int {
			if(_loaded == false) return 0;
			if(inSession == false) return 0;
			return _gamerSafe.getConsumptionsAvailable(itemId);
		}

				
		public function consumeItem(itemId:int, numToConsume:int):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.consumeItem(itemId, numToConsume);
		}

				
		public function requestOtherGameProfile(otherGamePasscode:String):void {
			if(_loaded == false) return;
			if(inSession == false) return;
			_gamerSafe.requestOtherGameProfile(otherGamePasscode);
		}
		
		
		public function hideInterface():void {
			if(_loaded == false) return;
			_gamerSafe.visible = false;
		}
		
		
		public function showInterface():void {
			if(_loaded == false) return;
			_gamerSafe.visible = true;
		}
		
		
		
		public function setRegistrationDefaults(defaults:Object):void {
			if(_loaded == false) return;
			_gamerSafe.setRegisterDefaults(defaults);
		}
		
		
		
		public function get userAuthKey():String {
			if(_loaded == false) return null;
			return _gamerSafe.userAuthKey;
		}
		
		
		
		public function get gameAuthCode():String {
			if(_loaded == false) return null;
			return _gamerSafe.gameAuthCode;			
		}
		
		// ---------------------------
		// Facebook:
		// ---------------------------
		
		
		
		public function facebookConnect(requireLogin:Boolean = false):void {
			if(_loaded == false) return;
			_gamerSafe.facebookConnect(requireLogin);
		}

		
		
		public function get facebookLoggedIn():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.facebookLoggedIn;
		}
		
		
		public function get facebookFriends():Array {
			if(_loaded == false) return [];
			return _gamerSafe.facebookFriends;
		}
		
		
		public function get facebookLocalUser():Object {
			if(_loaded == false) return {};
			return _gamerSafe.facebookLocalUser;
		}
		
		
		
		public function get facebookLocalUserId():int{
			if(_loaded == false) return 0;
			return _gamerSafe.facebookLocalUserId;
		}
		
		
		public function facebookWallPost(text:String, target:String = "me"):void {
			if(_loaded == false) return;
			_gamerSafe.facebookWallPost(text, target);
		}
		
		
		public function facebookConfigureAttachment(name:String, caption:String = null, 
				description:String = null, link:String = null, picture:String = null):void {
			if(_loaded == false) return;
			_gamerSafe.facebookConfigureAttachment(name, caption, description, link, picture);
		}
		
		
		
		public function facebookGetPicture(uid:String = "me"):URLRequest {
			if(_loaded == false) return null;
			return _gamerSafe.facebookGetPicture(uid);
		}
		
		
		
		public function showFriendsList(x:int, y:int, width:int = 400, height:int = 350):void {
			if(_loaded == false) return;
			_gamerSafe.facebookShowFriendsList(x, y, width, height);
		}
		
		
		
		public function hideFriendsList():void {
			if(_loaded == false) return;
			_gamerSafe.facebookHideFriendsList();
		}

		
		
		public function showPublisher(x:int, y:int, uids:Array = null, width:int = 400, height:int = 350):void {
			if(_loaded == false) return;
			if(uids != null)
				_gamerSafe.facebookShowPublisher(uids, x, y, width, height);
			else
			{
			   var me:Array = [{id:"me"}];
				_gamerSafe.facebookShowPublisher(me, x, y, width, height);
			}
		}
		
		

		public function hidePublisher():void {
			if(_loaded == false) return;
			_gamerSafe.facebookHidePublisher();
		}

		

		public function showFriendsPanel(width:int = 400, height:int = 350):void {
			if(_loaded == false) return;
			_gamerSafe.facebookShowFriendsPanel(width, height);
		}
		
		

		public function showPublisherPanel(uids:Array = null, width:int = 400, height:int = 350):void {
			if(_loaded == false) return;
			if(uids != null)
				_gamerSafe.facebookShowPublisherPanel(uids, width, height);
			else
			{
				var me:Array = [{id:"me"}];
				_gamerSafe.facebookShowPublisherPanel(me, width, height);
			}
		}
		// ---------------------------
		// Twitter:
		// ---------------------------
		
		
		
		public function twitterConnect():void {
			if(_loaded == false) return;
			_gamerSafe.twitterConnect();
		}

		
		
		public function get twitterLoggedIn():Boolean {
			if(_loaded == false) return false;
			return _gamerSafe.twitterLoggedIn;
		}
				
		
		
		public function get twitterUser():XML {
			if(_loaded == false) return null;
			return _gamerSafe.twitterUser;
		}
		
		
		public function twitterPost(text:String, useUrl:Boolean = false):void {
			if(_loaded == false) return;
			_gamerSafe.twitterPost(text, useUrl);
		}
		
		
		public function twitterConfigure(hashtag:String, url:String):void {
			if(_loaded == false) return;
			_gamerSafe.twitterConfigure(hashtag, url);
		}
		
		
		
		public function showTwitterPublisher(x:int, y:int, width:int = 400, height:int = 230):void {
			if(_loaded == false) return;
			_gamerSafe.twitterShowPublisher(x, y, width, height);
		}
		
		

		public function hideTwitterPublisher():void {
			if(_loaded == false) return;
			_gamerSafe.twitterHidePublisher();
		}
		
		

		public function showTwitterPublisherPanel(width:int = 400, height:int = 350):void {
			if(_loaded == false) return;
			_gamerSafe.twitterShowPublisherPanel(width, height);
		}
		
		
		
		public function fetchUsernames(uids:Array = null):Array {
			if(_loaded == false) return null;
			return _gamerSafe.fetchUsernames(uids);
		}
		
		
		
		public function getUsername(uid:uint):String {
			if(_loaded == false) return null;
			return _gamerSafe.getUsername(uid);
		}
			
		
		
		public function fetchAvatars(uids:Array = null):Array {
			if(_loaded == false) return null;
			return _gamerSafe.fetchAvatars(uids);
		}
		
		
		
		public function getAvatar(uid:uint):String {
			if(_loaded == false) return null;
			return _gamerSafe.getAvatar(uid);
		}
		
		
		public function configureView(config:Object):void {
			if(_loaded == false) return;
				_gamerSafe.configureView(config);
		}
			
		// ---------------------------
		// Level Vault:
		// ---------------------------
		
		
		protected function levelVaultFail(reason:String, returnValue:* = false):* {
			trace("[ LevelVault Error:", reason, "]");
			_levelVaultLastError = reason;
			return returnValue;
		}
		
		
		public function get levelVaultLastError():String {
			return _levelVaultLastError;
		}
		
		
		public function get levelVaultReady():Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultReady;
		}
		
		
		private function get levelVaultEventObject():EventDispatcher {
			if(_loaded == false) return levelVaultFail("API not yet loaded", null);
			return _gamerSafe.levelVaultEventObject;
		}
		
		// --- Create Level --- //
		
		
		public function levelVaultCreateLevel(levelData:*):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			//if(loggedIn == false) return levelVaultFail("You must be logged in to create levels");
			if(levelData is ByteArray){
				return levelVaultCreateLevelFromBytes(levelData);
			}else{
				return levelVaultCreateLevelFromObject(levelData);
			}
		}
		
		
		public function levelVaultCreateLevelFromBytes(levelData:ByteArray):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultCreateLevel(levelData);
		}
		
		
		public function levelVaultCreateLevelFromObject(level:Object):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultCreateLevelFromObject(level);
		}
		
		
		public function levelVaultCreateLevelWithAttributes(levelData:*, attributes:Object):Boolean {
			if(levelVaultCreateLevel(levelData)){
				_levelVaultTempAttributes = attributes;
				addEventListener(GamerSafe.EVT_LEVELVAULT_LEVEL_CREATED, levelVaultSetTempAttributes);
				return true;
			}
			return levelVaultFail(_levelVaultLastError);
		}
		
		private function levelVaultSetTempAttributes(e:Event):void {
			removeEventListener(GamerSafe.EVT_LEVELVAULT_LEVEL_CREATED, levelVaultSetTempAttributes);
			levelVaultSetAttributes(levelVaultLastCreatedLevelID, _levelVaultTempAttributes);
			_levelVaultTempAttributes = {};
		}
		
		
		
		public function get levelVaultLastCreatedLevelID():uint {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLastCreatedLevelID();
		}
		
		// --- Edit Level Stuff --- //
		
		
		
		public function levelVaultEditLevel(levelOrLevelId:*, levelData:ByteArray):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			//if(loggedIn == false) return levelVaultFail("You must be logged in to edit levels");
			return _gamerSafe.levelVaultEditLevel(levelOrLevelId, levelData);
		}
		
		public function get levelVaultLastEditedLevelID():uint {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLastEditedLevelID();
		}
		
		// --- //
		
		public function levelVaultGetLastSelectedLevel():Object {
			if(_loaded == false) return levelVaultFail("API not yet loaded", null);
			return _gamerSafe.levelVaultGetLastSelectedLevel();
		}
		
		public function levelVaultGetNumLevels():uint {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetNumLevels();
		}
		
		public function levelVaultGetLastNumLevels():int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLastNumLevels();
		}
		
		public function levelVaultGetLastSelectedLevels():Array {
			if(_loaded == false) return levelVaultFail("API not yet loaded", []);
			return _gamerSafe.levelVaultGetLastSelectedLevels();
		}
		
		public function levelVaultGetLastIndex():Array {
			if(_loaded == false) return levelVaultFail("API not yet loaded", []);
			return _gamerSafe.levelVaultGetLastIndex();			
		}
		
		public function levelVaultGetLastRanking():int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", -1);
			return _gamerSafe.levelVaultGetLastRanking();
		}
		
		public function levelVaultGetLevelAttributes(level:Object = null):Array {
			if(_loaded == false) return levelVaultFail("API not yet loaded", []);
			return _gamerSafe.levelVaultGetLevelAttributes(level);
		}
		
		public function levelVaultGetLevelData(level:Object = null):ByteArray {
			if(_loaded == false) return levelVaultFail("API not yet loaded", null);
			return _gamerSafe.levelVaultGetLevelData(level);
		}
		
		public function levelVaultGetLevelID(level:Object = null):uint {
			if(_loaded == false) return levelVaultFail("API not yet loaded", null);
			return _gamerSafe.levelVaultGetLevelID(level);
		}
		
		public function levelVaultGetLevelRating(level:Object = null):Number {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelRating(level);
		}
		
		public function levelVaultGetLevelNumRatings(level:Object = null):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelNumRatings(level);
		}
		
		public function levelVaultSetNumericAttribute(levelOrLevelId:*, key:String, value:Number):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultSetNumericAttribute(levelOrLevelId, key, value);
		}
		
		public function levelVaultSetNumericAttributes(levelOrLevelId:*, keys:Array, data:Array):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultSetNumericAttributes(levelOrLevelId, keys, data);
		}
		
		public function levelVaultSetExpiringNumericAttribute(levelOrLevelId:*, key:String, value:Number, expires:String):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return levelVaultSetExpiringNumericAttributes(levelOrLevelId, [key], [value], [expires]);
		}
		
		public function levelVaultSetExpiringNumericAttributes(levelOrLevelId:*, keys:Array, data:Array, expires:Array):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultSetExpiringNumericAttributes(levelOrLevelId, keys, data, expires);
		}
		
		public function levelVaultSetStringAttribute(levelOrLevelId:*, key:String, value:String):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultSetStringAttribute(levelOrLevelId, key, value);
		}
		
		public function levelVaultSetStringAttributes(levelOrLevelId:*, keys:Array, data:Array):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultSetStringAttributes(levelOrLevelId, keys, data);
		}
		
		public function levelVaultSetExpiringStringAttribute(levelOrLevelId:*, key:String, value:String, expires:String):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return levelVaultSetExpiringStringAttributes(levelOrLevelId, [key], [value], [expires]);
		}
		
		public function levelVaultSetExpiringStringAttributes(levelOrLevelId:*, keys:Array, data:Array, expires:Array):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultSetExpiringStringAttributes(levelOrLevelId, keys, data, expires);
		}
		
		public function levelVaultIncrementNumeric(levelOrLevelId:*, key:String):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultIncrementNumeric(levelOrLevelId, key);
		}
		
		public function levelVaultIncrementNumerics(levelOrLevelId:*, keys:Array):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultIncrementNumerics(levelOrLevelId, keys);
		}
		
		public function levelVaultFlagLevel(levelOrLevelId:*):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultFlagLevel(levelOrLevelId);
		}
		
		public function levelVaultRateLevel(levelOrLevelId:*, rating:uint):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultRateLevel(levelOrLevelId, rating);
		}
		
		public function levelVaultDeleteLevel(levelOrLevelId:*):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultDeleteLevel(levelOrLevelId);
		}
		
		public function levelVaultSetAttributes(levelOrLevelId:*, attributes:Object):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultSetAttributes(levelOrLevelId, attributes);
		}
		
		
		public function levelVaultGetLevelAsObject(level:Object = null):Object {
			if(_loaded == false) return levelVaultFail("API not yet loaded", null);
			return _gamerSafe.levelVaultGetLevelAsObject(level);
		}
		
		
		public function levelVaultGetLevelAsCustomObject(type:Class, level:Object = null):* {
			if(_loaded == false) return levelVaultFail("API not yet loaded", null);
			return _gamerSafe.levelVaultGetLevelAsCustomObject(type, level);
		}
		
		public function levelVaultGetLevelRanking(levelId:int, attribute:String, ascending:Boolean = false):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultGetLevelRanking(levelId, attribute, ascending);
		}
		
		public function levelVaultGetAttributeRanking(value:int, attribute:String, ascending:Boolean = false):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultGetAttributeRanking(value, attribute, ascending);					
		}
		
		// Level Fetchers:
		
		public function levelVaultFetchLevelByID(levelId:int):Boolean {
			if(_loaded == false) return levelVaultFail("API not yet loaded");
			return _gamerSafe.levelVaultFetchLevelByID(levelId);
		}
		
		public function levelVaultGetLevelsByDateCreated(start_date:String, end_date:String, ascending:Boolean = true, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsByDateCreated(start_date, end_date, ascending, limit, offset);
		}
		
		public function levelVaultGetLevelsByDateModified(start_date:String, end_date:String, ascending:Boolean = true, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsByDateModified(start_date, end_date, ascending, limit, offset);
		}
		
		public function levelVaultGetLevelsByRating(min_rating:Number, max_rating:Number, ascending:Boolean = true, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsByRating(min_rating, max_rating, ascending, limit, offset);
		}
		
		public function levelVaultGetAllLevels(ascending:Boolean = true, limit:uint = 20, offset:uint = 0):int {
			return levelVaultGetLevelsByRating(0, 10, ascending, limit, offset);
		}
		
		public function levelVaultGetLevelsRandom(count:uint):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsRandom(count);			
		}

		public function levelVaultGetLevelsByNumericData(key:String, min:Number, max:Number, ascending:Boolean = true, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsByNumericData(key, min, max, ascending, limit, offset);
		}
		
		public function levelVaultGetLevelsByStringData(key:String, value:String, ascending:Boolean = true, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsByStringData(key, value, ascending, limit, offset);
		}

		public function levelVaultGetLevelsLike(key:String, value:String, ascending:Boolean = true, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsLike(key, value, ascending, limit, offset);
		}

		public function levelVaultGetLevelsAdvanced(attributes:Array, order:Array, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetLevelsAdvanced(attributes, order, limit, offset);
		}
		
		public function levelVaultGetIndexAdvanced(attributes:Array, order:Array, limit:uint = 20, offset:uint = 0):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetIndexAdvanced(attributes, order, limit, offset);
		}

		public function levelVaultGetNumLevelsAdvanced(attributes:Array):int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultGetNumLevelsAdvanced(attributes);
		}
		
		public function get levelVaultLastSelectedLevelsReceipt():int {
			if(_loaded == false) return levelVaultFail("API not yet loaded", 0);
			return _gamerSafe.levelVaultLastSelectedLevelsReceipt;
		}
		
    	public function get levelVaultShareCookie():String {
            if(_loaded == false) return levelVaultFail("API not yet loaded", null);
            return _gamerSafe.levelVaultShareCookie;
        }
        
        
        
        public function levelVaultSwitchGame(passcode:String = ""):Boolean {
            if(_loaded == false) return levelVaultFail("API not yet loaded", null);
            return _gamerSafe.levelVaultSwitchGame(passcode);        	
        }
       
        // --- Concurrency and error reporting --- //
        public function levelVaultRegisterCallback(callback:Function, ...args):void {
        	if(_gamerSafe == null)
        	{        	
        		trace("GamerSafe is not ready to register the LV Callback! Please wait for BeginSession.");
        		return;
        	}
            var a:Array = [];
            a.push(callback);
            for each(var i:* in args) a.push(i);
            (_gamerSafe.levelVaultRegisterCallback as Function).apply(this, a);
        }
       
        public function levelVaultRegisterErrorCallback(callback:Function, ...args):void {
        	if(_gamerSafe == null)
        	{        	
        		trace("GamerSafe is not ready to register the Error Callback! Please wait for BeginSession.");
        		return;
        	}
            var a:Array = [];
            a.push(callback);
            for each(var i:* in args) a.push(i);
            (_gamerSafe.levelVaultRegisterErrorCallback as Function).apply(this, a);
        }
       
        public function levelVaultRegisterPersistentErrorCallback(callback:Function, ...args):void {
        	if(_gamerSafe == null)
        	{        	
        		trace("GamerSafe is not ready to register the Persistent Error Callback! Please wait for BeginSession.");
        		return;
        	}
            var a:Array = [];
            a.push(callback);
            for each(var i:* in args) a.push(i);
            (_gamerSafe.levelVaultRegisterPersistentErrorCallback as Function).apply(this, a);
        }		
        
		// Event handling..
		
		public function set onNetworkingError(func:Function):void { _evt_networkingError = func; }
		public function get onNetworkingError():Function {return _evt_networkingError;}
		private function e_onNetworkingError(e:Event):void {
			if(_evt_networkingError != null) _evt_networkingError();
			dispatchEvent(e);
		}
		
		public function set onAccountChange(func:Function):void  {_evt_accountChange = func;}
		public function get onAccountChange():Function {return _evt_accountChange;}
		private function e_onAccountChange(e:Event):void {
			if(_evt_accountChange != null) _evt_accountChange();
			dispatchEvent(e);
		}
		
		public function set onLogin(func:Function):void  {_evt_login = func;}
		public function get onLogin():Function {return _evt_login;}
		private function e_onLogin(e:Event):void {
			if(_evt_login != null) _evt_login();
			flashBar();
			dispatchEvent(e);
		}
		
		public function set onLoginFailed(func:Function):void  {_evt_loginFailed = func;}
		public function get onLoginFailed():Function {return _evt_loginFailed;}
		private function e_onLoginFailed(e:Event):void {
			if(_evt_loginFailed != null) _evt_loginFailed();
			dispatchEvent(e);
		}

		public function set onAutoLoginFailed(func:Function):void  {_evt_autoLoginFailed = func;}
		public function get onAutoLoginFailed():Function {return _evt_autoLoginFailed;}
		private function e_onAutoLoginFailed(e:Event):void {
			if(_evt_autoLoginFailed != null) _evt_autoLoginFailed();
			dispatchEvent(e);
		}
		
		public function set onOtherGameProfileReceived(func:Function):void  {_evt_onOtherGameProfileReceived = func;}
		public function get onOtherGameProfileReceived():Function {return _evt_onOtherGameProfileReceived;}
		private function e_onOtherGameProfileReceived(e:Event):void {
			if(_evt_onOtherGameProfileReceived != null) _evt_onOtherGameProfileReceived();
			dispatchEvent(e);
		}
		
		public function set onBeginSession(func:Function):void  {_evt_beginSession = func;}
		public function get onBeginSession():Function {return _evt_beginSession;}
		private function e_onBeginSession(e:Event):void {
			if(_evt_beginSession != null) _evt_beginSession();
			dispatchEvent(e);
		}
		
		public function set onBeginSessionFailed(func:Function):void  {_evt_beginSessionFailed = func;}
		public function get onBeginSessionFailed():Function {return _evt_beginSessionFailed;}
		private function e_onBeginSessionFailed(e:Event):void {
			if(_evt_beginSessionFailed != null) _evt_beginSessionFailed();
			dispatchEvent(e);
		}
		
		public function set onItemPurchase(func:Function):void  {_evt_itemPurchase = func;}
		public function get onItemPurchase():Function {return _evt_itemPurchase;}
		private function e_onItemPurchase(e:Event):void {
			if(_evt_itemPurchase != null) _evt_itemPurchase();
			dispatchEvent(e);
		}
		
		public function set onItemPurchaseCanceled(func:Function):void  {_evt_itemPurchaseCanceled = func;}
		public function get onItemPurchaseCanceled():Function {return _evt_itemPurchaseCanceled;}
		private function e_onItemPurchaseCanceled(e:Event):void {
			if(_evt_itemPurchaseCanceled != null) _evt_itemPurchaseCanceled();
			dispatchEvent(e);
		}

		public function set onItemPurchaseFailed(func:Function):void  {_evt_itemPurchaseFailed = func;}
		public function get onItemPurchaseFailed():Function {return _evt_itemPurchaseFailed;}
		private function e_onItemPurchaseFailed(e:Event):void {
			if(_evt_itemPurchaseFailed != null) _evt_itemPurchaseFailed();
			dispatchEvent(e);
		}		
		
		public function set onApiReady(func:Function):void  {_evt_apiReady = func;}
		public function get onApiReady():Function {return _evt_apiReady;}
		private function e_onApiReady(e:Event):void {
			if(_evt_apiReady != null) _evt_apiReady();
			dispatchEvent(e);
		}
		
		public function set onConfirmYes(func:Function):void  {_evt_confYes = func;}
		public function get onConfirmYes():Function {return _evt_confYes;}
		private function e_onConfirmYes(e:Event):void {
			if(_evt_confYes != null) _evt_confYes();
			dispatchEvent(new Event("confirmedYes"));
		}
		
		public function set onConfirmNo(func:Function):void  {_evt_confNo = func;}
		public function get onConfirmNo():Function {return _evt_confNo;}
		private function e_onConfirmNo(e:Event):void {
			if(_evt_confNo != null) _evt_confNo();
			dispatchEvent(new Event("confirmedNo"));
		}
		
		// Usage events:
		private var _dialogsOpen:uint = 0;
		public function get dialogsOpen():uint {return _dialogsOpen;}
		
		public function set onUseChanged(func:Function):void  {_evt_useChanged = func;}
		public function get onUseChanged():Function {return _evt_useChanged;}
		
		public function set onUseStarted(func:Function):void  {_evt_useStarted = func;}
		public function get onUseStarted():Function {return _evt_useStarted;}
		private function e_onUseStarted(e:*):void {
			_dialogsOpen++;
			if (_dialogsOpen > 1) return; 
			
			_inUse = true;
			if (_evt_useChanged != null) _evt_useChanged();
			if (_evt_useStarted != null) _evt_useStarted();
			dispatchEvent(new Event(EVT_INUSE_STARTED));
			dispatchEvent(new Event(EVT_INUSE_CHANGED));
		}
		
		public function set onUseEnded(func:Function):void  {_evt_useEnded = func;}
		public function get onUseEnded():Function {return _evt_useEnded;}
		private function e_onUseEnded(e:*):void {
			_dialogsOpen--
			if (_dialogsOpen > 0) { return; }
			
			_inUse = false;
			if(_evt_useChanged != null) _evt_useChanged();
			if(_evt_useEnded != null) _evt_useEnded();
			dispatchEvent(new Event(EVT_INUSE_ENDED));
			dispatchEvent(new Event(EVT_INUSE_CHANGED));
		}
		
		// Scoreboard events
		
		public function set onScoreboardError(func:Function):void  {_evt_onScoreboardError = func;}
		public function get onScoreboardError():Function {return _evt_onScoreboardError;}
		private function e_onScoreboardError(e:Event):void {
			if(_evt_onScoreboardError != null) _evt_onScoreboardError();
			dispatchEvent(e);
		}
		
		public function set onScoreboardRecieved(func:Function):void  {_evt_onScoreboardRecieved = func;}
		public function get onScoreboardRecieved():Function {return _evt_onScoreboardRecieved;}
		private function e_onScoreboardRecieved(e:Event):void {
			if(_evt_onScoreboardRecieved != null) _evt_onScoreboardRecieved();
			dispatchEvent(e);
		}
		
		public function set onScoreSubmitted(func:Function):void  {_evt_onScoreSubmitted = func;}
		public function get onScoreSubmitted():Function {return _evt_onScoreSubmitted;}
		private function e_onScoreSubmitted(e:Event):void {
			if(_evt_onScoreSubmitted != null) _evt_onScoreSubmitted();
			dispatchEvent(e);
		}
		
		public function set onUnregisteredName(func:Function):void  {_evt_onUnregisteredName= func;}
		public function get onUnregisteredName():Function {return _evt_onUnregisteredName;}
		private function e_onUnregisteredName(e:Event):void {
			if(_evt_onUnregisteredName != null) _evt_onUnregisteredName();
			dispatchEvent(e);
		}
		
		public function set onConsumptionCompleted(func:Function):void  {_evt_onConsumptionCompleted= func;}
		public function get onConsumptionCompleted():Function {return _evt_onConsumptionCompleted;}
		private function e_onConsumptionCompleted(e:Event):void {
			if(_evt_onConsumptionCompleted != null) _evt_onConsumptionCompleted();
			dispatchEvent(e);
		}
		
		public function set onRegistrationFormClosed(func:Function):void  {_evt_onRegistrationFormClosed= func;}
		public function get onRegistrationFormClosed():Function {return _evt_onRegistrationFormClosed;}
		private function e_onRegistrationFormClosed(e:Event):void {
			if(_evt_onRegistrationFormClosed != null) _evt_onRegistrationFormClosed();
			dispatchEvent(e);
		}
		
		public function set onLoginFormClosed(func:Function):void  {_evt_onLoginFormClosed= func;}
		public function get onLoginFormClosed():Function {return _evt_onLoginFormClosed;}
		private function e_onLoginFormClosed(e:Event):void {
			if(_evt_onLoginFormClosed != null) _evt_onLoginFormClosed();
			dispatchEvent(e);
		}
		
		public function set onBridgeSuccess(func:Function):void {_evt_onBridgeSuccess = func;}
		public function get onBridgeSuccess():Function {return _evt_onBridgeSuccess;}
		private function e_onBridgeSuccess(e:Event):void {
			if(_evt_onBridgeSuccess != null) _evt_onBridgeSuccess();
			dispatchEvent(e);
		}

		public function set onBridgeError(func:Function):void {_evt_onBridgeError = func;}
		public function get onBridgeError():Function {return _evt_onBridgeError;}
		private function e_onBridgeError(e:Event):void {
			if(_evt_onBridgeError != null) _evt_onBridgeError();
			dispatchEvent(e);
		}
		
		public function set onPaymentPanelShown(func:Function):void {_evt_onPaymentPanelShown = func;}
		public function get onPaymentPanelShown():Function {return _evt_onPaymentPanelShown;}
		private function e_onPaymentPanelShown(e:Event):void {
			if(_evt_onPaymentPanelShown != null) _evt_onPaymentPanelShown();
			dispatchEvent(e);
		}

		public function set onPaymentPanelHidden(func:Function):void {_evt_onPaymentPanelHidden = func;}
		public function get onPaymentPanelHidden():Function {return _evt_onPaymentPanelHidden;}
		private function e_onPaymentPanelHidden(e:Event):void {
			if(_evt_onPaymentPanelHidden != null) _evt_onPaymentPanelHidden();
			dispatchEvent(e);
		}
		
		public function set onStatusBarMouseOver(func:Function):void {_evt_onStatusBarMouseOver = func;}
		public function get onStatusBarMouseOver():Function {return _evt_onStatusBarMouseOver;}
		private function e_onStatusBarMouseOver(e:Event):void {
			if(_evt_onStatusBarMouseOver != null) _evt_onStatusBarMouseOver();
			dispatchEvent(e);
		}		
		
		public function set onStatusBarMouseOut(func:Function):void {_evt_onStatusBarMouseOut = func;}
		public function get onStatusBarMouseOut():Function {return _evt_onStatusBarMouseOut;}
		private function e_onStatusBarMouseOut(e:Event):void {
			if(_evt_onStatusBarMouseOut != null) _evt_onStatusBarMouseOut();
			dispatchEvent(e);
		}		
		
		// -------------------
		// Level Vault Events:
		// -------------------
		
		public function set onLevelVaultGotLevels(func:Function):void  {_evt_onLevelVaultGotLevels = func;}
		public function get onLevelVaultGotLevels():Function {return _evt_onLevelVaultGotLevels;}
		private function e_onLevelVaultGotLevels(e:Event):void {
			if(_evt_onLevelVaultGotLevels != null) _evt_onLevelVaultGotLevels();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultGotIndex(func:Function):void  {_evt_onLevelVaultGotIndex = func;}
		public function get onLevelVaultGotIndex():Function {return _evt_onLevelVaultGotIndex;}
		private function e_onLevelVaultGotIndex(e:Event):void {
			if(_evt_onLevelVaultGotIndex != null) _evt_onLevelVaultGotIndex();
			dispatchEvent(e);
		}		
		
		public function set onLevelVaultGotLevel(func:Function):void  {_evt_onLevelVaultGotLevel = func;}
		public function get onLevelVaultGotLevel():Function {return _evt_onLevelVaultGotLevel;}
		private function e_onLevelVaultGotLevel(e:Event):void {
			if(_evt_onLevelVaultGotLevel != null) _evt_onLevelVaultGotLevel();
			dispatchEvent(e);
		}

		public function set onLevelVaultGotNumLevels(func:Function):void  {_evt_onLevelVaultGotNumLevels = func;}
		public function get onLevelVaultGotNumLevels():Function {return _evt_onLevelVaultGotNumLevels;}
		private function e_onLevelVaultGotNumLevels(e:Event):void {
			if(_evt_onLevelVaultGotNumLevels != null) _evt_onLevelVaultGotNumLevels();
			dispatchEvent(e);
		}

		public function set onLevelVaultGotLevelRanking(func:Function):void  {_evt_onLevelVaultGotLevelRanking = func;}
		public function get onLevelVaultGotLevelRanking():Function {return _evt_onLevelVaultGotLevelRanking;}
		private function e_onLevelVaultGotLevelRanking(e:Event):void {
			if(_evt_onLevelVaultGotLevelRanking != null) _evt_onLevelVaultGotLevelRanking();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelCreated(func:Function):void  {_evt_onLevelVaultLevelCreated = func;}
		public function get onLevelVaultLevelCreated():Function {return _evt_onLevelVaultLevelCreated;}
		private function e_onLevelVaultLevelCreated(e:Event):void {
			if(_evt_onLevelVaultLevelCreated != null) _evt_onLevelVaultLevelCreated();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelAttributesChanged(func:Function):void  {_evt_onLevelVaultLevelAttributesChanged = func;}
		public function get onLevelVaultLevelAttributesChanged():Function {return _evt_onLevelVaultLevelAttributesChanged;}
		private function e_onLevelVaultLevelAttributesChanged(e:Event):void {
			if(_evt_onLevelVaultLevelAttributesChanged != null) _evt_onLevelVaultLevelAttributesChanged();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelDeleted(func:Function):void  {_evt_onLevelVaultLevelDeleted = func;}
		public function get onLevelVaultLevelDeleted():Function {return _evt_onLevelVaultLevelDeleted;}
		private function e_onLevelVaultLevelDeleted(e:Event):void {
			if(_evt_onLevelVaultLevelDeleted != null) _evt_onLevelVaultLevelDeleted();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelEdited(func:Function):void  {_evt_onLevelVaultLevelEdited = func;}
		public function get onLevelVaultLevelEdited():Function {return _evt_onLevelVaultLevelEdited;}
		private function e_onLevelVaultLevelEdited(e:Event):void {
			if(_evt_onLevelVaultLevelEdited != null) _evt_onLevelVaultLevelEdited();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelFlagged(func:Function):void  {_evt_onLevelVaultLevelFlagged = func;}
		public function get onLevelVaultLevelFlagged():Function {return _evt_onLevelVaultLevelFlagged;}
		private function e_onLevelVaultLevelFlagged(e:Event):void {
			if(_evt_onLevelVaultLevelFlagged != null) _evt_onLevelVaultLevelFlagged();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelNumericsIncremented(func:Function):void  {_evt_onLevelVaultLevelNumericsIncremented = func;}
		public function get onLevelVaultLevelNumericsIncremented():Function {return _evt_onLevelVaultLevelNumericsIncremented;}
		private function e_onLevelVaultLevelNumericsIncremented(e:Event):void {
			if(_evt_onLevelVaultLevelNumericsIncremented != null) _evt_onLevelVaultLevelNumericsIncremented();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelNumericsSet(func:Function):void  {_evt_onLevelVaultLevelNumericsSet = func;}
		public function get onLevelVaultLevelNumericsSet():Function {return _evt_onLevelVaultLevelNumericsSet;}
		private function e_onLevelVaultLevelNumericsSet(e:Event):void {
			if(_evt_onLevelVaultLevelNumericsSet != null) _evt_onLevelVaultLevelNumericsSet();			
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelRated(func:Function):void  {_evt_onLevelVaultLevelRated = func;}
		public function get onLevelVaultLevelRated():Function {return _evt_onLevelVaultLevelRated;}
		private function e_onLevelVaultLevelRated(e:Event):void {
			if(_evt_onLevelVaultLevelStringsSet != null) _evt_onLevelVaultLevelStringsSet();
			dispatchEvent(e);
		}
		
		public function set onLevelVaultLevelStringsSet(func:Function):void  {_evt_onLevelVaultLevelStringsSet = func;}
		public function get onLevelVaultLevelStringsSet():Function {return _evt_onLevelVaultLevelStringsSet;}
		private function e_onLevelVaultLevelStringsSet(e:Event):void {
			if(_evt_onLevelVaultLevelStringsSet != null) _evt_onLevelVaultLevelStringsSet();
			dispatchEvent(e);
		}
		
		// ----------------
		// Facebook Events:
		// ----------------
		public function set onFacebookConnected(func:Function):void  {_evt_onFacebookConnected = func;}
		public function get onFacebookConnected():Function {return _evt_onFacebookConnected;}
		private function e_onFacebookConnected(e:Event):void {
			if(_evt_onFacebookConnected != null) _evt_onFacebookConnected();
			dispatchEvent(e);
		}
		
		public function set onFacebookLoginFailed(func:Function):void  {_evt_onFacebookLoginFailed = func;}
		public function get onFacebookLoginFailed():Function {return _evt_onFacebookLoginFailed;}
		private function e_onFacebookLoginFailed(e:Event):void {
			if(_evt_onFacebookLoginFailed != null) _evt_onFacebookLoginFailed();
			dispatchEvent(e);
		}
		
		public function set onFacebookGotLocalUser(func:Function):void  {_evt_onFacebookGotLocalUser = func;}
		public function get onFacebookGotLocalUser():Function {return _evt_onFacebookGotLocalUser;}
		private function e_onFacebookGotLocalUser(e:Event):void {
			if(_evt_onFacebookGotLocalUser != null) _evt_onFacebookGotLocalUser();
			dispatchEvent(e);
		}
		
		public function set onFacebookGotFriends(func:Function):void  {_evt_onFacebookGotFriends = func;}
		public function get onFacebookGotFriends():Function {return _evt_onFacebookGotFriends;}
		private function e_onFacebookGotFriends(e:Event):void {
			if(_evt_onFacebookGotFriends != null) _evt_onFacebookGotFriends();
			dispatchEvent(e);
		}
		
		public function set onFacebookWallPostSuccess(func:Function):void  {_evt_onFacebookWallPostSuccess = func;}
		public function get onFacebookWallPostSuccess():Function {return _evt_onFacebookWallPostSuccess;}
		private function e_onFacebookWallPostSuccess(e:Event):void {
			if(_evt_onFacebookWallPostSuccess != null) _evt_onFacebookWallPostSuccess();
			dispatchEvent(e);
		}
		
		public function set onFacebookWallPostFailed(func:Function):void  {_evt_onFacebookWallPostFailed = func;}
		public function get onFacebookWallPostFailed():Function {return _evt_onFacebookWallPostFailed;}
		private function e_onFacebookWallPostFailed(e:Event):void {
			if(_evt_onFacebookWallPostFailed != null) _evt_onFacebookWallPostFailed();
			dispatchEvent(e);
		}
		
		public function set onFacebookPromptClosed(func:Function):void  {_evt_onFacebookPromptClosed = func;}
		public function get onFacebookPromptClosed():Function {return _evt_onFacebookPromptClosed;}
		private function e_onFacebookPromptClosed(e:Event):void {
			if(_evt_onFacebookPromptClosed != null) _evt_onFacebookPromptClosed();
			dispatchEvent(e);
		}
				
		// ----------------
		// Twitter Events:
		// ----------------
		public function set onTwitterConnected(func:Function):void  {_evt_onTwitterConnected = func;}
		public function get onTwitterConnected():Function {return _evt_onTwitterConnected;}
		private function e_onTwitterConnected(e:Event):void {
			if(_evt_onTwitterConnected != null) _evt_onTwitterConnected();
			dispatchEvent(e);
		}
		
		public function set onTwitterLoginFailed(func:Function):void  {_evt_onTwitterLoginFailed = func;}
		public function get onTwitterLoginFailed():Function {return _evt_onTwitterLoginFailed;}
		private function e_onTwitterLoginFailed(e:Event):void {
			if(_evt_onTwitterLoginFailed != null) _evt_onTwitterLoginFailed();
			dispatchEvent(e);
		}

		public function set onTwitterGotUser(func:Function):void  {_evt_onTwitterGotUser = func;}
		public function get onTwitterGotUser():Function {return _evt_onTwitterGotUser;}
		private function e_onTwitterGotUser(e:Event):void {
			if(_evt_onTwitterGotUser != null) _evt_onTwitterGotUser();
			dispatchEvent(e);
		}

		public function set onTwitterPostSuccess(func:Function):void  {_evt_onTwitterPostSuccess = func;}
		public function get onTwitterPostSuccess():Function {return _evt_onTwitterPostSuccess;}
		private function e_onTwitterPostSuccess(e:Event):void {
			if(_evt_onTwitterPostSuccess != null) _evt_onTwitterPostSuccess();
			dispatchEvent(e);
		}
		
		public function set onTwitterPostFailed(func:Function):void  {_evt_onTwitterPostFailed = func;}
		public function get onTwitterPostFailed():Function {return _evt_onTwitterPostFailed;}
		private function e_onTwitterPostFailed(e:Event):void {
			if(_evt_onTwitterPostFailed != null) _evt_onTwitterPostFailed();
			dispatchEvent(e);
		}
		
		public function set onTwitterPromptClosed(func:Function):void  {_evt_onTwitterPromptClosed = func;}
		public function get onTwitterPromptClosed():Function {return _evt_onTwitterPromptClosed;}
		private function e_onTwitterPromptClosed(e:Event):void {
			if(_evt_onTwitterPromptClosed != null) _evt_onTwitterPromptClosed();
			dispatchEvent(e);
		}
		
		
		public static function get api():GamerSafe {
			if(_instance == null){
				trace("GamerSafe: Instance Error: Attempted to get instance before initial construction.");
				return null;
			}
			return _instance;
		}
		
		
		public static function get apiLoaded():Boolean {
			return _instance != null;
		}
		
		
		public function disable():void {
			if(_status == "Ready"){
				_status = "Disabled";
				_loaded = false;
			}
		}
		
		
		public function enable():void {
			if(_status == "Disabled"){
				_status = "Ready";
				_loaded = true;
			}
		}
		
		// Internal stuff:
		
		public function GamerSafe(parent:*, passcode:String = null, hashseed:String = null, isAir:Boolean = false)
		{
			if(_instance == null){
				_instance = this;
			}else{
				trace("GamerSafe: Instance Error: The GamerSafe class is a singleton and should only be constructed once. Use Gamersafe.instance instead.");
				return;
			}
			
			if(passcode != null)
				_storedPasscode = passcode;
			if(hashseed != null)
				_storedHashseed = hashseed;
			
			// Allow GamerSafe to access our stage:
			if(!isAir)
			{
				Security.allowDomain("*");
				Security.allowInsecureDomain("*");
				_context.applicationDomain = ApplicationDomain.currentDomain;
						
				// Download
				_status = "Downloading";
				try { 
					_loader.load(_request, _context); 
					_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadingError);
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadingComplete);
				} catch(s:SecurityError) {
					_status = "Failed";
					trace("Security error - GamerSafe library cannot load"); 
					_loader = null; 
				}			
			}
			else
			{
				_status = "Downloading";
				try {
					_loader.load(_request, _context); 
					_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadingError);
					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadingCompleteAir);
				} catch(s:SecurityError) {
					_status = "Failed";
					trace("Security error - GamerSafe library cannot load"); 
					_loader = null; 
				}
			}

			addEventListener(Event.ADDED_TO_STAGE, setupStage);
			
			if(parent is Sprite || parent is MovieClip || parent is Stage){
				parent.addChild(this);
			} else {
				trace("Incompatible parent!");
			}
		}
		
		private function resizeStage(e:Event):void {
			if(loaded == false) return;
			_stageWidth = _stage.stageWidth;
			_stageHeight = _stage.stageHeight;
			_gamerSafe.componentWidth = _stageWidth;
			_gamerSafe.componentHeight = _stageHeight;
		}
		
		private function setupStage(e:Event):void {
			if(stage == null) return;
			_stage = stage;
			_stage.addEventListener(Event.RESIZE, resizeStage);
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			if(root != null){
				_referrer = root.loaderInfo.loaderURL;
			}
			if(loaded){
				_gamerSafe.componentWidth = _stageWidth;
				_gamerSafe.componentHeight = _stageHeight;
				_stage.addChild(_gamerSafe as Sprite);
			}
		}
		
		private function onLoadingCompleteAir(e:Event):void {
			_status = "Loading";
			
			var context:LoaderContext = new LoaderContext();
			if( "allowLoadBytesCodeExecution" in context ) { // runtime check if this field exists in context
		   	context["allowLoadBytesCodeExecution"] = true;
		   }			
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadingCompleteAir);			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadingComplete);
			_loader.loadBytes(_loader.contentLoaderInfo.bytes, context);
		}
		
		private function onLoadingComplete(e:Event):void {
			_status = "Ready";
			_loaded = true;//
			_gamerSafe = _loader.content as Object;
			_gamerSafe.componentWidth = _stageWidth;
			_gamerSafe.componentHeight = _stageHeight;
			
			_gamerSafe.setSkin(_tmpSkin);
			_gamerSafe.setAchievementSkin(_tmpAchievementSkin);
			
			_gamerSafe.addEventListener(EVT_NETWORKING_ERROR, e_onNetworkingError);
			_gamerSafe.addEventListener(EVT_ACCOUNT_CHANGE, e_onAccountChange);
			_gamerSafe.addEventListener("account_refresh", e_onAccountChange);
			_gamerSafe.addEventListener(EVT_LOGIN, e_onLogin);
			_gamerSafe.addEventListener(EVT_LOGIN_FAILED, e_onLoginFailed);
			_gamerSafe.addEventListener(EVT_AUTO_LOGIN_FAILED, e_onAutoLoginFailed);
			_gamerSafe.addEventListener(EVT_BEGIN_SESSION, e_onBeginSession);
			_gamerSafe.addEventListener(EVT_BEGIN_SESSION_FAILED, e_onBeginSessionFailed);
			_gamerSafe.addEventListener(EVT_ITEM_PURCHASE, e_onItemPurchase);
			_gamerSafe.addEventListener(EVT_ITEM_PURCHASE_CANCELED, e_onItemPurchaseCanceled);
			_gamerSafe.addEventListener(EVT_ITEM_PURCHASE_FAILED, e_onItemPurchaseFailed);
			_gamerSafe.addEventListener("yes", e_onConfirmYes);
			_gamerSafe.addEventListener("no", e_onConfirmNo);
			_gamerSafe.addEventListener("dialog_begin", e_onUseStarted);
			_gamerSafe.addEventListener("dialog_end", e_onUseEnded);
			_gamerSafe.addEventListener(EVT_SCOREBOARD_ENTRIES_ERROR, e_onScoreboardError);
			_gamerSafe.addEventListener(EVT_SCOREBOARD_ENTRIES_RECEIVED, e_onScoreboardRecieved);
			_gamerSafe.addEventListener(EVT_SCOREBOARD_ENTRY_SUBMITTED, e_onScoreSubmitted);
			_gamerSafe.addEventListener(EVT_UNREGISTERED_NAME, e_onUnregisteredName);
			_gamerSafe.addEventListener(EVT_CONSUMPTION_COMPLETED, e_onConsumptionCompleted);
			_gamerSafe.addEventListener(EVT_REGISTRATION_FORM_CLOSED, e_onRegistrationFormClosed);
			_gamerSafe.addEventListener(EVT_LOGIN_FORM_CLOSED, e_onLoginFormClosed);
			_gamerSafe.addEventListener(EVT_OTHER_GAME_PROFILE_RECEIVED, e_onOtherGameProfileReceived);
			_gamerSafe.addEventListener(EVT_BRIDGE_SUCCESS, e_onBridgeSuccess);
			_gamerSafe.addEventListener(EVT_BRIDGE_ERROR, e_onBridgeError);
			_gamerSafe.addEventListener(EVT_PAYMENT_PANEL_SHOWN, e_onPaymentPanelShown);
			_gamerSafe.addEventListener(EVT_PAYMENT_PANEL_HIDDEN, e_onPaymentPanelHidden);
			_gamerSafe.addEventListener(EVT_STATUSBAR_MOUSEOVER, e_onStatusBarMouseOver);
			_gamerSafe.addEventListener(EVT_STATUSBAR_MOUSEOUT, e_onStatusBarMouseOut);
			
			var levelVaultListener:EventDispatcher = levelVaultEventObject;
			levelVaultListener.addEventListener(EVT_LEVELVAULT_GOT_LEVELS, e_onLevelVaultGotLevels);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_GOT_NUM_LEVELS, e_onLevelVaultGotNumLevels);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_GOT_SINGLE_LEVEL, e_onLevelVaultGotLevel);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_GOT_LEVEL_RANKING, e_onLevelVaultGotLevelRanking);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_GOT_INDEX, e_onLevelVaultGotIndex);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_CREATED, e_onLevelVaultLevelCreated);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_DELETED, e_onLevelVaultLevelDeleted);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_EDITED, e_onLevelVaultLevelEdited);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_FLAGGED, e_onLevelVaultLevelFlagged);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_RATED, e_onLevelVaultLevelRated);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_NUMERICS_SET, e_onLevelVaultLevelNumericsSet);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_STRINGS_SET, e_onLevelVaultLevelStringsSet);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_NUMERICS_INCREMENTED, e_onLevelVaultLevelNumericsIncremented);
			// Change listener for level attributes:
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_NUMERICS_SET, e_onLevelVaultLevelAttributesChanged);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_STRINGS_SET, e_onLevelVaultLevelAttributesChanged);
			levelVaultListener.addEventListener(EVT_LEVELVAULT_LEVEL_NUMERICS_INCREMENTED, e_onLevelVaultLevelAttributesChanged);
		
			// Facebook listeners:
			_gamerSafe.addEventListener(EVT_FACEBOOK_CONNECTED, e_onFacebookConnected);
			_gamerSafe.addEventListener(EVT_FACEBOOK_LOGIN_FAILED, e_onFacebookLoginFailed);
			_gamerSafe.addEventListener(EVT_FACEBOOK_GOT_USER, e_onFacebookGotLocalUser);
			_gamerSafe.addEventListener(EVT_FACEBOOK_GOT_FRIENDS, e_onFacebookGotFriends);
			_gamerSafe.addEventListener(EVT_FACEBOOK_WALL_POST_SUCCESS, e_onFacebookWallPostSuccess);
			_gamerSafe.addEventListener(EVT_FACEBOOK_WALL_POST_FAILED, e_onFacebookWallPostFailed);
			_gamerSafe.addEventListener(EVT_FACEBOOK_PROMPT_CLOSED, e_onFacebookPromptClosed);
			
			// Twitter listeners:
			_gamerSafe.addEventListener(EVT_TWITTER_CONNECTED, e_onTwitterConnected);
			_gamerSafe.addEventListener(EVT_TWITTER_LOGIN_FAILED, e_onTwitterLoginFailed);
			_gamerSafe.addEventListener(EVT_TWITTER_GOT_USER, e_onTwitterGotUser);
			_gamerSafe.addEventListener(EVT_TWITTER_POST_SUCCESS, e_onTwitterPostSuccess);
			_gamerSafe.addEventListener(EVT_TWITTER_POST_FAILED, e_onTwitterPostFailed);
			
			if(_stage != null){
				_stage.addChild(_gamerSafe as Sprite);
			}
			
			if(root != null){
				_referrer = root.loaderInfo.loaderURL
			}
			
			if(_storedPasscode != ""){
				beginSession(_storedPasscode,_storedHashseed);
			}
			showStatusBar();
			e_onApiReady(new Event("apiReady"));
		}
		
		private function onLoadingError(e:IOErrorEvent):void {
			// Silently fail, don't affect gameplay.
			_loaded = false;
			_status = "Failed"
			trace("Failed to load GamerSafe");
		}
		
		private var _storedHashseed:String = "8247993db18b0bf4e2e85df2bf80ebc87cdb1c0f";
		private var _storedPasscode:String = "G1ee21e9a008eb19f1563f9e061304969180a3994d:1420256509";		
	}
}