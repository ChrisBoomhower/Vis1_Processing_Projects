/******************************************************************************************
 This file contains functions for drawing foreground objects such as the ball and door
 ******************************************************************************************/

// Object globals
int doorYcoord;
int doorXcoord;
int doorHeight;
int knobYcoord;
int doorAction = 0;
float ballX = 0;
float ballY = 0;
boolean pubFlag = false;
float pickupSpeedX = 0.3;
float pickupSpeedY = 5;
float gravity = 0.09;
float damping = 0.70;
float friction = 0.80;
//float throwSpeedX = 0.4;
float throwSpeedY = 6;
float throwSpeedX = 3.37;
//float throwSpeedY2 = 6;
boolean actionC = false;
int countCollisionX = 0;
int countThrow2p2Passes = 0;

void openDoor(){
  strokeWeight(1);
  fill(139, 69, 19);
  rect(doorXcoord, doorYcoord, fcSkit, doorHeight);
  fill(255, 255, 0);
  ellipse(doorXcoord + fcSkit - 20 * doorAction/120, doorYcoord + doorHeight/2 + 30, 10, 10);
  doorAction++;
}

void stillDoor(int doorXcoord, int doorYcoord){
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

void stillBallCeiling(){
  noStroke();
  fill(255, 0, 0);
  //ballX = 215.39339;
  ballY = 10 + ballRadius/2;
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
      pubFlag = true;
    }
  }
}

void throwBall1p1(){
  noStroke();
  fill(255, 0, 0);
  ballX = width/2 + 58;
  ballY = 538;
  ellipse(ballX, ballY, ballRadius, ballRadius);
  delay++;
  fill(0);
}

void throwBall1p2(){
  noStroke();
  fill(255, 0, 0);
  ellipse(ballX, ballY, ballRadius, ballRadius);
  throwSpeedY -= gravity;
  ballY = ballY - throwSpeedY;
  if(ballY > 531 - ballRadius/2 & throwSpeedY < 0){
    ballY = 531 - ballRadius/2;
    actionC = true;
  }
}

void throwBall2p2(){
  noStroke();
  fill(255, 0, 0);
  ellipse(ballX, ballY, ballRadius, ballRadius);
  ballX += throwSpeedX;
  throwSpeedY -= gravity;
  ballY = ballY - throwSpeedY;
  checkCollisions();
  if(throwSpeedX < 0 & ballX < width/2 + 90 & countThrow2p2Passes == 0){
    countThrow2p2Passes = 1;
    actionC = true;
  }
  else if(throwSpeedX > 0 & ballX > 215 & gravity < 0 & countThrow2p2Passes == 1){
    countThrow2p2Passes = 2;
    actionC = true;
  }
}

void fallingBall(){
  noStroke();
  fill(255, 0, 0);
  ellipse(ballX, ballY, ballRadius, ballRadius);
  throwSpeedY -= gravity;
  ballY = ballY - throwSpeedY;
  ballX += throwSpeedX;
  checkCollisions();
}

void checkCollisions(){
  // Impact with ground
  if(ballY > gnd - ballRadius/2){
    ballY = gnd - ballRadius/2;
    throwSpeedY = -throwSpeedY;
    throwSpeedY *= damping;
    throwSpeedX *= friction;
  }
  
  // Impact with ceiling
  if(ballY < 10 + ballRadius/2){
    ballY = 10 + ballRadius/2;
    throwSpeedY = -throwSpeedY;
    throwSpeedY *= damping;
    throwSpeedX *= friction;
  }
  
  // Impact with right wall
  if(ballX > width - 10 - ballRadius/2){
    ballX = width - 10 - ballRadius/2;
    throwSpeedX = -throwSpeedX;
    if(countCollisionX == 0) countCollisionX = 1;
    else if(countCollisionX == 1) gravity = -gravity;
  }
  
  // Impact with left wall
  if(ballX < 10 + ballRadius/2){
    ballX = 10 + ballRadius/2;
    throwSpeedX = -throwSpeedX;
  }
  
  // Impact with stick man's head
  if(ballX == 215.39339 & ballY > 450){
    throwSpeedY = -throwSpeedY * 0.9;
    throwSpeedY *= damping;
    throwSpeedX = throwSpeedX - 1;
    actionC = true;
  }
}