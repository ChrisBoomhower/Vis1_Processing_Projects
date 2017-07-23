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
      .setSize(int(frameWidth/18), int(frameHeight/20))
      .setValue(false)
      .setMode(ControlP5.SWITCH)
      .hide()
      ;
  }

  void Construct() {
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

    if (this.frameWidth/19.33>25) xOffset = 25;
    else xOffset = this.frameWidth/19.33;

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
      if (colorPosition>colorCycle.length-1) colorPosition = 0;

      fill(colorCycle[colorPosition]);
      if (AvgSalOverUnder[i]>=0) {
        rect(xOffset*2 + (xBarPad*(i+1)) + (barWidth*i), this.frameHeight/2, 
          barWidth, -map(AvgSalOverUnder[i], 0, maxDataVal, 0, maxBarHeight));
      }
      if (AvgSalOverUnder[i]<0) {
        rect(xOffset*2 + (xBarPad*(i+1)) + (barWidth*i), this.frameHeight/2, 
          barWidth, map(AvgSalOverUnder[i], 0, -maxDataVal, 0, maxBarHeight));
      }

      colorPosition++;
    }

    displayCountKnob.setValue(round(displayCountKnob.getValue()))
      .setPosition(x+frameWidth-frameWidth/7, y+frameHeight-frameHeight/5)
      .setSize(int(frameWidth/18), int(frameHeight/20))
      ;

    popMatrix();
  }

  void loadChartData() {
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
      .show()
      ;
  }


  int getDisplayCount() {
    return this.displayCount;
  }

  void setDisplayCount(int displayCount) {
    int DC = int(round(displayCount));
    this.displayCount = DC;
  }

  void addDisplayCount() {
    setDisplayCount(getDisplayCount() + 1);
  }

  void subDisplayCount() {
    setDisplayCount(getDisplayCount() - 1);
  }
}