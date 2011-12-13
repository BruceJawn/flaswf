/*
 * author:pallover#gmail.com
 * website: http://pallove.is-programmer.com/
 */

#include <string.h>
#include <stdlib.h>
#include <time.h>
//#include <SDL/SDL.h>

#define BALL_NUM        9
#define SRCW            640
#define SRCH            480
#define BALL_SIZE       42
#define MAX_CONNECT     3
#define GRID_INDEX(x, y) (x) + (y) * cols

/*#define DIR_NORTH       (1 << 0)*/
/*#define DIR_WEST        (1 << 1)*/
/*#define DIR_SOUTH       (1 << 2)*/
/*#define DIR_EAST        (1 << 3)*/
/*#define DIR_ALL         (DIR_NORTH | DIR_WEST | DIR_SOUTH | DIR_EAST)*/

char grids[SRCW * SRCH];
int rows, cols;
int total_score = 0;
static int nlen = 0;

SDL_Surface *screen, *balls[BALL_NUM];
struct pair
{
  int index;
  char value;
} pairs[40];

static void quit(int rc) 
{
  SDL_Quit();
  exit(rc);
}

static void update_score(int score)
{
  total_score = score;

  char temp[100];
  sprintf(temp, "Balls - Your Score:%d", total_score);
  SDL_WM_SetCaption(temp, NULL);
}

static void clear_balls() 
{
  int to = -1;
  int i, j, temp;
  for( j = 0; j < cols; j++) {
    to = -1;
    for( i = rows - 1; i >= 0; i--) {
      if(to == -1 && grids[GRID_INDEX(j, i)] == -1) {
	to = i;
      }
      else if(to != -1 && grids[GRID_INDEX(j, i)] != -1) {
	temp = grids[GRID_INDEX(j, i)];
	grids[GRID_INDEX(j, i)] = grids[GRID_INDEX(j, to)];
	grids[GRID_INDEX(j, to)] = temp;
	to--;
      }
    }
  }
}

static void fill_balls()
{
  int i, j;
  for( j = 0; j < cols; j++ ) {
    for( i = rows - 1; i >= 0; i-- ) {
      if(grids[GRID_INDEX(j, i)] == -1) 
	grids[GRID_INDEX(j, i)] = rand() % 5;
    }
  }
}

/*static int count_neighbors(int x, int y, int val, int dir_flags)*/
/*{*/
/*int sum = 1;*/
/*if ( x > 0 && grids[GRID_INDEX(x - 1, y) == val && (dir_flags & DIR_WEST)) */
/*sum += count_neighbors(x - 1, y, val, DIR_ALL ^ DIR_EAST);*/

/*if ( y > 0 && grids[GRID_INDEX(x, y - 1) == val && (dir_flags & DIR_NORTH)) */
/*sum += count_neighbors(x, y - 1, val, DIR_ALL ^ DIR_SOUTH);*/

/*if ( x < cols - 1 && grids[GRID_INDEX(x + 1, y) == val && (dir_flags & DIR_EAST)) */
/*sum += count_neighbors(x + 1, y, val, DIR_ALL ^ DIR_WEST);*/

/*if ( y < rows - 1 && grids[GRID_INDEX(x, y + 1) == val && (dir_flags & DIR_SOUTH)) */
/*sum += count_neighbors(x, y + 1, val, DIR_ALL ^ DIR_NORTH);*/

/*return sum;*/
/*}*/

static int count_neighbors(int x, int y, int val)
{
  int sum = 1;
  int index = GRID_INDEX(x, y);
  pairs[nlen++] = (struct pair) { index, val };
  grids[index] = -1;

  if ( x > 0 && grids[GRID_INDEX(x - 1, y)] == val) sum += count_neighbors(x - 1, y, val);
  if ( y > 0 && grids[GRID_INDEX(x, y - 1)] == val) sum += count_neighbors(x, y - 1, val);
  if ( x < cols - 1 && grids[GRID_INDEX(x + 1, y)] == val) sum += count_neighbors(x + 1, y, val);
  if ( y < rows - 1 && grids[GRID_INDEX(x, y + 1)] == val) sum += count_neighbors(x, y + 1, val);

  return sum;
}

static int restore_grids()
{
  int i;
  for( i = 0; i < nlen; ++i) 
    grids[pairs[i].index] = pairs[i].value;
}

static int check_neighbor(int x, int y, int num)
{
  memset(pairs, 0, sizeof(pairs));
  nlen = 0;

  int count = count_neighbors(x, y, grids[GRID_INDEX(x, y)]);

  restore_grids();
    
  return count >= num;
}

static int wrap_balls(int x, int y, int val)
{
  memset(pairs, 0, sizeof(pairs));
  nlen = 0;

  return count_neighbors(x, y, val);
}

static void sdl_error(char *str) {
  fprintf(stderr, "SDL_Error: %s : %s\n", str, SDL_GetError());
  quit(1);
}

static SDL_Surface* load_image(char *path)
{
  SDL_Surface *tmp, *dest;
  tmp = SDL_LoadBMP(path);
  dest = SDL_DisplayFormat(tmp);
  SDL_FreeSurface(tmp);

  return dest;
}

static void draw_img(SDL_Surface *src, int x, int y)
{
  SDL_BlitSurface(src, NULL, screen, &(SDL_Rect){x, y, src->w, src->h});
}

static void draw_scene()
{
  SDL_FillRect(screen, NULL, 0x000000);

  int i, j;
  for(i = 0; i < rows; i++) {
    for(j = 0; j < cols; j++) {
      if(grids[GRID_INDEX(j, i)] != -1)
	draw_img(balls[grids[GRID_INDEX(j, i)]], j * BALL_SIZE, i * BALL_SIZE);
    }
  }
  SDL_Flip(screen);
}

static void new_game()
{
  update_score(0);
  int i, j;
  for(i = 0; i < rows; i++) {
    for(j = 0; j < cols; j++) {
      grids[GRID_INDEX(j, i)] = rand() % 5;
    }
  }
  draw_scene();
}
/*
  int main(int argc, char *argv[]) 
  {
  if(!(screen = SDL_SetVideoMode(SRCW, SRCH, 32, SDL_HWSURFACE)))
  sdl_error("initializing sdl");

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

  int done = 0;
  int released = 1;
  while(!done) {
  SDL_Event event;
  while( SDL_PollEvent(&event) ) {
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
  }

  int x, y;
  SDL_GetMouseState(&x, &y);
  x /= BALL_SIZE;
  y /= BALL_SIZE;

  if( !SDL_GetMouseState(NULL, NULL) & SDL_BUTTON(1) ) {
  released = 1;
  }

  int running = 0;

  if ( !running && SDL_GetMouseState(NULL, NULL) & SDL_BUTTON(1) && released ) {
  released = 0;
  if ( x >=0 && y >= 0 && x < cols && y < rows 
  && grids[GRID_INDEX(x, y)] != -1 && check_neighbor(x, y, MAX_CONNECT)) {
  int result = wrap_balls(x, y, grids[GRID_INDEX(x, y)]) - MAX_CONNECT + 1;
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
  }

  SDL_FreeSurface(screen);
  quit(0);

  return 0;
  }
*/
