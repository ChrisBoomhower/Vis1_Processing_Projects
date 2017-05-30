// Object globals
int doorYcoord;
int doorXcoord;
int doorHeight;
int knobYcoord;
int doorAction = 0;
float ballX = 0;
float ballY = 0;
float pickupSpeedX = 0.2;
float pickupSpeedY = 4;
float gravity = .05;


void openDoor(){
  strokeWeight(1);
  fill(139, 69, 19);
  rect(doorXcoord, doorYcoord, fcSkit, doorHeight);
  fill(255, 255, 0);
  ellipse(doorXcoord + fcSkit - 20 * doorAction/120, doorYcoord + doorHeight/2 + 30, 10, 10);
  doorAction++;
}

void stillDoor(){
  fill(139, 69, 19);
  rect(doorXcoord, doorYcoord, 120, doorHeight);
  fill(255, 255, 0);
  ellipse(doorXcoord + 100, doorYcoord + doorHeight/2 + 30, 10, 10);
}

void stillBall(){
  noStroke();
  fill(255, 0, 0);
  ballX = width/2 + 80;
  ballY = gnd - ballRadius/2;
  ellipse(ballX, ballY, ballRadius, ballRadius);
}

void pickupBall(){
  noStroke();
  fill(255, 0, 0);
  ellipse(ballX, ballY, ballRadius, ballRadius);
  ballX -= pickupSpeedX;
  pickupSpeedY -= gravity;
  ballY = ballY - pickupSpeedY;
  if(pickupSpeedY < 0){
    catcher = true;
    if(ballY > 522){
      ballY = 522;
      ballX += pickupSpeedX;
    }
  }
}