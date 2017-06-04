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