
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
  }

  void Construct() {
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
      drawRings(0.25, 0.667, radXOSepL, radXQL, radXLoL, radXTotSepL, radXJoL, baseX, level);
      drawRings(0.75, 0.45, radXOSepR, radXQR, radXLoR, radXTotSepR, radXJoR, baseX, rate);
    }
    else {
      drawRings(0.25, 0.667, radYOSepL, radYQL, radYLoL, radYTotSepL, radYJoL, baseY, level);
      drawRings(0.75, 0.45, radYOSepR, radYQR, radYLoR, radYTotSepR, radYJoR, baseY, rate);
    }
  }

  void loadChartData() {
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
  
  void drawRings(float fracX, float fracY,
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
  
  void displayValue(float fracX, float fracY,
                   float radOSep, float radQ,
                   float radLo, float radTotSep,
                   float radJo, float base, boolean ver) {
                     
    textFont(agency, 24);
    fill(255);
    textAlign(LEFT, BOTTOM);
    if (mouseX > x + frameWidth*fracX - base/2 & mouseX < x + frameWidth*fracX + base/2 & mouseY > y + frameHeight*fracY - base/2 & mouseY < y + frameHeight*fracY + base/2) {
      println("Mouse over base ring");
    }
    else if (mouseX > x + frameWidth*fracX - radJo/2 & mouseX < x + frameWidth*fracX + radJo/2 & mouseY > y + frameHeight*fracY - radJo/2 & mouseY < y + frameHeight*fracY + radJo/2) {
      if (ver == true) text("Level = " + joL, mouseX, mouseY);
      else text("Rate = " + joR, mouseX, mouseY);
    }
    else if (mouseX > x + frameWidth*fracX - radTotSep/2 & mouseX < x + frameWidth*fracX + radTotSep/2 & mouseY > y + frameHeight*fracY - radTotSep/2 & mouseY < y + frameHeight*fracY + radTotSep/2) {
      if (ver == true) text("Level = " + totSepL, mouseX, mouseY);
      else text("Rate = " + totSepR, mouseX, mouseY);
    }
    else if (mouseX > x + frameWidth*fracX - radLo/2 & mouseX < x + frameWidth*fracX + radLo/2 & mouseY > y + frameHeight*fracY - radLo/2 & mouseY < y + frameHeight*fracY + radLo/2) {
      if (ver == true) text("Level = " + loL, mouseX, mouseY);
      else text("Rate = " + loR, mouseX, mouseY);
    }
    else if (mouseX > x + frameWidth*fracX - radQ/2 & mouseX < x + frameWidth*fracX + radQ/2 & mouseY > y + frameHeight*fracY - radQ/2 & mouseY < y + frameHeight*fracY + radQ/2) {
      if (ver == true) text("Level = " + qL, mouseX, mouseY);
      else text("Rate = " + qR, mouseX, mouseY);
    }
    else if (mouseX > x + frameWidth*fracX - radOSep/2 & mouseX < x + frameWidth*fracX + radOSep/2 & mouseY > y + frameHeight*fracY - radOSep/2 & mouseY < y + frameHeight*fracY + radOSep/2) {
      if (ver == true) text("Level = " + oSepL, mouseX, mouseY);
      else text("Rate = " + oSepR, mouseX, mouseY);
    }
    
  }
}