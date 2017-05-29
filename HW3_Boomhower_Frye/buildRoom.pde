/******************************************************************************************
Function utilized in order to create the room. 
buildRoom(0, 0); = Standard Room
buildRoom(int(random(-5,5)),int(random(-5,5))); = room shakes
******************************************************************************************/


void buildRoom(int x, int y) {
  pushMatrix();

  translate(x, y);

    //Room Fill
  fill(222, 207, 166);
  noStroke();
  quad(10,   10, 
       50,   10, 
       50,   640, 
       10,   640);

  quad(10,   10, 
       1190, 10, 
       1190, 100, 
       10,   100);

  quad(10,   350, 
       1190, 350, 
       1190, 640, 
       10,   640);
       
  quad(350,   100, 
       350,   350, 
       450,   350, 
       450,   100);
       
  quad(750,   100, 
       750,   350, 
       850,   350, 
       850,   100);
       
  quad(1150,   100, 
       1150,   350, 
       1190,   350, 
       1190,   100);
       
  stroke(0);
  strokeWeight(3);

    //Room Boundaries
  noFill();
  quad(10,   10, 
       1190, 10, 
       1190, 640, 
       10,   640);
  
  
    //Windows
  noFill();
        
        // Left
  quad(50, 100, 
       350, 100, 
       350, 350, 
       50, 350);

  line(200, 100, 200, 350);
  line(50, 225, 350, 225);

        // Middle
  quad(450, 100, 
       750, 100, 
       750, 350, 
       450, 350);

  line(600, 100, 600, 350);
  line(450, 225, 750, 225);
  
        // Right
  quad(850, 100, 
       1150, 100, 
       1150, 350, 
       850, 350);

  line(1000, 100, 1000, 350);
  line(850, 225, 1150, 225);
  
  
    // Picture Frame of "Boogers.jpg"
   stroke(53, 27, 12);
   strokeWeight(4);
   rect(950, 450, 42, 65);
   image(img, 950, 450, 42, 65);
   

  popMatrix();
}