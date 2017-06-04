/******************************************************************************************
 Title         : Pong Champions 
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/3/2017
 Assignment    : MSDS6390 - HW 4
 Resources     :  https://www.processing.org/discourse/beta/num_1118112730.html
 ******************************************************************************************/

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

PImage flagGermany;
PImage flagJapan;
PImage flagChina;
float flagWidth;
float flagHeight;

PFont fontGaming;
PFont fontStart;

void setup() {
  size(700, 600);


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
  background(200);
  
  if (round == 0){
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
    text("Round 2", width - width/5 - flagWidth/2, height - height/5, flagWidth, flagHeight);
    
    roundSelection();
    
    if (roundTemp != 0){
      stroke(0);
      fill(0, 255, 120);
      rect(width/2 - flagWidth/2, height/3 - flagHeight/2, flagWidth, flagHeight);
      fill(0);
      textFont(fontStart, 30);
      textAlign(CENTER, CENTER);
      text("START", width/2 - flagWidth/2, height/3 - flagHeight/2, flagWidth, flagHeight);
    }
    
    popMatrix();
  }

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

  if (round != 0) {
    if (ballCount == 0) {
      println("Game Over!");
      displayPaddleCount();
      stop();
    } else if (arraySum(paddleCount) >= maxPaddle[round-1]) {
      println("You Win!");
      displayPaddleCount();
      stop();
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