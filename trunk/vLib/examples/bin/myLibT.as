package 
{
     import flash.display.*;
     import flash.media.*;
     import flash.text.*;
     import flash.utils.*;
//Export from vLib-v0.1 by Bruce Jawn (zhoubu1988@gmail.com)

     public class myLibT
     {
     [Embed(source="DataFiles/texts/Textfile_0.txt", mimeType="application/octet-stream")]
     private static const Textfile_0:Class;
     [Embed(source="DataFiles/texts/Textfile_1.txt", mimeType="application/octet-stream")]
     private static const Textfile_1:Class;
     [Embed(source="DataFiles/xmls/Xmlfile_0.xml", mimeType="application/octet-stream")]
     private static const Xmlfile_0:Class;
     [Embed(source="DataFiles/xmls/Xmlfile_1.xml", mimeType="application/octet-stream")]
     private static const Xmlfile_1:Class;
     [Embed(source="DataFiles/textures/JPGfile.JPG")]
     private static const JPGfile:Class;
     [Embed(source="DataFiles/textures/PNGfile.PNG")]
     private static const PNGfile:Class;
     [Embed(source="DataFiles/swfs/enemydead.swf")]
     private static const enemydead:Class;
     [Embed(source="DataFiles/swfs/enemyfire.swf")]
     private static const enemyfire:Class;
     [Embed(source="DataFiles/sounds/sound1.mp3")]
     private static const S0:Class;
     [Embed(source="DataFiles/sounds/sound2.mp3")]
     private static const S1:Class;
     [Embed(source="DataFiles/sounds/sound3.mp3")]
     private static const S2:Class;
     [Embed(source="DataFiles/bins/Binaryfile_0.bin", mimeType="application/octet-stream")]
     private static const Binaryfile_0:Class;
     [Embed(source="DataFiles/bins/Binaryfile_1.bin", mimeType="application/octet-stream")]
     private static const Binaryfile_1:Class;

        private function getClass(name:String):Class
        {
            var ClassReference:Class = getDefinitionByName("myLibT_"+name) as Class;
            return ClassReference;
        }      

		private function getInstance(name:String):Object
		{
			var ClassReference:Class = getClass(name);
			return new ClassReference();
		}
		public function getBin (name:String) : ByteArray
		{
			return ByteArray(getInstance(name));
		}
		
		public function getBitmapData (name:String) : BitmapData
		{
			return Bitmap(getInstance(name)).bitmapData;
		}

        public function getFont (name:String) : Class
		{
			return getClass(name);
			//return Font(getInstance(name));
			//Font.registerFont(EmbeddedFont); 
		}
		
		public function getSound (name:String) : Sound
		{
			return Sound(getInstance(name));
		}

		public function getSwf (name:String) : Sprite
		{
			return Sprite(getInstance(name));
		}

		public function getText (name:String) : String
		{
			return String(getInstance(name));
		}

		public function getXML (name:String) : XML
		{
			return XML(getInstance(name));
		}
	}//end of class	
}//end of package
	