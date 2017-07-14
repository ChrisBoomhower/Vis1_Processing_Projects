
class BLSRingChart extends Frame {

  Table BLS;
  float scaleL = 300;
  float scaleR = 11;

  BLSRingChart() {
  }

  BLSRingChart(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
  }

  void Construct() {
    drawFrame();
    drawTitle("BLS Relationships - Levels and Rates");

    TableRow row = BLS.getRow(0);

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
      drawRings(0.25, 0.667, radXOSepL, radXQL, radXLoL, radXTotSepL, radXJoL, baseX);
      drawRings(0.75, 0.45, radXOSepR, radXQR, radXLoR, radXTotSepR, radXJoR, baseX);
    }
    else {
      drawRings(0.25, 0.667, radYOSepL, radYQL, radYLoL, radYTotSepL, radYJoL, baseY);
      drawRings(0.75, 0.45, radYOSepR, radYQR, radYLoR, radYTotSepR, radYJoR, baseY);
    }
  }

  void loadChartData() {
    BLS = loadTable("AvgBLS.csv", "header");

    for (TableRow row : BLS.rows()) {
      float totSepL  =  row.getFloat("BLS_FEDERAL_TotalSep_Level");
      float joL      =  row.getFloat("BLS_FEDERAL_JobOpenings_Level");
      float loL      =  row.getFloat("BLS_FEDERAL_Layoffs_Level");
      float qL       =  row.getFloat("BLS_FEDERAL_Quits_Level");
      float oSepL    =  row.getFloat("BLS_FEDERAL_OtherSep_Level");

      float totSepR  =  row.getFloat("BLS_FEDERAL_TotalSep_Rate");
      float joR      =  row.getFloat("BLS_FEDERAL_JobOpenings_Rate");
      float loR      =  row.getFloat("BLS_FEDERAL_Layoffs_Rate");
      float qR       =  row.getFloat("BLS_FEDERAL_Quits_Rate");
      float oSepR    =  row.getFloat("BLS_FEDERAL_OtherSep_Rate");

      println("BLSRingChart Data = " + totSepL + ", " + 
        joL + ", " + loL + ", " + qL + ", " + oSepL + 
        ", " + totSepR + ", " + joR + ", " + loR + ", " + 
        qR + ", " + oSepR);
    }
  }
  
  void drawRings(float fracX, float fracY,
                 float radOSepL, float radQL,
                 float radLoL, float radTotSepL,
                 float radJoL, float base) {
    pushMatrix();
    
    translate(x + frameWidth*fracX, y + frameHeight*fracY);
    fill(#F04765);
    stroke(#F04765);
    ellipse(0, 0, radOSepL, radOSepL);

    fill(#DB2343);
    stroke(#DB2343);
    ellipse(0, 0, radQL, radQL);

    fill(#FF8F4C);
    stroke(#FF8F4C);
    ellipse(0, 0, radLoL, radLoL);

    fill(#32A88B);
    stroke(#32A88B);
    ellipse(0, 0, radTotSepL, radTotSepL);

    fill(#70DC42);
    stroke(#70DC42);
    ellipse(0, 0, radJoL, radJoL);

    fill(75);
    stroke(75);
    ellipse(0, 0, base, base);

    popMatrix();
  }
}