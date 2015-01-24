import CPMStar.*;
import com.newgrounds.*;
import com.newgrounds.components.*;
import flash.system.*;
import flash.net.*;

private var showScoreBoardAds:Boolean = true;
//cpm*
private var cpmstaradsHolder:Sprite = new Sprite();
private var closeadButton:Button = new Button("Continue", 10, 5);
private var ad:DisplayObject = new CPMStar.AdLoader("11568Q43B4BC7B");
private var ad2:DisplayObject = new CPMStar.AdLoader("11569Q5AE316B4");

private function closeadButton_H(_arg1:MouseEvent = null):void
{
	removeChild(cpmstaradsHolder);
	//startup();//initGame();
}

private function initcpmsAds(ad:DisplayObject):void
{
	cpmstaradsHolder.graphics.beginFill(0x0);
	cpmstaradsHolder.graphics.drawRect(0, 0, 300, 250); //334);//384
	cpmstaradsHolder.graphics.endFill();
	cpmstaradsHolder.addChild(ad);
	addChild(cpmstaradsHolder);
	cpmstaradsHolder.x = (stage.stageWidth - cpmstaradsHolder.width) / 2;
	cpmstaradsHolder.y = (stage.stageHeight - cpmstaradsHolder.height) / 2;
	cpmstaradsHolder.addChild(closeadButton);
	closeadButton.y = 250; //334;//250;
	closeadButton.addEventListener(MouseEvent.CLICK, closeadButton_H);
}

private function uninitcpmsAds():void
{
	cpmstaradsHolder.addChild(closeadButton);
}

//FGL	
private var ads:FGLAds = new FGLAds(stage, "FGD-20027932" /*"FGL-20027896"*/);

private function initFGLAds():void
{
	//When the API is ready, show the ad!
	ads.addEventListener(FGLAds.EVT_API_READY, showStartupAd);
	//ads.addEventListener(FGLAds.EVT_AD_CLOSED, startup);
}

private function uninitFGLAds():void
{
	ads.removeEventListener(FGLAds.EVT_API_READY, showStartupAd);
}

private function showStartupAd(e:Event):void
{
	ads.showAdPopup();
}

//NEWG
private var scoreBrowser:ScoreBrowser;
private var closescButton:Button;

private function closescButton_H(_arg1:MouseEvent = null):void
{
	removeChild(scoreBrowser);
	removeChild(closescButton);
	closescButton.removeEventListener(MouseEvent.CLICK, closescButton_H);
	if (showScoreBoardAds)
	{
		initcpmsAds(ad2);
	}
}

private function initNEWGAds():void
{
	API.connect(root, "39512:8wZX1Mj3", "8IX2Id20tDxeMGkForYAfqoxswhdwHho");
	API.addEventListener(APIEvent.API_CONNECTED, onNEWGAPIConnected);
	scoreBrowser = new ScoreBrowser();
	scoreBrowser.scoreBoardName = "Best Destroyer";
	scoreBrowser.period = ScoreBoard.ALL_TIME;
	closescButton = new Button("Close [X]", 10, 5);
}

private function onNEWGAPIConnected(event:APIEvent):void
{
	if (event.success)
	{
		trace("The API is connected and ready to use!");
	}
	else
	{
		trace("Error connecting to the API: " + event.error);
	}
}

private function uninitNEWGAds():void
{

}

//KONG

// Pull the API path from the FlashVars
private var paramObj:Object; // = LoaderInfo(root.loaderInfo).parameters;
// The API path. The "shadow" API will load if testing locally. 
private var apiPath:String; // = paramObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
// Kongregate API reference
private var kongregate:*;
private var kongloader:Loader = new Loader();

private function initKONGAds():void
{
	
	paramObj = LoaderInfo(root.loaderInfo).parameters;
	apiPath = paramObj.kongregate_api_path || "http://www.kongregate.com/flash/API_AS3_Local.swf";
	// Allow the API access to this SWF
	Security.allowDomain(apiPath);
	
	// Load the API
	var request:URLRequest = new URLRequest(apiPath);
	
	kongloader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
	kongloader.load(request);
	this.addChild(kongloader);
	//startup();
}

// This function is called when loading is complete
private function loadComplete(event:Event):void
{
	// Save Kongregate API reference
	kongregate = event.target.content;
	// Connect to the back-end
	kongregate.services.connect();
	// You can now access the API via:
	// kongregate.services
	// kongregate.user
	// kongregate.scores
	// kongregate.stats
	// etc...
	//kongregate.stats.submit("BestDestroyer", 100000);
	//trace("submitted")
}

private function uninitKONGAds():void
{
	kongloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
	this.removeChild(kongloader);
}
//Gamersafe
private var _gamerSafe:GamerSafe;

private var ADChoice:String;
private var FGL:String = "flashgamelicense.com";
private var FGD:String = "flashgamedistribution.com";
private var KONG:String = "kongregate.com";
private var NEWG:String = "ungrounded.net"; //"newgrounds.com";

private function chooseAD():void
{
	var domain:String = this.root.loaderInfo.url; //.split("/")[2];
	//trace(domain);
	//trace(domain.indexOf('bin'));
	if (domain.indexOf(FGL) >= 0)
	{
		ADChoice = "FGL";
	}
	else if (domain.indexOf(FGD) >= 0)
	{
		ADChoice = "FGL";
	}
	else if (domain.indexOf(KONG) >= 0)
	{
		ADChoice = "KONG";
	}
	else if (domain.indexOf(NEWG) >= 0)
	{
		ADChoice = "NEWG";
	}
	else
	{
		ADChoice = "CPM*"
	}
	//ADChoice = "FGL";
}

private function onBeginSession(e:Event):void
{
	GamerSafe.api.hideStatusBar();
}

private function initAPI():void
{
	_gamerSafe = new GamerSafe(this); //for score
	//_gamerSafe.hideStatusBar();//_gamerSafe.hideInterface();
	GamerSafe.api.addEventListener(GamerSafe.EVT_BEGIN_SESSION, onBeginSession);
	
	initNEWGAds(); //for version control
	
	switch (ADChoice)
	{
		case("FGL"): 
		{
			initFGLAds();
			break;
		}
		case("KONG"): 
		{
			initKONGAds(); //do nothing
			break;
		}
		case("NEWG"): 
		{
			initcpmsAds(ad);
			break;
		}
		default: 
		{
			initcpmsAds(ad);
		}
	}
}

public function SubmitScore(PlayerScore:int):void
{
	//removeEventListener(Event.ENTER_FRAME, startGame);
	
	switch (ADChoice)
	{
		case("KONG"): 
		{
			kongregate.stats.submit("BestDestroyer", PlayerScore); // The user collected a coin
			break;
		}
		case("NEWG"): 
		{
			API.postScore("Best Destroyer", PlayerScore);
			scoreBrowser.loadScores();
			addChild(scoreBrowser);
			addChild(closescButton);
			closescButton.y = scoreBrowser.height;
			closescButton.addEventListener(MouseEvent.CLICK, closescButton_H);
			break;
		}
		default: //FGL,FGD,Other
		{
			GamerSafe.api.showScoreSubmit(PlayerScore, '');
			GamerSafe.api.addEventListener(GamerSafe.EVT_SCOREBOARD_ENTRY_SUBMITTED, onScoreSub);
		}
	}
}

private function onScoreSub(_arg1:Event = null):void
{
	if (showScoreBoardAds)
	{
		if (ADChoice == "FGL" || ADChoice == "FGD")
		{
			ads.showAdPopup();
		}
		else
		{
			initcpmsAds(ad2);
		}
	}

}