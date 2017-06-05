/******************************************************************************************
 Generates Ball, applying speed & gravity
 ******************************************************************************************/

void ball(int ballNum) {

  ballX[ballNum] += speedX[ballNum];
  ballY[ballNum] += gravityY[ballNum];

  pushMatrix();

  if (round == 1) {
    if (paddleCount[ballNum] % 3 == 1) fill(#ffda00 );
    else if (paddleCount[ballNum] % 3 == 2) fill(#e70000 );
    else if (paddleCount[ballNum] % 3 == 0 & ballCount != 0) fill(#000000 );
  } else if (round == 2) {
    if (paddleCount[ballNum] % 2 == 1) fill(0);
    else if (paddleCount[ballNum] % 2 == 0 & ballCount != 0) fill(255, 0, 0);
  } else if (round == 3) {
    if (paddleCount[ballNum] % 2 == 1) fill(255,215,0);
    else if (paddleCount[ballNum] % 2 == 0 & ballCount != 0) fill(255, 0, 0);
  }

  translate(ballX[ballNum], ballY[ballNum]);

  //println(ballNum, ballLeftBound.length, ballLeftBound[ballNum], ballRightBound[ballNum], ballUpperBound[ballNum], ballLowerBound[ballNum]);

  ballLeftBound[ballNum]  = ballX[ballNum] - ballRadius[ballNum];
  ballRightBound[ballNum] = ballX[ballNum] + ballRadius[ballNum];
  ballUpperBound[ballNum] = ballY[ballNum] - ballRadius[ballNum];
  ballLowerBound[ballNum] = ballY[ballNum] + ballRadius[ballNum];

  ellipse(0, 0, ballRadius[ballNum]*2, ballRadius[ballNum]*2);
  popMatrix();
}

void ballSplit(int ballNum) {
  int[] ballAddition = {1,2,4};
  
    // this is the ball size shrinking statement
  if (round == 1) ballRadius[ballNum] *=.5;
  else if (round == 2) ballRadius[ballNum] /=2.25;
  else if (round == 3) ballRadius[ballNum] /=3.0517578125;

  for (int i = 0; i<ballAddition[round-1];i++){
    ballCount++;
    ballRadius       = append(ballRadius, ballRadius[ballNum]);
    ballLeftBound    = append(ballLeftBound, ballLeftBound[ballNum]);
    ballRightBound   = append(ballRightBound, ballRightBound[ballNum]);
    ballUpperBound   = append(ballUpperBound, ballUpperBound[ballNum]);
    ballLowerBound   = append(ballLowerBound, ballLowerBound[ballNum]);
    ballX            = append(ballX, ballX[ballNum]);
    ballY            = append(ballY, ballY[ballNum]);
    speedX           = append(speedX, 5);
    
    if (round == 1)    gravityY = append(gravityY, -gravityY[ballNum]);
    else gravityY = append(gravityY, int(random(-12, 12)));
    
    paddleCount      = append(paddleCount, 0);
  }

  paddleHitFlag    = 0;
}

void ballPop(int ballNum) {
  ballCount--;

  retiredBallCount += paddleCount[ballNum] - 1;

  ballRadius       = pop(ballRadius, ballNum);
  ballLeftBound    = pop(ballLeftBound, ballNum);
  ballRightBound   = pop(ballRightBound, ballNum);
  ballUpperBound   = pop(ballUpperBound, ballNum);
  ballLowerBound   = pop(ballLowerBound, ballNum);
  ballX            = pop(ballX, ballNum);
  ballY            = pop(ballY, ballNum);
  speedX           = pop(speedX, ballNum);
  gravityY         = pop(gravityY, ballNum);
  paddleCount      = pop(paddleCount, ballNum);
}

void ballGrow(int ballNum) {
  if (round == 1) ballRadius[ballNum]*=2;
  else if (round == 2) ballRadius[ballNum]*=1.5;
  else if (round == 3) ballRadius[ballNum]*=1.25;
  paddleHitFlag = 0;
}