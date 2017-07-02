/****************************************************************************************** //<>// //<>// //<>// //<>//
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
import processing.sound.*;

SoundFile file;
//replace the sample.mp3 with your audio file name here
String audioName = "data/pong - atari style music for Atari 8-bit.mp3";
String path;

//int soundOn = 0;

// declare global variables
Paddle paddle;
Ball[] ball;
Ball newBall;
BallEmitter ballEmitter;
playGame playGame;
Menu menu;
Powerup powerup;
gameOver gameOver;
youWin youWin;
//Engine engine;
//Engine engine2;
Engine[] engines = new Engine[11];

//int roundTemp             = 0;
int round                 = 0;
int[] maxPaddle           = {30, 40, 50};
int gravityInit           = 1;
float origPaddleHeight    = 700;
float origPaddleWidth     = 20;

int ballCount            = 1;
float maxAbsSpeedX       = 45;

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

void setup() {
  size(700, 600);
  background = loadImage("data/background.png");

  // for more info about sketchPath, go to https://processing.org/discourse/beta/num_1229443269.html
  path = sketchPath(audioName);
  file = new SoundFile(this, path);

  playGame = new playGame();
  paddle = new Paddle(origPaddleHeight, origPaddleWidth);
  ballEmitter = new BallEmitter();
  menu = new Menu(0);
  gameOver = new gameOver();
  youWin = new youWin();


  fontGaming = loadFont("HarlowSolid-48.vlw");
  fontStart = loadFont("GoudyOldStyleT-Bold-48.vlw");


  flagGermany = loadImage("data/flag-of-Germany.png");
  flagJapan = loadImage("data/flag-of-Japan.png");
  flagChina = loadImage("data/flag-of-China.png");
  flagWidth = width/6;
  flagHeight = height/8.5;

  //Emitter(PVector loc, int particleCount, float particleBirthRate, PVector sprayVector, float sprayRadius,
  //boolean isInfinite, float particleScale, boolean colRand)
  Emitter[] emitters = new Emitter[11];
  emitters[0] = new Emitter(new PVector(0, height), 300, 1, new PVector(5, -15.2), 1.25, true, 5, true);
  emitters[1] = new Emitter(new PVector(width, height), 300, 1, new PVector(-5, -15.2), 1.25, true, 5, true);
  emitters[2] = new Emitter(new PVector(width/2, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[3] = new Emitter(new PVector(width/2 - width/8, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[4] = new Emitter(new PVector(width/4, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[5] = new Emitter(new PVector(width/8, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[6] = new Emitter(new PVector(0, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[7] = new Emitter(new PVector(width/2 + width/4, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[8] = new Emitter(new PVector(width/2 + width/8, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[9] = new Emitter(new PVector(width - width/8, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);
  emitters[10] = new Emitter(new PVector(width, 0), 5, 0.1, new PVector(0, 0), 0, true, 2, false);

  //Engine(Emitter emitter, float gravity, PVector turbulance, , PVector wind)
  for (int i=0; i<2; i++) engines[i] = new Engine(emitters[i], 1.15, new PVector(0.5, 0.5), new PVector(0.002, -0.7));
  for (int i=2; i<11; i++) engines[i] = new Engine(emitters[i], 1.15, new PVector(0.1, 0.1), new PVector(0.002, -0.7));

  //noLoop();
}

void draw() {

  if (round == 0) {
    menu.framework();
    menu.roundSelection();
  } else if (complete == false) {
    background(200);
    image(background, 0, height/3, width, height/3);
    paddle.displayPaddleCount();

    paddle.drawPaddle();

    playGame.playRound(round);

    for (int i = 0; i<ballCount; i++) {
      // remove ball on paddle miss
      if ((ball[i].getSpeedX()          < 0
        & ball[i].getBallLeftBound()  <= paddle.getLeftPaddleBound()
        & (ball[i].getBallY()          < paddle.getPaddleUpperY() | 
        ball[i].getBallY()             > paddle.getPaddleLowerY())
        ) |
        (ball[i].getSpeedX()  >  0 
        & ball[i].getBallRightBound() >= paddle.getRightPaddleBound() 
        & (ball[i].getBallY()         <  paddle.getPaddleUpperY() | 
        ball[i].getBallY()            >  paddle.getPaddleLowerY())
        )) {

        ball = ballEmitter.ballPop(i);
      }
    }
  }

  // Detect end of game
  if (round != 0) {
    if (ballCount == 0) {
      if (complete == false) fc = frameCount;
      gameOver.splashScreen();
      complete = true;
    } else if (arraySum(ball) >= maxPaddle[round-1]) {
      if (complete == false) fc = frameCount;
      //fireworks();
      fill(0, 100);
      noStroke();
      rect(-1, -1, width+1, height+1);
      stroke(0, 255, 0);
      for (int i=0; i<11; i++) engines[i].start();
      youWin.flashText();
      complete = true;
    }
  }
}


void mousePressed() {
  if (mousePressed == true & round == 0) {
    menu.interaction(mouseX, mouseY, menu.getRoundTemp());
  }
}



int arraySum(Ball[] array) {
  int sum = 0;
  for (int i =0; i<array.length; i++) {
    sum +=array[i].getPaddleCount();
  }
  return sum + retiredBallCount;
}