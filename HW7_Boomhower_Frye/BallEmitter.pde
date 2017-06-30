class BallEmitter {

  BallEmitter() {
    ball = new Ball[1];
    ball[0] = new Ball(15, 0, 0);
  }


  void ballSplit(int ballNum) {
    int[] ballAddition = {1, 2, 4};

    // this is the ball size shrinking statement
    if (round == 1) ball[ballNum].setBallRadius(ball[ballNum].getBallRadius() / 2);
    else if (round == 2) ball[ballNum].setBallRadius(ball[ballNum].getBallRadius() / 2.25);
    else if (round == 3) ball[ballNum].setBallRadius(ball[ballNum].getBallRadius() / 3.0517578125);
        
    for (int i = 0; i<ballAddition[round-1]; i++) {
      ballCount++;
      float gravityY;
      float speedX;
      
      if (round == 1)    gravityY = -ball[ballNum].getGravityY();
      else gravityY = int(random(-12, 12));

      if (ball[ballNum].getSpeedX() < 0) speedX = int(random(-7, -2));
      else speedX = int(random(2, 7)); // this code to fix the right paddle bugs?? 
       
      //print("speed: " + ball[ballNum].getSpeedX()+", newSpeed: "+speedX+", "); 
      //print("ballRadius: " + ball[ballNum].getBallRadius()+", "); 
      
      ball = (Ball[])append(ball, new Ball(ball[ballNum].getBallRadius(),  speedX,  gravityY, 
                                           ball[ballNum].getBallLeftBound(),  ball[ballNum].getBallRightBound(),  
                                           ball[ballNum].getBallUpperBound(),  ball[ballNum].getBallLowerBound(), 
                                           ball[ballNum].getBallX(),  ball[ballNum].getBallY()));

  

      //ball[ballNum+i+1].setPaddleCount(0);
      ball[ballNum+i+1].setBallLeftBound(ball[ballNum].getBallLeftBound());
      ball[ballNum+i+1].setBallRightBound(ball[ballNum].getBallRightBound());
      ball[ballNum+i+1].setBallUpperBound(ball[ballNum].getBallUpperBound());
      ball[ballNum+i+1].setBallLowerBound(ball[ballNum].getBallLowerBound());
      ball[ballNum+i+1].setBallX(ball[ballNum].getBallX());
      ball[ballNum+i+1].setBallY(ball[ballNum].getBallY());
    }  
    paddleHitFlag    = 0;
  }


  Ball[] ballPop(int ballNum) {
    ballCount--;

    retiredBallCount += ball[ballNum].getPaddleCount() - 1;

    Ball ballOut[] = new Ball[ball.length - 1];
    System.arraycopy(ball, 0, ballOut, 0, ballNum);
    System.arraycopy(ball, ballNum+1, ballOut, ballNum, ball.length - (ballNum + 1));
    return ballOut;
  }

  void ballGrow(int ballNum) {
    if (round == 1)  ball[ballNum].setBallRadius(ball[ballNum].getBallRadius()*2);
    else if (round == 2) ball[ballNum].setBallRadius(ball[ballNum].getBallRadius()*1.5);
    else if (round == 3) ball[ballNum].setBallRadius(ball[ballNum].getBallRadius()*1.25);
    paddleHitFlag = 0;
  }
}