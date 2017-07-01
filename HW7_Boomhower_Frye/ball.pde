/****************************************************************************************** //<>// //<>//
 Generates Ball, applying speed & gravity
 ******************************************************************************************/
class Ball {

  float ballRadius;//       = {15};
  float ballLeftBound;
  float ballRightBound;
  float ballUpperBound;
  float ballLowerBound;
  float ballX;
  float ballY;
  float speedX;//           = {0};
  float gravityY;//         = {0}; 
  int   paddleCount  = 0;
  boolean powerupFlag = false;
  
  Ball(float ballRadius, float speedX, float gravityY) {
    this.ballRadius     = ballRadius;
    this.ballX          = paddle.getLeftPaddleBound() + 20;
    this.ballY          = height/2;
    this.ballLeftBound  = ballX - ballRadius;
    this.ballRightBound = ballX + ballRadius;
    this.ballUpperBound = ballY - ballRadius;
    this.ballLowerBound = ballY + ballRadius;


    this.speedX = speedX;
    this.gravityY = gravityY;
  }


  Ball(float ballRadius, float speedX, float gravityY, 
       float ballLeftBound, float ballRightBound, float ballUpperBound, float ballLowerBound, 
       float ballX, float ballY, boolean powerupFlag) {
    this.ballRadius     = ballRadius;
    this.ballX          = ballX;
    this.ballY          = ballY;
    this.ballLeftBound  = ballLeftBound;
    this.ballRightBound = ballRightBound;
    this.ballUpperBound = ballUpperBound;
    this.ballLowerBound = ballLowerBound;

    this.speedX = speedX;
    this.gravityY = gravityY;
    
    this.powerupFlag = powerupFlag;
  }

  void drawBall() {

    this.ballX += this.speedX;
    this.ballY += this.gravityY;

    pushMatrix();

    if (round == 1) {
      if (paddleCount % 3 == 1) fill(#ffda00 );
      else if (paddleCount % 3 == 2) fill(#e70000 );
      else if (paddleCount % 3 == 0 & ballCount != 0) fill(#000000 );
    } else if (round == 2) {
      if (paddleCount % 2 == 1) fill(255);
      else if (paddleCount % 2 == 0 & ballCount != 0) fill(255, 0, 0);
    } else if (round == 3) {
      if (paddleCount % 2 == 1) fill(255, 215, 0);
      else if (paddleCount % 2 == 0 & ballCount != 0) fill(255, 0, 0);
    }

    translate(ballX, ballY);

    //println(ballNum, ballLeftBound.length, ballLeftBound[ballNum], ballRightBound[ballNum], ballUpperBound[ballNum], ballLowerBound[ballNum]);

    ballLeftBound  = ballX - this.ballRadius;
    ballRightBound = ballX + this.ballRadius;
    ballUpperBound = ballY - this.ballRadius;
    ballLowerBound = ballY + this.ballRadius;

    if (powerupFlag ==true) stroke(0,0,255);
    else noStroke();

    ellipse(0, 0, ballRadius*2, ballRadius*2);
    popMatrix();
  }

  void setBallRadius(float ballRadius){
    this.ballRadius = ballRadius;
  }
  
  void setBallLeftBound(float ballLeftBound){
    this.ballLeftBound = ballLeftBound;
  }
  
  void setBallRightBound(float ballRightBound){
    this.ballRightBound = ballRightBound;
  }
  
  void setBallUpperBound(float ballUpperBound){
    this.ballUpperBound = ballUpperBound;
  }

  void setBallLowerBound(float ballLowerBound){
    this.ballLowerBound = ballLowerBound;
  }
  
  void setBallX(float ballX){
    this.ballX = ballX;
  }

  void setBallY(float ballY){
    this.ballY = ballY;
  }

  void setSpeedX(float speedX){
    this.speedX = speedX;
  }

  void setGravityY(float gravityY){
    this.gravityY = gravityY;
  }

  void setPaddleCount(int paddleCount){
    this.paddleCount = paddleCount;
  }

  void setPowerupFlag(boolean powerupFlag){
    this.powerupFlag = powerupFlag;
  }

  float getBallRadius(){
    return this.ballRadius;
  }
  
  float getBallLeftBound(){
    return this.ballLeftBound;
  }
  
  float getBallRightBound(){
    return this.ballRightBound;
  }
  
  float getBallUpperBound(){
    return this.ballUpperBound;
  }

  float getBallLowerBound(){
    return this.ballLowerBound;
  }
  
  float getBallX(){
    return this.ballX;
  }

  float getBallY(){
    return this.ballY;
  }

  float getSpeedX(){
    return this.speedX;
  }

  float getGravityY(){
    return this.gravityY;
  }

  int getPaddleCount(){
     return this.paddleCount;
  }
  
  boolean getPowerupFlag(){
     return this.powerupFlag;
  }
}