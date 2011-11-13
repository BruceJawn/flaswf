package
{
	import flash.net.*
	import flash.utils.*
	public class BTVMAS3 extends BTVMCore
	{
		private function addi():void
		{
			Loc_Int[2] = Loc_Int[0]+Loc_Int[1];
		}
		private function subi():void
		{
			Loc_Int[2] = Loc_Int[0]-Loc_Int[1];
		}
		private function muli():void
		{
			Loc_Int[2] = Loc_Int[0]*Loc_Int[1];
		}
		private function divi():void
		{
			Loc_Int[2] = Loc_Int[0]/Loc_Int[1];
		}
		private function addf():void
		{
			Loc_Flt[2] = Loc_Flt[0]+Loc_Flt[1];
		}
		private function subf():void
		{
			Loc_Flt[2] = Loc_Flt[0]-Loc_Flt[1];
		}
		private function mulf():void
		{
			Loc_Flt[2] = Loc_Flt[0]*Loc_Flt[1];
		}
		private function divf():void
		{
			Loc_Flt[2] = Loc_Flt[0]/Loc_Flt[1];
		}
		private function itof():void
		{
			Loc_Flt[2] = Number(Loc_Int[0]);
		}
		private function ftoi():void
		{
			Loc_Int[2] = Number(Loc_Flt[0]);
		}
		private function itos():void
		{
			Loc_Str[2] = String(Loc_Int[0]);
		}
		private function stoi():void
		{
			Loc_Int[2] = String(Loc_Str[0]);
		}
		private function cats():void
		{
			Loc_Str[2] = Loc_Str[0]+Loc_Str[1];
		}
		private function subs():void
		{
			Loc_Str[2] = Loc_Str[0].substr(Loc_Int[0],Loc_Int[1]);
		}
		private function cmps():void
		{
			Loc_Int[2] = Loc_Str[0].localeCompare(Loc_Str[1]);
		}
		private function print():void
		{
			if(Loc_Int[0]==0)
			trace(Loc_Int[1]);
			else if(Loc_Int[0]==1)
			trace(Loc_Flt[1]);
			else if(Loc_Int[0]==2)
			trace(Loc_Str[1]);
		}

		private var loop0:int;
		private var loop1:int;
		private function setloop():void
		{
			loop0=Loc_Int[0];
			loop1=Loc_Int[1];
		}
		private function doloop():void
		{
			loop0-=loop1;
			if(loop0<=0)Loc_Int[0]=0;
		}
		private function cpyloop0():void
		{
			Loc_Int[0]=loop0;
		}
		
		public function BTVMAS3():void
		{
			super();
			ExternFunc={};
			ExternFunc.addi=addi;
			ExternFunc.subi=subi;
			ExternFunc.muli=muli;
			ExternFunc.divi=divi;
			ExternFunc.addf=addf;
			ExternFunc.subf=subf;
			ExternFunc.mulf=mulf;
			ExternFunc.divf=divf;
			ExternFunc.itof=itof;
			ExternFunc.ftoi=ftoi;
			ExternFunc.itos=itos;
			ExternFunc.stoi=stoi;
			ExternFunc.cats=cats;
			ExternFunc.subs=subs;
			ExternFunc.cmps=cmps;
			ExternFunc.print=print;
			
			ExternFunc.setloop=setloop;
			ExternFunc.doloop=doloop;
			ExternFunc.cpyloop0=cpyloop0;
		}

		public function Load(input:ByteArray):void
		{
			Mem_State = input.readUnsignedInt();
			MainPos = input.readUnsignedInt();
			Loc_Int = input.readObject();
			Loc_Flt = input.readObject();
			Loc_Str = input.readObject();
			Mem_Int = input.readObject();
			Mem_Flt = input.readObject();
			Mem_Str = input.readObject();
			Mem_MnOpc = input.readObject();
			Mem_Label = input.readObject();
		}
		
		public function Save():void
		{
			var out = new ByteArray();
			out.writeUnsignedInt(Mem_State);
			out.writeUnsignedInt(MainPos);
			out.writeObject(Loc_Int);
			out.writeObject(Loc_Flt);
			out.writeObject(Loc_Str);
			out.writeObject(Mem_Int);
			out.writeObject(Mem_Flt);
			out.writeObject(Mem_Str);
			out.writeObject(Mem_MnOpc);
			out.writeObject(Mem_Label);
			new FileReference().save(out,"BTVM.snapshot");
		}
	}
}