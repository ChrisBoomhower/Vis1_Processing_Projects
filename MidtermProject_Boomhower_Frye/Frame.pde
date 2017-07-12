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

  void resetFrameDims(float x, float y, float frameWidth, float frameHeight){
    this.x = x;
    this.y = y;
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
  }

  abstract void Construct();
  
  void drawFrame(){
    pushMatrix();
    noFill();
    stroke(0);
    strokeWeight(width/280);
    rect(this.x, this.y, this.frameWidth, this.frameHeight);
    popMatrix();
  }
}