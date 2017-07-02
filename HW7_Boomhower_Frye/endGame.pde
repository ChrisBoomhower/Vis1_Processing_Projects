

class gameOver {

  gameOver() {
  }

  void splashScreen() {
    fill(0);
    noStroke();
    rect(-1, -1, width+1, height+1);

    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    if ((frameCount - fc)/3 < 120) {
      if ((frameCount - fc)/3 < 1) textFont(fontGaming, 1);
      else textFont(fontGaming, (frameCount - fc)/3);
    } else {
      textFont(fontGaming, 120);
    }

    if (frameCount - fc > 3600) file.stop();

    text("Game Over!", width/2, height/2);
  }
}

class youWin {
  
  float posX;
  float posY;

  youWin() {
    this.posX = width/2;
    this.posY = height/2;
  }

  void flashText() {
    if (frameCount % 60 == 0) showText = !showText;

    if (showText == true) fill(255);
    else fill(0);
    textFont(fontGaming);
    textAlign(CENTER, CENTER);
    text("You Win!", posX, posY);

    if (frameCount - fc > 3600) file.stop();
  }
}