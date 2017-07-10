//This Class exists to define forced structure for Buttons Subclasses

abstract class Buttons {

  float x;
  float y;

  Buttons() {
  }

  Buttons(float x, float y) {
    this.x = x;
    this.y = y;
  }  

  abstract void Construct();
  abstract void Action(ControlEvent theEvent);
}