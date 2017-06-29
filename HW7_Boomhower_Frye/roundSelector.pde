/******************************************************************************************
 Generates Round Selector. 
 Use Coordinates from Round Selectors for mouseClicks
 Add accent on flags when selected
 only clicking start will assign the round variable
 ******************************************************************************************/

void roundSelector(float x, float y) {


  //  rect(width-75, 100, 25, 25);//on
  //  rect(width-100, 100, 25, 25);//off


  if (  x > width-75 
    & x < width-50
    & y > 100
    & y < 125) {
    soundOn = 1;
    file.play();
  } else if (  x > width-100 
    & x < width-75
    & y > 100
    & y < 125) {
    soundOn = 0;
    file.stop();
  }
  // use x and y mouse coordinates to identify which round is clicked

  if (x > width/5 - flagWidth/2
    & x < width/5 + flagWidth/2
    & y > height - height/5 - flagHeight/2
    & y < height - height/5 + flagHeight/2) roundTemp = 1;

  else if (x > width/2 - flagWidth/2
    & x < width/2 + flagWidth/2
    & y > height - height/5 - flagHeight/2
    & y < height - height/5 + flagHeight/2) roundTemp = 2;

  else if (x > width - width/5 - flagWidth/2
    & x < width - width/5 + flagWidth/2
    & y > height - height/5 - flagHeight/2
    & y < height - height/5 + flagHeight/2) roundTemp = 3;

  else if (x > width/2 - flagWidth/2
    & x < width/2 + flagWidth/2
    & y > height/3 - flagHeight/2
    & y < height/3 + flagHeight/2) round = roundTemp;

  for (int i = 0; i<ballCount; i++) {
    ball[i].setSpeedX(5);
  }  
  loop();
}

void roundSelection() {
  pushMatrix();
  noFill();
  stroke(0, 255, 120);
  strokeWeight(4);
  if (roundTemp == 1) rect(width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  else if (roundTemp == 2) rect(width/2 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  else if (roundTemp == 3) rect(width - width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  popMatrix();
}