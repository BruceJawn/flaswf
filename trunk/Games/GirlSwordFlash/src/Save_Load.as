
public function SaveData(data:ByteArray, path:String):void
{
	var so:SharedObject = SharedObject.getLocal(path);
	so.data.things = data;
	//trace("SaveData" + path)
	so.flush(); // writes changes to disk
}

public function SupplyData(path:String):void
{
	var so:SharedObject = SharedObject.getLocal(path);
	var data = so.data.things;
	this.libSDL.cLoader.supplyFile(path, data);
	//trace("SupplyData" + path)
}