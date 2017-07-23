Toggle ZoomRel;

class CircleChartRelationships extends Frame {

  CircleChartRelationships() {
  }

  CircleChartRelationships(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
    ZoomRel = cp5.addToggle("ZoomRel")
      .setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .setSize(width/55, height/60)
      .setValue(false)
      .setMode(ControlP5.SWITCH)
      .hide()
      ;
  }

  void Construct() {
    ZoomRel.setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .show();
    float radius;
    drawFrame();
    drawTitle("CIRCLECHARTRELATIONSHIPS TITLE HERE");

    pushMatrix();

    translate(x + frameWidth/2, y + frameHeight/1.85);
    noFill();
    stroke(255);
    if (frameWidth < frameHeight) radius = frameWidth*0.8;
    else radius = frameHeight*0.8;

    ellipse(0, 0, radius, radius);
    stroke(255, 0, 0);
    for (int i = 30; i < 60; i=i+2) {
      //println(i);
      point(cos(radians(i))*(radius/1.9), sin(radians(i))*radius/1.9);
    }

    stroke(255, 255, 0);
    for (int i = 150; i < 180; i=i+5) {
      //println(i);
      point(cos(radians(i))*(radius/1.9), sin(radians(i))*radius/1.9);
    }

    popMatrix();
  }

  void loadChartData() {
  }
}