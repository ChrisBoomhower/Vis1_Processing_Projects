
class BarChartAvgOverUnder extends Frame {

  BarChartAvgOverUnder() {
  }

  BarChartAvgOverUnder(float x, float y, float frameWidth, float frameHeight) {
    super(x, y, frameWidth, frameHeight);
  }

  void Construct() {
    drawFrame();
    drawTitle("Avg. Sal. Over/Under Ind. by OCCFAMT");
  }
}