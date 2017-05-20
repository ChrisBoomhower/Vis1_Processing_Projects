PImage pic;
int drawFlag = 0; // don't change this assignment
int debug = 1;  // 0 runs pointillized background; 1 runs original background
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
    ellipse(x,y,50,15);
  }
  else {
    noStroke();
    noFill();

    if (debug == 0) {
      pic = loadImage("Pointillized.jpg");
      background(pic);
    }
    else {
      background(pic);
      
      if (mouseButton == RIGHT) {
        background(0);
      }
      
      println("curveVertex(" + mouseX + ", " + mouseY + ");");
    }
    
      // DRAWING CODE STARTS HERE!

      // Pants
    fill(79, 91, 107);
    triangle(107, 911, 99, 952, 120, 941);
  
    quad(99, 945, 107, 984, 128, 964, 116, 931);
    
    triangle(105, 974, 118, 1004, 129, 965);

    triangle(111, 1024, 195, 1024, 128, 966);
    
    triangle(314, 1024, 394, 1024, 398, 993);
    
    quad(393, 1024, 394, 992, 423, 968, 440, 1024);
    
    beginShape();
    curveVertex(394, 1024);
    curveVertex(420, 1024);
    curveVertex(457, 987);
    curveVertex(445, 942);
    curveVertex(401, 988);
    curveVertex(416, 975);
    endShape(CLOSE);
    
      //Shirt Bottom
    fill(104, 46, 34);
    quad(108, 915, 115, 893, 192, 941, 126, 964);
    
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