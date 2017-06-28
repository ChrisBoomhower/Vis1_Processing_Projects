/******************************************************************************************
Round 2 Custom Ball Movement
******************************************************************************************/

void round2() {
  for (int i = 0; i<ballCount; i++) {
    ball(i);

    // Initialize ball gravityY
    if (paddleCount[i] == 1 & gravityInit == 1) {
      if (i%2 == 0) gravityY[i] = random(2, 15);
      else gravityY[i] = random(-2, -15);
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
      & ballLeftBound[i]  <= paddle.getLeftPaddleBound() 
      & ballY[i]          >= paddle.getPaddleUpperY()
      & ballY[i]          <= paddle.getPaddleLowerY()) {

      if (speedX[i]         >  -maxAbsSpeedX)  speedX[i]*=-1.1;
      else speedX[i]*=-1;
      
      if(gravityY[i]<0) gravityY[i] = random(2, 12);
      else gravityY[i] = random(-2, -12);

      paddleCount[i]++;
      paddleHitFlag    = 1;
    } else if (speedX[i]  >  0 
      & ballRightBound[i] >= paddle.getRightPaddleBound() 
      & ballY[i]          >= paddle.getPaddleUpperY()
      & ballY[i]          <= paddle.getPaddleLowerY()) {

      if (speedX[i]         <  maxAbsSpeedX)  speedX[i]*=random(-1.1,-2);
      else speedX[i]*=-1;

      paddleCount[i]++;
      paddleHitFlag    = 1;
    }

    if (paddleCount[i] != 0 & paddleCount[i] % 3 == 0 & paddleHitFlag    == 1)      ballSplit(i);
    else if (paddleCount[i] != 0 & (paddleCount[i] % 3 ==1 |paddleCount[i] % 3 ==2) & paddleHitFlag    == 1) ballGrow(i);
  }
}