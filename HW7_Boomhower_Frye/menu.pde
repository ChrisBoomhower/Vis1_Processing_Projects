/**********************************************************
 Menu class
***********************************************************/

class Menu {

  soundSwitch soundSwitch;
  GermanyButton GermanyButton;
  JapanButton JapanButton;
  ChinaButton ChinaButton;
  startButton startButton;
  boolean soundOn = false;
  int roundTemp;

  Menu(int roundTemp) {
    this.roundTemp = roundTemp;
    soundSwitch = new soundSwitch();
    GermanyButton = new GermanyButton();
    JapanButton = new JapanButton();
    ChinaButton = new ChinaButton();
    startButton = new startButton();
  }

  boolean getSoundOn() {
    return soundOn;
  }

  int getRoundTemp() {
    return roundTemp;
  }

  void setRoundTemp(int roundTemp) {
    this.roundTemp = roundTemp;
  }

  void framework() {
    background(200);

    pushMatrix();

    fill(0);
    textFont(fontGaming);

    textAlign(CENTER, CENTER);
    text("Select Round:", width/2, height - height/2.8);

    GermanyButton.build();
    JapanButton.build();
    ChinaButton.build(); 
    
    popMatrix();
    
    soundSwitch.build();
    
    if (getRoundTemp() != 0) startButton.build();
  }

  void roundSelection() {
    pushMatrix();
    noFill();
    stroke(0, 255, 120);
    strokeWeight(4);
    if (roundTemp == 1) rect(width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
    else if (roundTemp == 2) rect(width/2 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
    else if (roundTemp == 3) rect(width - width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
    popMatrix();
  }

  void interaction(float x, float y, int roundTemp) {
    if (  x > width-75 & x < width-50 & y > 100 & y < 125) {
      soundOn = true;
      file.play();
    } else if (  x > width-100 & x < width-75 & y > 100 & y < 125) {
      soundOn = false;
      file.stop();
    }

    if (x > width/5 - flagWidth/2
      & x < width/5 + flagWidth/2
      & y > height - height/5 - flagHeight/2
      & y < height - height/5 + flagHeight/2) setRoundTemp(1);

    else if (x > width/2 - flagWidth/2
      & x < width/2 + flagWidth/2
      & y > height - height/5 - flagHeight/2
      & y < height - height/5 + flagHeight/2) setRoundTemp(2);

    else if (x > width - width/5 - flagWidth/2
      & x < width - width/5 + flagWidth/2
      & y > height - height/5 - flagHeight/2
      & y < height - height/5 + flagHeight/2) setRoundTemp(3);

    else if (x > width/2 - flagWidth/2
      & x < width/2 + flagWidth/2
      & y > height/3 - flagHeight/2
      & y < height/3 + flagHeight/2) round = roundTemp;

    for (int i = 0; i<ballCount; i++) {
      ball[i].setSpeedX(5);
    }
  }
}