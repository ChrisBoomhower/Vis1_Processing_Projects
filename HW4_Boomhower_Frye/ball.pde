/******************************************************************************************
 Generates Ball, applying speed & gravity
 ******************************************************************************************/

void ball(int ballNum) {

  ballX[ballNum] += speedX[ballNum];
  ballY[ballNum] += gravityY[ballNum];

  pushMatrix();
  fill(0);  // this needs to cycle through colors

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
  ballRadius       = append(ballRadius, ballRadius[ballNum]);
  ballLeftBound    = append(ballLeftBound, ballLeftBound[ballNum]);
  ballRightBound   = append(ballRightBound, ballRightBound[ballNum]);
  ballUpperBound   = append(ballUpperBound, ballUpperBound[ballNum]);
  ballLowerBound   = append(ballLowerBound, ballLowerBound[ballNum]);
  ballX            = append(ballX, ballX[ballNum]);
  ballY            = append(ballY, ballY[ballNum]);
  speedX           = append(speedX, 5);
  gravityY         = append(gravityY, -gravityY[ballNum]);
  paddleHitFlag    = 0;
}

void ballPop(int ballNum) {
  ballCount--;
  ballRadius       = pop(ballRadius, ballNum);
  ballLeftBound    = pop(ballLeftBound, ballNum);
  ballRightBound   = pop(ballRightBound, ballNum);
  ballUpperBound    = pop(ballUpperBound, ballNum);
  ballLowerBound   = pop(ballLowerBound, ballNum);
  ballX            = pop(ballX, ballNum);
  ballY            = pop(ballY, ballNum);
  speedX           = pop(speedX, ballNum);
  gravityY         = pop(gravityY, ballNum);
}