/****************************************************************************************** //<>// //<>// //<>// //<>//
 Title         : OPM Separation Analysis Dashboard
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 7/9/2017
 Assignment    : MSDS6390 - Midterm Project
 Resources     : https://Forum.Processing.org/two/discussion/23324/executing-python-3-code-from-within-processing#Item_9
 https://GitHub.com/GoToLoop/command/blob/patch-1/src/deadpixel/command/Command.java
 ******************************************************************************************/
import controlP5.*;

ControlP5 cp5;
SEPCheckBox SEPcheckbox;
LOADButton LOADbutton;
QTRSlider QTRslider;
ExecPython execPython;
BarChartAvgOverUnder barChartAvgOverUnder;

void setup() {
  size(1400, 900);
  background(75);
  cp5 = new ControlP5(this);
  SEPcheckbox = new SEPCheckBox(25, 150, 100, 50);
  SEPcheckbox.Construct();

  LOADbutton = new LOADButton(width-125, 25, 100, 50);
  LOADbutton.Construct();

  QTRslider = new QTRSlider(0,0);
  QTRslider.Construct();

  SEPCheckBox.toggle(0);

  execPython = new ExecPython();
  //LOADbutton.Action();
  
  barChartAvgOverUnder = new BarChartAvgOverUnder(width/5.76,height/1.8);
  barChartAvgOverUnder.Construct();
}



void draw() {
  background(75);
  barChartAvgOverUnder.Construct();
  QTRslider.ticks();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(SEPCheckBox)) {
    SEPcheckbox.Action(theEvent);
  } else if (theEvent.isFrom(LOADData)) {
    LOADbutton.Action(theEvent);
  }///else if (theEvent.isFrom(QTRSlider)) {}
}

void mouseReleased() {
  QTRSlider.setHighValue(round(QTRSlider.getHighValue()));
  QTRSlider.setLowValue(round(QTRSlider.getLowValue()));
}