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

float boxWHDim = 20;
float diameter;
int bars;
float rotation=0;

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
}

void draw() {
  background(255);
  translate(width/2, height*0.75, 0);
  //camera(mouseX, mouseY, (height/2) / tan(PI/3), width/2, (height/2), 0, 0, 1, 0);
  rotateY(radians(map(mouseX,0,700,0,width)));
  /////////////////////////
  //float orbitRadius= mouseX/2+50;
  //float ypos= mouseY/3;
  //float xpos= cos(radians(rotation))*orbitRadius;
  //float zpos= sin(radians(rotation))*orbitRadius;
  
  //camera(xpos, ypos, zpos, 0, 0, 0, 0, 1, 0);

  //rotation++;
  /////////////////////////
  fft.forward(soundFile.mix);
  equalizer();
}

void equalizer() {
  
  pushMatrix();
  rotateX(PI/2);
  ellipse(0,0,diameter,diameter);
  for( int i = 0; i < bars; i++){
    float k = i*(2*PI)/bars;
    println (i + "; " + degrees(k));
    //println(i, "; ",fft.getAvg(i));
    pushMatrix();
    translate(cos(k)*diameter/2, sin(k)*diameter/2, fft.getAvg(i)/2);
    rotateZ(k);
    box(boxWHDim, boxWHDim, fft.getAvg(i));
    popMatrix();
  }
  popMatrix();
  
}