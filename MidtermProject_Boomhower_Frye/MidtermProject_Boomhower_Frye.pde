/******************************************************************************************  //<>//
 Title         : OPM Separation Analysis Dashboard
 Created By    : Chris Boomhower, Alex Frye
 Create Date   : 7/9/2017
 Assignment    : MSDS6390 - Midterm Project
 Description   : This OOP Project Design, implements the concept of abstract inheritance amongst a myriad of class objects. Our GUI controls are produced from the controlp5 library, 
                 and we utilize the deadpixel library to help facilitate the execution of multi-threaded python scripts within processing. 
                 The controls found on the left and bottom of the screen help "Filter" the original dataset .csv file to specific segments of the data.
                 Once filters are selected, you may click the "Load Data" button in the top right to update the visual with the new observation set.
                 Zoom toggles, and a "number of bars" knob control are also present within our visualization to interact with our visuals and gain additional insights. 
                 Finally, the entire Window is re-sizeable, and the visualization should scale as the window size changes. 
                 
                 We present three distinct Visual plots into our dataset:
                     1. BLS Relationships - Levels and Rates: Stacked ellipses produce "rings" of varying width based on values obtained by the Bureau of Labor Statistics (BLS). 
                                                              The thicker the "ring", the larger the value, as should be apparent when analyzing hover text values.
                     2. Avg. Salary Over/Under Industry by OCCFAMT: Bar chart identifying the average Industry Average salary for an occupation family minus the observation salary. 
                                                                    The Knob control will allow for varying number of bars to display on the screen. 
                                                                    To prevent a busy chart with text labels, hover text will help the user analyze which occupation family represents each bar.
                     3. Key Attribute Relationships: Visualization of categorical attributes is often difficult, thus we have created an interesting visual producing line connections around an 
                                                     ellipse for the distinct values amongst three categorical variables {Salary Level, Age Level, and Work Schedule}. The distinct values of
                                                     each attribute are encoded to specific regions of the exterior of an ellipse, and lines connect the distinct combination of values present within the dataset.
                                                     Line colors represent a 4th categorical attribute, representing "PATCO", describing whether a job role is White Collar, Blue Collar, Administrative, etc.
                                                     We recommend utilizing the Zoom Toggle for this plot, as it becomes very difficult to analyze in the smaller view.              
                 
 Requirements  : You must have Python 3 installed on your machine
 Resources     : https://Forum.Processing.org/two/discussion/23324/executing-python-3-code-from-within-processing#Item_9
                 https://GitHub.com/GoToLoop/command/blob/patch-1/src/deadpixel/command/Command.java
                 https://github.com/sojamo/controlp5
                 https://processing.org/examples/lineargradient.html
 ******************************************************************************************/
import controlP5.*;
import java.util.*;

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
    if((ZoomRel.getValue()!=1) & (ZoomBLS.getValue()!=1))    barChartAvgOverUnder.Construct();
    if((ZoomBar.getValue()!=1) & (ZoomBLS.getValue()!=1))    circleChartRelationships.Construct();
    if((ZoomRel.getValue()!=1) & (ZoomBar.getValue()!=1))    blsRingChart.Construct();
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
  } else if (theEvent.isFrom(ZoomBLS)) {
    println("ZoomBLS", ZoomBLS.getValue());
    if (ZoomBLS.getValue()==1){
      blsRingChart.resetFrameDims(width/5.76, height/8, width-width/4, height - height/4);
      ZoomBar.hide();
      displayCountKnob.hide();
      ZoomRel.hide();
    }else {
      blsRingChart.resetFrameDims(width/2.65, height/8, width/3, height/3);
    }
  } else if (theEvent.isFrom(ZoomBar)) {
    println("ZoomBar", ZoomBar.getValue());
    if (ZoomBar.getValue()==1){
      barChartAvgOverUnder.resetFrameDims(width/5.76, height/8, width-width/4, height - height/4);
      ZoomBLS.hide();
      ZoomRel.hide();
    }else {
      barChartAvgOverUnder.resetFrameDims(width/5.76, height/1.8, width/3, height/3);
    }
  } else if (theEvent.isFrom(ZoomRel)) {
    println("ZoomRel", ZoomRel.getValue());
    if (ZoomRel.getValue()==1){
      circleChartRelationships.resetFrameDims(width/5.76, height/8, width-width/4, height - height/4);
      ZoomBar.hide();
      displayCountKnob.hide();
      ZoomBLS.hide();
    }else {
      circleChartRelationships.resetFrameDims(width/1.7, height/1.8, width/3, height/3);
    }
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
  fill(255);
  agency = loadFont("AgencyFB-Reg-48.vlw");
  textFont(agency, width/30);
  textAlign(CENTER, CENTER);
  text("PLEASE WAIT WHILE DATA LOADS...", width/2, height/2);
}

void loadData() {
  LOADbutton.Action();
}