/* PartyTime
 *
 * Keyboard control:
 *  '+', '-' - adjust gain (vertical scale)
 *  '<', '>' - adjust timebase (horizontal scale)
 *  '1', '2' = mute and unmute volume
 * 
 * Code modified from:
 * 2010-01-25 Dan Ellis dpwe@ee.columbia.edu
 */

import ddf.minim.*;
 
Minim minim;
AudioPlayer song;
ArrayList <PVector> points = new ArrayList <PVector> ();

float gain = 200;
int tbase = 1024;
float[] myBuffer;
float maxdx = 0;
float amplitude = 0;


void setup()
{
  size(1028, 600);
 
  minim = new Minim(this);
  song = minim.loadFile("Ratatat - Bilar.mp3");
  song.play();

  myBuffer = new float[song.bufferSize()];
  
  for ( int i = 0 ; i < 9999 ; i++ ) {
        points.add( new PVector(width/2,height/2) ) ; ;
    } 
}
 
void draw()
{
  background(255,5);
  stroke(0);
  // draw the output waveforms, so there's something to look at
  // first grab a stationary copy
  for (int i = 0; i < song.bufferSize(); ++i) {
    myBuffer[i] = song.left.get(i);
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
}

void keyPressed()
{
  switch(key) {
    case '+': gain = gain * 1.5; break;
    case '-': gain = gain / 1.5; break;
    case '<': tbase = tbase / 2; break;
    case '>': tbase = 2*tbase; break;
    case '1': song.mute(); break;
    case '2': song.unmute(); break;
  }
}
 
void stop()
{
  song.close();
  minim.stop();
 
  super.stop();
}