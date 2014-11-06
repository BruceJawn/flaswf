/**
 * TextParser
 * Copyright (c) <2014> <Bruce Jawn> [http://bruce-lab.blogspot.com]
 * This software is released under the MIT License
 * <http://www.opensource.org/licenses/mit-license.php>
 */

package;

/**
 * ...
 * @author Bruce
 */

/** 
 * This class is omitted from the output. 
 * 
 * @private 
 */ 
class TextParser 
{
    private var Text:String;//the text file to parse
	private var TextIndex:Int;//temp var holding the current index

	public function new(srcText:String):Void
	{
		Text = srcText;
		TextIndex = 0;//GotoFileHead
	}
	
	public function EndofFile():Bool
	{
		return (TextIndex >= Text.length - 1);
	}
	
	public function ReadString():String
	{
		var c:String;
        var retStr:String = "";
        c = Text.charAt(TextIndex++);
 
		while ((c == ' ' || c == '\t') && TextIndex < Text.length)
		{
		c = Text.charAt(TextIndex++);	
		}
        
		while (c != ' ' && c != '\t' && c != '\r' && c != '\n'  && TextIndex < Text.length)
		{
		retStr += c;
		c = Text.charAt(TextIndex++);
		}
		return retStr;
	}
	
	public function ReadInteger():Int
	{
		return Std.parseInt(ReadString());
	}
	
	public function GotoNextLine():Void
	{
	    var c:String;
		c = Text.charAt(TextIndex++);
        while( c != '\n' && !EndofFile())
        {
        c = Text.charAt(TextIndex++);
        }
	}
	
	public function GetWholeLine():String
	{
		var c:String;
        var retStr:String = "";
	    if ( TextIndex > Text.length-1)
        return retStr;
		do 
		{
			c = Text.charAt(TextIndex++);
		}
        while ( c == '\n' && TextIndex < Text.length);
		if ( TextIndex > Text.length-1)
        return retStr;
		
		// read whole line
        do 
		{
		retStr += c;
		c = Text.charAt(TextIndex++);
		}
		while ( c != '\n' && TextIndex < Text.length);
		
		return retStr;
	}
	
}