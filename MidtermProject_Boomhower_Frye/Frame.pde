//This Class exists to define forced structure for Buttons Subclasses

abstract class Frame {

  float x;
  float y;
  float frameWidth;
  float frameHeight;
  float c = 125;
  color[] colorCycle= {#f06292, #ff8a65, #81c784, #fff176, #ba68c8};


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

  void drawFrame() {
    pushMatrix();
    noFill();
    stroke(c);
    strokeWeight(width/300);
    rect(this.x, this.y, this.frameWidth, this.frameHeight);
    popMatrix();
  }

  void drawTitle(String title) {
    pushMatrix();
    PFont VISfont = loadFont("VISFont.vlw");
    textFont(VISfont, width/58);
    textAlign(CENTER);
    fill(c);

    float yOffset;
    if (this.frameWidth/19.33>25) yOffset = 25;
    else yOffset = this.frameWidth/19.33;

    text(title, this.x + this.frameWidth/2, this.y + yOffset);
    popMatrix();
  }

  abstract void Construct();
  abstract void loadChartData();

  float getX() {
    return(x);
  }
  
  float getY() {
    return(y);
  }
  
  float getFrameWidth() {
    return frameWidth;
  }
  
  float getFrameHeight() {
    return frameHeight;
  }
}