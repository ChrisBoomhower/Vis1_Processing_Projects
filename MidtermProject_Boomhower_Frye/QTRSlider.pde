Range QTRSlider;

class QTRSlider extends Buttons {

  //create additional variables here
  int startQTR;
  int endQTR;
  float tickHigh = height/1.07 + height/20;
  float tickLow  = height - height/100;

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
    QTRSlider = cp5.addRange("rangeController")
             .setBroadcast(false) // disable broadcasting since setRange and setRangeValues will trigger an event
             .setPosition(x, y)
             .setSize(width/3, height/22)
             .setHandleSize(20)
             .setRange(1, 4)
             .setRangeValues(1, 4)
             .setBroadcast(true) // after the initialization we turn broadcast back on again
             .setColorForeground(color(255,40))
             .setColorBackground(color(255,40))  
             ;
  }
  //modify/assign slider attributes based on actions
  //Also Print to console "got an event from "slidername" : startQTR endQTR
  void Action(ControlEvent theEvent) {
  }
  
  void ticks() {
    stroke(255);
    line(width/2.88, tickHigh, width/2.88, tickLow);
    line(width/2.227, tickHigh, width/2.227, tickLow);
    line(width/1.815, tickHigh, width/1.815, tickLow);
    line(width/1.534, tickHigh, width/1.534, tickLow);
    noStroke();
  }
}