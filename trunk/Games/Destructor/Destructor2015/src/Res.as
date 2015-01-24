import flash.media.SoundChannel;
/*[Embed(source="sky.jpg")]
   private static var skyTexClass:Class;
   private var cloudmap:BitmapData = new skyTexClass().bitmapData;

   [Embed(source="ground.png")]
   private static var groundTexClass:Class;
   private var groundmap:BitmapData = new groundTexClass().bitmapData;

   [Embed(source="eb.mp3")]
   public var ebSC:Class;
   private var EB:Sound = new ebSC();

   [Embed(source="smzy_2011121101833177.mp3")]
   public var bcSC:Class;
   private var BC:Sound = new bcSC();

   [Embed(source="ball.mp3")]
   public var baSC:Class;
   private var BA:Sound = new baSC();
 */
[Embed(source="../res/music/Theme Crystalized .mp3")]
public var MusicC:Class;
private var Music:Sound = new MusicC();
private var playMusic:Boolean = true;
private var musicPlaying:Boolean = false;
private var MusicSC:SoundChannel;
private var lastMPosition:int = 0;

[Embed(source="../newVox11.vb",mimeType="application/octet-stream")] //vxlwolf vxlvoxlapdemo.vb map.vd
public static var dataClass:Class;

[Embed(source="../greystone.png")] //vxlwolf
public static var groundTexClass:Class;