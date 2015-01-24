public var doPhysics:Boolean = true;
private var fght:int = 8; //2;
private var hght:int = 1;

/*
   private function check_hit_floor():Boolean
   {
   if(alchemyMemory[  (((Cheight+2-fght)&(0x80-1))<<16|guv)*4 + alcvoxPointer]>0)//(voxdata[L2(cheight-fght)<<16|guv])
   {Cheight=(Cheight+2) & 0xff;//cheight=L(cheight+2+fght);
   return true;}

   if(alchemyMemory[  (((Cheight-fght)&(0x80-1))<<16|guv)*4 + alcvoxPointer]>0)//(voxdata[L2(cheight-fght)<<16|guv])
   {
   return true;}

   return false;

   }//end of check_hit_floor
 */

private function check_hit_ceil():Boolean
{
	//2=head height
	if (alchemyMemory[((((Cheight + 1 + hght) & (0x80 - 1)) << 16 | guv) << 2) + alcvoxPointer] > 0) //(voxdata[L2(cheight+1+hght)<<16|guv]/*>0*/)
		return true;
	else
		return false;
} //end of check_hit_ceil

private function check_hit_move():Boolean
{
	if (alchemyMemory[((((Cheight + 1) & (0x80 - 1)) << 16 | guv) << 2) + alcvoxPointer + 3] > 0) //(voxdata[L2(cheight+1)<<16|guv]/*>0*/)
		return true;
	else
		return false;
} //end of check_hit_move

private var OnFloor:Boolean = false;

private function do_gravity():void
{
	
	if (alchemyMemory[((((Cheight + 1 - fght) & (0x80 - 1)) << 16 | guv) << 2) + alcvoxPointer] > 0) //(voxdata[L2(cheight-fght)<<16|guv])
	{
		if (alchemyMemory[((((Cheight + 2 - fght) & (0x80 - 1)) << 16 | guv) << 2) + alcvoxPointer] == 0)
		{
			Cheight = (Cheight + 2) & 0xff; //cheight=L(cheight+2+fght);
			OnFloor = false;
		}
		else
			OnFloor = true;
	}
	
	else if (alchemyMemory[((((Cheight - 1 - fght) & (0x80 - 1)) << 16 | guv) << 2) + alcvoxPointer] == 0) //(voxdata[L2(cheight-fght)<<16|guv])
	{
		if (alchemyMemory[((((Cheight - 2 - fght) & (0x80 - 1)) << 16 | guv) << 2) + alcvoxPointer] == 0)
		{
			Cheight = (Cheight - 1) & (0x80 - 1); //& (0x80-1);
			OnFloor = false;
		}
		else
			OnFloor = true;
	}
	else
		OnFloor = true;
} //end of function do_gravity