//This Class exists to define forced structure for Buttons Subclasses

abstract class Frame {

  float x;
  float y;
  float frameWidth;
  float frameHeight;


  
  Frame() {
  }

  Frame(float x, float y, float frameWidth, float frameHeight) {
    this.x = x;
    this.y = y;
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
  }  

  void resetFrameDims(float x, float y, float frameWidth, float frameHeight) {
    this.x = x;
    this.y = y;
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
  }

  abstract void Construct();

  void drawFrame() {
    pushMatrix();
    noFill();
    stroke(0);
    strokeWeight(width/300);
    rect(this.x, this.y, this.frameWidth, this.frameHeight);
    popMatrix();
  }

  void drawTitle(String title) {
    pushMatrix();
    PFont VISfont = loadFont("VISFont.vlw");
    textFont(VISfont, width/58);
    textAlign(CENTER);
    fill(0);
    
    float yOffset;
    if (this.frameWidth/19.33>25) yOffset = 25;
    else yOffset = this.frameWidth/19.33;
    
    text(title, this.x + this.frameWidth/2, this.y + yOffset);
    popMatrix();
  }
}