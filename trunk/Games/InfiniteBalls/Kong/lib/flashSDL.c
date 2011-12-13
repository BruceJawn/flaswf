#include <stdio.h>
#include "SDL.h"
#include "AS3.h"
/*
  Porting your SDL application to FlashSDL

  Perhaps this is best understood by example. Examine ./flashsdl.c. Most immediately you will have to refactor your C application's main loop 

  to run iteratively in the tick() method, assuming you end up using the application scaffolding in ./src/.

  Make sure you've properly built and installed FlashSDL by building the test application. Then try running your application's ./configure.

  Once you've successfully compiled, try linking the resuling SWC with the AS3 side of your application (which should be built on ./src/).
*/
AS3_Val setup(void *data, AS3_Val args);
AS3_Val quitApplication();
AS3_Val tick();
AS3_Val FLASH_getDisplayPointer();
AS3_Val FLASH_setEventManager(void *data, AS3_Val args);

AS3_Val AS_Main;

AS3_Val init_AS_Main( void *self, AS3_Val args ){
  AS3_ArrayValue( args, "AS3ValType", &AS_Main);
  return AS3_Int(0);
}

#include "ALC_GE2D_PlaySound.c"
#include "ball_game.c"

AS3_Val Score_flash(void* self, AS3_Val args)
{
  return AS3_Int(total_score);
}//end of Score_flash

AS3_Val Restart_flash(void* self, AS3_Val args)
{
  new_game();
  return AS3_Int(0);
}//end of Restart_flash

extern AS3_Val FLASH_EVENT_MANAGER_OBJECT;

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
  AS3_Val Restart_flashMethod = AS3_Function(NULL, Restart_flash);

  AS3_Val libSDL = AS3_Object(
			      "setup:AS3ValType, tick:AS3ValType, getDisplayPointer:AS3ValType, quit:AS3ValType, setEventManager:AS3ValType, Score_flash:AS3ValType, init_AS_Main:AS3ValType, Restart_flash:AS3ValType", 
			      setupMethod, tickMethod, getDisplayPointerMethod, quitApplicationMethod, setEventManagerMethod, Score_flashMethod, init_AS_MainMethod, Restart_flashMethod
			      );
    
  AS3_Release( setupMethod );
  AS3_Release( tickMethod );
  AS3_Release( getDisplayPointerMethod );
  AS3_Release( quitApplicationMethod );
  AS3_Release( setEventManagerMethod );

  AS3_Release( Score_flashMethod );
  AS3_Release( init_AS_MainMethod );
  AS3_Release( Restart_flashMethod );
	
  AS3_LibInit(libSDL);
  return 0;
}

int released = 1;
/*
 * This method gets called on enterFrame. You should refactor your SDL Application's main()
 * loop so that one loop is executed on tick(). Tick's are followed by frame draws.
 */
AS3_Val tick() {
  //while(!done) {
  SDL_Event event;
  while( SDL_PollEvent(&event) ) {
    /*
      if( event.type == SDL_QUIT )
      done = 1;
      else if( event.type == SDL_KEYDOWN) {
      switch(event.key.keysym.sym) {
      case SDLK_ESCAPE:
      done = 1;
      break;
      case SDLK_SPACE:
      new_game();
      break;
      }
      }
    */
  }

  int x, y;
  SDL_GetMouseState(&x, &y);
  x /= BALL_SIZE;
  y /= BALL_SIZE;

  if( !SDL_GetMouseState(NULL, NULL) & SDL_BUTTON(1) ) {
    released = 1;
  }

  int running = 0;

  if ( !running && SDL_GetMouseState(NULL, NULL) & SDL_BUTTON(1) && released ) 
    {
      released = 0;
      if ( x >=0 && y >= 0 && x < cols && y < rows 
	   && grids[GRID_INDEX(x, y)] != -1 && check_neighbor(x, y, MAX_CONNECT)) 
	{
	  int result = wrap_balls(x, y, grids[GRID_INDEX(x, y)]) - MAX_CONNECT + 1;
	  PlaySound_Flash("eliminate_balls",result);//
	  update_score(total_score + result * result);

	  running = 1;
	  clear_balls();
	  draw_scene();
	  fill_balls();
	  SDL_Delay(100);
	  draw_scene();
	  running = 0;
	}
    }
  SDL_Delay(10);
  //}
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

  // Initialize defaults, Video and Audio
  if((SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO)==-1))
    {
      printf("Could not initialize SDL: %s.\n", SDL_GetError());
      return AS3_Int(-1);
    }

  (screen = SDL_SetVideoMode(SRCW, SRCH, 32, SDL_HWSURFACE));//screen = SDL_SetVideoMode(AS3_IntValue(bufWidth), AS3_IntValue(bufHeight), 32, SDL_SWSURFACE | SDL_FULLSCREEN);
  if ( screen == NULL )
    {
      fprintf(stderr, "Couldn't set video mode: %s\n", SDL_GetError());
      return AS3_Int(-2);
    }

  SDL_ShowCursor(SDL_DISABLE);

  srand((unsigned) time(NULL));

  int i; 
  char temp[100];
  SDL_Surface *surface;
  for( i = 0; i < BALL_NUM; i++ ) {
    memset(temp, 0, sizeof(temp));
    sprintf(temp, "balls/%d.bmp", i + 1);
    surface = load_image(temp);
    SDL_SetColorKey(surface, SDL_SRCCOLORKEY, 0x000000);
    balls[i] = surface;
  }
  SDL_FreeSurface(surface);

  memset(temp, 0, sizeof(temp));
  sprintf(temp, "balls/%d.bmp", rand() % 5 + 1);
  SDL_Surface *icon = load_image(temp);
  SDL_SetColorKey(icon, SDL_SRCCOLORKEY, 0x000000);
  SDL_WM_SetIcon(icon, NULL);
  SDL_FreeSurface(icon);

  rows = SRCH / BALL_SIZE;
  cols = SRCW / BALL_SIZE;


  new_game();

  return AS3_Int(0);
}


AS3_Val quitApplication(){
  SDL_FreeSurface(screen);
  SDL_Quit();
  quit(0);
  return AS3_Int(0);
}


AS3_Val FLASH_getDisplayPointer(){
  return AS3_Ptr(screen->pixels);
}


AS3_Val FLASH_setEventManager( void *data, AS3_Val args ){
  AS3_Val eventManager;
  AS3_ArrayValue( args, "AS3ValType", &eventManager );
  FLASH_EVENT_MANAGER_OBJECT = eventManager;
	
  return AS3_Int(0);
}
