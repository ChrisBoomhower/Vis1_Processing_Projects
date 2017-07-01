/******************************************************************************************
 Generates both Left and Right Paddles
 ******************************************************************************************/
class Paddle {

  float paddleHeight;
  float paddleWidth;
  float paddleUpperY;            // to be used for ball "hit" upper Y boundary
  float paddleLowerY;            // to be used for ball "hit" lower Y boundary
  float leftPaddleBound;         // to be used for ball "hit" X boundary for left paddle 
  float rightPaddleBound;        // to be used for ball "hit" X boundary for right paddle 

  Paddle(float paddleHeight, float paddleWidth) {
    this.paddleHeight = paddleHeight;
    this.paddleWidth  = paddleWidth;

    this.paddleUpperY     = height/2 - paddleHeight/2;
    this.paddleLowerY     = height/2 + paddleHeight/2;
    this.leftPaddleBound  = paddleWidth*2;
    this.rightPaddleBound = width - (paddleWidth*2);
  }

  void drawPaddle() {
    pushMatrix();
    //Default to Center Y, else use mouseY position
    fill(100);
    if (frameCount == 1) translate(0, height/2 - paddleHeight/2);
    else {
      translate(0, mouseY - paddleHeight/2);
      paddleUpperY     = mouseY - paddleHeight/2;
      paddleLowerY     = mouseY + paddleHeight/2;
    }
    //Left Paddle
    rect(paddleWidth, 0, paddleWidth, paddleHeight);

    //Right Paddle
    rect(width - paddleWidth*2, 0, paddleWidth, paddleHeight);
    popMatrix();
  }

  void displayPaddleCount() {
    pushMatrix();
    fill(200);
    noStroke();
    rect(335, 15, 60, 60);
    popMatrix();

    pushMatrix();
    fill(0);
    textSize(32);
    textAlign(BASELINE);
    text(arraySum(ball), 350, 50);
    popMatrix();
  }

  void setPaddleSize(float paddleHeight, float paddleWidth) {
    this.paddleHeight = paddleHeight;
    this.paddleWidth  = paddleWidth;

    this.paddleUpperY     = height/2 - paddleHeight/2;
    this.paddleLowerY     = height/2 + paddleHeight/2;
    this.leftPaddleBound  = paddleWidth*2;
    this.rightPaddleBound = width - (paddleWidth*2);
  }


  float getPaddleUpperY() {
    return this.paddleUpperY;
  }
  float getPaddleLowerY() {
    return this.paddleLowerY;
  }
  float getLeftPaddleBound() {
    return this.leftPaddleBound;
  }
  float getRightPaddleBound() {
    return this.rightPaddleBound;
  }
  float getPaddleHeight() {
    return this.paddleHeight;
  }
  float getPaddleWidth() {
    return this.paddleWidth;
  }
}