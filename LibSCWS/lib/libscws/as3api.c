#include <stdio.h>
#include <string.h>
#include "scws.h"
#include <AS3/AS3.h>
//http://www.xunsearch.com/scws/docs.php
// Mark the functions declaration with a GCC attribute specifying the
// AS3 signature we want it to have in the generated SWC. The functions will
// be located in the CrossBridge.libscws namespace.

scws_t s;
scws_res_t res; 
scws_res_t cur;

void initialize_SCWS_AS3() __attribute__((used,
	annotate("as3sig:public function initialize_SCWS_AS3():void"),
	annotate("as3package:CrossBridge.libscws")));

void initialize_SCWS_AS3()
{
	if (!(s = scws_new())) {
		printf("ERROR: cann't init the scws!\n");
		//exit(-1);
	}
	scws_set_charset(s, "utf8");
	scws_set_dict(s, "dict.utf8.xdb", SCWS_XDICT_XDB);
	scws_set_rule(s, "rules.utf8.ini");
	//scws_send_text(s, text, strlen(text));
}

void scws_send_text_AS3() __attribute__((used,
	annotate("as3sig:public function scws_send_text_AS3(inputString:String):String"),
	annotate("as3package:CrossBridge.libscws")));

void scws_send_text_AS3()
{
	char *text = NULL;
	AS3_MallocString(text, inputString);
	scws_send_text(s, text, strlen(text));
	AS3_DeclareVar(myString, String);
	AS3_CopyCharToVar(myString,'\0');
	AS3_DeclareVar(tempString, String);
	AS3_CopyCStringToVar(tempString, text+cur->off, cur->len);
	while (res = cur = scws_get_result(s))
	{
		while (cur != NULL)
		{
			printf("WORD: %.*s/%s (IDF = %4.2f)\n", cur->len, text+cur->off, cur->attr, cur->idf);
			AS3_CopyCStringToVar(tempString, text+cur->off, cur->len);
			inline_as3(
				"myString = myString+tempString+' ';\n"
				"//trace(tempString);\n"
				: : 
			);
			cur = cur->next;
		}
		scws_free_result(res);
	}

	//scws_free(s);
	AS3_ReturnAS3Var(myString);
}

void simpleTest()
{
	char *text = "Hi，我是Bruce，我喜欢与Flash相关的各种东西，欢迎来我的网站play.flaswf.tk玩各种在线游戏。";
	printf("[测试输入]: %s\n", text);
	if (!(s = scws_new())) {
		printf("ERROR: cann't init the scws!\n");
		//exit(-1);
	}
	scws_set_charset(s, "utf8");
	scws_set_dict(s, "dict.utf8.xdb", SCWS_XDICT_XDB);
	scws_set_rule(s, "rules.utf8.ini");
	scws_send_text(s, text, strlen(text));

	printf("%s\n","[测试分词结果]:");
	while (res = cur = scws_get_result(s))
	{
		while (cur != NULL)
		{
			printf("WORD: %.*s/%s (IDF = %4.2f)\n", cur->len, text+cur->off, cur->attr, cur->idf);
			cur = cur->next;
		}
		scws_free_result(res);
	}
	scws_free(s);
}