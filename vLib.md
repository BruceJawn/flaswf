# vLib #

Add your content here.


## Status: ##

|v0.1 Released!|
|:-------------|

## Description: ##
The virtual library project, a AS3 swc lib to manage your flash project's resources.
## Features: ##

Load once and then use all resources directly.

Export all resources as a single compressed binary file to protect your swf assets.

Export a .as Class with Embeds automatically.

## Todos: ##

## License: ##

|Closed Source/Free|
|:-----------------|

## Labels: ##
  * languages
  * tools
## Pics: ##

## Download: ##
bin: https://flaswf.googlecode.com/svn/trunk/vLib/bin

examples: https://flaswf.googlecode.com/svn/trunk/vLib/examples
## Source: ##

## API References: ##
```
public class Lib extends Sprite
{
		public function getBin (name:String) : ByteArray;
       /**
       * [function]:
        Get the Binary file in the Virtual Library.
       * [params]
         name: asset name declared in your "vLib.xml" file.
       * [return value]: 
         the binary file as a ByteArray.
       **/
		public function getBitmapData (name:String) : BitmapData;
       /**
       * [function]:
        Get the Picture file in the Virtual Library.
       * [params]
         name: asset name declared in your "vLib.xml" file.
       * [return value]: 
         the picture file as a BitmapData.
       **/

		public function getSound (name:String) : ByteArray;
       /**
       * [function]:
        Get the MP3 file in the Virtual Library.
       * [params]
         name: asset name declared in your "vLib.xml" file.
       * [return value]: 
         the mp3 file as a ByteArray.
       **/

		public function getSwf (name:String) : Loader;
       /**
       * [function]:
        Get the SWF file in the Virtual Library.
       * [params]
         name: asset name declared in your "vLib.xml" file.
       * [return value]: 
         the swf file as a Loader.
       **/

		public function getText (name:String) : String;
       /**
       * [function]:
        Get the TXT file in the Virtual Library.
       * [params]
         name: asset name declared in your "vLib.xml" file.
       * [return value]: 
         the txt file as a String.
       **/

		public function getXML (name:String) : XML;
       /**
       * [function]:
        Get the XML file in the Virtual Library.
       * [params]
         name: asset name declared in your "vLib.xml" file.
       * [return value]: 
         the xml file as a XML.
       **/

		public function init0 (Libxmlurl:String, levelindex:int=0) : void;
       /**
       * [function]:
        Initialize the Virtual Library with the Description XML URL.
       * [params]
         Libxmlurl: string of the url for description xml.
         levelindex: reserved.
       * [return value]: 
         none.
       **/

		public function init1 (Libbinurl:String) : void;
       /**
       * [function]:
        Initialize the Virtual Library with a Compressed Binary File.
       * [params]
         Libxmlurl: string of the url for binary file.
       * [return value]: 
         none.
       **/


		public function Lib ();
       /**
       * [function]:
        Initialize the Virtual Library Class.
       * [params]
         none.
       * [return value]: 
         none.
       **/


		public function load (lib:ByteArray) : void;
       /**
       * [function]:
        Initialize the Virtual Library with a Compressed Binary File.
       * [params]
         lib: ByteArray of the binary file.
       * [return value]: 
         none.
       **/

		public function save (name:String="MyLib.vLib") : void;
       /**
       * [function]:
        Save all the Resources as a Compressed Binary File.
       * [params]
         name: name string of the binary file.
       * [return value]: 
         none.
       **/


		public function XML2AS (Libxmlurl:String, className:String="myLib", packageName:String="", levelindex:int=0) : void;
       /**
       * [function]:
        Export all the Resources as a .as Class File.
       * [params]
         Libxmlurl: name string of the binary file.
         className: class name of the .as file.
         packageName: package name of the .as file.
         Levelindex: reserved.
       * [return value]: 
         none.
       **/

}
```
## Blog Posts: ##
http://bruce-lab.blogspot.com/2011/08/use-vlibswc-to-manage-flash-project.html
## Links: ##