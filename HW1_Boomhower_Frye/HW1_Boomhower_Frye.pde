/* MSDS 6390 - Homework 1 - 5/12/17 *
 * Alex Frye, Chris Boomhower       *
 * Replication of ......            */

//Set variables
PImage grad;
int grey = 75;

//Load gradient background image created using http://angrytools.com/gradient/image.php
//and make background
//size(665,890); //Sized to match original art frame
size(570,759);
//grad = loadImage("elsdjzob.png"); //gradient image 665x890 px to match
//background(grad);
stroke(grey);

//Ear on left
// create nose
beginShape();
vertex(50, 590); // left
vertex(80, 640); // bottom
vertex(110, 590);// right
endShape(CLOSE);

// add shapes to create wolf
strokeWeight(6);
fill(223, 223, 225);

  // Nose Point Right
line(110, 590, 160, 565);
line(160, 565, 185, 630);
line(185, 630, 165, 660);
line(165, 660, 80, 650);
line(80, 650, 80, 640);


  // Nose Point Left
line(80, 650, 70, 660);
line(70, 660, 40, 630);
line(40, 630, 50, 590);

  // Nose Point Bottom
line(70, 660, 115, 680);
line(115, 680, 160, 685);


// Jawline
quad(160, 685, 165, 660, 295, 635, 295, 685);
quad(295, 635, 295, 685, 345, 680, 430, 595);


beginShape();
vertex(295, 635); 
vertex(185, 630); 
vertex(165, 660);
endShape(CLOSE);


// cheek and top of nose
quad(295, 635, 185, 630, 160, 565, 235, 500);
line(235, 500, 185, 445);
line(185, 445, 135, 500);
line(135, 500, 100, 545);
line(100, 545, 50, 590);


// left cheek / eye
quad(100, 545, 95, 520, 110, 505, 135, 500);

beginShape();
vertex(110, 505); 
vertex(135, 500); 
vertex(120, 475);
endShape(CLOSE);
 
line(120, 475, 90, 500);
line(90, 500, 95, 520);

beginShape();
vertex(120, 474); 
vertex(90, 500); 
vertex(100, 415);
endShape(CLOSE);

beginShape();
vertex(120, 474); 
vertex(100, 415);
vertex(130, 365);
endShape(CLOSE);

beginShape();
vertex(122, 370); 
vertex(61, 180);
vertex(165, 305);
endShape(CLOSE);