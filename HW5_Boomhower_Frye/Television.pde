
void television() {
  pushMatrix();
  translate(35,35);
  
  pushMatrix();
  fill(0);
  strokeWeight(2);
  stroke(0);
  translate(285, 367.5);
  line(15,0,2.5,-20);
  line(60,0,72.5,-20);
  popMatrix();
  
  pushMatrix();
  fill(103, 57, 34);
  stroke(103, 57, 34);
  translate(320,395);
  quad(-5,0,7.5,0,30,55,-30,55);
  popMatrix();
  
  pushMatrix();
  fill(150);
  stroke(150);
  translate(285, 367.5);
  rect(0, 0, 75, 60, 10);
  fill(200);
  stroke(200);
  rect(7.5, 10, 60, 45, 5);
  popMatrix();

  pushMatrix();
  translate(300, 400);
  fill(0);
  stroke(0);
  equalizer();
  popMatrix();
  popMatrix();
}

void equalizer() {
  for (int i = 0; i < fft.avgSize(); i++)
  {
    stroke(colRect[i]);
    
    if (abs(20 - fft.getAvg(i)) < 20) rect(i, 0, 1, 20 - fft.getAvg(i));
    
    else if (20 - fft.getAvg(i) < 0) rect(i, 0, 1, -20);
    
    else rect(i, 0, 1, 20);
    
    if (fft.getAvg(i) > 100 & frameCount - fc > 3*60){
      fc = frameCount;
      amptest++;
    }
  }
}