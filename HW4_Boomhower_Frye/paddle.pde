/******************************************************************************************
 Generates both Left and Right Paddles
 ******************************************************************************************/


void paddle() {
  pushMatrix();
  //Default to Center Y, else use mouseY position
  fill(125);
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