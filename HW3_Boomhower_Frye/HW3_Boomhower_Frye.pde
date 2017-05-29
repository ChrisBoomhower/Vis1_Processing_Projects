/******************************************************************************************
 Title         : Defying Gravity 
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 5/28/2017
 Assignment    : MSDS6390 - HW 3
 Resources     : https://processing.org/examples/star.html
                 
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
int framesPerTrans = 10;

color[] skyRed = new color[(skyRedTemplate.length - 1)* framesPerTrans];
color[] skyGreen = new color[(skyGreenTemplate.length - 1)* framesPerTrans];
color[] skyBlue  = new color[(skyBlueTemplate.length - 1)* framesPerTrans];

int dayChangeCounter = skyRed.length-1;

// Identify the full array of x,y,r1,r2,npoints for Stars functio
int starCount = 50;
float[] starX = new float[starCount];
float[] starY = new float[starCount];
float[] starRadius1 = new float[starCount];
float[] starRadius2 = new float[starCount];
int[] starNPoints = new int[starCount];

//setup function
void setup() {
  size(1200, 650);

  //default sky color to "Night"
  fill(skyRedTemplate[skyRedTemplate.length-1], skyGreenTemplate[skyGreenTemplate.length-1], skyBlueTemplate[skyBlueTemplate.length-1]);
  quad(50, 100, 1150, 100, 1150, 350, 50, 350);

  // Load Boogers for Picture Frame  
  img = loadImage("Boogers.jpg");

  //Identify the full array of colors, establishing "transition" colors for the number of framesPerTrans identified 
  color redCurrent = skyRedTemplate[0];
  color greenCurrent = skyGreenTemplate[0];
  color blueCurrent = skyBlueTemplate[0];

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

  // Identify the full array of x,y,r1,r2,npoints for Stars function
  for (int i = 0; i<starCount; i++) {
    starX[i] = random(50, 1150);
    starY[i] = random(100, 350);
    starRadius1[i] = random(3, 6);
    starRadius2[i] = starRadius1[i] * 2.6667;
    starNPoints[i] = int(random(4, 8));
  }
  pushMatrix();
  fill(255);
  noStroke();
  for (int i = 0; i < starX.length; i++){
    //println(i, starCount, starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]);
    star(starX[i], starY[i], starRadius1[i], starRadius2[i], starNPoints[i]); 
  }
  popMatrix();
}

//draw function
void draw() {
  buildSky(dayType, skyRedTemplate, skyGreenTemplate, skyBlueTemplate, skyRed, skyGreen, skyBlue);
  if (dayType == "Night"){
    buildStars(starX, starY, starRadius1, starRadius2, starNPoints);
  }
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
    if (keyCode == UP & dayType == "Night" & dayChangeFlag != 1) {
      dayType = "Day";
      dayChangeCounter = skyRed.length-1;
      dayChangeFlag = 1;
    } else if (keyCode == DOWN & dayType == "Day" & dayChangeFlag != 1) {
      dayType = "Night";
      dayChangeCounter = 0;
      starCount = 30;
      dayChangeFlag = 1;
    }
  } else if (key == ' ') {
    reset();
  }
}

void reset() {
  dayType = "Day";
  dayChangeFlag = 1;
  dayChangeCounter = skyRed.length-1;
  starCount = 30;
    //draw default stars
  pushMatrix();
  fill(255);
  noStroke();
  for (int i = 0; i < starX.length; i++){
    //println(i, starCount, starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]);
    star(starX[i], starY[i], starRadius1[i], starRadius2[i], starNPoints[i]); 
  }
  popMatrix();
}