// Copyright (c) 2013 Adobe Systems Inc

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.LocalConnection;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.events.EventDispatcher;
	
	import CrossBridge.libscws.*;
	import CrossBridge.libscws.vfs.*;
	/**
	 * LibSCWS For Flash/AS3 v1.0
	 * By <Bruce Jawn> [http://bruce-lab.blogspot.com]
	 * This software is released under the BSD License
	 * <http://opensource.org/licenses/BSD-3-Clause>
	 * This software is ported from SCWS-1.2.2 by hightman
	 * [http://www.xunsearch.com/scws/] & [https://github.com/hightman/scws]
	 */
	/**
	 * A basic implementation of a console for FlasCC apps.
	 * The PlayerKernel class delegates to this for things like read/write
	 * so that console output can be displayed in a TextField on the Stage.
	 */
	//compiler options enable strict mode = false!
	public class Console extends Sprite implements ISpecialFile
	{
		private var enableConsole:Boolean = true
		private var _tf:TextField
		private var inputContainer:DisplayObjectContainer
		
		private var alclogo:String = "FlasCC"
		private var vfsURL:URLLoaderVFS;
		
		/**
		 * To Support the preloader case you might want to have the Console
		 * act as a child of some other DisplayObjectContainer.
		 */
		public function Console(container:DisplayObjectContainer = null)
		{
			CModule.rootSprite = container ? container.root : this
			
			if (container)
			{
				container.addChild(this)
				init(null)
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init)
			}
		}
		
		/**
		 * All of the real FlasCC init happens in this method
		 * which is either run on startup or once the SWF has
		 * been added to the stage.
		 */
		protected function init(e:Event):void
		{
			inputContainer = new Sprite()
			addChild(inputContainer)
			
			addEventListener(Event.ENTER_FRAME, enterFrame)
			
			stage.frameRate = 60
			stage.scaleMode = StageScaleMode.NO_SCALE
			
			if (enableConsole)
			{
				_tf = new TextField
				_tf.multiline = true
				_tf..wordWrap = true
				_tf.width = stage.stageWidth
				_tf.height = stage.stageHeight - 25;
				inputContainer.addChild(_tf)
			}
			
			// PlayerKernel will delegate read/write requests to the "/dev/tty"
			// file to the object specified with this API.
			CModule.vfs.console = this;
			vfsURL = new URLLoaderVFS();
			vfsURL.loadManifest("manifest.txt");
			vfsURL.addEventListener(Event.COMPLETE, onLoadedVFS);
			CModule.vfs.addBackingStore(vfsURL, "/")
		}
		
		private function onLoadedVFS(event:Event):void
		{
			trace("loaded!")
			CModule.vfs.addBackingStore(vfsURL, "/")
			CModule.startAsync(this);
			var args:Vector.<int> = new Vector.<int>;
			CModule.callI(CModule.getPublicSymbol("simpleTest"), args);
			initialize_SCWS_AS3();
			//trace(scws_send_text_AS3("Hello, 我名字叫李那曲是一个中国人, 我有时买Q币来玩, 我还听说过C#语言"));
			createInput();
		}
		
		private var input:TextField = new TextField();
		
		private function createInput():void
		{
			
			input.type = "input";
			input.text = "在这里输入需要进行分词的文字[以回车键结束]："
			input.border = true;
			input.width = stage.stageWidth - 2;
			input.multiline = input.wordWrap = false;
			input.height = 20;
			input.y = stage.stageHeight - 25;
			input.addEventListener(KeyboardEvent.KEY_DOWN, handleInput, false, 0, true);
			addChild(input);
		}
		
		private function handleInput(event:KeyboardEvent):void
		{
			event.stopImmediatePropagation();
			if (event.keyCode == 13) // Listen for Return key press.
			{
				var str:String = input.text;
				consoleWrite("\n");
				consoleWrite("========================================\n");
				consoleWrite("[输入]: \n");
				consoleWrite(input.text + "\n");
				consoleWrite("----------------------------------------\n");
				consoleWrite("[分词结果]: \n");
				consoleWrite("[空格分隔]: \n"+scws_send_text_AS3(input.text));
				consoleWrite("\n");
				consoleWrite("========================================\n");
				input.text = "";
			}
		}
		/**
		 * The callback to call when FlasCC code calls the posix exit() function. Leave null to exit silently.
		 * @private
		 */
		public var exitHook:Function;
		
		/**
		 * The PlayerKernel implementation will use this function to handle
		 * C process exit requests
		 */
		public function exit(code:int):Boolean
		{
			// default to unhandled
			return exitHook ? exitHook(code) : false;
		}
		
		/**
		 * The PlayerKernel implementation will use this function to handle
		 * C IO write requests to the file "/dev/tty" (e.g. output from
		 * printf will pass through this function). See the ISpecialFile
		 * documentation for more information about the arguments and return value.
		 */
		public function write(fd:int, bufPtr:int, nbyte:int, errnoPtr:int):int
		{
			var str:String = CModule.readString(bufPtr, nbyte)
			consoleWrite(str)
			return nbyte
		}
		
		/**
		 * The PlayerKernel implementation will use this function to handle
		 * C IO read requests to the file "/dev/tty" (e.g. reads from stdin
		 * will expect this function to provide the data). See the ISpecialFile
		 * documentation for more information about the arguments and return value.
		 */
		public function read(fd:int, bufPtr:int, nbyte:int, errnoPtr:int):int
		{
			return 0
		}
		
		/**
		 * The PlayerKernel implementation will use this function to handle
		 * C fcntl requests to the file "/dev/tty"
		 * See the ISpecialFile documentation for more information about the
		 * arguments and return value.
		 */
		public function fcntl(fd:int, com:int, data:int, errnoPtr:int):int
		{
			return 0
		}
		
		/**
		 * The PlayerKernel implementation will use this function to handle
		 * C ioctl requests to the file "/dev/tty"
		 * See the ISpecialFile documentation for more information about the
		 * arguments and return value.
		 */
		public function ioctl(fd:int, com:int, data:int, errnoPtr:int):int
		{
			return 0
		}
		
		/**
		 * Helper function that traces to the flashlog text file and also
		 * displays output in the on-screen textfield console.
		 */
		protected function consoleWrite(s:String):void
		{
			trace(s)
			if (enableConsole)
			{
				_tf.appendText(s)
				_tf.scrollV = _tf.maxScrollV
			}
		}
		
		/**
		 * The enterFrame callback will be run once every frame. UI thunk requests should be handled
		 * here by calling CModule.serviceUIRequests() (see CModule ASdocs for more information on the UI thunking functionality).
		 */
		protected function enterFrame(e:Event):void
		{
			CModule.serviceUIRequests()
		}
		
		/**
		 * Provide a way to get the TextField's text.
		 */
		public function get consoleText():String
		{
			var txt:String = null;
			
			if (_tf != null)
			{
				txt = _tf.text;
			}
			
			return txt;
		}
	}
}
