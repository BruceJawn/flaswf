private var CurState:int = GAME_MENU;

private const GAME_MENU:int = 0;
private const GAME_MENU$RUNNING:int = 1;

private const GAME_PAUSED:int = 2;
private const GAME_PAUSED$RUNNING:int = 3;

private const GAME_RUNNING:int = 4;
private const GAME_IDLE:int = 5;
private const GAME_OVER:int = 6;
private const GAME_SCORING:int = 7;