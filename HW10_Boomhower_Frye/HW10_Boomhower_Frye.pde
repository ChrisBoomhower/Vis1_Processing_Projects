void setup() {
  size(640, 360, P3D);

}

void draw() {
  background(0);
  camera(mouseX, mouseY, (height/2) / tan(PI/3), width/2, (height/2), 0, 0, 1, 0);
  translate(width/2, height/2, -300);
  stroke(255);
  noFill();
  box(200);
}