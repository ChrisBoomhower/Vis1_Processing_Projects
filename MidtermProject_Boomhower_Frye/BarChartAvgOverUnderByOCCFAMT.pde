
class BarChartAvgOverUnder extends Frame {

  BarChartAvgOverUnder() {
  }

  BarChartAvgOverUnder(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
  }

  void Construct() {
    float xOffset;
    float yOffset;
    drawFrame();
    drawTitle("Avg. Sal. Over/Under Ind. by OCCFAMT");
    pushMatrix();
    strokeWeight(width/400);

    if (this.frameWidth/19.33>25) xOffset = 25;
    else xOffset = this.frameWidth/19.33;

    yOffset = (this.frameWidth/10);

    line(x+xOffset, y+yOffset, x+this.frameWidth/19.33, y + this.frameHeight - yOffset);

    popMatrix();
  }
}