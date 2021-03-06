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

  void Construct() {
    LOADData = cp5.addButton("LOAD DATA")
      .setPosition(this.x, this.y)
      .setSize(this.buttonWidth, this.buttonHeight)
      ;
  }

  void Action() {
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