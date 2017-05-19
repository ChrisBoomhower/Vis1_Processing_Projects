PImage pic;
//int pointillize = 32;

void setup() {
  size(576, 1024);
  pic = loadImage("Original.jpg");
  pic.resize(576, 1024);
  background(0);
  smooth();
  frameRate(1000);
}

void draw() {
  // Pick a random point
  int x = int(random(pic.width));
  int y = int(random(pic.height));
  int loc = x + y*pic.width;
  
  // Look up the RGB color in the source image
  loadPixels();
  float r = red(pic.pixels[loc]);
  float g = green(pic.pixels[loc]);
  float b = blue(pic.pixels[loc]);
  noStroke();
  
  // Draw an ellipse at that location with that color
  fill(r,g,b,100);
  ellipse(x,y,50,10);
}

void mousePressed(){
  stop();
  saveFrame("Pointillized.jpg");
}