/******************************************************************************************
 Generates both Left and Right Paddles
 ******************************************************************************************/
class Paddle {

  float paddleHeight;
  float paddleWidth;

  Paddle(float paddleHeight, float paddleWidth) {
    this.paddleHeight = paddleHeight;
    this.paddleWidth  = paddleWidth;
    
    paddleUpperY     = height/2 - paddleHeight/2;
    paddleLowerY     = height/2 + paddleHeight/2;
    leftPaddleBound  = paddleWidth*2;
    rightPaddleBound = width - (paddleWidth*2);
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
    text(arraySum(paddleCount), 350, 50);
    popMatrix();
  }
}