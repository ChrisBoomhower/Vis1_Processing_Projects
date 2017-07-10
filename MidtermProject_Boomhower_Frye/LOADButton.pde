Button LOADData;

class LOADButton extends Buttons {

  LOADButton() {
    super();
  }

  LOADButton(float x, float y, int buttonWidth, int buttonHeight) {
    super(x, y, buttonWidth, buttonHeight);
  }

  void Construct() {
    LOADData = cp5.addButton("LOAD DATA")
      .setPosition(this.x, this.y)
      .setSize(this.buttonWidth, this.buttonHeight)
      ;
  }

  void Action() {
    print("Files Initialized With"+"\t: ", SEPcheckbox.startQTR, SEPcheckbox.endQTR, SEPcheckbox.SEP_NS, 
      SEPcheckbox.SEP_SA, SEPcheckbox.SEP_SC, SEPcheckbox.SEP_SD, 
      SEPcheckbox.SEP_SH, SEPcheckbox.SEP_SI, SEPcheckbox.SEP_SJ);
    execPython.Exec(SEPcheckbox.startQTR, SEPcheckbox.endQTR, SEPcheckbox.SEP_NS, 
      SEPcheckbox.SEP_SA, SEPcheckbox.SEP_SC, SEPcheckbox.SEP_SD, 
      SEPcheckbox.SEP_SH, SEPcheckbox.SEP_SI, SEPcheckbox.SEP_SJ);
    println();
  }
  
  void Action(ControlEvent theEvent) {
    print("got an event from "+LOADData.getName()+"\t: ", QTRslider.startQTR, QTRslider.endQTR, SEPcheckbox.SEP_NS, 
      SEPcheckbox.SEP_SA, SEPcheckbox.SEP_SC, SEPcheckbox.SEP_SD, 
      SEPcheckbox.SEP_SH, SEPcheckbox.SEP_SI, SEPcheckbox.SEP_SJ);
    execPython.Exec(QTRslider.startQTR, QTRslider.endQTR, SEPcheckbox.SEP_NS, 
      SEPcheckbox.SEP_SA, SEPcheckbox.SEP_SC, SEPcheckbox.SEP_SD, 
      SEPcheckbox.SEP_SH, SEPcheckbox.SEP_SI, SEPcheckbox.SEP_SJ);
    println();
  }
}