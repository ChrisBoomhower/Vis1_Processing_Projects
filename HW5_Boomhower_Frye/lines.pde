void lineDraw(int offset, int mylen, float tOffset){
  beginShape();
  for(int i = 0; i < mylen - 1; i++)
  {
    float x1 = map(i, 0, tbase, 0, width);
    //float x2 = map(i+1, 0, tbase, 0, width);
    //stroke(0);
    //line(x1, 100 - myBuffer[i+offset]*gain, x2, 100 - myBuffer[i+1+offset]*gain);
    curveVertex(x1+tOffset,height/4 - myBuffer[i+offset]*gain);
    if(myBuffer[i+offset] > amplitude) amplitude = myBuffer[i+offset];
    //stroke(255,0,0);
    //point(x1,100 - myBuffer[i+offset]*gain);
  }
  endShape();
}