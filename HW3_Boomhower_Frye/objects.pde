// Object globals
int doorYcoord;
int doorXcoord;
int doorHeight;
int knobYcoord;
int doorAction = 0;


void openDoor(){
  strokeWeight(1);
  fill(139, 69, 19);
  rect(doorXcoord, doorYcoord, frameCount, doorHeight);
  fill(255, 255, 0);
  ellipse(doorXcoord + frameCount - 20 * doorAction/120, doorYcoord + doorHeight/2 + 30, 10, 10);
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
  ellipse(width/2 + 80, gnd - ballRadius/2, ballRadius, ballRadius);
}