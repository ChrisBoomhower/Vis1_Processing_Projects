Range QTRSlider;

class QTRSlider extends Buttons {

  //create additional variables here
  int startQTR;
  int endQTR;
  //float tickHigh = height/1.07 + height/20;
  float tickHigh = height/130;
  //float tickLow  = height - height/100;
  float tickLow  = height/90;

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
    QTRSlider = cp5.addRange("Quarter Range")
             .setBroadcast(false) // disable broadcasting since setRange and setRangeValues will trigger an event
             .setPosition(x, y)
             .setSize(width/3, height/22)
             .setHandleSize(20)
             .setRange(1, 4)
             .setRangeValues(1, 4)
             .setBroadcast(true) // after the initialization we turn broadcast back on again
            // .setColorForeground(color(255,40))
            // .setColorBackground(color(255,40))  
             ;
  }
  //modify/assign slider attributes based on actions
  //Also Print to console "got an event from "slidername" : startQTR endQTR
  void Action() {
    QTRSlider.setHighValue(round(QTRSlider.getHighValue()));
    QTRSlider.setLowValue(round(QTRSlider.getLowValue()));
    this.startQTR = round(QTRSlider.getLowValue());
    this.endQTR = round(QTRSlider.getHighValue());
    println("got an event from "+QTRSlider.getName()+"\t: " + startQTR + " " + endQTR);
  }
  

  
  void ticks() {
    pushMatrix();
    translate(x,y + height/22);
    stroke(255);
    strokeWeight(width/700);
    line(width/70, tickHigh, width/70, tickLow);
    line(width/8.6, tickHigh, width/8.6, tickLow);
    line(width/4.6, tickHigh, width/4.6, tickLow);
    line(width/3.134, tickHigh, width/3.134, tickLow);
    noStroke();
    popMatrix();
  }
}