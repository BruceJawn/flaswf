package {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.external.*;
	import flash.system.*;
	public class codeViewer extends Sprite {
		var AS3KeyWords:String="addEventListener|align|ArgumentError|arguments|Array|as|AS3|Boolean|break|case|catch|class|Class|const|continue|data|Date|decodeURI|decodeURIComponent|default|DefinitionError|delete|do|dynamic|each|else|encodeURI|encodeURIComponent|Error|escape|EvalError|extends|false|finally|flash_proxy|for|function|get|getLineOffset|height|if|implements|import|in|include|index|Infinity|instanceof|interface|internal|intrinsic|is|isFinite|isNaN|isXMLName|label|load|namespace|NaN|native|new|null|Null|object_proxy|override|package|parseFloat|parseInt|private|protected|public|return|set|static|super|switch|this|throw|trace|true|try|typeof|undefined|unescape|use|var|void|while|with|Accessibility|AccessibilityProperties|ActionScriptVersion|ActivityEvent|AntiAliasType|ApplicationDomain|AsyncErrorEvent|AVM1Movie|BevelFilter|Bitmap|BitmapData|BitmapDataChannel|BitmapFilter|BitmapFilterQuality|BitmapFilterType|BlendMode|BlurFilter|ByteArray|Camera|Capabilities|CapsStyle|ColorMatrixFilter|ColorTransform|ContextMenu|ContextMenuBuiltInItems|ContextMenuEvent|ContextMenuItem|ConvolutionFilter|CSMSettings|DataEvent|Dictionary|DisplacementMapFilter|DisplacementMapFilterMode|DisplayObject|DisplayObjectContainer|DropShadowFilter|Endian|EOFError|ErrorEvent|Event|EventDispatcher|EventPhase|ExternalInterface|FileFilter|FileReference|FileReferenceList|FocusEvent|Font|FontStyle|FontType|FrameLabel|Function|GlowFilter|GradientBevelFilter|GradientGlowFilter|GradientType|Graphics|GridFitType|HTTPStatusEvent|IBitmapDrawable|ID3Info|IDataInput|IDataOutput|IDynamicPropertyOutput|IDynamicPropertyWriter|IEventDispatcher|IExternalizable||IllegalOperationError|IME|IMEConversionMode|IMEEvent|int|InteractiveObject|InterpolationMethod|InvalidSWFError|IOError|IOErrorEvent|JointStyle|Keyboard|KeyboardEvent|KeyLocation|LineScaleMode|Loader|LoaderContext|LoaderInfo|LocalConnection|Math|Matrix|MemoryError|Microphone|MorphShape|Mouse|MouseEvent|MovieClip|Namespace|NetConnection|NetStatusEvent|NetStream|Number|Object|ObjectEncoding|PixelSnapping|Point|PrintJob|PrintJobOptions|PrintJobOrientation|ProgressEvent|Proxy|QName|RangeError|Rectangle|ReferenceError|RegExp|resize|result|Responder|scaleMode|Scene|ScriptTimeoutError|Security|SecurityDomain|SecurityError|SecurityErrorEvent|SecurityPanel|setTextFormat|Shape|SharedObject|SharedObjectFlushStatus|SimpleButton|Socket|Sound|SoundChannel|SoundLoaderContext|SoundMixer|SoundTransform|SpreadMethod|Sprite|StackOverflowError|Stage|stageHeight|stageWidth|StageAlign|StageQuality|StageScaleMode|StaticText|StatusEvent|String|StyleSheet|SWFVersion|SyncEvent|SyntaxError|System|text|TextColorType|TextDisplayMode|TextEvent|TextField|TextFieldAutoSize|TextFieldType|TextFormat|TextFormatAlign|TextLineMetrics|TextRenderer|TextSnapshot|Timer|TimerEvent|Transform|true|TypeError|uint|URIError|URLLoader|URLLoaderDataFormat|URLRequest|URLRequestHeader|URLRequestMethod|URLStream|URLVariables|VerifyError|Video|width|XML|XMLDocument|XMLList|XMLNode|XMLNodeType|XMLSocket|flash|display|addChild|graphics|clear|beginBitmapFill|endFill|drawRect|geom|rect|draw|fillRect|getPixel|getPixels|getPixel32|lock()|noise|perlinNoise|setPixel|setPixels|setPixel32|unlock|beginFill|clear|curveTo|drawEllipse|drawCircle|drawRect|drawRoundRect |endFill()|lineStyle|moveTo|lineTo|events|ENTER_FRAME|mouseX|mouseY|stage";
		var EvaldrawKeyWords:String="ScreenBuffer|Screen|Canvas|Canvas|Pen|onEnterFrame";
		var AS3SystemObjects:String="not_set_yet";
		var KeywordFormat:TextFormat=new TextFormat(null,null,0x0000FF);
		var EvaldrawKeywordFormat:TextFormat=new TextFormat(null,null,0x00FF00);
		var SystemObjectFormat:TextFormat=new TextFormat(null,null,0xFF0000);
		var BracketFormat:TextFormat=new TextFormat(null,null,0x000000);
		var StringFormat:TextFormat=new TextFormat(null,null,0x009900);
		var CommentFormat:TextFormat=new TextFormat(null,null,0x666666);
		var DefaultFormat:TextFormat=new TextFormat(null,null,0x000000);
		// comment "with a double quote string "
		// comment 'with a single quote string '
		/* multiline comment " with a string " in one line*/
		/* multiline comment 
		accross multiple lines*/
		var SingleQuoteString:RegExp=new RegExp("\'.*\'","g");
		var DoubleQuoteString:RegExp=new RegExp("\".*\"","g");
		var StartMultiLineQuote:RegExp=new RegExp("/\\*.*","g");
		var EndMultiLineQuote:RegExp=new RegExp("\\*/.*","g");
		var KeyWords:RegExp=new RegExp("(\\b)("+AS3KeyWords+"){1}(\\.|(\\s)+|;|,|\\(|\\)|\\]|\\[|\\{|\\}){1}","g");
		var EKeyWords:RegExp=new RegExp("(\\b)("+EvaldrawKeyWords+"){1}(\\.|(\\s)+|;|,|\\(|\\)|\\]|\\[|\\{|\\}){1}","g");
		var SystemObjects:RegExp=new RegExp("(\\b)("+AS3SystemObjects+"){1}(\\.|(\\s)+|;|,|\\(|\\)|\\]|\\[|\\{|\\}){1}","g");
		var Comment:RegExp=new RegExp("//.*","g");
		var Brackets:RegExp=new RegExp("(\\{|\\[|\\(|\\}|\\]|\\))","g");

		var txtCode:TextField=new TextField  ;
		var txtLineNumbers:TextField=new TextField  ;
		var txtPath:String=null;
		var codeLoader:URLLoader=new URLLoader  ;

		function codeViewer():void {
			init();
		}//end of function codeViewer

		function init():void {
			createCodeBox();
			createLineBox();
			//stage.align=StageAlign.TOP_LEFT;
			//stage.scaleMode=StageScaleMode.NO_SCALE;
			txtCode.addEventListener('scroll',codeScrolled);
		}//end of function init

		public function set code(code:String) {
			txtCode.text=code.replace(new RegExp("\r\n","ig"),"\n");
			txtLineNumbers.text="1\n";
			HighlightSyntax();
			txtCode.wordWrap=true;
			for (var i=1; i<txtCode.numLines; i++) {
				txtLineNumbers.appendText(i+1+"\n");
			}//end of for
		}//end of function set code

		public function get code() {
			return txtCode.text;
		}//end of function get code

		function HighlightSyntax():void {
			var InMultilineComment:Boolean=false;
			for (var i=0; i<txtCode.numLines; i++) {
				if (InMultilineComment) {
					txtCode.setTextFormat(CommentFormat,txtCode.getLineOffset(i),txtCode.getLineOffset(i)+txtCode.getLineText(i).length);
					InMultilineComment=! ParseExpression(EndMultiLineQuote,CommentFormat,i,false);
				} else {
					var CommentIndex:Boolean;
					ParseExpression(KeyWords,KeywordFormat,i,true);
					ParseExpression(EKeyWords,EvaldrawKeywordFormat,i,true);
					ParseExpression(SystemObjects,SystemObjectFormat,i,true);
					ParseExpression(Brackets,BracketFormat,i,false);
					ParseExpression(SingleQuoteString,StringFormat,i,false);
					ParseExpression(DoubleQuoteString,StringFormat,i,false);
					CommentIndex=ParseExpression(Comment,CommentFormat,i,false,true);
					InMultilineComment=ParseExpression(StartMultiLineQuote,CommentFormat,i,false,true);
					if (InMultilineComment) {
						InMultilineComment=! ParseExpression(EndMultiLineQuote,CommentFormat,i,false,true);
					}
				}
			}//end of for
		}//end of function HighlightSyntax

		function ParseExpression(exp:RegExp,format:TextFormat,lineno:Number,Trim:Boolean,DontSearchStrings:Boolean=false):Boolean {
			var result:Object=exp.exec(txtCode.getLineText(lineno));
			if (result==null) {
				return false;
			}//end of if

			while (result!=null) {
				if (DontSearchStrings) {
					var IsInString:Boolean=false;
					if (InString(result,DoubleQuoteString,lineno)==true) {
						IsInString=true;
					}
					if (InString(result,SingleQuoteString,lineno)==true) {
						IsInString=true;
					}
					if (IsInString) {
						return false;
					}
				}
				if (Trim) {
					txtCode.setTextFormat(format,txtCode.getLineOffset(lineno)+result.index,txtCode.getLineOffset(lineno)+result.index+result[0].length-1);
				} else {
					txtCode.setTextFormat(format,txtCode.getLineOffset(lineno)+result.index,txtCode.getLineOffset(lineno)+result.index+result[0].length);
				}
				result=exp.exec(txtCode.getLineText(lineno));
			}
			return true;
		}//end of function ParseExpression

		function InString(result:Object,exp:RegExp,lineno:Number):Boolean {
			var stringResult:Object=exp.exec(txtCode.getLineText(lineno));
			var IsInString:Boolean=false;
			while (stringResult!=null) {
				if (result.index>stringResult.index&&result.index<stringResult.index+stringResult[0].length) {
					IsInString=true;
				}
				stringResult=exp.exec(txtCode.getLineText(lineno));
			}
			return IsInString;
		}//end of function InString

		function codeScrolled(e:Event):void {
			txtLineNumbers.scrollV=e.target.scrollV;
		}//end of function codeScrolled

		function createCodeBox():void {
			var format:TextFormat = new TextFormat();
			format.size=16;
			format.bold=true;
			with (txtCode) {
				type=TextFieldType.INPUT;
				border=true;
				borderColor=0x000000;
				background=true;
				backgroundColor=0xffffff;
				multiline=true;
				//wordWrap=true;
				mouseWheelEnabled=true;
				alwaysShowSelection=true;
				defaultTextFormat=format;
			}//end of with(myTextBox)
			addChild(txtCode);
			txtCode.width=470;
			txtCode.height=480;
			txtCode.x=50;
			txtCode.addEventListener(Event.CHANGE,changeHandler);
		}//end of function

		function changeHandler(e:Event):void {
			code=e.target.text;
		}//end of function changeHandler

		function createLineBox():void {
			var format:TextFormat = new TextFormat();
			format.size=16;
			format.bold=true;
			txtLineNumbers.width=50;
			txtLineNumbers.height=480;
			with (txtLineNumbers) {
				border=true;
				borderColor=0x000000;
				background=true;
				backgroundColor=0xBEBEBE;
				//wordWrap=true;
				mouseWheelEnabled=true;
				defaultTextFormat=format;
			}//end of with(myTextBox)
			addChild(txtLineNumbers);
		}//end of function

	}//end of class
}//end of package