import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import java.util.*; 
import deadpixel.command.Command; 

import deadpixel.command.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MidtermProject_Boomhower_Frye extends PApplet {

/****************************************************************************************** 
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
 /****************************************************************************************** 
 Modified By   : Chris Boomhower, Alex Frye
 Modified Date : 8/1/2017
 Assignment    : Advanced OOP Design
 Description   : This week, we have added two enhancements for our Key Attribute Relationship visualization.
 1. Ellipse density for each category represents the magnitude of observations of that type from the original data
 2. Key Attribute Filters added within an accordian group object to remove/add category types from data displayed
 
 OOP inheritance was maintained through abstract button and frame class, forcing coding consistency across like classes
 when creating core Filter controls and each visualization presented.
 ******************************************************************************************/
 /****************************************************************************************** 
 Modified By   : Chris Boomhower, Alex Frye
 Modified Date : 8/7/2017
 Assignment    : .Java Conversion
 Description   : This week, we were assigned to convert processing code into a working .java project. 
 We chose to convert this existing project, and add the below functionality post-conversion.
 
 1. XXXXXXYYYYYYYZZZZZZZZ
 ******************************************************************************************/


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


public void setup() {
  
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



public void draw() {
  //fill(#343932);
  //rect(0, 0, width, height);
  panelBG.drawBackground();
  windowReSize();
  if (displaySplash == true) displayLoadSplashScreen();
  else {
    QTRslider.ticks();
    if ((ZoomRel.getValue()!=1) & (ZoomBLS.getValue()!=1))    barChartAvgOverUnder.Construct();
    if ((ZoomBar.getValue()!=1) & (ZoomBLS.getValue()!=1))    circleChartRelationships.Construct();
    if ((ZoomRel.getValue()!=1) & (ZoomBar.getValue()!=1))    blsRingChart.Construct();
  }
}

public void controlEvent(ControlEvent theEvent) {
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
    barChartAvgOverUnder.setDisplayCount(PApplet.parseInt(displayCountKnob.getValue()));
  } else if (theEvent.isFrom(ZoomBLS)) {
    println("ZoomBLS", ZoomBLS.getValue());
    if (ZoomBLS.getValue()==1) {
      blsRingChart.resetFrameDims(width/5.76f, height/8, width-width/4, height - height/4);
      ZoomBar.hide();
      displayCountKnob.hide();
      ZoomRel.hide();
      CATaccordion.hide();
    } else {
      blsRingChart.resetFrameDims(width/2.65f, height/8, width/3, height/3);
    }
  } else if (theEvent.isFrom(ZoomBar)) {
    println("ZoomBar", ZoomBar.getValue());
    if (ZoomBar.getValue()==1) {
      barChartAvgOverUnder.resetFrameDims(width/5.76f, height/8, width-width/4, height - height/4);
      ZoomBLS.hide();
      ZoomRel.hide();
      CATaccordion.hide();
    } else {
      barChartAvgOverUnder.resetFrameDims(width/5.76f, height/1.8f, width/3, height/3);
    }
  } else if (theEvent.isFrom(ZoomRel)) {
    println("ZoomRel", ZoomRel.getValue());
    if (ZoomRel.getValue()==1) {
      circleChartRelationships.resetFrameDims(width/5.76f, height/8, width-width/4, height - height/4);
      ZoomBar.hide();
      displayCountKnob.hide();
      ZoomBLS.hide();
    } else {
      circleChartRelationships.resetFrameDims(width/1.7f, height/1.8f, width/3, height/3);
    }
  } else if (theEvent.isFrom(CBCircleChartPATCO)) {
    circleChartRelationships.cbPATCOAction();
  } else if (theEvent.isFrom(CBCircleChartAGELVLT)) {
    circleChartRelationships.cbAGELVLTAction();
  } else if (theEvent.isFrom(CBCircleChartWORKSCHT)) {
    circleChartRelationships.cbWORKSCHTAction();
  } else if (theEvent.isFrom(CBCircleChartSALLVLT)) {
    circleChartRelationships.cbSALLVLTAction();
  }
}

//CheckBox CBCircleChartPATCO;
//CheckBox CBCircleChartAGELVLT;
//CheckBox CBCircleChartWORKSCHT;
//CheckBox CBCircleChartSALLVLT;

public void mouseReleased() {
  if (QTRSliderEvent == 1) {
    QTRslider.Action();
    QTRSliderEvent = 0;
  }
}

public void windowReSize() {
  if (curWidth != width || curHeight != height) {
    curWidth = width;
    curHeight = height;

    float[] SEPCheckBoxArrayValues = SEPcheckbox.getValues();
    int startQTR  = round(QTRSlider.getLowValue());
    int endQTR = round(QTRSlider.getHighValue());

    float[] CBCircleChartPATCOArrayValues = circleChartRelationships.CBCircleChartPATCOCurrentValues;
    float[] CBCircleChartAGELVLTArrayValues = circleChartRelationships.CBCircleChartAGELVLTCurrentValues;
    float[] CBCircleChartWORKSCHTArrayValues = circleChartRelationships.CBCircleChartWORKSCHTCurrentValues;
    float[] CBCircleChartSALLVLTArrayValues = circleChartRelationships.CBCircleChartSALLVLTCurrentValues;

    constructAll();

    for (int i=1; i<SEPCheckBoxArrayValues.length-1; i++) {
      float n = SEPCheckBoxArrayValues[i];

      if (n == 1) SEPCheckBox.toggle(i);
    }

 
    
    for (int i=0; i<circleChartRelationships.CBCircleChartPATCOCurrentValues.length; i++) {
      float n = CBCircleChartPATCOArrayValues[i];

      if (n == 0) CBCircleChartPATCO.toggle(i);
    }

    for (int i=0; i<circleChartRelationships.CBCircleChartAGELVLTCurrentValues.length; i++) {
      float n = CBCircleChartAGELVLTArrayValues[i];

      if (n == 0) CBCircleChartAGELVLT.toggle(i);
    }

    for (int i=0; i<circleChartRelationships.CBCircleChartWORKSCHTCurrentValues.length; i++) {
      float n = CBCircleChartWORKSCHTArrayValues[i];

      if (n == 0) CBCircleChartWORKSCHT.toggle(i);
    }

    for (int i=0; i<circleChartRelationships.CBCircleChartSALLVLTCurrentValues.length; i++) {
      float n = CBCircleChartSALLVLTArrayValues[i];

      if (n == 0) CBCircleChartSALLVLT.toggle(i);
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

public void constructAll() {

  SEPcheckbox = new SEPCheckBox(width/56, height/6, width/14, height/18);
  SEPcheckbox.Construct();

  LOADbutton = new LOADButton(width-(width/11.2f), height/36, width/14, height/18);
  LOADbutton.Construct();

  QTRslider = new QTRSlider(width/3, height/1.07f);
  QTRslider.Construct();

  barChartAvgOverUnder = new BarChartAvgOverUnder(width/5.76f, height/1.8f, width/3, height/3);
  //barChartAvgOverUnder.Construct();

  circleChartRelationships = new CircleChartRelationships(width/1.7f, height/1.8f, width/3, height/3);
  //circleChartRelationships.Construct();

  blsRingChart = new BLSRingChart(width/2.65f, height/8, width/3, height/3);
  //blsRingChart.Construct();
}

public void displayLoadSplashScreen() {
  fill(255);
  agency = loadFont("AgencyFB-Reg-48.vlw");
  textFont(agency, width/30);
  textAlign(CENTER, CENTER);
  text("PLEASE WAIT WHILE DATA LOADS...", width/2, height/2);
}

public void loadData() {
  LOADbutton.Action();
}
Toggle ZoomBLS;

class BLSRingChart extends Frame {

  Table BLS;
  float scaleL = 300;
  float scaleR = 11;
  float totSepL;
  float joL;
  float loL;
  float qL;
  float oSepL;
  float totSepR;
  float joR;
  float loR;
  float qR;
  float oSepR;

  BLSRingChart() {
  }

  BLSRingChart(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
    ZoomBLS = cp5.addToggle("ZoomBLS")
      .setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .setSize(width/55, height/60)
      .setValue(false)
      .setMode(ControlP5.SWITCH)
      .hide()
      ;
  }

  public void Construct() {
    ZoomBLS.setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .show();
    drawFrame();
    drawTitle("BLS Relationships - Levels and Rates");

    TableRow row = BLS.getRow(0);
    boolean level = true;
    boolean rate = false;

    // Outside to Inside order:
    // radOSep, radQ, radLo, radTotSep, radJo, base
    float baseX        =  frameWidth/50;
    float baseY        =  frameHeight/50;
    float radXJoL      =  baseX + (frameWidth * row.getFloat("BLS_FEDERAL_JobOpenings_Level")/scaleL);
    float radXTotSepL  =  radXJoL + (frameWidth * row.getFloat("BLS_FEDERAL_TotalSep_Level")/scaleL);
    float radXLoL      =  radXTotSepL + (frameWidth * row.getFloat("BLS_FEDERAL_Layoffs_Level")/scaleL);
    float radXQL       =  radXLoL + (frameWidth * row.getFloat("BLS_FEDERAL_Quits_Level")/scaleL);
    float radXOSepL    =  radXQL + (frameWidth * row.getFloat("BLS_FEDERAL_OtherSep_Level")/scaleL);
    float radYJoL      =  baseY + (frameHeight * row.getFloat("BLS_FEDERAL_JobOpenings_Level")/scaleL);
    float radYTotSepL  =  radYJoL + (frameHeight * row.getFloat("BLS_FEDERAL_TotalSep_Level")/scaleL);
    float radYLoL      =  radYTotSepL + (frameHeight * row.getFloat("BLS_FEDERAL_Layoffs_Level")/scaleL);
    float radYQL       =  radYLoL + (frameHeight * row.getFloat("BLS_FEDERAL_Quits_Level")/scaleL);
    float radYOSepL    =  radYQL + (frameHeight * row.getFloat("BLS_FEDERAL_OtherSep_Level")/scaleL);
    float radXJoR      =  baseX + (frameWidth * row.getFloat("BLS_FEDERAL_JobOpenings_Rate")/scaleR);
    float radXTotSepR  =  radXJoR + (frameWidth * row.getFloat("BLS_FEDERAL_TotalSep_Rate")/scaleR);
    float radXLoR      =  radXTotSepR + (frameWidth * row.getFloat("BLS_FEDERAL_Layoffs_Rate")/scaleR);
    float radXQR       =  radXLoR + (frameWidth * row.getFloat("BLS_FEDERAL_Quits_Rate")/scaleR);
    float radXOSepR    =  radXQR + (frameWidth * row.getFloat("BLS_FEDERAL_OtherSep_Rate")/scaleR);
    float radYJoR      =  baseY + (frameHeight * row.getFloat("BLS_FEDERAL_JobOpenings_Rate")/scaleR);
    float radYTotSepR  =  radYJoR + (frameHeight * row.getFloat("BLS_FEDERAL_TotalSep_Rate")/scaleR);
    float radYLoR      =  radYTotSepR + (frameHeight * row.getFloat("BLS_FEDERAL_Layoffs_Rate")/scaleR);
    float radYQR       =  radYLoR + (frameHeight * row.getFloat("BLS_FEDERAL_Quits_Rate")/scaleR);
    float radYOSepR    =  radYQR + (frameHeight * row.getFloat("BLS_FEDERAL_OtherSep_Rate")/scaleR);


    if (frameWidth < frameHeight) {
      drawRings(0.75f, 0.45f, radXOSepR, radXQR, radXLoR, radXTotSepR, radXJoR, baseX, rate);
      drawRings(0.25f, 0.667f, radXOSepL, radXQL, radXLoL, radXTotSepL, radXJoL, baseX, level);
    } else {
      drawRings(0.75f, 0.45f, radYOSepR, radYQR, radYLoR, radYTotSepR, radYJoR, baseY, rate);
      drawRings(0.25f, 0.667f, radYOSepL, radYQL, radYLoL, radYTotSepL, radYJoL, baseY, level);
    }
  }

  public void loadChartData() {
    BLS = loadTable("AvgBLS.csv", "header");

    for (TableRow row : BLS.rows()) {
      this.totSepL  =  row.getFloat("BLS_FEDERAL_TotalSep_Level");
      this.joL      =  row.getFloat("BLS_FEDERAL_JobOpenings_Level");
      this.loL      =  row.getFloat("BLS_FEDERAL_Layoffs_Level");
      this.qL       =  row.getFloat("BLS_FEDERAL_Quits_Level");
      this.oSepL    =  row.getFloat("BLS_FEDERAL_OtherSep_Level");

      this.totSepR  =  row.getFloat("BLS_FEDERAL_TotalSep_Rate");
      this.joR      =  row.getFloat("BLS_FEDERAL_JobOpenings_Rate");
      this.loR      =  row.getFloat("BLS_FEDERAL_Layoffs_Rate");
      this.qR       =  row.getFloat("BLS_FEDERAL_Quits_Rate");
      this.oSepR    =  row.getFloat("BLS_FEDERAL_OtherSep_Rate");

      println("BLSRingChart Data = " + totSepL + ", " + 
        joL + ", " + loL + ", " + qL + ", " + oSepL + 
        ", " + totSepR + ", " + joR + ", " + loR + ", " + 
        qR + ", " + oSepR);
    }
  }

  public void drawRings(float fracX, float fracY, 
    float radOSep, float radQ, 
    float radLo, float radTotSep, 
    float radJo, float base, boolean ver) {
    pushMatrix();

    translate(x + frameWidth*fracX, y + frameHeight*fracY);
    fill(colorCycle[0]);
    stroke(colorCycle[0]);
    ellipse(0, 0, radOSep, radOSep);

    fill(colorCycle[1]);
    stroke(colorCycle[1]);
    ellipse(0, 0, radQ, radQ);

    fill(colorCycle[2]);
    stroke(colorCycle[2]);
    ellipse(0, 0, radLo, radLo);

    fill(colorCycle[3]);
    stroke(colorCycle[3]);
    ellipse(0, 0, radTotSep, radTotSep);

    fill(colorCycle[4]);
    stroke(colorCycle[4]);
    ellipse(0, 0, radJo, radJo);

    fill(75);
    stroke(75);
    ellipse(0, 0, base, base);

    popMatrix();

    displayValue(fracX, fracY, radOSep, radQ, radLo, radTotSep, radJo, base, ver);
  }

  public void displayValue(float fracX, float fracY, 
    float radOSep, float radQ, 
    float radLo, float radTotSep, 
    float radJo, float base, boolean ver) {

    textFont(agency, 24);
    fill(255);
    textAlign(LEFT, BOTTOM);
    if (mouseX > x + frameWidth*fracX - base/2 & mouseX < x + frameWidth*fracX + base/2 & mouseY > y + frameHeight*fracY - base/2 & mouseY < y + frameHeight*fracY + base/2) {
      println("Mouse over base ring");
    } else if (mouseX > x + frameWidth*fracX - radJo/2 & mouseX < x + frameWidth*fracX + radJo/2 & mouseY > y + frameHeight*fracY - radJo/2 & mouseY < y + frameHeight*fracY + radJo/2) {
      if (ver == true) text("Job Openings\nLevel = " + joL, mouseX, mouseY);
      else text("Job Openings\nRate = " + joR, mouseX, mouseY);
    } else if (mouseX > x + frameWidth*fracX - radTotSep/2 & mouseX < x + frameWidth*fracX + radTotSep/2 & mouseY > y + frameHeight*fracY - radTotSep/2 & mouseY < y + frameHeight*fracY + radTotSep/2) {
      if (ver == true) text("Total Separation\nLevel = " + totSepL, mouseX, mouseY);
      else text("Total Separation\nRate = " + totSepR, mouseX, mouseY);
    } else if (mouseX > x + frameWidth*fracX - radLo/2 & mouseX < x + frameWidth*fracX + radLo/2 & mouseY > y + frameHeight*fracY - radLo/2 & mouseY < y + frameHeight*fracY + radLo/2) {
      if (ver == true) text("Layoffs\nLevel = " + loL, mouseX, mouseY);
      else text("Layoffs\nRate = " + loR, mouseX, mouseY);
    } else if (mouseX > x + frameWidth*fracX - radQ/2 & mouseX < x + frameWidth*fracX + radQ/2 & mouseY > y + frameHeight*fracY - radQ/2 & mouseY < y + frameHeight*fracY + radQ/2) {
      if (ver == true) text("Quits\nLevel = " + qL, mouseX, mouseY);
      else text("Quits\nRate = " + qR, mouseX, mouseY);
    } else if (mouseX > x + frameWidth*fracX - radOSep/2 & mouseX < x + frameWidth*fracX + radOSep/2 & mouseY > y + frameHeight*fracY - radOSep/2 & mouseY < y + frameHeight*fracY + radOSep/2) {
      if (ver == true) text("Other Separation\nLevel = " + oSepL, mouseX, mouseY);
      else text("Other Separation\nRate = " + oSepR, mouseX, mouseY);
    }
  }
}
// Gradient background class

class Background {

  int y_axis = 1;
  int x_axis = 2;
  int c1, c2;
  float x, y;
  float backgroundW, backgroundH;
  
  Background() {
  }

  Background(float x, float y, float backgroundW, float backgroundH, int c1, int c2) {
    this.x = x;
    this.y = y;
    this.backgroundW = backgroundW;
    this.backgroundH = backgroundH;
    this.c1 = c1;
    this.c2 = c2;
  }  

  public void drawBackground() {
    pushMatrix();
    setGradient(x, y, width, height, c1, c2, y_axis);
    popMatrix();
  }
  
  public void setGradient(float x, float y, float w, float h, int c1, int c2, int axis ) {

    noFill();
  
    if (axis == y_axis) {  // Top to bottom gradient
      for (float i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        int c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == x_axis) {  // Left to right gradient
      for (float i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        int c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}
Knob displayCountKnob;
Toggle ZoomBar;

class BarChartAvgOverUnder extends Frame {

  Table Data;
  String[] OCCFAMT = {};  
  float[] AvgSalOverUnder = {};
  int totalCount;
  int displayCount = 15;
  float maxDataVal = 0;


  BarChartAvgOverUnder() {
  }

  BarChartAvgOverUnder(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
    
    displayCountKnob = cp5.addKnob("Num of Bars")
      .setPosition(x+frameWidth-frameWidth/7, y+frameHeight-frameHeight/5)
      .setRadius(this.frameWidth/25)
      .setDragDirection(Knob.HORIZONTAL)
      .setViewStyle(Knob.ARC)
      .hide()
      ;

    ZoomBar = cp5.addToggle("ZoomBar")
      .setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .setSize(PApplet.parseInt(frameWidth/18), PApplet.parseInt(frameHeight/20))
      .setValue(false)
      .setMode(ControlP5.SWITCH)
      .hide()
      ;
  }

  public void Construct() {
    ZoomBar.setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .show();
    float xOffset;
    float yOffset;
    float xBarPad = this.frameWidth/75;
    float barWidth;
    float maxBarHeight;
    int colorPosition = 0;

    drawFrame();
    drawTitle("Avg. Sal. Over/Under Ind. by OCCFAMT");
    pushMatrix();
    noFill();
    strokeWeight(width/400);
    translate(x, y);

    if (this.frameWidth/19.33f>25) xOffset = 25;
    else xOffset = this.frameWidth/19.33f;

    yOffset = (this.frameWidth/10);

    barWidth = ((this.frameWidth - (3*xOffset)) - (displayCount * xBarPad))/displayCount;
    maxBarHeight = this.frameHeight/2 - yOffset;

    //vertical Line
    line(xOffset*2, yOffset, xOffset*2, this.frameHeight - yOffset);

    //Horizontal Line
    line(xOffset*2, this.frameHeight/2, this.frameWidth - xOffset, frameHeight/2);

    strokeWeight(width/700);

    textFont(VISfont, width/110);
    textAlign(RIGHT);

    //ticks
    for (int i=-4; i<5; i++) {
      line(xOffset*2 - width/144, this.frameHeight/2 + (i * maxBarHeight/4), 
        xOffset*2 - width/288, this.frameHeight/2 + (i * maxBarHeight/4));
      text(round(maxDataVal/4*i), xOffset*2 - width/275, this.frameHeight/2 - (i * maxBarHeight/4) - width/600);
    }

    noStroke();

    //Bars
    for (int i = 0; i<this.displayCount; i++) {
      float rectX = xOffset*2 + (xBarPad*(i+1)) + (barWidth*i);
      float rectY = this.frameHeight/2;
      float rectHeight;

      if (colorPosition>colorCycle.length-1) colorPosition = 0;

      fill(colorCycle[colorPosition]);
      if (AvgSalOverUnder[i]>=0) {
        rectHeight = -map(AvgSalOverUnder[i], 0, maxDataVal, 0, maxBarHeight);  
        rect(rectX, rectY, barWidth, rectHeight);
      }
      if (AvgSalOverUnder[i]<0) {
        rectHeight = map(AvgSalOverUnder[i], 0, -maxDataVal, 0, maxBarHeight);
        rect(rectX, rectY, barWidth, rectHeight);
      }
      colorPosition++;
    }

    for (int i = 0; i<this.displayCount; i++) {
      float rectX = xOffset*2 + (xBarPad*(i+1)) + (barWidth*i);
      float rectY = this.frameHeight/2;
      float rectHeight;

      if (AvgSalOverUnder[i]>=0) {
        rectHeight = -map(AvgSalOverUnder[i], 0, maxDataVal, 0, maxBarHeight);  
        displayValue(rectX, rectY, barWidth, rectHeight, OCCFAMT[i], AvgSalOverUnder[i]);
      }
      if (AvgSalOverUnder[i]<0) {
        rectHeight = map(AvgSalOverUnder[i], 0, -maxDataVal, 0, maxBarHeight);
        displayValue(rectX, rectY, barWidth, rectHeight, OCCFAMT[i], AvgSalOverUnder[i]);
      }
    }


    displayCountKnob.setValue(round(displayCountKnob.getValue()))
      .setPosition(x+frameWidth-frameWidth/7, y+frameHeight-frameHeight/5)
      .setSize(PApplet.parseInt(frameWidth/18), PApplet.parseInt(frameHeight/20))
      .show()
      ;

    popMatrix();
  }

  public void displayValue(float rectX, float rectY, float barWidth, float rectHeight, String OCCFAMT, float AvgSalOverUnder) {
    textFont(agency, 24);
    fill(255);
    textAlign(LEFT, BOTTOM);
    if (AvgSalOverUnder>=0) {
      if ((mouseX-x >= rectX) & (mouseX-x<= rectX + barWidth)     & 
        (mouseY-y <= rectY) & (mouseY-y >= rectY + rectHeight)
        ) {
        text(OCCFAMT + "\n" + AvgSalOverUnder, mouseX-x, mouseY-y);
      }
    }
    if (AvgSalOverUnder<0) {
      if ((mouseX-x >= rectX) & (mouseX-x<= rectX + barWidth)     & 
        (mouseY-y >= rectY) & (mouseY-y <= rectY + rectHeight)
        ) {
        text(OCCFAMT + "\n" + AvgSalOverUnder, mouseX-x, mouseY-y);
      }
    }
  }

  public void loadChartData() {
    OCCFAMT = new String[0];  
    AvgSalOverUnder = new float[0];
    maxDataVal = 0;
    Data = loadTable("AvgSalOverUnderByOCCFAMT.csv", "header");

    print("BarChartAvgOverUnder Data = ");
    for (int i = 0; i < Data.getRowCount(); i++) {
      TableRow row = Data.getRow(i);
      if (row.getString("OCCFAMT")!= "NO OCCUPATION FAMILY REPORTED") {
        OCCFAMT = append(OCCFAMT, row.getString("OCCFAMT"));
        AvgSalOverUnder = append(AvgSalOverUnder, row.getFloat("AvgSalOverUnder"));
        if (abs(maxDataVal)<abs(AvgSalOverUnder[i])) maxDataVal=abs(AvgSalOverUnder[i]);
      }

      if (i < this.displayCount-1) print(AvgSalOverUnder[i] + ", ");
      else if (i == this.displayCount-1) println(AvgSalOverUnder[i]);
    }
    totalCount = Data.getRowCount();

    displayCountKnob.setRange(1, totalCount)
      .setValue(displayCount)
      .setPosition(x+frameWidth-frameWidth/7, y+frameHeight-frameHeight/5)
      ;
  }


  public int getDisplayCount() {
    return this.displayCount;
  }

  public void setDisplayCount(int displayCount) {
    int DC = PApplet.parseInt(round(displayCount));
    this.displayCount = DC;
  }

  public void addDisplayCount() {
    setDisplayCount(getDisplayCount() + 1);
  }

  public void subDisplayCount() {
    setDisplayCount(getDisplayCount() - 1);
  }
}
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

  public abstract void Construct();
  public abstract void Action();
}
Toggle ZoomRel; //<>// //<>// //<>//
Group PATCOGroup;
Group AGELVLTGroup;
Group WORKSCHTGroup;
Group SALLVLTGroup;

CheckBox CBCircleChartPATCO;
CheckBox CBCircleChartAGELVLT;
CheckBox CBCircleChartWORKSCHT;
CheckBox CBCircleChartSALLVLT;

Accordion CATaccordion;

class CircleChartRelationships extends Frame {

  Table circle;
  Table ageMag;
  Table workMag;
  Table sallMag;
  int[] patco = {};
  String[] agelvlT = {};
  String[] workschT = {};
  String[] sallvlT = {};
  int[] cnt = {};
  int[] agelvlTmag = {};
  int[] workschTmag = {};
  int[] sallvlTmag = {};
  int[] patcoUnique = {};
  String[] agelvlTUnique = {};
  String[] workschTUnique = {};
  String[] sallvlTUnique = {};
  int[] agelvlTmagUnique = {};
  int[] workschTmagUnique = {};
  int[] sallvlTmagUnique = {};
  float[] CBCircleChartPATCOCurrentValues = new float[7];
  float[] CBCircleChartAGELVLTCurrentValues = new float[12];
  float[] CBCircleChartWORKSCHTCurrentValues = new float[10];
  float[] CBCircleChartSALLVLTCurrentValues = new float[19];

  CircleChartRelationships() {
  }

  CircleChartRelationships(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);

    ZoomRel = cp5.addToggle("ZoomRel")
      .setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .setSize(width/55, height/60)
      .setValue(false)
      .setMode(ControlP5.SWITCH)
      .hide()
      ;


    PATCOGroup = cp5.addGroup("PATCOGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(75)
      ;

    CBCircleChartPATCO = cp5.addCheckBox("CBCircleChartPATCO")
      .setSize(PApplet.parseInt(frameWidth/35), PApplet.parseInt(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("1,Professional", 0) // Don't need the numerical assignment, so setting to zero
      .addItem("2,Administrative", 0)
      .addItem("3,Technical", 0)
      .addItem("4,Clerical", 0)
      .addItem("5,Other White Collar", 0)
      .addItem("6,Blue Collar", 0)
      .addItem("9,Unspecified", 0)
      .activateAll()
      .moveTo(PATCOGroup)
      ;

    this.CBCircleChartPATCOCurrentValues = CBCircleChartPATCO.getArrayValue();

    AGELVLTGroup = cp5.addGroup("AGELVLTGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(140)
      ;

    CBCircleChartAGELVLT = cp5.addCheckBox("CBCircleChartAGELVLT")
      .setSize(PApplet.parseInt(frameWidth/35), PApplet.parseInt(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("55-59", 0)
      .addItem("60-64", 0)
      .addItem("30-34", 0)
      .addItem("25-29", 0)
      .addItem("50-54", 0)
      .addItem("35-39", 0)
      .addItem("65 or more", 0)
      .addItem("45-49", 0)
      .addItem("40-44", 0)
      .addItem("20-24", 0)
      .addItem("Less than 20", 0)
      .addItem("Unspecified", 0)
      .activateAll()
      .moveTo(AGELVLTGroup)
      ;

    this.CBCircleChartAGELVLTCurrentValues = CBCircleChartAGELVLT.getArrayValue();

    WORKSCHTGroup = cp5.addGroup("WORKSCHTGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(120)
      ;

    CBCircleChartWORKSCHT = cp5.addCheckBox("CBCircleChartWORKSCHT")
      .setSize(PApplet.parseInt(frameWidth/35), PApplet.parseInt(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("Full-time Nonseasonal", 0)
      .addItem("Intermittent Nonseasonal", 0)
      .addItem("Part-time Nonseasonal", 0)
      .addItem("Full-time Seasonal", 0)
      .addItem("Intermittent Seasonal", 0)
      .addItem("Part-time Seasonal", 0)
      .addItem("Part-time Job Sharer Nonseasonal", 0)
      .addItem("NO WORK SCHEDULE REPORTED", 0)
      .addItem("Part-time Job Sharer Seasonal", 0)
      .addItem("Full-time Nonseasonal Baylor Plan", 0)
      .activateAll()
      .moveTo(WORKSCHTGroup)
      ;

    this.CBCircleChartWORKSCHTCurrentValues = CBCircleChartWORKSCHT.getArrayValue();

    SALLVLTGroup = cp5.addGroup("SALLVLTGroup")
      .setBackgroundColor(color(0, 64))
      .setBackgroundHeight(250)
      ;

    CBCircleChartSALLVLT = cp5.addCheckBox("CBCircleChartSALLVLT")
      .setSize(PApplet.parseInt(frameWidth/35), PApplet.parseInt(frameHeight/40))
      .setPosition(10, 0)
      .setItemsPerRow(1)
      .setSpacingRow(height/200)
      .addItem("$30,000 - $39,999", 0)
      .addItem("$40,000 - $49,999", 0)
      .addItem("$20,000 - $29,999", 0)
      .addItem("$50,000 - $59,999", 0)
      .addItem("$60,000 - $69,999", 0)
      .addItem("$70,000 - $79,999", 0)
      .addItem("$90,000 - $99,999", 0)
      .addItem("$80,000 - $89,999", 0)
      .addItem("$100,000 - $109,999", 0)
      .addItem("$110,000 - $119,999", 0)
      .addItem("$120,000 - $129,999", 0)
      .addItem("$130,000 - $139,999", 0)
      .addItem("$150,000 - $159,999", 0)
      .addItem("$180,000 or more", 0)
      .addItem("$140,000 - $149,999", 0)
      .addItem("Less than $20,000", 0)
      .addItem("$160,000 - $169,999", 0)
      .addItem("Unspecified or Zero", 0)
      .addItem("$170,000 - $179,999", 0)
      .activateAll()
      .moveTo(SALLVLTGroup)
      ;

    this.CBCircleChartSALLVLTCurrentValues = CBCircleChartSALLVLT.getArrayValue();

    CATaccordion = cp5.addAccordion("CATaccordion")
      .setPosition(x + frameWidth/30, y+height/25)
      .setWidth(PApplet.parseInt(frameWidth/3.85f))
      .addItem(PATCOGroup)
      .addItem(AGELVLTGroup)
      .addItem(WORKSCHTGroup)
      .addItem(SALLVLTGroup)
      .hide()
      ;
  }

  public void Construct() {
    ZoomRel.setPosition(x + frameWidth - frameWidth/17, y-height/30)
      .show();

    CATaccordion.setPosition(x + frameWidth/30, y+height/25)
      .setWidth(PApplet.parseInt(frameWidth/3.85f))
      .show();

    //TableRow row = circle.getRow(0);
    float radius;
    int alignmentX;

    drawFrame();
    drawTitle("Key Attribute Relationships");

    pushMatrix();

    // Draw circle (center set as reference)
    translate(x + frameWidth/2, y + frameHeight/1.85f);

    noFill();
    stroke(255);
    if (frameWidth < frameHeight) radius = frameWidth*0.8f;
    else radius = frameHeight*0.6f;
    ellipse(0, 0, radius, radius);

    // Determine attribute level coordinates and draw magnitude colors
    strokeWeight(getFrameWidth()/200);
    textSize(getFrameHeight()/50);

    alignmentX = 0;
    for (int i = 0; i < agelvlTUnique.length; i++) {
      int k = 30 + i*5;
      //if (agelvlTmag.length > 0) {
      try {
        stroke(255, 0, 0, map(agelvlTmagUnique[i], min(agelvlTmag), max(agelvlTmag), 50, 255));
      } catch (ArrayIndexOutOfBoundsException e) {
        stroke(255, 0, 0);
      }
      point(cos(radians(k))*(radius/1.95f), sin(radians(k))*radius/1.95f);
      drawLabels(agelvlTUnique, i, k, 0, radius, alignmentX);
    }

    alignmentX = 39;
    for (int i = 0; i < workschTUnique.length; i++) {
      int k = 150 + i*5;
      try {
        stroke(255, 255, 0, map(workschTmagUnique[i], min(workschTmagUnique), max(workschTmagUnique), 50, 255));
      } catch (ArrayIndexOutOfBoundsException e) {
        stroke(255, 255, 0);
      }
      point(cos(radians(k))*(radius/1.95f), sin(radians(k))*radius/1.95f);
      drawLabels(workschTUnique, i, k, 180, radius, alignmentX);
    }

    alignmentX = 0;
    for (int i = 0; i < sallvlTUnique.length; i++) {
      int k = 240 + i*5;
      try {
        stroke(0, 255, 255, map(sallvlTmagUnique[i], min(sallvlTmag), max(sallvlTmag), 50, 255));
      } catch (ArrayIndexOutOfBoundsException e) {
        stroke(0, 255, 255);
      }
      point(cos(radians(k))*(radius/1.95f), sin(radians(k))*radius/1.95f);
      drawLabels(sallvlTUnique, i, k, 0, radius, alignmentX);
    }

    // Observation triangles
    for (int i=0; i < patco.length; i++) {
      switch(patco[i]) {
      case 1:
        //println("patco 1");
        stroke(colorCycle[0]);
        break;
      case 2:
        //println("patco 2");
        stroke(colorCycle[1]);
        break;
      case 3:
        //println("patco 3");
        stroke(colorCycle[2]);
        break;
      case 4:
        //println("patco 4");
        stroke(colorCycle[3]);
        break;
      case 5:
        //println("patco 5");
        stroke(colorCycle[4]);
        break;
      case 6:
        //println("patco 6");
        stroke(colorCycle[5]);
        break;
      case 9:
        //println("patco 9");
        stroke(colorCycle[6]);
        break;
      }
      strokeWeight(map(cnt[i], 1, 3480, getFrameWidth()/2000, getFrameWidth()/100));
      beginShape();
      //println(agelvlT[i]);
      for (int j=0; j < agelvlTUnique.length; j++) {
        if (agelvlT[i].equals(agelvlTUnique[j])) {
          //print(agelvlT[i] + " " + agelvlTUnique[j]);
          //println("");
          vertex(cos(radians(30 + j*5))*(radius/2.1f), sin(radians(30 + j*5))*radius/2.1f);
        }
      }
      for (int j=0; j < workschTUnique.length; j++) {
        if (workschT[i].equals(workschTUnique[j])) {
          //print(workschT[i] + " " + workschT[j]);
          //println("");
          vertex(cos(radians(150 + j*5))*(radius/2.1f), sin(radians(150 + j*5))*radius/2.1f);
        }
      }
      for (int j=0; j < sallvlTUnique.length; j++) {
        if (sallvlT[i].equals(sallvlTUnique[j])) {
          //print(sallvlTUnique[i] + " " + sallvlTUnique[j]);
          //println("");
          vertex(cos(radians(240 + j*5))*(radius/2.1f), sin(radians(240 + j*5))*radius/2.1f);
        }
      }
      endShape(CLOSE);
    }
    strokeWeight(1);

    popMatrix();
  }

  public void loadChartData() {
    patco             = new int[0];
    agelvlT           = new String[0];
    workschT          = new String[0];
    sallvlT           = new String[0];
    cnt               = new int[0];
    agelvlTmag        = new int[0];
    workschTmag       = new int[0];
    sallvlTmag        = new int[0];
    agelvlTUnique     = new String[0];
    agelvlTmagUnique  = new int[0];
    workschTUnique    = new String[0];
    workschTmagUnique = new int[0];
    sallvlTUnique     = new String[0];
    sallvlTmagUnique  = new int[0];
    circle            = loadTable("DistinctPATCO_AGELVL_WORKSCH_SALLVL_FINAL.csv", "header");
    ageMag            = loadTable("AGELVLTMagnitude.csv", "header");
    workMag           = loadTable("WORKSCHTMagnitude.csv", "header");
    sallMag           = loadTable("SALLVLTMagnitude.csv", "header");

    if (circle.getRowCount() > 0) {
      for (TableRow row : circle.rows()) {
        this.patco        =  append(patco, row.getInt("PATCO"));
        this.agelvlT      =  append(agelvlT, row.getString("AGELVLT"));
        this.workschT     =  append(workschT, row.getString("WORKSCHT"));
        this.sallvlT      =  append(sallvlT, row.getString("SALLVLT"));
        this.cnt          =  append(cnt, row.getInt("CNT"));
        this.agelvlTmag   =  append(agelvlTmag, row.getInt("AGELVLTMagnitude"));
        this.workschTmag  =  append(workschTmag, row.getInt("WORKSCHTMagnitude"));
        this.sallvlTmag   =  append(sallvlTmag, row.getInt("SALLVLTMagnitude"));
      }
    }
    //for (int i = 0; i < 10; i++) {
    //  println("CircleChart Line " + i + " = " + patco[i] + ", " + 
    //    agelvlT[i] + ", " + workschT[i] + ", " + sallvlT[i] + ", " + cnt[i] + 
    //    ", " + agelvlTmag[i] + ", " + workschTmag[i] + ", " + sallvlTmag[i]);
    //}

    for (TableRow row : ageMag.rows()) {
      this.agelvlTUnique      =  append(agelvlTUnique, row.getString("AGELVLT"));
      this.agelvlTmagUnique   =  append(agelvlTmagUnique, row.getInt("AGELVLTMagnitude"));
    }

    for (TableRow row : workMag.rows()) {
      this.workschTUnique      =  append(workschTUnique, row.getString("WORKSCHT"));
      this.workschTmagUnique   =  append(workschTmagUnique, row.getInt("WORKSCHTMagnitude"));
    }

    for (int i = 0; i < workschTUnique.length; i++) {
      println(workschTUnique[i] + " " + workschTmagUnique[i]);
    }

    for (TableRow row : sallMag.rows()) {
      this.sallvlTUnique      =  append(sallvlTUnique, row.getString("SALLVLT"));
      this.sallvlTmagUnique   =  append(sallvlTmagUnique, row.getInt("SALLVLTMagnitude"));
    }
  }

  public void drawLabels(String array[], int i, int k, int rot2, float radius, int alignmentX) {
    pushMatrix();
    translate(cos(radians(k))*(radius/1.9f), sin(radians(k))*radius/1.9f);
    pushMatrix();
    rotate(radians(k + rot2));
    textAlign(alignmentX, CENTER);
    text(array[i], 0, 0);
    popMatrix();
    popMatrix();
  }

  public void cbPATCOAction() {
    print("got an event from "+CBCircleChartPATCO.getName()+"\t: ");
    for (int i=0; i<CBCircleChartPATCO.getArrayValue().length; i++) {
      int n = (int)CBCircleChartPATCO.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartPATCOCurrentValues[i];

      if (n != nCurrent) {
        print("n" + n + "nCurrent" + nCurrent + "i" + i);
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;

        switch(i) {
        case 0: 
          catValue = "1";
          break;
        case 1: 
          catValue = "2";
          break;
        case 2: 
          catValue = "3";
          break;
        case 3: 
          catValue = "4";
          break;
        case 4: 
          catValue = "5";
          break;
        case 5: 
          catValue = "6";
          break;
        case 6: 
          catValue = "9";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "PATCO", "\"" + catValue + "\"");
        execPython.Exec(n, "PATCO", "\"" + catValue + "\"");
        loadChartData();
      }
    }

    this.CBCircleChartPATCOCurrentValues = CBCircleChartPATCO.getArrayValue();
  }

  public void cbAGELVLTAction() {
    print("got an event from "+CBCircleChartAGELVLT.getName()+"\t: ");
    for (int i=0; i<CBCircleChartAGELVLT.getArrayValue().length; i++) {
      int n = (int)CBCircleChartAGELVLT.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartAGELVLTCurrentValues[i];

      if (n != nCurrent) {
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;

        switch(i) {
        case 0:  
          catValue = "55-59";
          break;
        case 1:  
          catValue = "60-64";
          break;
        case 2:  
          catValue = "30-34";
          break;
        case 3:  
          catValue = "25-29";
          break;
        case 4:  
          catValue = "50-54";
          break;
        case 5:  
          catValue = "35-39";
          break;
        case 6:  
          catValue = "65 or more";
          break;
        case 7:  
          catValue = "45-49";
          break;
        case 8:  
          catValue = "40-44";
          break;
        case 9:  
          catValue = "20-24";
          break;
        case 10: 
          catValue = "Less than 20";
          break;
        case 11: 
          catValue = "Unspecified";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "AGELVLT", "\"" + catValue + "\"");
        execPython.Exec(n, "AGELVLT", "\"" + catValue + "\"");
        loadChartData();
      }
    }


    this.CBCircleChartAGELVLTCurrentValues = CBCircleChartAGELVLT.getArrayValue();
  }

  public void cbWORKSCHTAction() {
    print("got an event from "+CBCircleChartWORKSCHT.getName()+"\t: ");
    for (int i=0; i<CBCircleChartWORKSCHT.getArrayValue().length; i++) {
      int n = (int)CBCircleChartWORKSCHT.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartWORKSCHTCurrentValues[i];

      if (n != nCurrent) {
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;
        println("switch:", i);
        switch(i) {
        case 0:  
          catValue = "Full-time Nonseasonal";
          break;
        case 1:  
          catValue = "Intermittent Nonseasonal";
          break;
        case 2:  
          catValue = "Part-time Nonseasonal";
          break;
        case 3:  
          catValue = "Full-time Seasonal";
          break;
        case 4:  
          catValue = "Intermittent Seasonal";
          break;
        case 5:  
          catValue = "Part-time Seasonal";
          break;
        case 6:  
          catValue = "Part-time Job Sharer Nonseasonal";
          break;
        case 7:  
          catValue = "NO WORK SCHEDULE REPORTED";
          break;
        case 8:  
          catValue = "Part-time Job Sharer Seasonal";
          break;
        case 9:  
          catValue = "Full-time Nonseasonal Baylor Plan";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "WORKSCHT", "\"" + catValue + "\"");
        execPython.Exec(n, "WORKSCHT", "\"" + catValue + "\"");
        loadChartData();
      }
    }  

    this.CBCircleChartWORKSCHTCurrentValues = CBCircleChartWORKSCHT.getArrayValue();
  }

  public void cbSALLVLTAction() {
    print("got an event from "+CBCircleChartSALLVLT.getName()+"\t: ");
    for (int i=0; i<CBCircleChartSALLVLT.getArrayValue().length; i++) {
      int n = (int)CBCircleChartSALLVLT.getArrayValue()[i];
      int nCurrent = (int)this.CBCircleChartSALLVLTCurrentValues[i];

      if (n != nCurrent) {
        println("Value Mismatch at Item Number - ", i);
        String catValue = null;

        switch(i) {
        case 0:   
          catValue = "$30,000 - $39,999";
          break;
        case 1:   
          catValue = "$40,000 - $49,999";
          break;
        case 2:   
          catValue = "$20,000 - $29,999";
          break;
        case 3:   
          catValue = "$50,000 - $59,999";
          break;
        case 4:   
          catValue = "$60,000 - $69,999";
          break;
        case 5:   
          catValue = "$70,000 - $79,999";
          break;
        case 6:   
          catValue = "$90,000 - $99,999";
          break;
        case 7:   
          catValue = "$80,000 - $89,999";
          break;
        case 8:   
          catValue = "$100,000 - $109,999";
          break;
        case 9:   
          catValue = "$110,000 - $119,999";
          break;
        case 10:  
          catValue = "$120,000 - $129,999";
          break;
        case 11:  
          catValue = "$130,000 - $139,999";
          break;
        case 12:  
          catValue = "$150,000 - $159,999";
          break;
        case 13:  
          catValue = "$180,000 or more";
          break;
        case 14:  
          catValue = "$140,000 - $149,999";
          break;
        case 15:  
          catValue = "Less than $20,000";
          break;
        case 16:  
          catValue = "$160,000 - $169,999";
          break;
        case 17:  
          catValue = "Unspecified or Zero";
          break;
        case 18:  
          catValue = "$170,000 - $179,999";
          break;
        }
        println("Loading Key Attribute Relationship Data for: ", n, "SALLVLT", "\"" + catValue + "\"");
        execPython.Exec(n, "SALLVLT", "\"" + catValue + "\"");
        loadChartData();
      }
    }  

    this.CBCircleChartSALLVLTCurrentValues = CBCircleChartSALLVLT.getArrayValue();
  }
}
/**********************************************************
 Class used to Execute Python Script
 ***********************************************************/


Command cmd;

class ExecPython { 

  private final String APP  = "python ";
  private String FILE;
  private final String dataPath = "cd /D \""+dataPath("")+ "\"";
  private final String PythonFilesPath = sketchPath()+"\\PythonFiles\\";

  ExecPython() {
  }

  public void Exec(int startQTR, int endQTR, String SEP_NS, String SEP_SA, String SEP_SC, 
    String SEP_SD, String SEP_SH, String SEP_SI, String SEP_SJ) {

    FILE = "parseData.py";  

    cmd = new Command("cmd.exe /c " + dataPath + " && " + APP + "\"" + PythonFilesPath + FILE + "\"" 
      + " " +startQTR + " " + endQTR + " " + SEP_NS + " " + SEP_SA + " " + SEP_SC + " " 
      + SEP_SD + " " + SEP_SH + " " + SEP_SI + " " + SEP_SJ);

    cmd.run();
  }

  public void Exec(int addRemove, String catType, String catValue) {

    FILE = "parseKeyAttributeRelationships.py";

    cmd = new Command("cmd.exe /c " + dataPath + " && " + APP + "\"" + PythonFilesPath + FILE + "\"" 
      + " " +addRemove + " " + catType + " " + catValue);

    cmd.run();
  }
}
//This Class exists to define forced structure for Buttons Subclasses

abstract class Frame {

  float x;
  float y;
  float frameWidth;
  float frameHeight;
  float c = 125;
  int[] colorCycle= {0xff81c784, 0xfffff176, 0xffba68c8, 0xfff06292, 0xff4fc3f7, 0xffff8a65, 0xffb2ebf2, 0xffef5350, 0xffffca28};
  PFont VISfont = loadFont("VISFont.vlw");

  Frame() {
  }

  Frame(float x, float y, float frameWidth, float frameHeight) {
    this.x = x;
    this.y = y;
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
}  

  public void resetFrameDims(float x, float y, float frameWidth, float frameHeight) {
    this.x = x;
    this.y = y;
    this.frameWidth = frameWidth;
    this.frameHeight = frameHeight;
  }

  public void drawFrame() {
    pushMatrix();
    noFill();
    stroke(c);
    strokeWeight(width/300);
    rect(this.x, this.y, this.frameWidth, this.frameHeight);
    popMatrix();
  }

  public void drawTitle(String title) {
    pushMatrix();
    textFont(VISfont, width/58);
    textAlign(CENTER);
    fill(c);

    float yOffset;
    if (this.frameWidth/19.33f>25) yOffset = 25;
    else yOffset = this.frameWidth/19.33f;

    text(title, this.x + this.frameWidth/2, this.y + yOffset);
    popMatrix();
  }

  public abstract void Construct();
  public abstract void loadChartData();

  public float getX() {
    return(x);
  }
  
  public float getY() {
    return(y);
  }
  
  public float getFrameWidth() {
    return frameWidth;
  }
  
  public float getFrameHeight() {
    return frameHeight;
  }
}
Button LOADData;

class LOADButton extends Buttons {
  int buttonWidth;
  int buttonHeight;

  LOADButton() {
    super();
  }

  LOADButton(float x, float y, int buttonWidth, int buttonHeight) {
    super(x, y);
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
  }

  public void Construct() {
    LOADData = cp5.addButton("LOAD DATA")
      .setPosition(this.x, this.y)
      .setSize(this.buttonWidth, this.buttonHeight)
      ;
  }

  public void Action() {
    //loadBG.drawBackground();
    displayCountKnob.hide();
    ZoomBLS.hide();
    ZoomBar.hide();
    ZoomRel.hide();
    CATaccordion.hide();
    
    CBCircleChartPATCO.activateAll();
    CBCircleChartAGELVLT.activateAll();
    CBCircleChartWORKSCHT.activateAll();
    CBCircleChartSALLVLT.activateAll();
    
    print("got an event from "+LOADData.getName()+"\t: ", QTRslider.startQTR, QTRslider.endQTR, SEPcheckbox.SEP_NS, 
      SEPcheckbox.SEP_SA, SEPcheckbox.SEP_SC, SEPcheckbox.SEP_SD, 
      SEPcheckbox.SEP_SH, SEPcheckbox.SEP_SI, SEPcheckbox.SEP_SJ);
    
    execPython.Exec(QTRslider.startQTR, QTRslider.endQTR, SEPcheckbox.SEP_NS, 
      SEPcheckbox.SEP_SA, SEPcheckbox.SEP_SC, SEPcheckbox.SEP_SD, 
      SEPcheckbox.SEP_SH, SEPcheckbox.SEP_SI, SEPcheckbox.SEP_SJ);
    println();

    if((ZoomRel.getValue()!=1) & (ZoomBLS.getValue()!=1))    barChartAvgOverUnder.loadChartData();
    if((ZoomBar.getValue()!=1) & (ZoomBLS.getValue()!=1))    circleChartRelationships.loadChartData();
    if((ZoomRel.getValue()!=1) & (ZoomBar.getValue()!=1))    blsRingChart.loadChartData();
    
    displaySplash = false;

  }
}
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
  public void Construct() {
    QTRSlider = cp5.addRange("Quarter Range")
      .setBroadcast(false) // disable broadcasting since setRange and setRangeValues will trigger an event
      .setPosition(x, y)
      .setSize(width/3, height/22)
      .setHandleSize(20)
      .setRange(1, 4)
      .setRangeValues(1, 4)
      .setBroadcast(true) // after the initialization we turn broadcast back on again
      //.setColorForeground(#193334)
      //.setColorBackground(#151818)  
      ;
  }
  //modify/assign slider attributes based on actions
  //Also Print to console "got an event from "slidername" : startQTR endQTR
  public void Action() {
    QTRSlider.setHighValue(round(QTRSlider.getHighValue()));
    QTRSlider.setLowValue(round(QTRSlider.getLowValue()));
    this.startQTR = round(QTRSlider.getLowValue());
    this.endQTR = round(QTRSlider.getHighValue());

    //defensive code for resetting if values get flipped
    if (this.startQTR>this.endQTR) QTRSlider.setRangeValues(1, 4);

    println("got an event from "+QTRSlider.getName()+"\t: " + startQTR + " " + endQTR);
  }



  public void ticks() {
    pushMatrix();
    translate(x, y + height/22);
    stroke(255);
    strokeWeight(width/700);
    line(width/70, tickHigh, width/70, tickLow);
    line(width/8.6f, tickHigh, width/8.6f, tickLow);
    line(width/4.6f, tickHigh, width/4.6f, tickLow);
    line(width/3.134f, tickHigh, width/3.134f, tickLow);
    noStroke();
    popMatrix();
  }
}
CheckBox SEPCheckBox;

class SEPCheckBox extends Buttons {

  int buttonWidth;
  int buttonHeight;

  String SEP_NS;
  String SEP_SA;
  String SEP_SC;
  String SEP_SD;
  String SEP_SH;
  String SEP_SI;
  String SEP_SJ;

  SEPCheckBox() {
    super();
  }
  SEPCheckBox(float x, float y, int buttonWidth, int buttonHeight) {
    super(x, y);
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;

    this.SEP_NS   = "NS";
    this.SEP_SA   = "SA";
    this.SEP_SC   = "SC";
    this.SEP_SD   = "SD";
    this.SEP_SH   = "SH";
    this.SEP_SI   = "SI";
    this.SEP_SJ   = "SJ";
  }

  public void Construct() {
    SEPCheckBox = cp5.addCheckBox("SEPCheckBox")
      .setPosition(this.x, this.y)
      .setSize(this.buttonWidth, this.buttonHeight)
      .setItemsPerRow(1)
      .setSpacingRow(height/45)
      .addItem("ALL", 0) // Don't need the numerical assignment, so setting to zero
      .addItem("NS", 0)
      .addItem("SA", 0)
      .addItem("SC", 0)
      .addItem("SD", 0)
      .addItem("SH", 0)
      .addItem("SI", 0)
      .addItem("SJ", 0)
      .addItem("CLEAR", 0)
      ;
  }

  public void Action() {    
    if ((int)SEPCheckBox.getArrayValue()[0] == 1) {
      SEPCheckBox.deactivateAll();
      for (int i=1; i<SEPCheckBox.getArrayValue().length-1; i++) {
        SEPCheckBox.toggle(i);
      }
    }

    if ((int)SEPCheckBox.getArrayValue()[SEPCheckBox.getArrayValue().length-1] == 1) {
      SEPCheckBox.deactivateAll();
    }

    print("got an event from "+SEPCheckBox.getName()+"\t: ");
    for (int i=0; i<SEPCheckBox.getArrayValue().length-1; i++) {
      int n = (int)SEPCheckBox.getArrayValue()[i];

      if (i == 1 & n == 1) this.SEP_NS = "NS";
      else if (i == 1) this.SEP_NS = "";

      if (i == 2 & n == 1) this.SEP_SA = "SA";
      else if (i == 2) this.SEP_SA = "";

      if (i == 3 & n == 1) this.SEP_SC = "SC";
      else if (i == 3) this.SEP_SC = "";

      if (i == 4 & n == 1) this.SEP_SD = "SD";
      else if (i == 4) this.SEP_SD = "";

      if (i == 5 & n == 1) this.SEP_SH = "SH";
      else if (i == 5) this.SEP_SH = "";

      if (i == 6 & n == 1) this.SEP_SI = "SI";
      else if (i == 6) this.SEP_SI = "";

      if (i == 7 & n == 1) this.SEP_SJ = "SJ";
      else if (i == 7) this.SEP_SJ = "";

      print(n);
    }
    println();
  }
  
  public float[] getValues(){
    return SEPCheckBox.getArrayValue();
  }
}
  public void settings() {  size(1400, 900); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MidtermProject_Boomhower_Frye" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
