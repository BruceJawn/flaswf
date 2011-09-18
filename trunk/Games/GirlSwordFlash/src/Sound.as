[Embed(source="voc/Aqing.mp3")]
public var AqingSC:Class;
var Aqing = new AqingSC();

[Embed(source="voc/ChangeButton.mp3")]
public var ChangeButtonSC:Class;
var ChangeButton = new ChangeButtonSC();

[Embed(source="voc/Fail.mp3")]
public var FailSC:Class;
var Fail = new FailSC();

[Embed(source="voc/Feitu.mp3")]
public var FeituSC:Class;
var Feitu = new FeituSC();

[Embed(source="voc/Jianke.mp3")]
public var JiankeSC:Class;
var Jianke = new JiankeSC();

[Embed(source="voc/OpenBox.mp3")]
public var OpenBoxSC:Class;
var OpenBox = new OpenBoxSC();

[Embed(source="voc/PushButton.mp3")]
public var PushButtonSC:Class;
var PushButton = new PushButtonSC();

[Embed(source="voc/Refresh.mp3")]
public var RefreshSC:Class;
var Refresh = new RefreshSC();

[Embed(source="voc/victory.mp3")]
public var victorySC:Class;
var victory = new victorySC();

[Embed(source="voc/Wujianshi.mp3")]
public var WujianshiSC:Class;
var Wujianshi = new WujianshiSC();

[Embed(source="voc/Wushi.mp3")]
public var WushiSC:Class;
var Wushi = new WushiSC();

[Embed(source="voc/Yehaizi.mp3")]
public var YehaiziSC:Class;
var Yehaizi = new YehaiziSC();


public function PlaySound(name:String,num:int):void
{
	//trace(name);
	if (name == "voc\\Aqing.wav")
	{
		Aqing.play(num);
	}
	else if (name == "voc\\ChangeButton.wav")
	{
		ChangeButton.play(num);
	}
	else if (name == "voc\\Fail.wav")
	{
		Fail.play(num);
	}
	else if (name == "voc\\Feitu.mp3")
	{
		Feitu.play(num);
	}
	else if (name == "voc\\Jianke.wav")
	{
		Jianke.play(num);
	}
	else if (name == "voc\\OpenBox.wav")
	{
		OpenBox.play(num);
	}
	else if (name == "voc\\PushButton.wav")
	{
		PushButton.play(num);
	}
	else if (name == "voc\\Refresh.wav")
	{
		Refresh.play(num);
	}
	else if (name == "voc\\victory.wav")
	{
		victory.play(num);
	}
	else if (name == "voc\\Wujianshi.wav")
	{
		Wujianshi.play(num);
	}
	else if (name == "voc\\Wushi.wav")
	{
		Wushi.play(num);
	}
	else if (name == "voc\\Yehaizi.wav")
	{
		Yehaizi.play(num);
	}
}