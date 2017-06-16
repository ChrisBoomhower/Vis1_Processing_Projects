/****************************************************************************************** //<>//
 Title         : PartyTime
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 6/16/2017
 Assignment    : MSDS6390 - HW 5
 Resources     : https://vimeo.com/7586074
                 https://github.com/ddf/Minim/tree/master/examples/Analysis/SoundSpectrum
                 https://www.ee.columbia.edu/~dpwe/resources/Processing/
 ******************************************************************************************/

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioPlayer soundFile;
FFT fft;

int w;
int pause = 0;


ArrayList <PVector> points = new ArrayList <PVector> ();
float gain = 200;
int tbase = 1024;
float[] myBuffer;
float maxdx = 0;
float amplitude = 0;


void setup()
{
  size(500, 500);

  fill(0);
  stroke(0);

  minim = new Minim(this);
  soundFile = minim.loadFile("Ratatat - Bilar.mp3", 1024);

  // loop the file
  soundFile.loop();

  fft = new FFT( soundFile.bufferSize(), soundFile.sampleRate());
  fft.logAverages(60, 7);
  w = 100/fft.avgSize();

  myBuffer = new float[soundFile.bufferSize()];

  for ( int i = 0; i < 9999; i++ ) {
    points.add( new PVector(width/2, height/2) );
  }
}

void draw()
{
  background(255);

  fft.forward(soundFile.mix);

  // draw the output waveforms, so there's something to look at
  // first grab a stationary copy
  for (int i = 0; i < soundFile.bufferSize(); ++i) {
    myBuffer[i] = soundFile.left.get(i);
  }
  // find trigger point as largest +ve slope in first 1/4 of buffer
  int offset = 0;
  //float maxdx = 0;
  for(int i = 0; i < myBuffer.length/4; ++i)
  {
      float dx = myBuffer[i+1] - myBuffer[i]; 
      if (dx > maxdx) {
        offset = i;
        maxdx = dx;
      }
  }
  // plot out that waveform
  int mylen = min(tbase, myBuffer.length-offset);
  beginShape();
  for(int i = 0; i < mylen - 1; i++)
  {
    float x1 = map(i, 0, tbase, 0, width);
    //float x2 = map(i+1, 0, tbase, 0, width);
    stroke(0);
    //line(x1, 100 - myBuffer[i+offset]*gain, x2, 100 - myBuffer[i+1+offset]*gain);
    curveVertex(x1,height/4 - myBuffer[i+offset]*gain);
    if(myBuffer[i+offset] > amplitude) amplitude = myBuffer[i+offset];
    //stroke(255,0,0);
    //point(x1,100 - myBuffer[i+offset]*gain);
  }
  endShape();
  
  pushMatrix();
  translate(width/2, height/2);
  for ( PVector p : points ) {
        //ellipse(p.x, p.y, 4,4);
        point(p.x, p.y);
    }
  popMatrix();

  amplitude *= 100;
  explode() ;
  
  amplitude = 0;


  for (int i = 0; i < fft.avgSize(); i++)
  {
    if (abs(25 - fft.getAvg(i)) < 25) rect(i*w+300, 400, 1, 25 - fft.getAvg(i));
    else if (25 - fft.getAvg(i) < 0)  rect(i*w+300, 400, 1, -25);
    else rect(i*w+300, 400, 1, 25);
  }
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
    case '+': gain = gain * 1.5; break;
    case '-': gain = gain / 1.5; break;
    case '<': tbase = tbase / 2; break;
    case '>': tbase = 2*tbase; break;
    case '1': soundFile.mute(); break;
    case '2': soundFile.unmute(); break;
  }
}
 
void stop()
{
  soundFile.close();
  minim.stop();
 
  super.stop();
}