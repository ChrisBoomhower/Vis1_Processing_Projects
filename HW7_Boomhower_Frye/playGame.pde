/******************************************************************************************
 Round 1 Custom Ball Movement
 ******************************************************************************************/
class playGame {

  playGame() {
  }

  void playRound(int roundNum) {

    float[] gravInitFactorMin = {5,2,2};
    float[] gravInitFactorMax = {5,15,15};
    float[] gravModFactorMin = {-1,-1,-1};
    float[] gravModFactorMax = {-1,-1,-2};
    float[] speedModFactorMin = {-1.1,-1.1,-1};
    float[] speedModFactorMax = {-1.1,-2,-2};
        
    for (int i = 0; i<ballCount; i++) {
      ball[i].drawBall();

      // Initialize ball gravityY
      if (ball[i].getPaddleCount() == 1 & gravityInit == 1) {
        if (i%2 == 0) ball[i].setGravityY(random(gravInitFactorMin[roundNum-1],gravInitFactorMax[roundNum-1]));
        else ball[i].setGravityY(-random(gravInitFactorMin[roundNum-1],gravInitFactorMax[roundNum-1]));
        gravityInit = 0;
      }

      // change ball gravityY direction on wall bounce
      if (ball[i].getGravityY()       <  0
        & ball[i].getBallUpperBound()  <= 0) {

        ball[i].setGravityY(ball[i].getGravityY()*random(gravModFactorMin[roundNum-1],gravModFactorMax[roundNum-1]));
      } else if (ball[i].getGravityY() >  0
        & ball[i].getBallLowerBound()  >= height) {

        ball[i].setGravityY(ball[i].getGravityY()*random(gravModFactorMin[roundNum-1],gravModFactorMax[roundNum-1]));
      }

      // change ball speedX on successful paddle hit
      if (ball[i].getSpeedX()         <  0
        & ball[i].getBallLeftBound()  <= paddle.getLeftPaddleBound ()
        & ball[i].getBallY()          >= paddle.getPaddleUpperY()
        & ball[i].getBallY()          <= paddle.getPaddleLowerY()) {

        if (ball[i].getSpeedX()         >  -maxAbsSpeedX)  ball[i].setSpeedX(ball[i].getSpeedX()*-1.1);
        else ball[i].setSpeedX(ball[i].getSpeedX()*-1);

        if(roundNum>1){
          if(ball[i].getGravityY()<0) ball[i].setGravityY(random(2, 12));
          else ball[i].setGravityY(random(-2, -12));
        }
        
        ball[i].setPaddleCount(ball[i].getPaddleCount()+1);

        paddleHitFlag    = 1;
      } else if (ball[i].getSpeedX()  >  0 
        & ball[i].getBallRightBound() >= paddle.getRightPaddleBound()
        & ball[i].getBallY()          >= paddle.getPaddleUpperY()
        & ball[i].getBallY()          <= paddle.getPaddleLowerY()) {

        if (ball[i].getSpeedX()         <  maxAbsSpeedX)  ball[i].setSpeedX(ball[i].getSpeedX()*random(speedModFactorMin[roundNum-1],speedModFactorMax[roundNum-1]));
        else ball[i].setSpeedX(ball[i].getSpeedX()*-1);

        ball[i].setPaddleCount(ball[i].getPaddleCount()+1);
        paddleHitFlag    = 1;
      }

      if(roundNum == 1){
        if (ball[i].getPaddleCount() != 0 & ball[i].getPaddleCount() % 2 == 0 & paddleHitFlag    == 1)      ballEmitter.ballSplit(i);
        else if (ball[i].getPaddleCount() != 0 & ball[i].getPaddleCount() % 2 == 1 & paddleHitFlag    == 1) ballEmitter.ballGrow(i);
      }
      else if(roundNum == 2){
        if (ball[i].getPaddleCount() != 0 & ball[i].getPaddleCount() % 3 == 0 & paddleHitFlag    == 1)      ballEmitter.ballSplit(i);
        else if (ball[i].getPaddleCount() != 0 & (ball[i].getPaddleCount() % 3 ==1 | ball[i].getPaddleCount() % 3 ==2) & paddleHitFlag    == 1) ballEmitter.ballGrow(i);
      }
      else if(roundNum == 3){
        if (ball[i].getPaddleCount() != 0 & ball[i].getPaddleCount() % 5 == 0 & paddleHitFlag    == 1)      ballEmitter.ballSplit(i);
        else if (ball[i].getPaddleCount() != 0 & (ball[i].getPaddleCount() % 5 ==1 | ball[i].getPaddleCount() % 5 ==2 | ball[i].getPaddleCount() % 5 ==3 | ball[i].getPaddleCount() % 5 ==4) & paddleHitFlag    == 1) ballEmitter.ballGrow(i);
      }
    }
  }
}