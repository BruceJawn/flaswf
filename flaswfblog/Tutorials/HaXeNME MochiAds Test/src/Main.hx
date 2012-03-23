package ;

import mochi.as3.MochiAd;
import mochi.as3.MochiServices;
import nme.display.Loader;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;
import nme.net.URLRequest;
import nme.text.TextField;

/**
 * ...
 * @author Bruce
 * http://bruce-lab.blogspot.com/
 * Simple test using mochiads with haxenme.
 */

class Main extends Sprite
{
	
	static public function main() 
	{
		Lib.current.addChild (new Main()); 
	}
	public function new() 
	{
		super();
        Lib.current.addChild(this);
       
		MochiServices.connect("60347b2977273733", root);
        MochiAd.showPreGameAd( { id:"60347b2977273733", res:"640x580", clip: root } );
		
		var myText:TextField = new TextField();
		myText.width = 200;
		myText.x = 150;
		myText.y = 100;
		myText.scaleX = 2;
		myText.scaleY = 2;
		myText.text = "Click Anywhere to Load the Game!";
		addEventListener(MouseEvent.CLICK, loadGame);
		addChild(myText);
	}
	
	private function loadGame(event:Event)
	{
		var myLoader:Loader = new Loader();
		myLoader.load(new URLRequest("http://games.mochiads.com/c/g/infinite-balls/InfiniteBalls_EN.swf"));
		addChild(myLoader);	
		removeEventListener(MouseEvent.CLICK, loadGame);
	}

}