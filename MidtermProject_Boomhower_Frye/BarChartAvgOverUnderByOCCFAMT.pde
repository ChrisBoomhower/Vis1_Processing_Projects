
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
  }

  void Construct() {
    float xOffset;
    float yOffset;
    float xBarPad = this.frameWidth/75;
    float barWidth;
    float maxBarHeight;

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
      
      //Bars
    for (int i = 0; i<this.displayCount; i++) {
      if (AvgSalOverUnder[i]>=0) {
        rect(xOffset*2 + (xBarPad*(i+1)) + (barWidth*i), this.frameHeight/2, 
          barWidth, -map(AvgSalOverUnder[i], 0, maxDataVal, 0, maxBarHeight));
      }
      if (AvgSalOverUnder[i]<0) {
        rect(xOffset*2 + (xBarPad*(i+1)) + (barWidth*i), this.frameHeight/2, 
          barWidth, map(AvgSalOverUnder[i], 0, -maxDataVal, 0, maxBarHeight));
      }
    }

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
      
      if(i < this.displayCount-1) print(AvgSalOverUnder[i] + ", ");
      else if(i == this.displayCount-1) println(AvgSalOverUnder[i]);

    }
    totalCount = Data.getRowCount();
  }

  int getDisplayCount() {
    return this.displayCount;
  }

  void setDisplayCount(int displayCount) {
    this.displayCount = displayCount;
  }

  void addDisplayCount() {
    setDisplayCount(getDisplayCount() + 1);
  }

  void subDisplayCount() {
    setDisplayCount(getDisplayCount() - 1);
  }
}