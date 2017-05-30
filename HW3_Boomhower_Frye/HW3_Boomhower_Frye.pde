/******************************************************************************************
 Title         : Defying Gravity 
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 5/28/2017
 Assignment    : MSDS6390 - HW 3
 Resources     : https://processing.org/examples/star.html
 https://forum.processing.org/two/discussion/12335/can-you-purely-draw-lunar-eclipse-by-arc-or-curve-function
 
 ******************************************************************************************/
//import libraries
import gifAnimation.*;
GifMaker gifExport;

// declare global variables
int x = 0;    // Used as width coordinates
int y = 0;    // Used as height coordinates
PImage img;
int gif = 0;

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
int starCount = 75;
float[] starX = new float[starCount];
float[] starY = new float[starCount];
float[] starRadius1 = new float[starCount];
float[] starRadius2 = new float[starCount];
int[] starNPoints = new int[starCount];
int fc = 0;
float scaleFactor = 0;

float SunRotate = 0;
float SunPivot  = 0;
float currentSunRotate = 0;
int sunStop = 0;

float MoonRotate = 0;
float currentMoonRotate = 0;
int moonStop = 1;

int nbSamples = 1200;
float [] [] ptsCircle = new float [nbSamples] [2];
float radius = 25.0, deltaX;
int idVertexStart, idVertexEnd, deltaIndex, idVertexStartInsideCrescent, idVertexEndInsideCrescent;

int firstRun = 1;

//setup function
void setup() {
  size(1200, 650);
  background(0);

  if (gif == 1) {
    gifExport = new GifMaker(this, "Defying Gravity.gif");
    gifExport.setRepeat(0); // make it an "endless" animation
    //gifExport.setTransparent(255); // make white the transparent color -- match browser bg color
    gifExport.setDelay(0);
  }
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
    starRadius1[i] = random(.5, 1.5);
    starRadius2[i] = starRadius1[i] * 2.6667;
    starNPoints[i] = int(random(4, 8));
  }


  for (int i = 0; i < starX.length; i++) {
    pushMatrix();
    fill(255);
    noStroke();

    translate(starX[i], starY[i]);
    scale(3);

    //println(i, starCount, starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]);
    star(0, 0, starRadius1[i], starRadius2[i], starNPoints[i]); 

    popMatrix();
  }

  // define moon circlePoints
  for (int i=0; i<nbSamples; i++) {
    ptsCircle[i][0] = radius * (cos(TWO_PI*(i/float(nbSamples))));
    ptsCircle[i][1] = radius * (sin(TWO_PI*(i/float(nbSamples))));
  }
  gnd = height-10;
  Stanley = new Stickman(35);
  
  doorYcoord = height - height/3;
  doorXcoord = 11;
  doorHeight = height/3 - 11;
  knobYcoord = (doorYcoord - doorHeight)/2;  
}

//draw function
void draw() {

  buildSky(dayType, skyRedTemplate, skyGreenTemplate, skyBlueTemplate, skyRed, skyGreen, skyBlue);

  if (dayType == "Night") {
    buildStars(starX, starY, starRadius1, starRadius2, starNPoints);
    rotateMoon();
  } else if (dayType == "Day" | fc == 0) {
    destroyStars(starX, starY, starRadius1, starRadius2, starNPoints);
    rotateSun();
  }


  if (frameCount % 4 == 0 & sunStop == 0) {
    SunRotate += PI/48;
  }
  if (frameCount % 4 == 0) {
    SunPivot += PI/48;
  }

  if (frameCount % 4 == 0 & moonStop == 0) {
    MoonRotate += PI/48;
    //println(MoonRotate);
  }

  buildRoom(0, 0);


  /* If you want to make him jump up and down, code such as the below, can make the room jiggle. 
   you can use framecount conditional logic for when the room shakes vs still.
   
   if (frameCount >=50 & frameCount < 60){
   buildRoom(int(random(-5,5)),int(random(-5,5)));
   }
   
   */
   
  skit();

  //Add a frame to the .GIF image. this MUST be the last thing inside the draw() function
  if (frameCount % 5 == 0 & gif == 1) {
    addGifFrame();
  }
}

//Check for Key Strokes, UP and DOWN
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP & dayType == "Night" & dayChangeFlag != 1) {
      resetMatrix();
      dayType = "Day";
      dayChangeCounter = skyRed.length-1;
      fc = frameCount;
      sunStop = 0;
      moonStop = 1;
      scaleFactor = 0;
      SunRotate = 0;
      SunPivot  = 0;
      currentSunRotate = 0;
      dayChangeFlag = 1;
    } else if (keyCode == DOWN & dayType == "Day" & dayChangeFlag != 1) {
      resetMatrix();
      dayType = "Night";
      dayChangeCounter = 0;
      starCount = 75;
      fc = frameCount;
      scaleFactor = 0;
      moonStop = 0;
      sunStop = 1;
      MoonRotate = 0;
      currentMoonRotate = 0;
      dayChangeFlag = 1;
    }
  } else if (key == ' ') {
    if (gif == 1) gifExport.finish(); 
    reset();
  }
}

void reset() {
  dayType = "Day";
  dayChangeFlag = 1;
  dayChangeCounter = skyRed.length-1;
  starCount = 75;
  firstRun = 1;
  SunRotate = 0;
  SunPivot  = 0;
  sunStop = 0;
  moonStop = 1;
  currentSunRotate = 0;
  resetMatrix();
  //draw default stars
  for (int i = 0; i < starX.length; i++) {
    pushMatrix();
    fill(255);
    noStroke();

    translate(starX[i], starY[i]);
    scale(3);

    //println(i, starCount, starX[starCount-1], starY[starCount-1], starRadius1[starCount-1], starRadius2[starCount-1], starNPoints[starCount-1]);
    star(0, 0, starRadius1[i], starRadius2[i], starNPoints[i]); 

    popMatrix();
  }
  fc = frameCount;
  scaleFactor = 0;
}

void addGifFrame() {
  gifExport.addFrame();
}