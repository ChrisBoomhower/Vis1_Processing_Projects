/******************************************************************************************
 Title         : Defying Gravity 
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 5/28/2017
 Assignment    : MSDS6390 - HW 3
 ******************************************************************************************/

// declare global variables
int x = 0;    // Used as width coordinates
int y = 0;    // Used as height coordinates
PImage img;

String dayType = "Day";
int dayChangeFlag = 1;
int[] skyRedTemplate = {102, 226, 231, 126, 41};
color[] skyGreenTemplate = {150, 227, 165, 75, 41};
color[] skyBlueTemplate  = {186, 139, 83, 104, 101};
int framesPerTrans = 5;

color[] skyRed = new color[(skyRedTemplate.length - 1)* framesPerTrans];
color[] skyGreen = new color[(skyGreenTemplate.length - 1)* framesPerTrans];
color[] skyBlue  = new color[(skyBlueTemplate.length - 1)* framesPerTrans];

color redCurrent = skyRedTemplate[0];
color greenCurrent = skyGreenTemplate[0];
color blueCurrent = skyBlueTemplate[0];

int dayChangeCounter = skyRed.length-1;


//setup function
void setup() {
  size(1200, 650);
  
      //default sky color to "Night"
  fill(skyRedTemplate[skyRedTemplate.length-1], skyGreenTemplate[skyGreenTemplate.length-1], skyBlueTemplate[skyBlueTemplate.length-1]);
  quad(50, 100, 1150, 100, 1150, 350, 50, 350);
  
  img = loadImage("Boogers.jpg");

  for (int i = 0; i<skyRedTemplate.length-1; i++) {
    color redDiff   = (skyRedTemplate[i+1]-skyRedTemplate[i]) / framesPerTrans;
    color greenDiff = (skyGreenTemplate[i+1]-skyGreenTemplate[i]) / framesPerTrans;
    color blueDiff  = (skyBlueTemplate[i+1]-skyBlueTemplate[i]) / framesPerTrans;

    for (int j = 0; j<framesPerTrans; j++) {
      redCurrent+=redDiff;
      greenCurrent+=greenDiff;
      blueCurrent+=blueDiff;
      
      //println(redCurrent, greenCurrent, blueCurrent);
      
      skyRed[(i*framesPerTrans)+j] = redCurrent;
      skyGreen[(i*framesPerTrans)+j] = greenCurrent;
      skyBlue[(i*framesPerTrans)+j] = blueCurrent;
    }
  }
}

    //draw function
void draw() {
  buildSky(dayType, skyRedTemplate, skyGreenTemplate, skyBlueTemplate, skyRed, skyGreen, skyBlue);

  buildRoom(0, 0);


  /* If you want to make him jump up and down, code such as the below, can make the room jiggle. 
   you can use framecount conditional logic for when the room shakes vs still.
   
   if (frameCount >=50 & frameCount < 60){
   buildRoom(int(random(-5,5)),int(random(-5,5)));
   }
   
   */
}

//Check for Key Strokes, UP and DOWN
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP & dayType == "Night") {
      dayType = "Day";
      dayChangeCounter = skyRed.length-1;
      dayChangeFlag = 1;
    } else if (keyCode == DOWN & dayType == "Day") {
      dayType = "Night";
      dayChangeCounter = 0;
      dayChangeFlag = 1;
    }
  }
}