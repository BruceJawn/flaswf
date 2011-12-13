[Embed(source="assets/sound/eb.mp3")]
public var ebSC:Class;
var EB = new ebSC();

public function PlaySound(name:String, num:int):void
{
	if (name == "eliminate_balls")
	{
		EB.play(num);
	}
}