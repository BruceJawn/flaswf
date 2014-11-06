/**
 * JGG-UI v0.2
 * Copyright (c) <2014> <Bruce Jawn> [http://bruce-lab.blogspot.com]
 * This software is released under the MIT License
 * <http://www.opensource.org/licenses/mit-license.php>
 */
package;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import motion.Actuate;
/**
 * ...
 * @author Bruce
 * 
 * Cells holder.
 */
class JGG extends Sprite
{
    /**
	 * @private
	 * Cells on the current layer.
	 */
    private var CurrentLayerCells:Array<JGGCell>;
	/**
	 * @private
	 * All cells.
	 */
	private var Cells:Array<JGGCell>;
    /**
	 * Size of the cells.
	 */
	public var CellsSize:Int;
	/**
	 * Current level info.
	 */
	public var CurrentLevel:Array<Int>;
	/**
	 * Type Level of Cells.
	 */
	/*
	typedef LevelCells = { 
		var Cells:Array<JGGCell>; 
		var Level:String; 
		}
	*/	
	/**
	 * Array of LevelCells.
	 */
	private var LevelCellsArray:Array<Dynamic>;
	/**
	 * The JGG UI host.
	 */
	public var UIHost:Sprite;
	/**
	 * The Icons host.
	 */
	public var ResHost:Dynamic;
	
	/** 
    * 
    * Constructor function.</p> 
    * 
	* @private  
    * @return nothing;
    * 
    */ 
	public function new():Void
	{
		super();
	}
	
	/** 
    * Initialize the JGG. 
    * 
    * @param UIHost The JGG UI host, usually the parent of JGG. 
    * @param ResHost The Icons host, with <code>getIcon(ID:String)</code> 
	* implemented as a public function.
    * @param UILayout The txt config file declaring all the cells and their relations. 
	* @param CellsSize Size of the cells. 
	*  
    */ 
	public function init(UIHost,ResHost,UILayout,CellsSize=64):Void
	{
		CurrentLevel = new Array();
		Cells = new Array();
		CurrentLayerCells = new Array();
		LevelCellsArray = new Array();
		this.UIHost = UIHost;
		this.ResHost = ResHost;
		this.CellsSize = CellsSize;
		parse(UILayout);
		draw();
	}
	
	/** 
    * Get some cell by name. 
    * 
    * @param name The name of the cell. 
	* 
	* @return The cell with the given name, or <code>null</code> if not found. 
	*  
    */ 
	public function getCell(name:String):JGGCell 
	{
		for (i in 1...Cells.length)
		{
			if (Cells[i].name == name)
			{
				return Cells[i];
			}
		}
		return null;
	}
	
	/** 
    * Get some cell by name. 
    * 
    * @param Parse the txt config file and create the cells. 
	*  
    */ 
	private function parse(SetUpFileContent:String):Void
	{
		var myTextParser:TextParser = new TextParser(SetUpFileContent);
		while (!myTextParser.EndofFile())
		{
		var Name:String = myTextParser.ReadString();
		//comment line
		if (Name == "#")
		{
			myTextParser.GotoNextLine();
			continue;
		}
		var CallBackStr:String = myTextParser.ReadString();
		var CallBackFunc:MouseEvent->Void;
		var Color:UInt = myTextParser.ReadInteger();
		var IconStr:String = myTextParser.ReadString();
		var Label:String = myTextParser.ReadString();
		Label = Label.split('_').join(' ');
		Label = Label.split('/').join('\n');
		var LevelStr:String = myTextParser.ReadString();
		var LevelStrArray:Array<String> = LevelStr.split(',');
		var Level:Array<Int> = new Array(); 
		for (i in 0...LevelStrArray.length)
		{
			Level[i] = Std.parseInt(LevelStrArray[i]);
		}
		
		//some shortcut strings
		//JGG_ChangeLevel - Enter a new level from current cell or Exit current level
		if (CallBackStr == "JGG_ChangeLevel")
			CallBackFunc = onClickChangeLevelCell;
		else
			CallBackFunc = Reflect.field(UIHost, CallBackStr);
			
		var Icon:DisplayObject = null;
		if (IconStr != 'null') Icon = ResHost.getIcon(IconStr);
		var tempcell:JGGCell = new JGGCell();
		
		tempcell.init(Name, Level, CallBackFunc,
		Color,Icon,Label,CellsSize);
	    Cells.push(tempcell);
		//Create the array of LevelCells
		var InLevel:Bool = false;
		var InLevelIndex:UInt = 0;
		var LevelString:String = (tempcell.Level.slice(0, tempcell.Level.length - 1)).join("");
		for (i in 0...LevelCellsArray.length)
		{
			if (LevelCellsArray[i].Level == LevelString)
			{
				LevelCellsArray[i].Cells.push(tempcell);
				InLevel = true;
				break;
			}
		}
		
		if (!InLevel)
		{
			LevelCellsArray.push( { Cells : new Array(), Level : LevelString } );
			LevelCellsArray[LevelCellsArray.length - 1].Cells.push(tempcell);
			//trace(LevelCellsArray[LevelCellsArray.length - 1]);
		}

		//default is first level (0), find all first level cells
		if (Level.length == 1)
		{   
			CurrentLayerCells.push(tempcell);
		}
		
		myTextParser.GotoNextLine();
		}
		
	}
	
    /** 
    * Draw the UI.
    */ 
	public function draw():Void
	{
		//remove all existing children
		while (this.numChildren > 0) 
		{
        removeChildAt(0);
		}
		//add all cells on current level
		for (i in 0...CurrentLayerCells.length)
		{
			addChild(CurrentLayerCells[i]);
			var PosX:Int = 0;
			var PosY:Int = 0;
			switch(CurrentLayerCells[i].Level[CurrentLevel.length])
			{
				case 0: 
					PosX = 0;
					PosY = 0;
				case 1:
					PosX = -1;
					PosY = 0;
				case 2:
					PosX = -1;
					PosY = -1;
				case 3:
					PosX = 0;
					PosY = -1;
				case 4:
					PosX = 1;
					PosY = -1;
				case 5:
					PosX = 1;
					PosY = 0;
				case 6:
					PosX = 1;
					PosY = 1;
				case 7:
					PosX = 0;
					PosY = 1;
				case 8:
					PosX = -1;
					PosY = 1;
			}
			
			CurrentLayerCells[i].x = 0;
			CurrentLayerCells[i].y = 0;
			Actuate.tween (CurrentLayerCells[i], 1, { x: PosX * 64 } );
			Actuate.tween (CurrentLayerCells[i], 1, { y: PosY * 64 } );
			//CurrentLayerCells[i].x = PosX * 64;
			//CurrentLayerCells[i].y = PosY * 64;
		}
	}
	
	/** 
    * Close current level and go back to parent level.
    */ 
	public function foldLevel(/*TargetCell:JGGCell*/):Void
	{
		preLevel();
		draw();
	}
	
	/** 
    * Go to child level.
    */ 
	public function unfoldLevel(TargetCell:JGGCell):Void
	{
		var Level:Int = (TargetCell.Level[CurrentLevel.length]);
		nextLevel(Level);
		draw();
	}
	
	/** 
    * Shortcut event handler function.
	* Default behavior: cell index - 0: fold, - other: unfold
    */ 
	private function onClickChangeLevelCell(e:Event):Void
	{
		var Level:UInt = (e.currentTarget.Level[CurrentLevel.length]);
		if (e.currentTarget.Level.length == 1)
		{
		nextLevel(Level);
		draw();	
		}
		else if (Level == 0)
		{
		preLevel();
		draw();
		}
		else
		{
		nextLevel(Level);
		draw();
		}
	}
	
	private function nextLevel(Level:UInt):Void
	{
		//trace(CurrentLevel);
		CurrentLevel.push(Level);
		
		var LevelString:String = CurrentLevel.join("");
		for (i in 0...LevelCellsArray.length)
		{
			if (LevelCellsArray[i].Level == LevelString)
			{
				CurrentLayerCells = LevelCellsArray[i].Cells;
				break;
			}
		}
		//CurrentLayerCells = new Array();
		/*
		//find all cells that are in the level
		for (i in 0...Cells.length)
		{
			if (Cells[i].Level.length != (CurrentLevel.length + 1))
			continue;
			var match:Bool = true;
			for (j in 0...CurrentLevel.length)
			{
				if (CurrentLevel[j] != Cells[i].Level[j])
				{
					match = false;
					break;
				}
			}
			if (!match) continue;
			else CurrentLayerCells.push(Cells[i]);
		}
		*/
	}
	
	private function preLevel():Void
	{
		//trace(CurrentLevel);
		CurrentLevel.pop();
        
		var LevelString:String = CurrentLevel.join("");
		for (i in 0...LevelCellsArray.length)
		{
			if (LevelCellsArray[i].Level == LevelString)
			{
				CurrentLayerCells = LevelCellsArray[i].Cells;
				break;
			}
		}
		//CurrentLayerCells = new Array();
		/*
		for (i in 0...Cells.length)
		{
			if (Cells[i].Level.length != (CurrentLevel.length + 1))
			continue;
			else if (CurrentLevel.length == 0)//starting level
			{
				if (Cells[i].Level.length == 1)
				CurrentLayerCells.push(Cells[i]);
				else
				continue;
			}
			else//not starting level
			{
			var match:Bool = true;
			for (j in 0...CurrentLevel.length)
			{
				if (CurrentLevel[j] != Cells[i].Level[j])
				{
					match = false;
					break;
				}
			}
			if (!match) continue;
			else CurrentLayerCells.push(Cells[i]);
			}
		}
		*/
	}//end of function preLevel()
}