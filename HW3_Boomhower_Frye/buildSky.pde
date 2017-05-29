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
    if (dayType == "Day" & frameCount % 10 == 0) {
      //println(skyRed[dayChangeCounter], skyGreen[dayChangeCounter], skyBlue[dayChangeCounter]);
      fill(skyRed[dayChangeCounter], skyGreen[dayChangeCounter], skyBlue[dayChangeCounter]);
      quad(50, 100, 1150, 100, 1150, 350, 50, 350);

      dayChangeCounter --;

      if (dayChangeCounter == 0) {
        dayChangeFlag = 0;
      }
    } else if (dayType == "Night" & frameCount % 10 == 0) {
      fill(skyRed[dayChangeCounter], skyGreen[dayChangeCounter], skyBlue[dayChangeCounter]);
      quad(50, 100, 1150, 100, 1150, 350, 50, 350);

      dayChangeCounter ++;

      if (dayChangeCounter == skyRed.length-1) {
        dayChangeFlag = 0;
      }
    }
  }
}