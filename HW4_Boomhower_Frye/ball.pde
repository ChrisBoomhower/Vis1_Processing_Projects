/******************************************************************************************
 Generates Ball, applying speed & gravity
 ******************************************************************************************/

void ball(int ballNum) {

  ballX[ballNum] += speedX[ballNum];
  ballY[ballNum] += gravityY[ballNum];

  pushMatrix();
  fill(ballColor[ballNum]);  // this needs to cycle through colors

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
  ballCount++;

    // this is the ball size shrinking statement
  ballRadius[ballNum] *=.5;

  ballRadius       = append(ballRadius, ballRadius[ballNum]);
  ballLeftBound    = append(ballLeftBound, ballLeftBound[ballNum]);
  ballRightBound   = append(ballRightBound, ballRightBound[ballNum]);
  ballUpperBound   = append(ballUpperBound, ballUpperBound[ballNum]);
  ballLowerBound   = append(ballLowerBound, ballLowerBound[ballNum]);
  ballX            = append(ballX, ballX[ballNum]);
  ballY            = append(ballY, ballY[ballNum]);
  speedX           = append(speedX, 5);
  gravityY         = append(gravityY, -gravityY[ballNum]);
  paddleCount      = append(paddleCount, 0);
  
  if (ballNum % 3 == 1) ballColor = append(ballColor, #ffda00);
  else if (ballNum % 3 == 2) ballColor = append(ballColor, #e70000);
  else if (ballNum % 3 == 0 & ballCount != 0) ballColor = append(ballColor, #000000);
  
  print(ballNum % 3);
  
  paddleHitFlag    = 0;
}

void ballPop(int ballNum) {
  ballCount--;
  
  retiredBallCount += paddleCount[ballNum] - 1;
  
  ballRadius       = pop(ballRadius, ballNum);
  ballLeftBound    = pop(ballLeftBound, ballNum);
  ballRightBound   = pop(ballRightBound, ballNum);
  ballUpperBound    = pop(ballUpperBound, ballNum);
  ballLowerBound   = pop(ballLowerBound, ballNum);
  ballX            = pop(ballX, ballNum);
  ballY            = pop(ballY, ballNum);
  speedX           = pop(speedX, ballNum);
  gravityY         = pop(gravityY, ballNum);
  paddleCount      = pop(paddleCount, ballNum);
}

void ballGrow(int ballNum) {
  ballRadius[ballNum]*=2;
  paddleHitFlag = 0;
}