/******************************************************************************************
 Title         : Pong Champions 
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/3/2017
 Assignment    : MSDS6390 - HW 4
 Resources     :  
 ******************************************************************************************/

// declare global variables

float paddleHeight      = 100;
float paddleWidth       = 20;
float paddleUpperY;            // to be used for ball "hit" upper Y boundary
float paddleLowerY;            // to be used for ball "hit" lower Y boundary
float leftPaddleBound;         // to be used for ball "hit" X boundary for left paddle 
float rightPaddleBound;        // to be used for ball "hit" X boundary for right paddle 
int round               = 0;
float ballRadius        = 15;
float ballLeftBound;
float ballRightBound;
float ballX;
float ballY;
float speedX           = 0;
float gravityY         = 0;
int ballcount          = 1;
float maxAbsSpeedX     = 45;    

void setup() {
  size(700, 600);


  paddleUpperY     = height/2 - paddleHeight/2;
  paddleLowerY     = height/2 + paddleHeight/2;
  leftPaddleBound  = paddleWidth*2;
  rightPaddleBound = width - (paddleWidth*2);

  ballX            = leftPaddleBound + 20;
  ballY            = height/2;
  ballLeftBound  = ballX - ballRadius;
  ballRightBound = ballX + ballRadius;

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

  paddle();
  ball();

  if (speedX         <  0
    & ballLeftBound  <= leftPaddleBound 
    & ballY          >= paddleUpperY
    & ballY          <= paddleLowerY) {

    if (speedX         >  -maxAbsSpeedX)  speedX*=-1.1;
    else speedX*=-1;
  } else if (speedX  >  0 
    & ballRightBound >= rightPaddleBound 
    & ballY          >= paddleUpperY
    & ballY          <= paddleLowerY) {

    if (speedX         <  maxAbsSpeedX)  speedX*=-1.1;
    else speedX*=-1;
  }

  println(speedX);
}


void mousePressed() {
  if (mousePressed == true & round == 0) {
    roundSelector(mouseX, mouseY);
  }
}