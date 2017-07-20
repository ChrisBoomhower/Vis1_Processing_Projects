/****************************************************************************************** //<>// //<>// //<>// //<>// //<>// //<>// //<>//
 Title         : OPM Separation Analysis Dashboard
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 7/9/2017
 Assignment    : MSDS6390 - Midterm Project
 Resources     : https://Forum.Processing.org/two/discussion/23324/executing-python-3-code-from-within-processing#Item_9
 https://GitHub.com/GoToLoop/command/blob/patch-1/src/deadpixel/command/Command.java
 ******************************************************************************************/
import controlP5.*;

PFont agency;

ControlP5 cp5;
SEPCheckBox SEPcheckbox;
LOADButton LOADbutton;
QTRSlider QTRslider;
ExecPython execPython;
BarChartAvgOverUnder barChartAvgOverUnder;
CircleChartRelationships circleChartRelationships;
BLSRingChart blsRingChart;
Background loadBG;
Background panelBG;

int QTRSliderEvent = 0;
float curWidth;
float curHeight;
boolean displaySplash = true;


void setup() {
  size(1400, 900);
  loadBG = new Background(0, 0, width, height, 75, 0);
  loadBG.drawBackground();

  displayLoadSplashScreen();

  surface.setResizable(true);
  curWidth = width;
  curHeight= height;

  cp5 = new ControlP5(this);

  constructAll();

  execPython = new ExecPython();

  SEPCheckBox.toggle(0);

  panelBG = new Background(0, 0, width, height, 75, 0);

  thread("loadData");
}



void draw() {
  //fill(#343932);
  //rect(0, 0, width, height);
  panelBG.drawBackground();
  windowReSize();
  if (displaySplash == true) displayLoadSplashScreen();
  else {
    QTRslider.ticks();
    barChartAvgOverUnder.Construct();
    circleChartRelationships.Construct();
    blsRingChart.Construct();
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(SEPCheckBox)) {
    SEPcheckbox.Action();
  } else if (theEvent.isFrom(LOADData)) {
    if (displaySplash==false) {
      displaySplash=true;
      thread("loadData");
    }
  } else if (theEvent.isFrom(QTRSlider)) {
    QTRSliderEvent = 1;
  } else if (theEvent.isFrom(displayCountKnob)) {
    barChartAvgOverUnder.setDisplayCount(int(displayCountKnob.getValue()));
  }
}

void mouseReleased() {
  if (QTRSliderEvent == 1) {
    QTRslider.Action();
    QTRSliderEvent = 0;
  }
}

void windowReSize() {
  if (curWidth != width || curHeight != height) {
    curWidth = width;
    curHeight = height;

    float[] SEPCheckBoxArrayValues = SEPcheckbox.getValues();
    int startQTR  = round(QTRSlider.getLowValue());
    ;
    int endQTR = round(QTRSlider.getHighValue());
    ;

    constructAll();

    for (int i=1; i<SEPCheckBoxArrayValues.length-1; i++) {
      float n = SEPCheckBoxArrayValues[i];

      if (n == 1) SEPCheckBox.toggle(i);
    }

    QTRSlider.setHighValue(round(endQTR));
    QTRSlider.setLowValue(round(startQTR));

    SEPcheckbox.Action();
    QTRslider.Action();

    barChartAvgOverUnder.loadChartData();
    circleChartRelationships.loadChartData();
    blsRingChart.loadChartData();
  }
}

void constructAll() {

  SEPcheckbox = new SEPCheckBox(width/56, height/6, width/14, height/18);
  SEPcheckbox.Construct();

  LOADbutton = new LOADButton(width-(width/11.2), height/36, width/14, height/18);
  LOADbutton.Construct();

  QTRslider = new QTRSlider(width/3, height/1.07);
  QTRslider.Construct();

  barChartAvgOverUnder = new BarChartAvgOverUnder(width/5.76, height/1.8, width/3, height/3);
  //barChartAvgOverUnder.Construct();

  circleChartRelationships = new CircleChartRelationships(width/1.7, height/1.8, width/3, height/3);
  //circleChartRelationships.Construct();

  blsRingChart = new BLSRingChart(width/2.65, height/8, width/3, height/3);
  //blsRingChart.Construct();
}

void displayLoadSplashScreen() {
  agency = loadFont("AgencyFB-Reg-48.vlw");
  textFont(agency, width/30);
  textAlign(CENTER, CENTER);
  text("PLEASE WAIT WHILE DATA LOADS...", width/2, height/2);
}

void loadData() {
  LOADbutton.Action();
}