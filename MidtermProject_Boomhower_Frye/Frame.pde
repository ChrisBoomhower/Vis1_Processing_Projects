//This Class exists to define forced structure for Buttons Subclasses

abstract class Frame {

  float x;
  float y;

  Frame() {
  }

  Frame(float x, float y) {
    this.x = x;
    this.y = y;
  }  

  void resetFrameDims(float x, float y){
    this.x = x;
    this.y = y;
  }

  abstract void Construct();
}