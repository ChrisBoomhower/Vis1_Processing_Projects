PImage pic;
int drawFlag = 0; // don't change this assignment
int debug = 0;  // 0 runs pointillized background; 1 runs original background
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

  if(drawFlag == 0){
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
  else {
    stroke(255, 127, 0);
    strokeWeight(4);
    noFill();

    if (debug == 0) {
      pic = loadImage("Pointillized.jpg");
      background(pic);
    }
    else {
      background(pic);
      
      if (mouseButton == RIGHT) {
        
      }
      
      println("curveVertex(" + mouseX + ", " + mouseY + ");");
    }
    
    beginShape();
    curveVertex(189, 416);
    curveVertex(89, 389);
    curveVertex(76, 321);
    curveVertex(75, 248);
    curveVertex(155, 142);
    curveVertex(277, 161);
    curveVertex(331, 284);
    curveVertex(324, 426);
    curveVertex(250, 508);
    curveVertex(169, 525);
    endShape();
    
    saveFrame("Boogers.jpg");
  }
}

void mousePressed(){
  if (drawFlag == 0) {
    noLoop();  
    saveFrame("Pointillized.jpg");
    drawFlag = 1;
  }
  else {
    redraw();
  }  
}