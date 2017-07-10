
abstract class Buttons {

  float x;
  float y;
  int buttonWidth;
  int buttonHeight;
  
  int startQTR = 1;
  int endQTR   = 4;
  String SEP_NS;
  String SEP_SA;
  String SEP_SC;
  String SEP_SD;
  String SEP_SH;
  String SEP_SI;
  String SEP_SJ;
 
  Buttons() {
  }

  Buttons(float x, float y, int buttonWidth, int buttonHeight) {
    this.x = x;
    this.y = y;
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

  abstract void Construct();
  abstract void Action(ControlEvent theEvent);
}