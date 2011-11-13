   /*
	* Bruce's Tiny Virtual Machine
	* 
    * Copyright (C) 2011 
    * Bruce Jawn [bruce-lab.blogspot.com]
    *
	*
	* BTVM is free software; you can redistribute it and/or modify
	* it under the terms of the GNU Lesser General Public License as published
	* by the Free Software Foundation; either version 3 of the License, or
	* (at your option) any later version.
	*
	* BTVM is distributed in the hope that it will be useful,
	* but WITHOUT ANY WARRANTY; without even the implied warranty of
	* MERCHANTABILITY or FITNESS FOR A PARTIMACULAR PURPOSE.  See the
	* GNU Lesser General Public License for more details.
	*
	* You should have received a copy of the GNU Lesser General Public License
	* along with this program.  If not, see <http://www.gnu.org/licenses/>.
	*
	*/
package{
	public class BTVMCore
	{
		public var Loc_Int:Array=[3];
		public var Loc_Flt:Array=[3];
		public var Loc_Str:Array=[3];
		
		public var Mem_Int:Array=[];
		public var Mem_Flt:Array=[];
		public var Mem_Str:Array=[];
		
		public var Mem_Label:Array=[];
		public var Mem_MnOpc:Array=[];

        //const input
		const BC_setloci =0x00;
		const BC_setlocf =0x01;
		const BC_setlocs =0x02;
        //const input
		const BC_cpyloci =0x03;
		const BC_cpylocf =0x04;
		const BC_cpylocs =0x05;
        //variable input
		const BC_setint =0x06;
		const BC_setflt =0x07;
		const BC_setstr =0x08;
        //const input
		const BC_goto =0x09;
		const BC_ifto =0x0A;
		const BC_call =0x0B;
		const BC_stat =0x0C;

		public var Mem_State:int=0;
		/*
		  Pause 2 
		  Run 0
		  Stop 1
		  */
		public var MainPos:int=0;
		public var ExternFunc:Object={};
		
		public function BTVMCore():void
		{
			//Run();
		}
		
		public function Run():void
		{
			RunL(Mem_MnOpc,MainPos,true);
			trace(Mem_Int);
			trace(Mem_Flt);
			trace(Mem_Str);
			trace(Mem_State);
		}
		public function RunL(CLabel:Array, pos=0, Main:Boolean=false):void
		{
			var i=pos;
			while(i<CLabel.length&&Mem_State==0)
			{
				
				if(CLabel[i]==BC_setloci)
				{
					if(CLabel[i+2]=="loc0")
					Loc_Int[CLabel[i+1]] = Loc_Int[0];
					else if(CLabel[i+2]=="loc1")
					Loc_Int[CLabel[i+1]] = Loc_Int[1];
					else if(CLabel[i+2]=="loc2")
					Loc_Int[CLabel[i+1]] = Loc_Int[2];
					else
					Loc_Int[CLabel[i+1]] = CLabel[i+2];
					i+=2;
				}
				else if(CLabel[i]==BC_setlocf)
				{
					if(CLabel[i+2]=="loc0")
					Loc_Flt[CLabel[i+1]] = Loc_Flt[0];
					else if(CLabel[i+2]=="loc1")
					Loc_Flt[CLabel[i+1]] = Loc_Flt[1];
					else if(CLabel[i+2]=="loc2")
					Loc_Flt[CLabel[i+1]] = Loc_Flt[2];
					else
					Loc_Flt[CLabel[i+1]] = CLabel[i+2];
					i+=2;
				}
				else if(CLabel[i]==BC_setlocs)
				{
					if(CLabel[i+2]=="loc0")
					Loc_Str[CLabel[i+1]] = Loc_Str[0];
					else if(CLabel[i+2]=="loc1")
					Loc_Str[CLabel[i+1]] = Loc_Str[1];
					else if(CLabel[i+2]=="loc2")
					Loc_Str[CLabel[i+1]] = Loc_Str[2];
					else
					Loc_Str[CLabel[i+1]] = CLabel[i+2];
					i+=2;
				}
				
				else if(CLabel[i]==BC_cpyloci)
				{
					Loc_Int[CLabel[i+1]] = Mem_Int[CLabel[i+2]];
					i+=2;
				}
				else if(CLabel[i]==BC_cpylocf)
				{
					Loc_Flt[CLabel[i+1]] = Mem_Flt[CLabel[i+2]];
					i+=2;
				}
				else if(CLabel[i]==BC_cpylocs)
				{
					Loc_Str[CLabel[i+1]] = Mem_Str[CLabel[i+2]];
					i+=2;
				}
				
				else if(CLabel[i]==BC_setint)
				{
					Mem_Int[Loc_Int[0]] = Loc_Int[2];
				}
				else if(CLabel[i]==BC_setflt)
				{
					Mem_Flt[Loc_Int[0]] = Loc_Flt[2];
				}
				else if(CLabel[i]==BC_setstr)
				{
					Mem_Str[Loc_Int[0]] = Loc_Str[2];
				}
				
				else if(CLabel[i]==BC_goto) 
				{
					RunL(Mem_Label[CLabel[i+1]]);
					i++;
				}
				else if(CLabel[i]==BC_ifto) 
				{
					if(Loc_Int[0]>0)
					RunL(Mem_Label[CLabel[i+1]]);
					i++;
				}
				else if(CLabel[i]==BC_call) 
				{
					ExternFunc[CLabel[i+1]]();//parameters & return value bind outside! call apply
					i++;
				}
				else if(CLabel[i]==BC_stat&&Main)//can only change state in Main thread 
				{
					Mem_State=CLabel[i+1];
					i++;
				}
				
				i++;
			}//end of while
			
			if(Main&&Mem_State!=0)
			{
				MainPos = i;
			}
			else if(Main&&Mem_State==0)
			{
				Stop();
			}
			
		}
		
		public function Continue():void
		{
			RunL(Mem_MnOpc,MainPos,true);
		}

		public function Pause():void
		{
			Mem_State = 2;
		}

		public function Stop():void
		{
			Mem_State = 1;
			MainPos = 0;
		}
		
	}//end of class
}//end of package