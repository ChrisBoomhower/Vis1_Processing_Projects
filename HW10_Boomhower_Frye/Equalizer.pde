class Equalizer {

  final int bars = fft.avgSize();
  float diameter;
  float boxWHDim;
  public final float randTranslateX = random(-width, width*2);
  public final float randTranslateY = random(-height, height*2);
  public final float randTranslateZ = random(-1000, 1000);
  private final float randRadianRotateY = random(0,360);

  Equalizer() {
  }

  Equalizer(float diameter) {
    this.diameter = diameter;
    this.boxWHDim = diameter/14.705;
  }

  void Construct() {
    rotateY(radians(randRadianRotateY));
    pushMatrix();
    rotateY(radians(map(-mouseX, 0, width, 0, 360)));
    rotateX(radians(map(mouseY, 0, height, -90, 70)));

    rotateX(PI/2);
    for ( int i = 0; i < bars; i++) {

      float k = i*(2*PI)/bars;
      pushMatrix();
      translate(cos(k)*diameter/2, sin(k)*diameter/2, 0);
      rotateZ(k);
      box(boxWHDim, boxWHDim, (diameter/(width/2))*fft.getAvg(i));
      popMatrix();
    }
    popMatrix();
  }
}