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

void buildStars(float[] starX, float[] starY, float[] starRadius1, float[] starRadius2, int[] starNPoints) {
  pushMatrix();
  fill(255, 255, 255);
  noStroke();

  if (frameCount - fc >= 120) {

    if (scaleFactor <= 2) {
      scaleFactor += .01;
    }
    //println(scaleFactor);
    if (frameCount % 2 == 0 & starCount > 0) {
      fill(255, 255, 255, (frameCount % 200)/2);
      for (int i = 0; i < starCount; i++) {
        //println(i, starCount, starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]);
        star(starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]);
      }  
      starCount --;
    }


    for (int i = starX.length-1; i >= starCount; i--) {
      pushMatrix();

      translate(starX[i], starY[i]);
      scale(1 + scaleFactor);
      if (frameCount % 4 == 0) {
        rotate(PI/90 * int(random(-10, 5)));
      }
      star(0, 0, starRadius1[i], starRadius2[i], starNPoints[i]); 

      popMatrix();
    }
    //println(1+scaleFactor);
  }

  popMatrix();
}


void destroyStars(float[] starX, float[] starY, float[] starRadius1, float[] starRadius2, int[] starNPoints) {
  pushMatrix();
  fill(255, 255, 255);
  noStroke();

  if (frameCount - fc < 180) {

    if (scaleFactor <= 2) {
      scaleFactor += .02;
    }

    if (firstRun == 1) {
      starCount = 0;
    }
    //println(scaleFactor);

    for (int i = starX.length-1; i >= starCount; i--) {
      pushMatrix();
      //println(starCount);
      translate(starX[i], starY[i]);
      scale(3 - scaleFactor);
      if (frameCount % 7 == 0) {
        rotate(PI/90 * int(random(-10, 5)));
      }
      star(0, 0, starRadius1[i], starRadius2[i], starNPoints[i]); 

      popMatrix();
    }
    //println(starCount, 3-scaleFactor);
  }

  popMatrix();
}

void rotateSun() {
  pushMatrix();
  resetMatrix();
  translate(600, 800);

  pushMatrix();
  moonStop = 0;
  if (frameCount - fc <= 175) {
    rotate(MoonRotate/4);
    currentMoonRotate = MoonRotate/4;
  } else {
    moonStop = 1;
  }
  //printMatrix();
  moon();

  popMatrix();

  pushMatrix();
  if (dayChangeFlag == 1) {
    rotate(SunRotate/4);
    currentSunRotate = SunRotate/4;
  } else {
    rotate(currentSunRotate);
    sunStop = 1;
  }

  sun();
  popMatrix();
  popMatrix();
}


void rotateMoon() {
  pushMatrix();
  resetMatrix();
  translate(600, 800);

  pushMatrix();
  sunStop = 0;
  if (frameCount - fc <= 175) {
    rotate(SunRotate/4);
    currentSunRotate = SunRotate/4;
  } else {
    sunStop = 1;
  }

  sun();

  popMatrix();

  pushMatrix();
  if (dayChangeFlag == 1) {
    rotate(MoonRotate/4);
    currentMoonRotate = MoonRotate/4;
  } else {
    rotate(currentMoonRotate);
    moonStop = 1;
  }

  moon();
  popMatrix();

  popMatrix();
}