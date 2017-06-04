/******************************************************************************************
Generates Round Selector. 
Use Coordinates from Round Selectors for mouseClicks
Add accent on flags when selected
only clicking start will assign the round variable
******************************************************************************************/

void roundSelector(float x, float y){
  
  // use x and y mouse coordinates to identify which round is clicked
  
  if (x > width/5 - flagWidth/2
      & x < width/5 + flagWidth/2
      & y > height - height/5 - flagHeight/2
      & y < height - height/5 + flagHeight/2) roundTemp = 1;
      
  else if(x > width/2 - flagWidth/2
          & x < width/2 + flagWidth/2
          & y > height - height/5 - flagHeight/2
          & y < height - height/5 + flagHeight/2) roundTemp = 2;
          
  else if(x > width - width/5 - flagWidth/2
          & x < width - width/5 + flagWidth/2
          & y > height - height/5 - flagHeight/2
          & y < height - height/5 + flagHeight/2) roundTemp = 3;
          
  else if(x > width/2 - flagWidth/2
          & x < width/2 + flagWidth/2
          & y > height/3 - flagHeight/2
          & y < height/3 + flagHeight/2) round = roundTemp;
  
  //roundTemp = 1; // roundTemp will be assigned as staging selection until the start button is clicked
  //round = roundTemp; // once start button is clicked, this may occur
  
  for(int i = 0; i<ballCount; i++){
  speedX[i] = 5;
  }  
  loop();
  
}

void roundSelection(){
  noFill();
  stroke(0, 255, 120);
  strokeWeight(4);
  if (roundTemp == 1) rect(width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  else if (roundTemp == 2) rect(width/2 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  else if (roundTemp == 3) rect(width - width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
}