/****************************************************************************************** //<>//
 Title         : PartyTime
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/16/2017
 Assignment    : MSDS6390 - HW 5
 Resources     : https://vimeo.com/7586074
 https://github.com/ddf/Minim/tree/master/examples/Analysis/SoundSpectrum
 https://www.ee.columbia.edu/~dpwe/resources/Processing/
                 https://www.openprocessing.org/sketch/214311
 ******************************************************************************************/

import ddf.minim.analysis.*;
import ddf.minim.*;
import gifAnimation.*;

Minim minim;  
AudioPlayer soundFile;
FFT fft;

Gif astr;
Gif cactus;
Gif dancer;
Gif fox;
Gif frederick;
Gif jumper;

int w;
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


void setup()
{
  size(500, 500);
  
  astr = new Gif(this, "astr.gif");
  astr.loop();
  
  cactus = new Gif(this, "cactus.gif");
  cactus.loop();
  
  dancer = new Gif(this, "dancer.gif");
  dancer.loop();
  
  fox = new Gif(this, "fox.gif");
  fox.loop();
  
  frederick = new Gif(this, "frederick.gif");
  frederick.loop();
  
  jumper = new Gif(this, "jumper.gif");
  jumper.loop();
  
  fill(0);
  stroke(0);

  minim = new Minim(this);
  soundFile = minim.loadFile("Ratatat - Bilar.mp3", 1024);

  // loop the file
  soundFile.loop();

  fft = new FFT( soundFile.bufferSize(), soundFile.sampleRate());
  fft.logAverages(60, 5);
  println(w);

  myBuffer = new float[soundFile.bufferSize()];

  for ( int i = 0; i < 1000; i++ ) {
    points1.add( new PVector(-1,-1) );
    points2.add( new PVector(-1,-1) );
    points3.add( new PVector(-1,-1) );
    points4.add( new PVector(-1,-1) );
  }
}

void draw()
{
  background(255);

  fft.forward(soundFile.mix);
  
  speaker(width/6, height/2.2, width/3, height/3, width - width/2.5, height/4, width - width/4, height/2, 400, 1000, 600, 300);
  //speaker(width/3, height/3, 2000);
  //speaker(width - width/2.5, height/4, 600);
  //speaker(width - width/4, height/2, 350);
  
  amplitude = 0;

  // draw the output waveforms, so there's something to look at
  // first grab a stationary copy
  for (int i = 0; i < soundFile.bufferSize(); ++i) {
    myBuffer[i] = soundFile.left.get(i);
  }
  // find trigger point as largest +ve slope in first 1/4 of buffer
  int offset = 0;
  //float maxdx = 0;
  for (int i = 0; i < myBuffer.length/4; ++i)
  {
    float dx = myBuffer[i+1] - myBuffer[i]; 
    if (dx > maxdx) {
      offset = i;
      maxdx = dx;
    }
  }
  // plot out that waveform
  int mylen = min(tbase, myBuffer.length-offset);
  noFill();
  stroke(0);
  lineDraw(offset, mylen, 0);
  stroke(150,255,0);
  lineDraw(offset, mylen, 2);
  stroke(100,255,255);
  lineDraw(offset, mylen, -2);

  for (int i = 0; i < fft.avgSize(); i++)
  {
    if (abs(25 - fft.getAvg(i)) < 25) rect(i*w+300, 400, 1, 25 - fft.getAvg(i));
    else if (25 - fft.getAvg(i) < 0)  rect(i*w+300, 400, 1, -25);
    else rect(i*w+300, 400, 1, 25);
  amplitude *= 100;
  explode() ;

  amplitude = 0;

  }
  television();
  
  dance();
}

void mousePressed() {
  if (mousePressed == true & pause == 0) {
    soundFile.pause();
    pause = 1;
  } else if (mousePressed == true & pause == 1) {
    soundFile.play();
    pause = 0;
  }
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
  case '<': 
    tbase = tbase / 2; 
    break;
  case '>': 
    tbase = 2*tbase; 
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