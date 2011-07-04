/**
*Bitmap Fonts
*July 4, 2011
*Bruce Jawn
*http://bruce-lab.blogspot.com
*Ref: http://lazyfoo.net/SDL_tutorials/lesson30/index.php
*Font: http://lazyfoo.net
* 
*Copyright (c) <2011> <Bruce Jawn>
*This software is released under the MIT License 
*<http://www.opensource.org/licenses/mit-license.php>
**/
package {
    import flash.display.*;
    import flash.events.*;
	import flash.geom.*;
    import flash.net.*;
    import flash.system.* ;
	import flash.text.*;
    import flash.ui.*;
    [SWF(width="512", height="512", backgroundColor="#ffffff")]
    public class BitmapFont extends Sprite
    {
        
        public function BitmapFont():void
        {
            Loadimage();
        }//end of function BitmapFont
        
        private var out:BitmapData = new BitmapData(640, 480, false, 0x0);
        private var InputData:BitmapData;
        private var nImageHeight:int;
        private var nImageWidth:int; 
		private var InfoText:TextField = new TextField();
        //====================================
        
        private function Loadimage():void
        {
            Security.loadPolicyFile("http://flaswf.googlecode.com/svn/trunk/crossdomain.xml");
            var context:LoaderContext = new LoaderContext();
            context.checkPolicyFile = true;
            var myLoader:Loader = new Loader();
			addChild(InfoText);
			myLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			function loadProgress(event:ProgressEvent):void 
			{
				var percentLoaded:Number = event.bytesLoaded/event.bytesTotal;
				percentLoaded = Math.round(percentLoaded * 100);
				InfoText.text = percentLoaded + "% Loaded!";//trace("Loading: "+percentLoaded+"%");
            }
            myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
            myLoader.load(new URLRequest("https://flaswf.googlecode.com/svn/trunk/BitmapFont/En/lazyfont.png"), context);
            function onLoaderReady(evt:Event):void
            {
				removeChild(InfoText);
                InputData = Bitmap ( evt.target.content ).bitmapData;
                nImageHeight= InputData.height;
                nImageWidth = InputData.width;
                //trace(nImageHeight);
                //trace(nImageWidth);
                out = new BitmapData(nImageWidth, nImageHeight);
                addChild(new Bitmap(out));           
                init();
				show_text(100, 128, "Hello Bitmap Font!\nABDCEFGHIJKLMNOPQRSTUVWXYZ\nabcdefghijklmnopqrstuvwxyz\n0123456789");
            }//end of function onLoaderReady
        }//end of function Loadimage
        //====================================

		//cell dimensions
		private var cellW:int ;
		private var cellH:int;
		//New line variables
		private var top:int;
		private var baseA:int;
		//The current character we're setting
		private var currentChar:int = 0;
		private var chars:Array = [];
		private var newLine:int;
		private var space:int;
		//====================================

		private function init():void
		{
			//Set the cell dimensions
			cellW =InputData.width / 16;
			cellH = InputData.height / 16;

			//New line variables
			top = cellH;
			baseA = cellH;
			
			//Go through the cell rows
			for( var rows:int = 0; rows < 16; rows++ )
			{
				//Go through the cell columns
				for( var cols:int = 0; cols < 16; cols++ )
				{
					chars[ currentChar ]={};
					//Set the character offset
					chars[ currentChar ].x = cellW * cols;
					chars[ currentChar ].y = cellH * rows;
					
					//Set the dimensions of the character
					chars[ currentChar ].w = cellW;
					chars[ currentChar ].h = cellH;
					
					var bgColor:int=0x00ffff;
					//Find Left Side
					//Go through pixel columns
					for( var pCol:int = 0; pCol < cellW; pCol++ )
					{
						//Go through pixel rows
						for( var pRow:int = 0; pRow < cellH; pRow++ )
						{
							//Get the pixel offsets
							var pX:int = ( cellW * cols ) + pCol;
							var pY:int = ( cellH * rows ) + pRow;
							//If a non colorkey pixel is found
							if( InputData.getPixel( pX, pY) != bgColor )
							{
								//Set the x offset
								chars[ currentChar ].x = pX;
								
								//Break the loops
								pCol = cellW;
								pRow = cellH;
							}//end of if 
						}//end of for pRow
					}//end of for  pCol

					//Find Right Side
					//Go through pixel columns
					for( var pCol_w:int = cellW - 1; pCol_w >= 0; pCol_w-- )
					//Go through pixel rows
					{
						for( var pRow_w:int = 0; pRow_w < cellH; pRow_w++ )
						{
							//Get the pixel offsets
							var pX:int = ( cellW * cols ) + pCol_w;
							var pY:int = ( cellH * rows ) + pRow_w;

							//If a non colorkey pixel is found
							if( InputData.getPixel( pX, pY)!= bgColor )
							{
								//Set the width
								chars[ currentChar ].w = ( pX - chars[ currentChar ].x ) + 1;

								//Break the loops
								pCol_w = -1;
								pRow_w = cellH;
							}
						}// pRow_w
					}//pCol_w
					
					//Find Top
					//Go through pixel rows
					for( var pRow:int = 0; pRow < cellH; pRow++ )
					{
						//Go through pixel columns
						for( var pCol:int = 0; pCol < cellW; pCol++ )
						{
							//Get the pixel offsets
							var pX:int = ( cellW * cols ) + pCol;
							var pY:int = ( cellH * rows ) + pRow;

							//If a non colorkey pixel is found
							if( InputData.getPixel( pX, pY)!= bgColor )
							{
								//If new top is found
								if( pRow < top )
								{
									top = pRow;
								}

								//Break the loops
								pCol = cellW;
								pRow = cellH;
							}
						}
					}

					//Find Bottom of A
					if( currentChar == int('A') )
					{
						//Go through pixel rows
						for( var pRow:int = cellH - 1; pRow >= 0; pRow-- )
						{
							//Go through pixel columns
							for( var pCol:int = 0; pCol < cellW; pCol++ )
							{
								//Get the pixel offsets
								var pX:int = ( cellW * cols ) + pCol;
								var pY:int = ( cellH * rows ) + pRow;

								//If a non colorkey pixel is found
								if( InputData.getPixel( pX, pY) != bgColor )
								{
									//Bottom of a is found
									baseA = pRow;

									//Break the loops
									pCol = cellW;
									pRow = -1;
								}
							}
						}
					}

					//Go to the next character
					currentChar++;
				}
			} 
			
			//Calculate space
			space = cellW / 2;

			//Calculate new line
			newLine = baseA - top;

			//Lop off excess top pixels
			for( var t:int = 0; t < 256; t++ )
			{
				chars[ t ].y += top;
				chars[ t ].h -= top;
			}//end of for t
		}//end function init
		//====================================================

		private function show_text(X:int, Y:int, string:String):void
		{ 
			var text:Array = string.split('');
			
			//Go through the text
			for( var show:int = 0; text[ show ] != '\0'; show++ )
			{
				//If the current character is a space
				if( text[ show ] == ' ' )
				{
					//Move over
					X += space;
				}//end of if
				//If the current character is a newline
				else if( text[ show ] == '\n' )
				{
					//Move down
					Y += newLine;

					//Move back
					X = x;
				}//end of else if
				else
				{
					//Get the ASCII value of the character
					var ascii:int = text[ show ].charCodeAt(0);
					
					//Show the character
					var myrect:Rectangle = new Rectangle(chars[ ascii ].x, chars[ ascii ].y, chars[ ascii ].w, chars[ ascii ].h);
					out.copyPixels(InputData, myrect, new Point(X,Y));
					//Move over the width of the character with one pixel of padding
					X += chars[ ascii ].w + 1;
				}//end of else
			}//end of for

			out.threshold (out, out.rect,new Point(), "==", 0xff00ffff);

		}//end of function
        //====================================

    }//end of class
}//end of package