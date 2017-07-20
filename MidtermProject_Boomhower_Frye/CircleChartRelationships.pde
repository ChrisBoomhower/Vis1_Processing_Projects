
class CircleChartRelationships extends Frame {
  
  CircleChartRelationships() {
  }

  CircleChartRelationships(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
  }

  void Construct() {
    drawFrame();
    drawTitle("CIRCLECHARTRELATIONSHIPS TITLE HERE");
    
    pushMatrix();
    
    translate(x + frameWidth/2, y + frameHeight/2);
    noFill();
    stroke(255);
    if (frameWidth < frameHeight) {
      ellipse(0, 0, frameWidth, frameWidth);
    }
    else {
      ellipse(0, 0, frameHeight, frameHeight);
      strokeWeight(5);
      stroke(255,0,0);
      ellipse(cos(PI/4)*frameHeight/2, sin(PI/4)*frameHeight/2, 10, 10);
      strokeWeight(1);
    }
    
    
    popMatrix();
  }

  void loadChartData(){

  }
  
}