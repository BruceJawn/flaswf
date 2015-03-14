# Introduction #



# Details #
**The easiest way is to use Flash Develop(http://www.flashdevelop.org/) or Flex, open the .as file: Main.as and press the 'build' button(Flash Develop-Tools-Flash Tools-Build Current File), then you will get the swf file at once.**


**Or create a new empty FlashDevelop/Flex project, add all .as file to the project and then build the project(Flash Develop-Project-Build Project).**


**If you use Flash IDE, open Flash->File->NEW->Flash File(AS3.0)->open library(F11)->(right click)New Symbol->linkage-Export for ActionScript-Class-Main->OK->Drag and Put the symbol on the stage->Press Ctrl+Enter and finally you will get the swf.**


**If you use Flash 9 or 10, open Flash->File->NEW->Flash File(AS3.0)->
Document Class->Main.as->OK->Press Ctrl+Enter.**


By the way, this way:
```
import Main; 
var myMain=new Main(); 
addChild(myMain);
```
on action script layer may get errors because I usually use "stage.stageWidth" and "stage.stageHeight" in the Class file. Find and Replace those two words to some Number like "550" and "400" and then you can compile it successfully.