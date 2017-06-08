import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class HW4_Boomhower_Frye extends PApplet {

/****************************************************************************************** //<>// //<>//
 Title         : Pong Champions 
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/3/2017
 Assignment    : MSDS6390 - HW 4
 Resources     :   https://www.processing.org/discourse/beta/num_1118112730.html
                   https://poanchen.github.io/blog/2016/11/15/how-to-add-background-music-in-processing-3.0
                   https://www.youtube.com/watch?v=2kP1bZfUNJE
                   https://www.countries-ofthe-world.com/flags-of-the-world.html
                   https://ping-pong.en.softonic.com/
                   http://www.absolud.com/foot/?page_id=73
 ******************************************************************************************/
//sound import


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

public void setup() {
  
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
  ballColor[0]      = 0xff000000;

  fontGaming = loadFont("HarlowSolid-48.vlw");
  fontStart = loadFont("GoudyOldStyleT-Bold-48.vlw");


  flagGermany = loadImage("data/flag-of-Germany.png");
  flagJapan = loadImage("data/flag-of-Japan.png");
  flagChina = loadImage("data/flag-of-China.png");
  flagWidth = width/6;
  flagHeight = height/8.5f;


  noLoop();
}

public void draw() {

  if (round == 0) {
    background(200);
    
    pushMatrix();

    fill(0);
    textFont(fontGaming);
    
    textAlign(CENTER, CENTER);
    text("Select Round:", width/2, height - height/2.8f);

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
  
}


public void mousePressed() {
  if (mousePressed == true & round == 0) {
    roundSelector(mouseX, mouseY);
  }
}

public float[] pop(float array[], int item) {
  float outgoing[] = new float[array.length - 1];
  System.arraycopy(array, 0, outgoing, 0, item);
  System.arraycopy(array, item+1, outgoing, item, array.length - (item + 1));
  return outgoing;
} 

public int[] pop(int array[], int item) {
  int outgoing[] = new int[array.length - 1];
  System.arraycopy(array, 0, outgoing, 0, item);
  System.arraycopy(array, item+1, outgoing, item, array.length - (item + 1));
  return outgoing;
} 

public int arraySum(int[] array) {
  int sum = 0;
  for (int i =0; i<array.length; i++) {
    sum +=array[i];
  }
  return sum + retiredBallCount;
}
/****************************************************************************************** //<>// //<>//
 Generates Ball, applying speed & gravity
 ******************************************************************************************/

public void ball(int ballNum) {

  ballX[ballNum] += speedX[ballNum];
  ballY[ballNum] += gravityY[ballNum];

  pushMatrix();

  if (round == 1) {
    if (paddleCount[ballNum] % 3 == 1) fill(0xffffda00 );
    else if (paddleCount[ballNum] % 3 == 2) fill(0xffe70000 );
    else if (paddleCount[ballNum] % 3 == 0 & ballCount != 0) fill(0xff000000 );
  } else if (round == 2) {
    if (paddleCount[ballNum] % 2 == 1) fill(255);
    else if (paddleCount[ballNum] % 2 == 0 & ballCount != 0) fill(255, 0, 0);
  } else if (round == 3) {
    if (paddleCount[ballNum] % 2 == 1) fill(255,215,0);
    else if (paddleCount[ballNum] % 2 == 0 & ballCount != 0) fill(255, 0, 0);
  }

  translate(ballX[ballNum], ballY[ballNum]);

  //println(ballNum, ballLeftBound.length, ballLeftBound[ballNum], ballRightBound[ballNum], ballUpperBound[ballNum], ballLowerBound[ballNum]);

  ballLeftBound[ballNum]  = ballX[ballNum] - ballRadius[ballNum];
  ballRightBound[ballNum] = ballX[ballNum] + ballRadius[ballNum];
  ballUpperBound[ballNum] = ballY[ballNum] - ballRadius[ballNum];
  ballLowerBound[ballNum] = ballY[ballNum] + ballRadius[ballNum];

  ellipse(0, 0, ballRadius[ballNum]*2, ballRadius[ballNum]*2);
  popMatrix();
}

public void ballSplit(int ballNum) {
  int[] ballAddition = {1,2,4};
  
    // this is the ball size shrinking statement
  if (round == 1) ballRadius[ballNum] *=.5f;
  else if (round == 2) ballRadius[ballNum] /=2.25f;
  else if (round == 3) ballRadius[ballNum] /=3.0517578125f;

  for (int i = 0; i<ballAddition[round-1];i++){
    ballCount++;
    ballRadius       = append(ballRadius, ballRadius[ballNum]);
    ballLeftBound    = append(ballLeftBound, ballLeftBound[ballNum]);
    ballRightBound   = append(ballRightBound, ballRightBound[ballNum]);
    ballUpperBound   = append(ballUpperBound, ballUpperBound[ballNum]);
    ballLowerBound   = append(ballLowerBound, ballLowerBound[ballNum]);
    ballX            = append(ballX, ballX[ballNum]);
    ballY            = append(ballY, ballY[ballNum]);
    speedX           = append(speedX, PApplet.parseInt(random(2,7)));
    
    if (round == 1)    gravityY = append(gravityY, -gravityY[ballNum]);
    else gravityY = append(gravityY, PApplet.parseInt(random(-12, 12)));
    
    paddleCount      = append(paddleCount, 0);
  }

  paddleHitFlag    = 0;
}

public void ballPop(int ballNum) {
  ballCount--;

  retiredBallCount += paddleCount[ballNum] - 1;

  ballRadius       = pop(ballRadius, ballNum);
  ballLeftBound    = pop(ballLeftBound, ballNum);
  ballRightBound   = pop(ballRightBound, ballNum);
  ballUpperBound   = pop(ballUpperBound, ballNum);
  ballLowerBound   = pop(ballLowerBound, ballNum);
  ballX            = pop(ballX, ballNum);
  ballY            = pop(ballY, ballNum);
  speedX           = pop(speedX, ballNum);
  gravityY         = pop(gravityY, ballNum);
  paddleCount      = pop(paddleCount, ballNum);
}

public void ballGrow(int ballNum) {
  if (round == 1) ballRadius[ballNum]*=2;
  else if (round == 2) ballRadius[ballNum]*=1.5f;
  else if (round == 3) ballRadius[ballNum]*=1.25f;
  paddleHitFlag = 0;
}
int particleCount = 100;

float[] x = new float[particleCount];
float[] y = new float[particleCount];
float[] fSpeedX = new float[particleCount];
float[] fSpeedY = new float[particleCount];
float[] gravity = new float[particleCount];

float[] x2 = new float[particleCount];
float[] y2 = new float[particleCount];
float[] fSpeedX2 = new float[particleCount];
float[] fSpeedY2 = new float[particleCount];
float[] gravity2 = new float[particleCount];

public void fireworks() {
  //float[] burstX = new float[5];
  //float[] burstY = new float[5];
  fill(0, 20);
  noStroke();
  rect(-1, -1, width+1, height+1);
  stroke(0, 255, 0);

  if (frameCount % PApplet.parseInt(random(125,175)) == 0) {
    float xRand = random(-200, 200);
    float yRand = random(-200, 200);
    for (int i = 0; i < particleCount; i++) {
      x[i] = width/2 + xRand;
      y[i] = height/3 + yRand;
      fSpeedX[i] = random(-1.2f, 1.2f);
      fSpeedY[i] = random(-4, -2);
      gravity[i] = 0.07f;
    }
  }

  if (frameCount % PApplet.parseInt(random(125,175)) == 0) {
    float xRand = random(-200, 200);
    float yRand = random(-200, 200);
    for (int i = 0; i < particleCount; i++) {
      x2[i] = width/2 + xRand;
      y2[i] = height/3 + yRand;
      fSpeedX2[i] = random(-1.2f, 1.2f);
      fSpeedY2[i] = random(-4, -2);
      gravity2[i] = 0.07f;
    }
  }

  burst(x, y, fSpeedX, fSpeedY, gravity);
  burst(x2, y2, fSpeedX2, fSpeedY2, gravity2);
  
  if (frameCount % 60 == 0) showText = !showText;
  
  if (showText == true)fill(255);
  else fill(0);
  textFont(fontGaming);
  textAlign(CENTER, CENTER);
  text("You Win!", width/2, height/2);
  
  if(frameCount - fc > 3600) file.stop();
  
}
public void burst(float[] x, float[] y, float[] fSpeedX, float[] fSpeedY, float[] gravity) {
  strokeWeight(1);
  for (int i = 0; i < particleCount; i++) {
    stroke(PApplet.parseInt(random(0, 255)), PApplet.parseInt(random(0, 255)), PApplet.parseInt(random(0, 255)));
    rect(x[i], y[i], 1, 1);
    x[i] += fSpeedX[i];
    fSpeedY[i] += gravity[i];
    y[i] += fSpeedY[i];
  }
}

public void gameOver(){
  fill(0);
  noStroke();
  rect(-1, -1, width+1, height+1);
  
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  if ((frameCount - fc)/3 < 120){
    if ((frameCount - fc)/3 < 1) textFont(fontGaming, 1);
    else textFont(fontGaming, (frameCount - fc)/3);
  }
  else{
    textFont(fontGaming, 120);
  }
  
  if(frameCount - fc > 3600) file.stop();
    
  text("Game Over!", width/2, height/2);
  //else if (complete == true) textFont(fontGaming, 120);
  
}

/******************************************************************************************
 Generates both Left and Right Paddles
 ******************************************************************************************/


public void paddle() {
  pushMatrix();
  //Default to Center Y, else use mouseY position
  fill(100);
  if (frameCount == 1) translate(0, height/2 - paddleHeight/2);
  else {
    translate(0, mouseY - paddleHeight/2);
    paddleUpperY     = mouseY - paddleHeight/2;
    paddleLowerY     = mouseY + paddleHeight/2;
  }
  //Left Paddle
  rect(paddleWidth, 0, paddleWidth, paddleHeight);

  //Right Paddle
  rect(width - paddleWidth*2, 0, paddleWidth, paddleHeight);
  popMatrix();
}

public void displayPaddleCount() {
  pushMatrix();
  fill(200);
  noStroke();
  rect(335, 15, 60, 60);
  popMatrix();
  
  pushMatrix();
  fill(0);
  textSize(32);
  textAlign(BASELINE);
  text(arraySum(paddleCount), 350, 50);
  popMatrix();
}
/******************************************************************************************
 Round 1 Custom Ball Movement
 ******************************************************************************************/

public void round1() {
  for (int i = 0; i<ballCount; i++) {
    ball(i);

    // Initialize ball gravityY
    if (paddleCount[i] == 1 & gravityInit == 1) {
      if (i%2 == 0) gravityY[i] = 5;
      else gravityY[i] = -5;
      gravityInit = 0;
    }

    // change ball gravityY direction on wall bounce
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

      if (speedX[i]         >  -maxAbsSpeedX)  speedX[i]*=-1.1f;
      else speedX[i]*=-1;

      paddleCount[i]++;
      paddleHitFlag    = 1;
    } else if (speedX[i]  >  0 
      & ballRightBound[i] >= rightPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         <  maxAbsSpeedX)  speedX[i]*=-1.1f;
      else speedX[i]*=-1;

      paddleCount[i]++;
      paddleHitFlag    = 1;
    }

    if (paddleCount[i] != 0 & paddleCount[i] % 2 == 0 & paddleHitFlag    == 1)      ballSplit(i);
    else if (paddleCount[i] != 0 & paddleCount[i] % 2 == 1 & paddleHitFlag    == 1) ballGrow(i);
  }
}
/******************************************************************************************
Round 2 Custom Ball Movement
******************************************************************************************/

public void round2() {
  for (int i = 0; i<ballCount; i++) {
    ball(i);

    // Initialize ball gravityY
    if (paddleCount[i] == 1 & gravityInit == 1) {
      if (i%2 == 0) gravityY[i] = random(2, 15);
      else gravityY[i] = random(-2, -15);
      gravityInit = 0;
    }

    // change ball gravityY direction on wall bounce
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

      if (speedX[i]         >  -maxAbsSpeedX)  speedX[i]*=-1.1f;
      else speedX[i]*=-1;
      
      if(gravityY[i]<0) gravityY[i] = random(2, 12);
      else gravityY[i] = random(-2, -12);

      paddleCount[i]++;
      paddleHitFlag    = 1;
    } else if (speedX[i]  >  0 
      & ballRightBound[i] >= rightPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         <  maxAbsSpeedX)  speedX[i]*=random(-1.1f,-2);
      else speedX[i]*=-1;

      paddleCount[i]++;
      paddleHitFlag    = 1;
    }

    if (paddleCount[i] != 0 & paddleCount[i] % 3 == 0 & paddleHitFlag    == 1)      ballSplit(i);
    else if (paddleCount[i] != 0 & (paddleCount[i] % 3 ==1 |paddleCount[i] % 3 ==2) & paddleHitFlag    == 1) ballGrow(i);
  }
}
/******************************************************************************************
Round 3 Custom Ball Movement
******************************************************************************************/

public void round3() {
  for (int i = 0; i<ballCount; i++) {
    ball(i);

    // Initialize ball gravityY
    if (paddleCount[i] == 1 & gravityInit == 1) {
      if (i%2 == 0) gravityY[i] = random(2, 15);
      else gravityY[i] = random(-2, -15);
      gravityInit = 0;
    }

    // change ball gravityY direction on wall bounce
    if (gravityY[i]       <  0
      & ballUpperBound[i]  <= 0) {

      gravityY[i]*=random(-1, -2);
    } else if (gravityY[i] >  0
      & ballLowerBound[i]  >= height) {

      gravityY[i]*=random(-1, -2);
    }

    // change ball speedX on successful paddle hit
    if (speedX[i]         <  0
      & ballLeftBound[i]  <= leftPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         >  -maxAbsSpeedX)  speedX[i]*=-1.1f;
      else speedX[i]*=-1;
      
      if(gravityY[i]<0) gravityY[i] = random(2, 12);
      else gravityY[i] = random(-2, -12);

      paddleCount[i]++;
      paddleHitFlag    = 1;
    } else if (speedX[i]  >  0 
      & ballRightBound[i] >= rightPaddleBound 
      & ballY[i]          >= paddleUpperY
      & ballY[i]          <= paddleLowerY) {

      if (speedX[i]         <  maxAbsSpeedX)  speedX[i]*=random(-1.1f,-2);
      else speedX[i]*=-1;

      paddleCount[i]++;
      paddleHitFlag    = 1;
    }

    if (paddleCount[i] != 0 & paddleCount[i] % 5 == 0 & paddleHitFlag    == 1)      ballSplit(i);
    else if (paddleCount[i] != 0 & (paddleCount[i] % 5 ==1 | paddleCount[i] % 5 ==2 | paddleCount[i] % 5 ==3 | paddleCount[i] % 5 ==4) & paddleHitFlag    == 1) ballGrow(i);
  }
}
/******************************************************************************************
 Generates Round Selector. 
 Use Coordinates from Round Selectors for mouseClicks
 Add accent on flags when selected
 only clicking start will assign the round variable
 ******************************************************************************************/

public void roundSelector(float x, float y) {


  //  rect(width-75, 100, 25, 25);//on
  //  rect(width-100, 100, 25, 25);//off


  if (  x > width-75 
    & x < width-50
    & y > 100
    & y < 125) {
    soundOn = 1;
    file.play();
  } else if (  x > width-100 
    & x < width-75
    & y > 100
    & y < 125) {
    soundOn = 0;
    file.stop();
  }
  // use x and y mouse coordinates to identify which round is clicked

  if (x > width/5 - flagWidth/2
    & x < width/5 + flagWidth/2
    & y > height - height/5 - flagHeight/2
    & y < height - height/5 + flagHeight/2) roundTemp = 1;

  else if (x > width/2 - flagWidth/2
    & x < width/2 + flagWidth/2
    & y > height - height/5 - flagHeight/2
    & y < height - height/5 + flagHeight/2) roundTemp = 2;

  else if (x > width - width/5 - flagWidth/2
    & x < width - width/5 + flagWidth/2
    & y > height - height/5 - flagHeight/2
    & y < height - height/5 + flagHeight/2) roundTemp = 3;

  else if (x > width/2 - flagWidth/2
    & x < width/2 + flagWidth/2
    & y > height/3 - flagHeight/2
    & y < height/3 + flagHeight/2) round = roundTemp;

  for (int i = 0; i<ballCount; i++) {
    speedX[i] = 5;
  }  
  loop();
}

public void roundSelection() {
  pushMatrix();
  noFill();
  stroke(0, 255, 120);
  strokeWeight(4);
  if (roundTemp == 1) rect(width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  else if (roundTemp == 2) rect(width/2 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  else if (roundTemp == 3) rect(width - width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
  popMatrix();
}
  public void settings() {  size(700, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "HW4_Boomhower_Frye" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
