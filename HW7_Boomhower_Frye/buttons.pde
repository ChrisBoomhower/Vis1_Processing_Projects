/**********************************************************
 Button classes that function as sub-classes to Menu class
***********************************************************/

class soundSwitch {
  float a = width-100;
  float b = 100;
  float c = 50;
  float d = 25;
  String ct = "Sound";
  float x = width-75;
  float y = 100;

  soundSwitch() {
  }

  void build() {
    pushMatrix();

    noFill();
    stroke(0);
    strokeWeight(4);
    rect(a, b, c, d);

    textAlign(CENTER, BOTTOM);
    textFont(fontGaming);
    textSize(25);
    text(ct, x, y);

    popMatrix();

    //println(menu.getSoundOn());
    selection(menu.getSoundOn());
  }

  void selection(boolean soundOn) {
    pushMatrix();
    if (soundOn == true) {
      fill(0, 255, 0);
      rect(x, b, d, d);
    } else {
      fill(255, 0, 0);
      rect(a, b, d, d);
    }
    popMatrix();
  }
}

class GermanyButton {

  GermanyButton() {
  }

  void build() {
    noStroke();
    image(flagGermany, width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);

    textSize(30);
    textAlign(CENTER, BOTTOM);
    text("Round 1", width/5 - flagWidth/2, height - height/5, flagWidth, flagHeight);
  }
}

class JapanButton {

  JapanButton() {
  }

  void build() {
    noStroke();
    image(flagJapan, width/2 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);

    textSize(30);
    textAlign(CENTER, BOTTOM);
    text("Round 2", width/2 - flagWidth/2, height - height/5, flagWidth, flagHeight);
  }
}

class ChinaButton {
  
  ChinaButton() {
  }
  
  void build() {
    noStroke();
    image(flagChina, width - width/5 - flagWidth/2, height - height/5 - flagHeight/2, flagWidth, flagHeight);
    
    textSize(30);
    textAlign(CENTER, BOTTOM);
    text("Round 3", width - width/5 - flagWidth/2, height - height/5, flagWidth, flagHeight);
  }
}

class startButton {
  
  startButton() {
  }
  
  void build() {
    pushMatrix();
    stroke(0);
    fill(0, 255, 120);
    rect(width/2 - flagWidth/2, height/3 - flagHeight/2, flagWidth, flagHeight);
    fill(0);
    textFont(fontStart, 30);
    textAlign(CENTER, CENTER);
    text("START", width/2 - flagWidth/2, height/3 - flagHeight/2, flagWidth, flagHeight);
    textAlign(BASELINE);
    textFont(fontGaming);
    popMatrix();
  }
}