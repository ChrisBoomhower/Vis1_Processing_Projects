/******************************************************************************************
 Round 1 Custom Ball Movement
 ******************************************************************************************/

void round1() {
  for (int i = 0; i<ballCount; i++) {
    ball(i);

    // Initialize ball gravityY
    if (paddleCount[i] == 1 & gravityInit == 1) {
      if (i%2 == 0) gravityY[i] = 5;
      else gravityY[i] = -5;
      gravityInit = 0;
    }

    // change ball gravityY direction on wall bounce
    if (gravityY[i]       <  0
      & ballUpperBound[i]  <= 0) {

      gravityY[i]*=-1;
    } else if (gravityY[i] >  0
      & ballLowerBound[i]  >= height) {

      gravityY[i]*=-1;
    }

    // change ball speedX on successful paddle hit
    if (speedX[i]         <  0
      & ballLeftBound[i]  <= leftPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         >  -maxAbsSpeedX)  speedX[i]*=-1.1;
      else speedX[i]*=-1;

      paddleCount[i]++;
      paddleHitFlag    = 1;
    } else if (speedX[i]  >  0 
      & ballRightBound[i] >= rightPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         <  maxAbsSpeedX)  speedX[i]*=-1.1;
      else speedX[i]*=-1;

      paddleCount[i]++;
      paddleHitFlag    = 1;
    }

    if (paddleCount[i] != 0 & paddleCount[i] % 2 == 0 & paddleHitFlag    == 1)      ballSplit(i);
    else if (paddleCount[i] != 0 & paddleCount[i] % 2 == 1 & paddleHitFlag    == 1) ballGrow(i);
  }
}