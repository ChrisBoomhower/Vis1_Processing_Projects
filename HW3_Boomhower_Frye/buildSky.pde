/******************************************************************************************
Function utilized in order to create the sky background inside the windows. 
Facilitates the transition between "Day" and "Night"
******************************************************************************************/

void buildSky(String dayType, color[] skyRedTemplate, color[] skyGreenTemplate, color[] skyBlueTemplate, 
  color[] skyRed, color[] skyGreen, color[] skyBlue) {
  if (dayChangeFlag == 0 & dayType == "Day") {
    fill(skyRedTemplate[0], skyGreenTemplate[0], skyBlueTemplate[0]);
    quad(50, 100, 1150, 100, 1150, 350, 50, 350);
  } else if (dayChangeFlag == 0 & dayType == "Night") {
    fill(skyRedTemplate[skyRedTemplate.length-1], skyGreenTemplate[skyGreenTemplate.length-1], skyBlueTemplate[skyBlueTemplate.length-1]);
    quad(50, 100, 1150, 100, 1150, 350, 50, 350);
  } else {
    if (dayType == "Day" & frameCount % 7 == 0) {
      //println(skyRed[dayChangeCounter], skyGreen[dayChangeCounter], skyBlue[dayChangeCounter]);
      fill(skyRed[dayChangeCounter], skyGreen[dayChangeCounter], skyBlue[dayChangeCounter]);
      quad(50, 100, 1150, 100, 1150, 350, 50, 350);

      dayChangeCounter --;

      if (dayChangeCounter == 0) {
        dayChangeFlag = 0;
      }
    } else if (dayType == "Night" & frameCount % 7 == 0) {
      fill(skyRed[dayChangeCounter], skyGreen[dayChangeCounter], skyBlue[dayChangeCounter]);
      quad(50, 100, 1150, 100, 1150, 350, 50, 350);
      


      dayChangeCounter ++;

      if (dayChangeCounter == skyRed.length-1) {
        dayChangeFlag = 0;
      }
    }
  }
}

void buildStars(float[] starX, float[] starY, float[] starRadius1, float[] starRadius2, int[] starNPoints){
  pushMatrix();
  fill(255);
  noStroke();
  
  
  if (frameCount % 5 == 0 & starCount > 0){
    for (int i = 0; i < starCount; i++){
      //println(i, starCount, starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]);
      star(starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]); 
    }  
    starCount --; 
  }
  
  for (int i = starX.length-1; i >= starCount; i--){
    pushMatrix();
    
    translate(starX[i], starY[i]);
    if (frameCount % 3 == 0){
      rotate(PI/90 * int(random(-5,5)));
    }
    star(0,0, starRadius1[i], starRadius2[i], starNPoints[i]); 
    
    popMatrix();
  }
  
  popMatrix();
  
}