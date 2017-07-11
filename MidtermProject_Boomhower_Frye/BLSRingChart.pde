
class BLSRingChart extends Frame {

  BLSRingChart() {
  }

  BLSRingChart(float x, float y) {
    super(x, y);
  }

  void Construct() {
    pushMatrix();
    fill(0);
    rect(this.x, this.y, width/3, height/3);
    popMatrix();
  }
}