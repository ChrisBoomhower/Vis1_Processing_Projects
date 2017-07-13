
class BLSRingChart extends Frame {
  
  Table BLS;
  boolean dataLoaded = false;
  float scale = 500;

  BLSRingChart() {
  }

  BLSRingChart(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
  }

  void Construct() {
    drawFrame();
    drawTitle("BLS Relationships - Levels and Rates");
    
    if (dataLoaded == true) {
      TableRow row = BLS.getRow(0);
      
      // Outside to Inside order:
      // radOSep, radQ, radLo, radTotSep, radJo, base
      float baseX        =  frameWidth/50;
      float radXJoL      =  baseX + (frameWidth * row.getFloat("BLS_FEDERAL_JobOpenings_Level")/scale);
      float radXTotSepL  =  radXJoL + (frameWidth * row.getFloat("BLS_FEDERAL_TotalSep_Level")/scale);
      float radXLoL      =  radXTotSepL + (frameWidth * row.getFloat("BLS_FEDERAL_Layoffs_Level")/scale);
      float radXQL       =  radXLoL + (frameWidth * row.getFloat("BLS_FEDERAL_Quits_Level")/scale);
      float radXOSepL    =  radXQL + (frameWidth * row.getFloat("BLS_FEDERAL_OtherSep_Level")/scale);
      float baseY        =  frameHeight/50;
      float radYJoL      =  baseY + (frameHeight * row.getFloat("BLS_FEDERAL_JobOpenings_Level")/scale);
      float radYTotSepL  =  radYJoL + (frameHeight * row.getFloat("BLS_FEDERAL_TotalSep_Level")/scale);
      float radYLoL      =  radYTotSepL + (frameHeight * row.getFloat("BLS_FEDERAL_Layoffs_Level")/scale);
      float radYQL       =  radYLoL + (frameHeight * row.getFloat("BLS_FEDERAL_Quits_Level")/scale);
      float radYOSepL    =  radYQL + (frameHeight * row.getFloat("BLS_FEDERAL_OtherSep_Level")/scale);
      float radXTotSepR  =  row.getFloat("BLS_FEDERAL_TotalSep_Rate");
      float radXJoR      =  row.getFloat("BLS_FEDERAL_JobOpenings_Rate");
      float radXLoR      =  row.getFloat("BLS_FEDERAL_Layoffs_Rate");
      float radXQR       =  row.getFloat("BLS_FEDERAL_Quits_Rate");
      float radXOSepR    =  row.getFloat("BLS_FEDERAL_OtherSep_Rate");
      
      pushMatrix();
      
      translate(x + frameWidth/4, y + frameHeight*0.667);
      fill(255, 0, 0);
      stroke(255, 0, 0);
      ellipse(0, 0, radXOSepL, radXOSepL);
      
      fill(255, 255, 0);
      stroke(255, 255, 0);
      ellipse(0, 0, radXQL, radXQL);
      
      fill(255, 0, 255);
      stroke(255, 0, 255);
      ellipse(0, 0, radXLoL, radXLoL);
      
      fill(0, 255, 255);
      stroke(0, 255, 255);
      ellipse(0, 0, radXTotSepL, radXTotSepL);
      
      fill(0, 255, 0);
      stroke(0, 255, 0);
      ellipse(0, 0, radXJoL, radXJoL);
      
      fill(75);
      stroke(75);
      ellipse(0, 0, baseX, baseX);
      
      popMatrix();
    }
  }
  
  void loadChartData(){
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
    dataLoaded = true;
  }
}