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

  void Construct() {
    SEPCheckBox = cp5.addCheckBox("SEPCheckBox")
      .setPosition(this.x, this.y)
      .setSize(this.buttonWidth, this.buttonHeight)
      .setItemsPerRow(1)
      .setSpacingRow(20)
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

  void Action() {    
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
}