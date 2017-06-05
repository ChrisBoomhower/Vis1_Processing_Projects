/****************************************************************************************** //<>// //<>//
 Generates Ball, applying speed & gravity
 ******************************************************************************************/

void ball(int ballNum) {

  ballX[ballNum] += speedX[ballNum];
  ballY[ballNum] += gravityY[ballNum];

  pushMatrix();

  if (splitCount[ballNum] % 2 == 1) fill(0);
  else if (splitCount[ballNum] % 2 == 0 & ballCount != 0) fill(255, 0, 0);

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

  if (round == 1) {
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
    splitCount       = append(splitCount, 0);
  } else if (round == 2) {
    ballCount+=2;
    // this is the ball size shrinking statement
    ballRadius[ballNum] /=2.25;

    ballRadius       = append(append(ballRadius, ballRadius[ballNum]), ballRadius[ballNum]);
    ballLeftBound    = append(append(ballLeftBound, ballLeftBound[ballNum]), ballLeftBound[ballNum]);
    ballRightBound   = append(append(ballRightBound, ballRightBound[ballNum]), ballRightBound[ballNum]);
    ballUpperBound   = append(append(ballUpperBound, ballUpperBound[ballNum]), ballUpperBound[ballNum]);
    ballLowerBound   = append(append(ballLowerBound, ballLowerBound[ballNum]), ballLowerBound[ballNum]);
    ballX            = append(append(ballX, ballX[ballNum]), ballX[ballNum]);
    ballY            = append(append(ballY, ballY[ballNum]), ballY[ballNum]);
    speedX           = append(append(speedX, 5), 5);
    gravityY         = append(append(gravityY, int(random(-12,12))), int(random(-12,12)));
    paddleCount      = append(append(paddleCount, 0), 0);
    splitCount       = append(append(splitCount, 0), 0);
    println(ballCount);
  }

  splitCount[ballNum]+=1;

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
  paddleHitFlag = 0;
}