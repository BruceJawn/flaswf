/**
 * JGG-UI v0.2
 * Copyright (c) <2014> <Bruce Jawn> [http://bruce-lab.blogspot.com]
 * This software is released under the MIT License
 * <http://www.opensource.org/licenses/mit-license.php>
 */
package ;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

/**
 * ...
 * @author Bruce
 * 
 * One Cell.
 */
class JGGCell extends Sprite
{

	/**
	 * The level information of the cell, e.g., 0,1,1,2.
	 * @private
	 */
	public var Level:Array<Int>;
	/**
	 * @private
	 * The callback function pointer.
	 */
	public var CallBack:MouseEvent->Void;
	/**
	 * @private
	 * Background color of the cell.
	 */
	public var Color:UInt;
	/**
	 * @private
	 * Icon of the cell.
	 */
	public var Icon:DisplayObject;
	/**
	 * @private
	 * Label text of the cell.
	 */
	public var Label:String;
	/**
	 * @private
	 * Size of the cell.
	 */
	public var Size:Int;
	
	/** 
    * 
    * Constructor function.</p> 
    * @private  
    * @return nothing;
    *  
    */ 
	public function new() 
	{
		super();
	}
	
	/** 
    * Initialize the cell. 
    * 
    * @param Name Name of the cell. 
    * @param Level Level information of the cell. 
    * @param CallBack Callback function pointer of the cell. 
	* @param Color Background color of the cell. 
	* @param Icon Icon of the cell. 
	* @param Label Label text of the cell.
	* @param Size Size of the cell.
	*  
    */ 
	public function init(Name:String,Level:Array<Int>,CallBack:MouseEvent->Void,Color:UInt,Icon:DisplayObject=null,Label:String=null,Size:Int=64):Void
	{
		this.name = Name;
		this.Level = Level;
		this.CallBack = CallBack;
		this.Color = Color;
		this.Icon = Icon;
		this.Label = Label;
		this.Size = Size;
		draw();
		this.buttonMode = true;
		this.mouseChildren = false;
		this.addEventListener(MouseEvent.CLICK, CallBack);
	}
	
	/** 
    * Draw the cell.
    */ 
	public function draw():Void
	{   
		this.graphics.clear();
		//this.graphics.lineStyle(0x0);
		this.graphics.beginFill(Color);
		this.graphics.drawRect(-Size/2, -Size/2, Size, Size);
		this.graphics.endFill();
		//If has Icon, then add the Icon
		if (Icon != null)
		{
		addChild(Icon);
		//Icon.width = 64;
		//Icon.height = 64;
		Icon.x = -Size/2;
		Icon.y = -Size/2;
		}//No Icon, use text label
		else if (Label != null && Label !="null")
		{
			var LabelTF:TextField = new TextField();
			LabelTF.width = Size;
			LabelTF.height = Size;
			LabelTF.htmlText = '<P ALIGN="CENTER"><b>'+'\n'+Label+'</b></P>';
			addChild(LabelTF);
			LabelTF.x = -Size/2;
		    LabelTF.y = -Size/2;
			LabelTF.selectable = false;
		}
		
	}
}