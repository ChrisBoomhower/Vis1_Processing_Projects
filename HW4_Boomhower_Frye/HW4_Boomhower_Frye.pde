/****************************************************************************************** //<>//
 Title         : Pong Champions 
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/3/2017
 Assignment    : MSDS6390 - HW 4
 Resources     :  https://www.processing.org/discourse/beta/num_1118112730.html
 https://poanchen.github.io/blog/2016/11/15/how-to-add-background-music-in-processing-3.0
 https://www.youtube.com/watch?v=2kP1bZfUNJE
 https://www.countries-ofthe-world.com/flags-of-the-world.html
 https://ping-pong.en.softonic.com/
 ******************************************************************************************/
//sound import
import processing.sound.*;

SoundFile file;
//replace the sample.mp3 with your audio file name here
String audioName = "pong - atari style music for Atari 8-bit.mp3";
String path;

int soundOn = 0;

// declare global variables

float paddleHeight      = 100;
float paddleWidth       = 20;
float paddleUpperY;            // to be used for ball "hit" upper Y boundary
float paddleLowerY;            // to be used for ball "hit" lower Y boundary
float leftPaddleBound;         // to be used for ball "hit" X boundary for left paddle 
float rightPaddleBound;        // to be used for ball "hit" X boundary for right paddle 

int roundTemp             = 0;
int round                 = 0;
int[] maxPaddle           = {30, 40, 50};
int gravityInit           = 1;

float[] ballColor        = new float[1];
float[] ballRadius       = {15};
float[] ballLeftBound    = new float[1];
float[] ballRightBound   = new float[1];
float[] ballUpperBound   = new float[1];
float[] ballLowerBound   = new float[1];
float[] ballX            = new float[1];
float[] ballY            = new float[1];
float[] speedX           = {0};
float[] gravityY         = {0};
int ballCount            = 1;
float maxAbsSpeedX       = 45;

int[] paddleCount        = {0};
int paddleHitFlag        = 0;

int retiredBallCount     = 0;
int[] splitCount         = {0};

PImage background;
PImage flagGermany;
PImage flagJapan;
PImage flagChina;
float flagWidth;
float flagHeight;

PFont fontGaming;
PFont fontStart;

int fc;
boolean showText = true;

boolean complete = false;

void setup() {
  size(700, 600);
  background = loadImage("data/background.png");
  
  // for more info about sketchPath, go to https://processing.org/discourse/beta/num_1229443269.html
  path = sketchPath(audioName);
  file = new SoundFile(this, path);


  paddleUpperY     = height/2 - paddleHeight/2;
  paddleLowerY     = height/2 + paddleHeight/2;
  leftPaddleBound  = paddleWidth*2;
  rightPaddleBound = width - (paddleWidth*2);

  ballX[0]          = leftPaddleBound + 20;
  ballY[0]          = height/2;
  ballLeftBound[0]  = ballX[0] - ballRadius[0];
  ballRightBound[0] = ballX[0] + ballRadius[0];
  ballUpperBound[0] = ballY[0] - ballRadius[0];
  ballLowerBound[0] = ballY[0] + ballRadius[0];
  ballColor[0]      = #000000;

  fontGaming = loadFont("HarlowSolid-48.vlw");
  fontStart = loadFont("GoudyOldStyleT-Bold-48.vlw");
  /*
    Code to go here for:
   Start Selector Rectangles (make the country flag the rectangle) 
   with "Start at Round" with the number in it via text. 
   and then a larger rectangle which says START at the bottom
   */

  flagGermany = loadImage("data/flag-of-Germany.png");
  flagJapan = loadImage("data/flag-of-Japan.png");
  flagChina = loadImage("data/flag-of-China.png");
  flagWidth = width/6;
  flagHeight = height/8.5;

  //pushMatrix();
  //noStroke();
  //image(flagJapan, width/2 - flagWidth/2, height/2 - flagHeight/2, flagWidth, flagHeight);
  //popMatrix();

  noLoop();
}

void draw() {

  if (round == 0) {
    background(200);
    
    pushMatrix();

    fill(0);
    textFont(fontGaming);
    //textSize(32);
    textAlign(CENTER, CENTER);
    text("Select Round:", width/2, height - height/2.8);

    noStroke();
    image(flagGermany, width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
    image(flagJapan, width/2 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
    image(flagChina, width - width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);

    textSize(30);
    textAlign(CENTER, BOTTOM);
    text("Round 1", width/5 - flagWidth/2, height - height/5, flagWidth, flagHeight);
    text("Round 2", width/2 - flagWidth/2, height - height/5, flagWidth, flagHeight);
    text("Round 3", width - width/5 - flagWidth/2, height - height/5, flagWidth, flagHeight);

    roundSelection();

    // Sound Switch
    pushMatrix();
    noFill();
    stroke(0);
    textFont(fontGaming);
    textSize(25);
    text("Sound", width-100, 100);
    rect(width-100, 100, 50, 25);
    popMatrix();

    pushMatrix();
    if (soundOn == 1) {
      fill(0, 255, 0);
      rect(width-75, 100, 25, 25);
    } else {
      fill(255, 0, 0);
      rect(width-100, 100, 25, 25);
    }
    popMatrix();

    if (roundTemp != 0) {
      pushMatrix();
      stroke(0);
      fill(0, 255, 120);
      rect(width/2 - flagWidth/2, height/3 - flagHeight/2, flagWidth, flagHeight);
      fill(0);
      textFont(fontStart, 30);
      textAlign(CENTER, CENTER);
      text("START", width/2 - flagWidth/2, height/3 - flagHeight/2, flagWidth, flagHeight);
      textAlign(BASELINE);
      textFont(fontGaming);
      popMatrix();  
    }

    popMatrix();
  }

  else if(complete == false){
    background(200);
    image(background, 0, height/3, width, height/3);
    displayPaddleCount();
  
    paddle();
  
    if (round == 1)  round1();
    else if (round == 2) round2();
    else if (round == 3) round3();
  
  
    for (int i = 0; i<ballCount; i++) {
      // remove ball on paddle miss
      if ((speedX[i]          < 0
        & ballLeftBound[i]  <= leftPaddleBound 
        & (ballY[i]          < paddleUpperY | 
        ballY[i]             > paddleLowerY)
        ) |
        (speedX[i]  >  0 
        & ballRightBound[i] >= rightPaddleBound 
        & (ballY[i]         <  paddleUpperY | 
        ballY[i]            >  paddleLowerY)
        )) {
  
        ballPop(i);
      }
    }
  }

  // Detect end of game
  if (round != 0) {
    if (ballCount == 0) {
      if (complete == false) fc = frameCount;
      gameOver();
      complete = true;
    } else if (arraySum(paddleCount) >= maxPaddle[round-1]) {
      if (complete == false) fc = frameCount;
      fireworks();
      complete = true;
    }
  }
  //println(ballCount);
}


void mousePressed() {
  if (mousePressed == true & round == 0) {
    roundSelector(mouseX, mouseY);
  }
}

float[] pop(float array[], int item) {
  float outgoing[] = new float[array.length - 1];
  System.arraycopy(array, 0, outgoing, 0, item);
  System.arraycopy(array, item+1, outgoing, item, array.length - (item + 1));
  return outgoing;
} 

int[] pop(int array[], int item) {
  int outgoing[] = new int[array.length - 1];
  System.arraycopy(array, 0, outgoing, 0, item);
  System.arraycopy(array, item+1, outgoing, item, array.length - (item + 1));
  return outgoing;
} 

int arraySum(int[] array) {
  int sum = 0;
  for (int i =0; i<array.length; i++) {
    sum +=array[i];
  }
  return sum + retiredBallCount;
}