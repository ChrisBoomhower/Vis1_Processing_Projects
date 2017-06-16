
void television() {
  pushMatrix();
  translate(35,35);
  
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
    if (abs(20 - fft.getAvg(i)) < 20) rect(i, 0, 1, 20 - fft.getAvg(i));
    else if (20 - fft.getAvg(i) < 0)  rect(i, 0, 1, -20);
    else                              rect(i, 0, 1, 20);
    
    if (fft.getAvg(i) > 55) amptest = 1;
  }
}