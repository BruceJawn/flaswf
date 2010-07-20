package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import PNGEncoder;
	//snapshot swf as png 
	public class SavingBitmap extends Bitmap {
		var _fileRef:FileReference= new FileReference();
		var _encoder:PNGEncoder = new PNGEncoder();

		public function SavingBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false) {
			super(bitmapData, pixelSnapping, smoothing);
		}//end of function SavingBitmap

		public function save(defaultFileName:String = null):void {
			var ba:ByteArray=PNGEncoder.encode(bitmapData);//encode bitmapdata
			_fileRef.save(ba, defaultFileName);//save png
			ba.clear();
		}//end of function save

	}//end of class
}//end of package