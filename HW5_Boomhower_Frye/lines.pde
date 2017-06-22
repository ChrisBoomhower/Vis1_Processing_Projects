/**** Oscilloscope related code ****/

void lineDraw(int offset, int mylen, float tOffset){
  beginShape();
  for(int i = 0; i < mylen - 1; i++)
  {
    float x1 = map(i, 0, tbase, 0, width);
    curveVertex(x1+tOffset,height/4 - myBuffer[i+offset]*gain);
    if(myBuffer[i+offset] > amplitude) amplitude = myBuffer[i+offset];
  }
  endShape();
}