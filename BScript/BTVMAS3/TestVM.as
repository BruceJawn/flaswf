package
{
	import flash.display.*
	public class TestVM extends Sprite
	{
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

		public function TestVM():void
		{
			var myVM:BTVMAS3=new BTVMAS3();
			myVM.Mem_MnOpc=
			[   BC_setloci,0,12,
				BC_setloci,2,12,
				BC_setint,
				BC_goto,0,
				BC_setlocs,2,"Hello World!",
				BC_setstr,
				
				BC_setloci,0,12,
				BC_setloci,1,34,
				BC_call,"addi",
				BC_setloci,0,0,
				BC_setint,
				
				BC_setloci,0,10,
				BC_setloci,1,1,
				BC_call,"setloop",
				BC_goto,1
			];
			myVM.Mem_Label=
			[
				[
					BC_setloci,0,12,
					BC_setlocf,2,12.21,
					BC_setflt],
				[
					BC_call,"cpyloop0",
					//BC_setloci,1,6,//
					BC_goto,2,
					BC_call,"addi",
					BC_setint,
					BC_call,"doloop",
					BC_ifto,1
				],
				//set loc1 = square of loc0
				[
					BC_setloci,1,"loc0",
					BC_call,"muli",
					BC_setloci,1,"loc1",
				]
			];
			myVM.Run();
		}//end of TestVM
	}//end of class
	
}//end of package