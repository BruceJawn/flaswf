#include <stdio.h>

#include "SDL_ttf.h"
#include "SDL_ttf.c"

#include "SDL.h"
#include "AS3.h"
AS3_Val AS_Main;
#include "ALC_GE2D_PlaySound.cpp"
#include "Girl.cpp"
#include "Save_Flash.cpp"

#include "Map.cpp" 
#include "Role.cpp"
#include "Fighter.cpp"
#include "Menu.cpp" 
#include "Record.cpp" 
#include "Dialog.cpp" 
#include "assist.cpp"

extern AS3_Val FLASH_EVENT_MANAGER_OBJECT;

AS3_Val setup(void *data, AS3_Val args);
AS3_Val quitApplication(void *data, AS3_Val args);
AS3_Val tick(void *data, AS3_Val args);
AS3_Val FLASH_getDisplayPointer(void *data, AS3_Val args);
AS3_Val FLASH_setEventManager(void *data, AS3_Val args);
AS3_Val Score_flash(void *self, AS3_Val args);
AS3_Val init_AS_Main(void *self, AS3_Val args);
// Tmp global vars
//SDL_Surface *screen;
int		TMPFLASH_quit = 0;
SDL_Event	event;
/*
 * Lib Initialization
 */
int main(int argc, char **argv){
    
  // Create callbacks
  AS3_Val setupMethod = AS3_Function(NULL, setup);
  AS3_Val tickMethod = AS3_Function(NULL, tick);
  AS3_Val getDisplayPointerMethod = AS3_Function(NULL, FLASH_getDisplayPointer);
  AS3_Val quitApplicationMethod = AS3_Function(NULL, quitApplication);
  AS3_Val setEventManagerMethod = AS3_Function(NULL, FLASH_setEventManager);
  AS3_Val Score_flashMethod = AS3_Function(NULL, Score_flash);
  AS3_Val init_AS_MainMethod = AS3_Function(NULL, init_AS_Main);
  AS3_Val libSDL = AS3_Object(
			      "setup:AS3ValType, tick:AS3ValType, getDisplayPointer:AS3ValType, quit:AS3ValType, setEventManager:AS3ValType, Score_flash:AS3ValType, init_AS_Main:AS3ValType", 
			      setupMethod, tickMethod, getDisplayPointerMethod, quitApplicationMethod, setEventManagerMethod,Score_flashMethod, init_AS_MainMethod 
			      );
    
  AS3_Release( setupMethod );
  AS3_Release( tickMethod );
  AS3_Release( getDisplayPointerMethod );
  AS3_Release( quitApplicationMethod );
  AS3_Release( setEventManagerMethod );
  AS3_Release( Score_flashMethod );
  AS3_Release( init_AS_MainMethod );	
  AS3_LibInit(libSDL);
  return 0;
}

/*
 * This method gets called on enterFrame. You should refactor your SDL Application's main()
 * loop so that one loop is executed on tick(). Tick's are followed by frame draws.
 */
AS3_Val tick(void *data, AS3_Val args) {
  // Lock the screen for direct access to the pixels
  if ( SDL_MUSTLOCK(screen) )
    {
      if ( SDL_LockSurface(screen) < 0 )
	{
	  fprintf(stderr, "Can't lock screen: %s\n", SDL_GetError());
	  return AS3_Int(-3);
	}
    }
  if(SDL_PollEvent(&event)){
    if(event.type == SDL_QUIT)
      game_running = 0;
  }
  MainLoop();
       
  //SDL_Delay(80);//??

  // Unlock Surface if necessary
  if ( SDL_MUSTLOCK(screen) )
    {
      SDL_UnlockSurface(screen);
    }
  SDL_Flip(screen);
  // Update just the part of the display that we've changed
  //SDL_UpdateRect(screen, TMPFLASH_x, TMPFLASH_y, 1, 1);
  
  if (TMPFLASH_quit){
    //quitApplication();
  }
  
  return AS3_Int(0);

}


/*
 * Set up the application before the main loop. Move/rename variables to exist in the global
 * ns.
 */
AS3_Val setup(void *data, AS3_Val args) {

  // Grab the provided buffer width and height
  AS3_Val bufWidth, bufHeight;
  AS3_ArrayValue( args, "AS3ValType, AS3ValType", &bufWidth, &bufHeight );

  SDL_Event event;
  // Initialize defaults, Video and Audio
  if((SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO)==-1))
    {
      printf("Could not initialize SDL: %s.\n", SDL_GetError());
      return AS3_Int(-1);
    }
 
  Uint32 colorkey;
 

  screen = SDL_SetVideoMode(AS3_IntValue(bufWidth), AS3_IntValue(bufHeight), 32, SDL_SWSURFACE | SDL_FULLSCREEN);
  //screen = SDL_SetVideoMode(AS3_IntValue(bufWidth), AS3_IntValue(bufHeight), 32, SDL_DOUBLEBUF | SDL_FULLSCREEN);
  if ( screen == NULL )
    {
      fprintf(stderr, "Couldn't set video mode: %s\n", SDL_GetError());
      return AS3_Int(-2);
    }
  //
  SDL_EnableKeyRepeat(0, 30); //disable key repeat
  SDL_ShowCursor(SDL_DISABLE);
 
  //3 创建菜单页面
  CreateBmpSurface(&menu, "pic/menu.bmp");

  //create dialog background
  CreateBmpSurface(&dlg, "pic/dlg.bmp");
  CreateBmpSurface(&info, "pic/info.bmp");

  //4 创建状态页面
  CreateBmpSurface(&state, "pic/state.bmp");
  colorkey = SDL_MapRGB(state->format, 0, 0, 0);
  SDL_SetColorKey(state, SDL_SRCCOLORKEY, colorkey);
	
  //5 创建精灵页面
  CreateBmpSurface(&hero, "pic/aqing.bmp");
  colorkey = SDL_MapRGB(hero->format, 0, 0, 0);
  SDL_SetColorKey(hero, SDL_SRCCOLORKEY, colorkey);

  //6 范蠡
  CreateBmpSurface(&FanLi, "pic/fanli.bmp");
  colorkey = SDL_MapRGB(FanLi->format, 0, 0, 0);
  SDL_SetColorKey(FanLi, SDL_SRCCOLORKEY, colorkey);

  //7 西施
  CreateBmpSurface(&XiShi, "pic/xishi.bmp");
  colorkey = SDL_MapRGB(XiShi->format, 0, 0, 0);
  SDL_SetColorKey(XiShi, SDL_SRCCOLORKEY, colorkey);

  //8 创建绵羊页面
  CreateBmpSurface(&sheep, "pic/sheep.bmp");
  colorkey = SDL_MapRGB(sheep->format, 0, 0, 0);
  SDL_SetColorKey(sheep, SDL_SRCCOLORKEY, colorkey);

  //9 创建越国杂项页面
  CreateBmpSurface(&other_yue, "pic/other.bmp");
  colorkey = SDL_MapRGB(other_yue->format, 0, 0, 0);
  SDL_SetColorKey(other_yue, SDL_SRCCOLORKEY, colorkey);

  //10 创建物体页面
  CreateBmpSurface(&item, "pic/item.bmp");
  colorkey = SDL_MapRGB(item->format, 0, 0, 0);
  SDL_SetColorKey(item, SDL_SRCCOLORKEY, colorkey);

  //11 创建战斗页面
  CreateBmpSurface(&fight, "pic/fight.bmp");
  colorkey = SDL_MapRGB(fight->format, 0, 0, 0);
  SDL_SetColorKey(fight, SDL_SRCCOLORKEY, colorkey);

  //12 创建地图元素页面1
  CreateBmpSurface(&map_tile1, "pic/maptile.bmp");

  //13 创建地图元素页面2
  CreateBmpSurface(&map_tile2, "pic/grass.bmp");

  //14 创建地图元素页面2
  CreateBmpSurface(&map_tile3, "pic/palace.bmp");
  //
  OpenFonts();
  Flag = GAME_LOAD_;	//设置游戏进度 
  InitGame();

  return AS3_Int(0);
}


AS3_Val quitApplication(void *data, AS3_Val args){
  SDL_Quit();
  return AS3_Int(0);
}


AS3_Val FLASH_getDisplayPointer(void *data, AS3_Val args){
  return AS3_Ptr(screen->pixels);
}


AS3_Val FLASH_setEventManager( void *data, AS3_Val args ){
  AS3_Val eventManager;  
  AS3_ArrayValue( args, "AS3ValType", &eventManager );
      
  FLASH_EVENT_MANAGER_OBJECT = eventManager;
	
  return AS3_Int(0);
}

AS3_Val Score_flash(void* self, AS3_Val args)
{
  return AS3_Int(fAqing.Attack + fAqing.Defend + fAqing.HP);
}//end of Score_flash

AS3_Val init_AS_Main( void *self, AS3_Val args ){
  AS3_ArrayValue( args, "AS3ValType", &AS_Main);
	
  return AS3_Int(0);
}
