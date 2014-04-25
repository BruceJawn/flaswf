#include <stdio.h>
#include <Flash++.h>

int param_i=0;
char *param_j;
int main(int argc, char **argv)
{
	int arg_i;
	char arg_j[10];
	arg_i = atof(argv[0]);
	strcpy(arg_j, argv[1]);

	int i=0;
	while(1)
	{
		i++;
		printf("==========Test from Main==========%d\n",i);
		printf("==========arg_i==========%d\n",arg_i);
		printf("==========param_i==========%d\n",param_i);
		printf("==========arg_j==========%s\n",arg_j);
		printf("==========param_j==========%s\n",param_j);
		avm2_wait_for_ui_frame(0);
	}
	AS3_GoAsync();
	return 0;
}


void testCfun() __attribute__((used,
	annotate("as3sig:public function testCfun_AS3(i:int,j:String):void"),
	annotate("as3package:com.adobe.flascc")));

void testCfun()
{
	AS3_GetScalarFromVar(param_i,i);
	inline_as3(
		"var stringptr:int = CModule.mallocString(j);\n"
		"CModule.write32(%0, stringptr);\n"
		: : "r"(&param_j)
		); 
}