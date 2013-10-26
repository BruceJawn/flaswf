#include <stdio.h>
#include <string.h>
#include "scws.h"
#include <AS3/AS3.h>
//http://www.xunsearch.com/scws/docs.php
// Mark the functions declaration with a GCC attribute specifying the
// AS3 signature we want it to have in the generated SWC. The functions will
// be located in the FlasCCTest.lookupeffect namespace.

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

	//char *result;
	//result[0] = '\0';   // ensures the memory is an empty string
	char result[5000]={"0"};
    char temp[1000]={'\0'};
	printf("%s",result);
	while (res = cur = scws_get_result(s))
	{
		while (cur != NULL)
		{
			printf("WORD: %.*s/%s (IDF = %4.2f)\n", cur->len, text+cur->off, cur->attr, cur->idf);
			//if((result = malloc(strlen(result)+ cur->len +1)) != NULL){
			//if((result = (char*) realloc(strlen(result)+ (cur->len) +1)) != NULL)
            strncpy(temp, text+cur->off, cur->len);
			temp[(cur->len)+1]='\0';
			strcat(result, temp);
			strcat(result, ' ');
			strcat(result, '\0');
            //strncpy(new_str,str2);
            //} else {
            //printf("malloc failed!\n");
            // exit?
            //}
			cur = cur->next;
		}
		scws_free_result(res);
	}
	strcat(result, '\0');
	
	printf("%s",result);
	AS3_CopyCStringToVar(myString, result, strlen(result));
	scws_free(s);
	//scws_free(result);
	AS3_Trace(myString);
	
	AS3_Return("212");
}

void updateUniverse()
{
  char *text = "Hello, 我名字叫李那曲是一个中国人, 我有时买Q币来玩, 我还听说过C#语言";

  if (!(s = scws_new())) {
    printf("ERROR: cann't init the scws!\n");
    //exit(-1);
  }
  scws_set_charset(s, "utf8");
  scws_set_dict(s, "dict.utf8.xdb", SCWS_XDICT_XDB);
  scws_set_rule(s, "rules.utf8.ini");

  scws_send_text(s, text, strlen(text));
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