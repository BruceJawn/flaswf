package{
	
	import myLibT
	
	import flash.display.*;
    import flash.media.*;
    import flash.text.*;
    import flash.utils.*;

	public class ExportAStest extends Sprite
	{
		public function ExportAStest():void
		{
			
         var myLib = new myLibT();
         var b = myLib.getBitmapData("JPGfile")
         addChild(new Bitmap(b));

         var s1= myLib.getSound("S1");
         trace(s1);
		 
         var s0= myLib.getSwf ("enemydead");
         trace(s0);
		 addChild(s0);
		 
         trace(myLib.getText("Textfile_0"));
         trace(myLib.getXML("Xmlfile_1"));
		}
	}
}