// Gradient background class

class Background {

  int y_axis = 1;
  int x_axis = 2;
  color c1, c2;
  float x, y;
  float backgroundW, backgroundH;
  
  Background() {
  }

  Background(float x, float y, float backgroundW, float backgroundH, color c1, color c2) {
    this.x = x;
    this.y = y;
    this.backgroundW = backgroundW;
    this.backgroundH = backgroundH;
    this.c1 = c1;
    this.c2 = c2;
  }  

  void drawBackground() {
    pushMatrix();
    setGradient(x, y, width, height, c1, c2, y_axis);
    popMatrix();
  }
  
  void setGradient(float x, float y, float w, float h, color c1, color c2, int axis ) {

    noFill();
  
    if (axis == y_axis) {  // Top to bottom gradient
      for (float i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
    else if (axis == x_axis) {  // Left to right gradient
      for (float i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}