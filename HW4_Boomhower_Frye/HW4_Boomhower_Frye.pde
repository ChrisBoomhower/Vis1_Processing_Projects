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

int round                 = 0;
int[] maxPaddle           = {30, 40, 50};
int gravityInit           = 1;

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

int splitNum             = 2;
int[] paddleCount        = {0};
int paddleHitFlag        = 0;

int retiredBallCount     = 0;

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

  /*
    Code to go here for:
   Start Selector Rectangles (make the country flag the rectangle) 
   with "Start at Round" with the number in it via text. 
   and then a larger rectangle which says START at the bottom
   */


  noLoop();
}

void draw() {
  background(200);

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