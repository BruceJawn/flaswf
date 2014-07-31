/*
* Copyright (c) <2014> <Bruce Jawn> [http://bruce-lab.blogspot.com]
* This software is released under the MIT License
* <http://www.opensource.org/licenses/mit-license.php>
*/
#include <stdio.h>
#include <iostream>
#include <fstream>
#include "AS3/AS3.h"
#include <Flash++.h>
using namespace std;
using namespace AS3::local; 

//AS3::local::var mainToWorker;
//AS3::local::var workerToMain;

static AS3::local::var channelMessageEventListenerProc(void *arg, AS3::local::var as3Args)
{
	flash::events::Event event = flash::events::Event(as3Args[0]); // event
	flash::system::MessageChannel msgChan = flash::system::MessageChannel(event->target); // event.target
	AS3::local::var msg = msgChan->receive();
	char* str = AS3::local::internal::utf8_toString(msg);
	//printf("debug msg: Message Latency %dms\n");
	printf("debug msg: %s\n", str);
	inline_as3(
		"workerToMain.send(CModule.readString(%0, %1));\n"
		"workerToMain.send('consoleWrite');\n"
		::"r"(str),"r"(strlen(str))
		);
	return internal::_undefined;
}


int main(int argc, char **argv)
{
	//while(1)
	{
		inline_as3(
			"import flash.system.MessageChannel;import flash.system.Worker;import flash.system.WorkerDomain;"
			"mainToWorker = Worker.current.getSharedProperty('mainToWorker');\n"
			"workerToMain = Worker.current.getSharedProperty('workerToMain');\n"
			"trace(mainToWorker);trace(workerToMain);\n"
			"workerToMain.send(12345678);\n"
			"workerToMain.send('consoleWrite');\n"
			::
			);	

		flash::system::Worker worker = internal::get_Worker();
		flash::system::MessageChannel msgChan = worker->getSharedProperty("mainToWorker");

		msgChan->addEventListener("channelMessage", Function::_new(channelMessageEventListenerProc, NULL));
	}

	AS3_GoAsync();
	return 0;
}