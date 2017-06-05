int particleCount = 100;

float[] x = new float[particleCount];
float[] y = new float[particleCount];
float[] fSpeedX = new float[particleCount];
float[] fSpeedY = new float[particleCount];
float[] gravity = new float[particleCount];

float[] x2 = new float[particleCount];
float[] y2 = new float[particleCount];
float[] fSpeedX2 = new float[particleCount];
float[] fSpeedY2 = new float[particleCount];
float[] gravity2 = new float[particleCount];

void fireworks() {
  //float[] burstX = new float[5];
  //float[] burstY = new float[5];
  fill(0, 20);
  noStroke();
  rect(-1, -1, width+1, height+1);
  stroke(0, 255, 0);

  if (frameCount % int(random(125,175)) == 0) {
    float xRand = random(-200, 200);
    float yRand = random(-200, 200);
    for (int i = 0; i < particleCount; i++) {
      x[i] = width/2 + xRand;
      y[i] = height/3 + yRand;
      fSpeedX[i] = random(-1.2, 1.2);
      fSpeedY[i] = random(-4, -2);
      gravity[i] = 0.07;
    }
  }

  if (frameCount % int(random(125,175)) == 0) {
    float xRand = random(-200, 200);
    float yRand = random(-200, 200);
    for (int i = 0; i < particleCount; i++) {
      x2[i] = width/2 + xRand;
      y2[i] = height/3 + yRand;
      fSpeedX2[i] = random(-1.2, 1.2);
      fSpeedY2[i] = random(-4, -2);
      gravity2[i] = 0.07;
    }
  }

  burst(x, y, fSpeedX, fSpeedY, gravity);
  burst(x2, y2, fSpeedX2, fSpeedY2, gravity2);
  
  if (frameCount % 60 == 0) showText = !showText;
  
  if (showText == true)fill(255);
  else fill(0);
  textFont(fontGaming);
  textAlign(CENTER, CENTER);
  text("You Win!", width/2, height/2);
  
  if(frameCount - fc > 3600) file.stop();
  
}
void burst(float[] x, float[] y, float[] fSpeedX, float[] fSpeedY, float[] gravity) {
  strokeWeight(1);
  for (int i = 0; i < particleCount; i++) {
    stroke(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
    rect(x[i], y[i], 1, 1);
    x[i] += fSpeedX[i];
    fSpeedY[i] += gravity[i];
    y[i] += fSpeedY[i];
  }
}

void gameOver(){
  fill(0);
  noStroke();
  rect(-1, -1, width+1, height+1);
  
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  if ((frameCount - fc)/3 < 120){
    if ((frameCount - fc)/3 < 1) textFont(fontGaming, 1);
    else textFont(fontGaming, (frameCount - fc)/3);
  }
  else{
    textFont(fontGaming, 120);
  }
  
  if(frameCount - fc > 3600) file.stop();
    
  text("Game Over!", width/2, height/2);
  //else if (complete == true) textFont(fontGaming, 120);
  
}