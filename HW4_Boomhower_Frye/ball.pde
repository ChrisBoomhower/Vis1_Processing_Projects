/******************************************************************************************
 Generates Ball, applying speed & gravity
 ******************************************************************************************/

void ball() {
  ballX += speedX;
  ballY += gravityY;
  
  pushMatrix();
  fill(0);  // this needs to cycle through colors
  
  translate(ballX, ballY);

  ballLeftBound  = ballX - ballRadius;
  ballRightBound = ballX + ballRadius;

  ellipse(0, 0, ballRadius*2, ballRadius*2);
  popMatrix();
}