// Stage3d game timer routines version 1.0
// 
package
{
	
	public class GameTimer
	{
		// when the game started
		public var gameStartTime:Number;
		// timestamp: previous frame
		public var lastFrameTime:Number;
		// timestamp: right now
		public var currentFrameTime:Number;
		// how many ms elapsed last frame
		public var frameMs:Number;
		// number of frames this game
		public var frameCount:uint;
		// when to fire this next
		public var nextHeartbeatTime:uint;
		// how many ms so far?
		public var gameElapsedTime:uint;
		// how often in ms does the heartbeat occur?
		public var heartbeatIntervalMs:uint;
		// function to run each heartbeat
		public var heartbeatFunction:Function;
		
		// class constructor
		public function GameTimer(heartbeatFunc:Function = null, heartbeatMs:uint = 1000):void
		{
			if (heartbeatFunc != null)
				heartbeatFunction = heartbeatFunc;
			
			heartbeatIntervalMs = heartbeatMs;
		}
		
		public function tick():void
		{
			currentFrameTime = getTimer();
			if (frameCount == 0) // first frame?
			{
				gameStartTime = currentFrameTime;
				trace("First frame happened after " + gameStartTime + "ms");
				frameMs = 0;
				gameElapsedTime = 0;
			}
			else
			{
				// how much time has passed since the last frame?
				frameMs = currentFrameTime - lastFrameTime;
				gameElapsedTime += int(frameMs);
			}
			
			if (heartbeatFunction != null)
			{
				if (currentFrameTime >= nextHeartbeatTime)
				{
					heartbeatFunction();
					nextHeartbeatTime = int(currentFrameTime + heartbeatIntervalMs);
				}
			}
			
			lastFrameTime = currentFrameTime;
			frameCount++;
		}
	
	} // end class

} //end of package
