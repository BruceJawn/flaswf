#include "AS3/AS3.h"
#include <Flash++.h>
#include <pthread.h>
using namespace AS3::ui;
//using namespace AS3::local;

static char keyInputCond; 
int KeyInputNum = -1;

int S()
{
	avm2_self_msleep(&keyInputCond, 0);
	int KeyInputNumTemp = KeyInputNum;
	KeyInputNum = -1;
	if(KeyInputNumTemp>=0&&KeyInputNumTemp<=9||KeyInputNumTemp==100)
	return KeyInputNumTemp;
	else
	return -1;
}

void gotInput_AS3() __attribute__((used,
	annotate("as3sig:public function gotInput_AS3(AS3InputValue:int):void"),
	annotate("as3package:FlasCCSWC.Sanguosha")));

void gotInput_AS3()
{
	AS3_GetScalarFromVar(KeyInputNum, AS3InputValue);
	//KeyInputNum-=48;
	avm2_wake(&keyInputCond);
}


//
void getScore_AS3() __attribute__((used,
	annotate("as3sig:public function getScore_AS3():int"),
	annotate("as3package:FlasCCSWC.Sanguosha")));

void getScore_AS3()
{
	AS3_Return(int((hurtcnt/12.0+recovercnt/21.0)*int(wincnt/321.0)/int(roundcnt/123.0)));
}

///////////////////////////////////////////////

AS3::local::var AS3Main=AS3::local::internal::new_undefined();//AS3::local::var

void initGame_AS3() __attribute__((used,
	annotate("as3sig:public function initGame_AS3(MyAS3Main):void"),
	annotate("as3package:FlasCCSWC.Sanguosha")));

void initGame_AS3()
{
	printf("%d\n", KeyInputNum);
	//AS3_GetVarxxFromVar(AS3Main,MyAS3Main);
	inline_as3(
				"AS3Main=MyAS3Main;\n"
				"var args:Vector.<int> = new Vector.<int>;\n"
				"args[0]=1;\n"
				//"trace(CModule.getPublicSymbol('submitScore'));\n"
				//"CModule.callI(CModule.getPublicSymbol('submitScore'), args);"
				//"trace(AS3Main);\n"
				//"%0 = MyAS3Main;\n"
                //: "=r"(AS3Main) : 
				//"AS3Main.submitScore(100);"
				//: : 
			);
				inline_as3(
	 //"import com.adobe.flascc.Console;\n"
	 //"trace(Console.submitScore);\n" 
     //"Console.submitScore(100);\n" 
	 ::
	 );

}

int key0[10];//={0,0,0,0,0,0,0,0,0,0};
void getKey0_AS3() __attribute__((used,
	annotate("as3sig:public function getKey0_AS3():int"),
	annotate("as3package:FlasCCSWC.Sanguosha")));

void getKey0_AS3()
{
	AS3_Return(key0);
}

int key1[10];//={1,1,1,1,1,1,1,1,1,1};
void getKey1_AS3() __attribute__((used,
	annotate("as3sig:public function getKey1_AS3():int"),
	annotate("as3package:FlasCCSWC.Sanguosha")));

void getKey1_AS3()
{
	AS3_Return(key1);
}



int main()
{
	/*for(int i=0;i<10;i++)
	{
	printf("%d",key0[i]);
	printf("%d",key1[i]);
	}*/
//#include"mochi.c"
	do
	{
	lasthurtcnt=0;
	lastrecovercnt=0;

	roundcnt+=123;
	wincnt+=newJu()*321;

	printf("总局数：       %d\n",int(roundcnt/123.0));
	printf("赢局数：       %d\n",int(wincnt/321.0));

	printf("伤害数：       %d\n",int(lasthurtcnt/12.0));
	printf("回复数：       %d\n",int(lastrecovercnt/21.0));

	int lasttotalscore = int((hurtcnt/12.0+recovercnt/21.0)*int(wincnt/321.0)/int(roundcnt/123.0));
	hurtcnt+=lasthurtcnt;
    recovercnt+=lastrecovercnt;
	int totalscore = int((hurtcnt/12.0+recovercnt/21.0)*int(wincnt/321.0)/int(roundcnt/123.0));

	printf("本局得分：     %d\n",totalscore-lasttotalscore);
	printf("总得分：       %d\n",totalscore);
	
	printf("%s\n", "本局结束!请上传得分并查看【《三国杀》世界总排名榜】。");
	/*printf("%s\n", "1:是 0:否");
	for(;;)
	{
		int x=S();
		if(x==1)
			//AS3Main -> submitScore(int((hurtcnt/12.0+recovercnt/21.0)*int(wincnt/321.0)/int(roundcnt/123.0)));
			inline_as3(
			"CModule.rootSprite.submitScore(%0);\n"
				: : "r"(totalscore)
			);
		else if(x==0) break;
	}
	*/
	printf("1:继续游戏       0:结束游戏\n");
	}
	while(S()!=0);
	
	printf("%s\n", "游戏结束!请上传得分并查看【《三国杀》世界总排名榜】。");
	AS3_GoAsync();
}