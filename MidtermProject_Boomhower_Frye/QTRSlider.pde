//load slider here

class QTRSlider extends Buttons {

  //create additional variables here
  int startQTR;
  int endQTR;

  //leave the default constructor, and add a new one accounting for data needed for slider
  QTRSlider() {
    super();
  }
  QTRSlider(float x, float y) {
    super(x, y);
    this.startQTR = 1;
    this.endQTR   = 4;
  }

  // Initialize slider here
  void Construct() {
  }
  //modify/assign slider attributes based on actions
  //Also Print to console "got an event from "slidername" : startQTR endQTR
  void Action(ControlEvent theEvent) {
  }
}