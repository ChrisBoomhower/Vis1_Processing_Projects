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
int[] maxPaddle           = {10, 20, 30};
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
int paddleCount          = 0;
int paddleHitFlag        = 0;

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

  for (int i = 0; i<ballCount; i++) {
    ball(i);

    // Initialize ball gravityY
    if (paddleCount == 1 & gravityInit == 1) {
      if (i%2 == 0) gravityY[i] = 5;
      else gravityY[i] = -5;
      gravityInit = 0;
    }

    // change ball gravityY direction on wall bounc
    if (gravityY[i]       <  0
      & ballUpperBound[i]  <= 0) {

      gravityY[i]*=-1;
    } else if (gravityY[i] >  0
      & ballLowerBound[i]  >= height) {

      gravityY[i]*=-1;
    }

    // change ball speedX on successful paddle hit
    if (speedX[i]         <  0
      & ballLeftBound[i]  <= leftPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         >  -maxAbsSpeedX)  speedX[i]*=-1.1;
      else speedX[i]*=-1;

      paddleCount++;
      paddleHitFlag    = 1;
    } else if (speedX[i]  >  0 
      & ballRightBound[i] >= rightPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         <  maxAbsSpeedX)  speedX[i]*=-1.1;
      else speedX[i]*=-1;

      paddleCount++;
      paddleHitFlag    = 1;
    }

    if (paddleCount != 0 & paddleCount % 2 == 0 & paddleHitFlag    == 1) {
      ballCount++;
      ballRadius       = append(ballRadius, ballRadius[i]);
      ballLeftBound    = append(ballLeftBound, ballLeftBound[i]);
      ballRightBound   = append(ballRightBound, ballRightBound[i]);
      ballUpperBound   = append(ballUpperBound, ballUpperBound[i]);
      ballLowerBound   = append(ballLowerBound, ballLowerBound[i]);
      ballX            = append(ballX, ballX[i]);
      ballY            = append(ballY, ballY[i]);
      speedX           = append(speedX, 5);
      gravityY         = append(gravityY, -gravityY[i]);
      paddleHitFlag    = 0;
    }
  }

  for (int i = 0; i<ballCount; i++) {
    // remove ball on paddle miss
    if (speedX[i]          < 0
      & ballLeftBound[i]  <= leftPaddleBound 
      & (ballY[i]           < paddleUpperY | 
      ballY[i]           > paddleLowerY)
      ) {

      ballCount--;
      ballRadius       = pop(ballRadius, i);
      ballLeftBound    = pop(ballLeftBound, i);
      ballRightBound   = pop(ballRightBound, i);
      ballUpperBound    = pop(ballUpperBound, i);
      ballLowerBound   = pop(ballLowerBound, i);
      ballX            = pop(ballX, i);
      ballY            = pop(ballY, i);
      speedX           = pop(speedX, i);
      gravityY         = pop(gravityY, i);
    } else if (speedX[i]  >  0 
      & ballRightBound[i] >= rightPaddleBound 
      & (ballY[i]         <  paddleUpperY | 
      ballY[i]            >  paddleLowerY)
      ) {

      ballCount--;
      ballRadius       = pop(ballRadius, i);
      ballLeftBound    = pop(ballLeftBound, i);
      ballRightBound   = pop(ballRightBound, i);
      ballUpperBound   = pop(ballUpperBound, i);
      ballLowerBound   = pop(ballLowerBound, i);
      ballX            = pop(ballX, i);
      ballY            = pop(ballY, i);
      speedX           = pop(speedX, i);
      gravityY         = pop(gravityY, i);
    }
  }


  if (ballCount == 0) {
    println("Game Over!");
    displayPaddleCount();
    stop();
  } else if (paddleCount >= maxPaddle[round]){
    println("You Win!");
    displayPaddleCount();
    stop();
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