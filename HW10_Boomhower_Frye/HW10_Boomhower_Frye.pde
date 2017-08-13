/****************************************************************************************** //<>//
 Title         : 3d Equalizer
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 8/13/2017
 Assignment    : MSDS6390 - HW 10
 Description   :          
 Resources     : 
 ******************************************************************************************/

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioPlayer soundFile;
AudioMetaData meta;
FFT fft;

float boxWHDim = 17;
float diameter;
int bars;
//float rotation=0;
float[] randomWPoint = new float[3];
float[] randomHPoint = new float[3];
float[] randomZPoint = new float[3];

void setup()
{
  size(500, 500, P3D);

  minim = new Minim(this);
  soundFile = minim.loadFile("Ratatat - Wildcat.mp3", 1024);
  meta = soundFile.getMetaData();

  // loop the file
  soundFile.loop();
  soundFile.mute();
  
  fft = new FFT( soundFile.bufferSize(), soundFile.sampleRate());
  fft.logAverages(60, 5);
  
  diameter = width/2;
  bars = fft.avgSize();
  
  for(int i = 0; i<randomWPoint.length; i++){
    randomWPoint[i] = random(0,width);
    randomHPoint[i] = random(0,height);
    randomZPoint[i] = random(-400,400);
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i<randomWPoint.length; i++) {
    pushMatrix();
    translate(randomWPoint[i], randomHPoint[i], randomZPoint[i]);
    box(25);
    popMatrix();
  }
  
  pointLight(0, 0, 255, randomWPoint[0], randomHPoint[0], randomZPoint[0]);
  pointLight(0, 255, 0, randomWPoint[1], randomHPoint[1], randomZPoint[1]);
  pointLight(255, 0, 0, randomWPoint[2], randomHPoint[2], randomZPoint[2]);
  
  translate(width/2, height*0.68, 0);
  fill(255);
  sphere(70);
  
  //camera(mouseX, mouseY, (height/2) / tan(PI/3), width/2, (height/2), 0, 0, 1, 0);
  rotateY(radians(map(-mouseX,0,width,0,360)));
  rotateX(radians(map(mouseY,0,height,-90,70)));
  
  fft.forward(soundFile.mix);
  equalizer();
}

void equalizer() {
  
  pushMatrix();
  rotateX(PI/2);
  for( int i = 0; i < bars; i++){
    //randomSeed(i);
    //fill(random(0,255), random(0,255), random(0,255));
    float k = i*(2*PI)/bars;
    println (i + "; " + degrees(k));
    pushMatrix();
    translate(cos(k)*diameter/2, sin(k)*diameter/2, 0);
    rotateZ(k);
    box(boxWHDim, boxWHDim, fft.getAvg(i));
    popMatrix();
  }
  popMatrix();
  
}