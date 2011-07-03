/**
*8 Bit Palette Map
*July 3, 2011
*Bruce Jawn
*http://bruce-lab.blogspot.com
*Ref: http://www.codeproject.com/KB/graphics/Image_Bitdepth_Conversion.aspx
* 
*Copyright (c) <2011> <Bruce Jawn>
*This software is released under the MIT License 
*<http://www.opensource.org/licenses/mit-license.php>
**/
package {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.* ;
    import flash.ui.*;
    [SWF(width="640", height="480", backgroundColor="#ffffff")]
    public class Bit32toBit8 extends Sprite
    {
        private const STANDARD_PALETTE:Array = [00, 51, 102, 153, 204, 255];
        private const STANDARD_COLOR_SIZE:int = 6;
        private const PALETTE_VAL_DIF:int = 51; 
        // difference between two consecutive standard color Palette.
        
        private var  dwColorMapTable:Array = [216];
        private var  nColorMapIdx:int = 0;
        
        public function Bit32toBit8():void
        {
            //Build the 8 bit palette table
            for (var nBlueIdx:int = 0; nBlueIdx < STANDARD_COLOR_SIZE; ++nBlueIdx)
            {
                for(var nGreenIdx:int = 0; nGreenIdx < STANDARD_COLOR_SIZE; ++nGreenIdx)
                {
                    for(var nRedIdx:int = 0; nRedIdx < STANDARD_COLOR_SIZE; ++nRedIdx)
                    {
                        var rgbRed:int = STANDARD_PALETTE[nRedIdx];
                        var rgbGreen:int = STANDARD_PALETTE[nGreenIdx];
                        var rgbBlue:int = STANDARD_PALETTE[nBlueIdx];
                        dwColorMapTable[nColorMapIdx]=rgbRed<<16|rgbGreen<<8|rgbBlue 
                        ++nColorMapIdx;
                    }
                }
            }//end of for
            //trace(dwColorMapTable);
            //Draw the palette
            for(var i:int=0;i<216;i++)
            {
                graphics.beginFill(dwColorMapTable[i]);
                graphics.drawRect((i % 50) * 10, int(i / 50) * 10, 10, 10);
                graphics.endFill();
            }
            initMenu();
            Loadimage();
        }//end of function Bit32toBit8
        
        private var out:BitmapData;
        private var InputData:BitmapData;
        private var nImageHeight:int;
        private var nImageWidth:int; 
        //====================================
        
        private function Loadimage():void
        {
            Security.loadPolicyFile("http://flaswf.googlecode.com/svn/trunk/crossdomain.xml");
            var context:LoaderContext = new LoaderContext();
            context.checkPolicyFile = true;
            var myLoader:Loader = new Loader();
            myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
            myLoader.load(new URLRequest("http://flaswf.googlecode.com/svn/trunk/Palette%20AS3/test.PNG"), context);
            function onLoaderReady(evt:Event):void
            {
                InputData = Bitmap ( evt.target.content ).bitmapData;
                nImageHeight= InputData.height;
                nImageWidth = InputData.width;
                //trace(nImageHeight);
                //trace(nImageWidth);
                out = new BitmapData(nImageWidth, nImageHeight);
                addChild(new Bitmap(InputData));
                addChild(new Bitmap(out));
                getChildAt(0).y = 50;
                getChildAt(1).y = 50;
                getChildAt(1).x = nImageWidth;
                
                convert();
            }//end of function onLoaderReady
        }//end of function Loadimage
        //====================================
        
        private function upLoadimage():void
        {
            while (this.numChildren)
            removeChildAt(0);
            
            var ref:FileReference = new FileReference( );
            ref.addEventListener(Event.SELECT,imgSelected)
            ref.browse([new FileFilter("Images", "*.jpg;*.gif;*.png")]);
            
            function imgSelected(e:Event):void 
            {
                e.target.addEventListener(Event.COMPLETE,imgLoaded);
                e.target.load();
            }
            
            function imgLoaded(e:Event):void 
            {
                //trace("imgLoaded");
                var _loader:Loader = new Loader( );
                _loader.contentLoaderInfo.addEventListener ( Event.COMPLETE, _onImageDataLoaded ) ;
                _loader.loadBytes ( e.target.data ) ;
                
                function _onImageDataLoaded(evt:Event):void{
                    //trace("_onImageLoaded");
                    InputData = Bitmap ( evt.target.content ).bitmapData;
                    nImageHeight= InputData.height;
                    nImageWidth = InputData.width;
                    //trace(nImageHeight);
                    //trace(nImageWidth);
                    out = new BitmapData(nImageWidth, nImageHeight);
                    addChild(new Bitmap(InputData));
                    addChild(new Bitmap(out));
                    getChildAt(0).y = 50;
                    getChildAt(1).y = 50;
                    getChildAt(1).x = nImageWidth;
                    
                    convert();
                }//end of function _onImageDataLoaded
                e.target.removeEventListener(Event.COMPLETE,imgLoaded)
            }//end of function imgLoaded
            
        }//end of function upLoadimage
        //====================================
        
        private function convert():void
        {
            for(var nRow:int = 0; nRow < nImageHeight; ++nRow)
            {
                for(var nCol:int = 0; nCol < nImageWidth; ++nCol)
                {
                    var objColorData:int=InputData.getPixel(nCol,nRow);
                    // Get RGB value from color data.
                    var nRed :int= objColorData>>16&0xff
                    var nGreen:int = objColorData>>8&0xff
                    var nBlue:int = objColorData&0xff
                    // Get Index of suitable color data in the palette table.
                    var uRedValue:int = GetPixelValue(nRed);
                    var uGreenValue:int = GetPixelValue(nGreen);
                    var uBlueValue:int = GetPixelValue(nBlue);
                    // Calculate Pixel color position
                    // in the color map table using RGB values. 
                    // Finally set this index in to the pixel data.
                    var uPalettePos:int = uBlueValue*36+uGreenValue*6+uRedValue;
                    out.setPixel(nCol,nRow,dwColorMapTable[uPalettePos])
                }
            }//end of for
        }//end of function convert
        
        private function GetPixelValue(uPixelValue_i:int):int
        {
            var uRetValue:int = 0;
            var uPos:int = (int)(uPixelValue_i / PALETTE_VAL_DIF);
            if(0 == uPixelValue_i % PALETTE_VAL_DIF)
            {
                uRetValue = uPixelValue_i/PALETTE_VAL_DIF;
            }
            else
            {
                if(Math.abs(uPixelValue_i - STANDARD_PALETTE [uPos]) > 
                    Math.abs(uPixelValue_i - STANDARD_PALETTE [uPos+1]))
                {
                    uRetValue = uPos+1;
                }
                else
                {
                    uRetValue = uPos;
                }
            }
            return uRetValue;
        }//end of function GetPixelValue
        //====================================    
        
        private var myMenu:ContextMenu = new ContextMenu();
        private function AddMouseMenu(Name:String,Break:Boolean=false,Listener:Function=null):void
        {
            var NCMI:ContextMenuItem = new ContextMenuItem(Name,Break);
            myMenu.customItems.push(NCMI);
            NCMI.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, Listener);
        }//end of function AddMouseMenu

        private function initMenu():void
        {
            //myMenu.hideBuiltInItems();
            this.contextMenu = myMenu;
            AddMouseMenu("☆UpLoad image!",false,function menuItemSelectHandlerupload(e:ContextMenuEvent):void
                {
                    upLoadimage();
                });
        }//end of function initMenu
        //====================================
    }//end of class
}//end of package
