/****************************************************************************************** //<>// //<>//
 Title         : PartyTime
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/16/2017
 Assignment    : MSDS6390 - HW 5
 Instructions  : '+' key increases oscilloscope gain
                 '-' key decreases oscilloscope gain
                 '1' key mutes audio
                 '2' key unmutes audio
                 LeftMouseClick toggles pause/unpause
                 RightMouseClick toggles song Title, Author, and Album details
                 
 Resources     : https://vimeo.com/7586074
 https://github.com/ddf/Minim/tree/master/examples/Analysis/SoundSpectrum
 https://www.ee.columbia.edu/~dpwe/resources/Processing/
 https://www.openprocessing.org/sketch/214311
 
 GIF Images:
 https://slack-imgs.com/?c=1&url=http%3A%2F%2Fpa1.narvii.com%2F6204%2F1ba8c1443bcdaf1a0e809b22936163a12f5737c2_hq.gif
 https://slack-imgs.com/?c=1&url=https%3A%2F%2Fmedia.giphy.com%2Fmedia%2Fl41lS0IgRIFkAuA5G%2Fgiphy.gif
 https://slack-imgs.com/?c=1&url=http%3A%2F%2Fmedia0.giphy.com%2Fmedia%2Fl0HlHgiDgsW2c32p2%2Fgiphy.gif
 https://slack-imgs.com/?c=1&url=http%3A%2F%2Fmedia2.giphy.com%2Fmedia%2FYPNSva1pEGFFu%2Fgiphy.gif
 https://slack-imgs.com/?c=1&url=http%3A%2F%2Fmedia4.giphy.com%2Fmedia%2FKkF4Ts9p08J1K%2Fgiphy.gif
 https://slack-imgs.com/?c=1&url=http%3A%2F%2Fmedia2.giphy.com%2Fmedia%2F3oKIPyn8SKfUVOzEsM%2Fgiphy.gif
 https://slack-imgs.com/?c=1&url=http%3A%2F%2Fmedia4.giphy.com%2Fmedia%2Fl2JJMi4asqpvhXLQk%2Fgiphy.gif
 http://www.gifbin.com/bin/20052777.gif
 http://www.animatedimages.org/data/media/218/animated-penguin-image-0164.gif
 ******************************************************************************************/

import ddf.minim.analysis.*;
import ddf.minim.*;
import gifAnimation.*;

Minim minim;  
AudioPlayer soundFile;
AudioMetaData meta;
FFT fft;

Gif panda;
Gif cactus;
Gif dancer;
Gif fox;
Gif Peng;
Gif jumper;

int pause = 0;
int amptest = 0;


ArrayList <PVector> points1 = new ArrayList <PVector> ();
ArrayList <PVector> points2 = new ArrayList <PVector> ();
ArrayList <PVector> points3 = new ArrayList <PVector> ();
ArrayList <PVector> points4 = new ArrayList <PVector> ();
float gain = 200;
int tbase = 1024;
float[] myBuffer;
float maxdx = 0;
float amplitude = 0;
int[] transparency = new int[6];
int fc = 0;
int[] colRect = new int[45];
boolean metaDetails = false;


void setup()
{
  size(500, 500);
  
  textFont( loadFont("AgencyFB-Reg-24.vlw") );
  textAlign( CENTER );
  
  for(int i = 0; i < transparency.length; i++) transparency[i] = 0;

  panda = new Gif(this, "panda.gif");
  panda.loop();

  cactus = new Gif(this, "cactus.gif");
  cactus.loop();

  dancer = new Gif(this, "dancer.gif");
  dancer.loop();

  fox = new Gif(this, "fox.gif");
  fox.loop();

  Peng = new Gif(this, "Peng.gif");
  Peng.loop();

  jumper = new Gif(this, "jumper.gif");
  jumper.loop();

  fill(0);
  stroke(0);

  minim = new Minim(this);
  soundFile = minim.loadFile("Ratatat - Bilar.mp3", 1024);
  meta = soundFile.getMetaData();

  // loop the file
  soundFile.loop();

  fft = new FFT( soundFile.bufferSize(), soundFile.sampleRate());
  fft.logAverages(60, 5);

  myBuffer = new float[soundFile.bufferSize()];

  for(int i = 0; i < 1000; i++){
    points1.add( new PVector(-1, -1));
    points2.add( new PVector(-1, -1));
    points3.add( new PVector(-1, -1));
    points4.add( new PVector(-1, -1));
  }
  
  for(int i = 0; i < fft.avgSize(); i++){
    if(i < fft.avgSize()/7) colRect[i] = 255;
    else if( i < 2*fft.avgSize()/7) colRect[i] = #FFFF00;
    else if( i < 3*fft.avgSize()/7) colRect[i] = #00FFFF;
    else if( i < 4*fft.avgSize()/7) colRect[i] = #00FF00;
    else if( i < 5*fft.avgSize()/7) colRect[i] = #FF00FF;
    else if( i < 6*fft.avgSize()/7) colRect[i] = #FF0000;
    else if( i < fft.avgSize()) colRect[i] = #0000FF;
    else colRect[i] = 0;
  }
}

void draw()
{
  background(255);

  fft.forward(soundFile.mix);

  speaker(width/6, height/2.2, width/3, height/3, width - width/2.5, height/4, width - width/4, height/2, 400, 1000, 600, 300);

  amplitude = 0;

  // Obtain stationary copy of waveform
  for (int i = 0; i < soundFile.bufferSize(); ++i) {
    myBuffer[i] = soundFile.left.get(i);
  }
  
  // find trigger point as largest +ve slope in first 1/4 of buffer
  int offset = 0;
  for (int i = 0; i < myBuffer.length/4; ++i)
  {
    float dx = myBuffer[i+1] - myBuffer[i]; 
    if (dx > maxdx) {
      offset = i;
      maxdx = dx;
    }
  }
  
  // plot oscillating waveform
  int mylen = min(tbase, myBuffer.length-offset);
  noFill();
  stroke(0);
  lineDraw(offset, mylen, 0);
  stroke(150, 255, 0);
  lineDraw(offset, mylen, 2);
  stroke(100, 255, 255);
  lineDraw(offset, mylen, -2);

  television();

  dance();
  
  if (metaDetails) {
    text("Title: " + meta.title(), width/2, 1.5*height/3);
    text("Author: " + meta.author(), width/2, 1.5*height/3 + 25); 
    text("Album: " + meta.album(), width/2, 1.5*height/3 + 50);
  }
}

void mousePressed() {
  if (mousePressed == true & pause == 0 & mouseButton == LEFT) {
    soundFile.pause();
    if (amptest >= 1) dancer.pause();    
    if (amptest >= 2) cactus.pause();    
    if (amptest >= 3) panda.pause();    
    if (amptest >= 4) fox.pause();    
    if (amptest >= 5) Peng.pause();    
    if (amptest >= 6) jumper.pause();
    
    pause = 1;
  } else if (mousePressed == true & pause == 1 & mouseButton == LEFT) {
    soundFile.loop();
    if (amptest >= 1) dancer.play();    
    if (amptest >= 2) cactus.play();    
    if (amptest >= 3) panda.play();    
    if (amptest >= 4) fox.play();    
    if (amptest >= 5) Peng.play();    
    if (amptest >= 6) jumper.play();
    pause = 0;
  }
  else if (mousePressed == true & mouseButton == RIGHT & metaDetails == false) metaDetails = true;
  else if (mousePressed == true & mouseButton == RIGHT & metaDetails == true) metaDetails = false;
  
}

void keyPressed()
{
  switch(key) {
  case '+': 
    gain = gain * 1.5; 
    break;
  case '-': 
    gain = gain / 1.5; 
    break;
  case '1': 
    soundFile.mute(); 
    break;
  case '2': 
    soundFile.unmute(); 
    break;
  }
}

void stop()
{
  soundFile.close();
  minim.stop();

  super.stop();
}