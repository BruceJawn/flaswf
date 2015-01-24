include "fsm/StateVars.as";
private var FrameCNT:int = 0;

private function onEnterFrame(event:Event):void
{
	FrameCNT++;
	switch (CurState)
	{
		case GAME_PAUSED: 
			PauseMenu_P.addChild(Continue_B);
			Continue_B.x = 156;
			Continue_B.y = 64 + 16 + 16;
			PauseMenu_P.addChild(Instruction_B);
			Instruction_B.x = 156;
			Instruction_B.y = 64 + 16 + 16 + 64 + 16;
			PauseMenu_P.addChild(SubmitScore_B);
			SubmitScore_B.x = 156;
			SubmitScore_B.y = 64 + 16 + 16 + 64 + 16 + 64 + 16;
			addChild(PauseMenu_P);
			setChildIndex(PauseMenu_P, 1);
			Mouse.show();
			if (playMusic && musicPlaying)
			{
				lastMPosition = MusicSC.position;
				MusicSC.stop();
				musicPlaying = false;
			}
			CurState = GAME_IDLE;
			break;
		case GAME_RUNNING: 
			Begnine_RenderLoop();
			break;
		case GAME_MENU: 
			MainMenu_P.addChild(NewGame_B);
			NewGame_B.x = 156;
			NewGame_B.y = 64 + 16 + 16;
			MainMenu_P.addChild(Instruction_B);
			Instruction_B.x = 156;
			Instruction_B.y = 64 + 16 + 16 + 64 + 16;
			MainMenu_P.addChild(Credit_B);
			Credit_B.x = 156;
			Credit_B.y = 64 + 16 + 16 + 64 + 16 + 64 + 16;
			addChild(MainMenu_P);
			setChildIndex(MainMenu_P, 1);
			//stage.focus = MainMenu_P;
			CurState = GAME_IDLE;
			break;
		case GAME_MENU$RUNNING: 
			Mouse.hide();
			removeChild(MainMenu_P);
			if (playMusic && !musicPlaying)
			{
				MusicSC = Music.play(lastMPosition, int.MAX_VALUE);
				musicPlaying = true;
			}
			CurState = GAME_RUNNING;
			break;
		case GAME_PAUSED$RUNNING: 
			Mouse.hide();
			removeChild(PauseMenu_P);
			if (playMusic && !musicPlaying)
			{
				MusicSC = Music.play(lastMPosition, int.MAX_VALUE);
				musicPlaying = true;
			}
			CurState = GAME_RUNNING;
			break;
		case GAME_SCORING: 
			//Mouse.show();
			break;
	}
}