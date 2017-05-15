/* MSDS 6390 - Homework 1 - 5/12/17 *
 * Alex Frye, Chris Boomhower       *
 * Replication of ......            */

//Set variables
PImage grad;
int grey = 75;
int xoff = 0;
int yoff = 0;

//Load gradient background image created using http://angrytools.com/gradient/image.php
//and make background
size(665,890); //Sized to match original art frame
grad = loadImage("elsdjzob.png"); //gradient image 665x890 px to match
background(grad);
stroke(grey);

//Ear on left
noFill();
strokeWeight(6.5);
strokeJoin(MITER);
//line(80, 200, 280, 320);
//strokeWeight(8.5);
//line(280, 320, 215, 322);
beginShape();
vertex(80+xoff, 200+yoff);
vertex(280+xoff, 320+yoff);
vertex(215+xoff, 322+yoff);
vertex(188+xoff, 345+yoff);
vertex(135+xoff, 424+yoff);
endShape(CLOSE);

strokeWeight(7.5);
line(92+xoff, 212+yoff, 215+xoff, 322+yoff);
strokeWeight(4.0);
//line(89, 209, 188, 345);
fill(grey);
triangle(87+xoff, 207+yoff, 190+xoff, 343+yoff, 186+xoff, 347+yoff);
line(215+xoff, 322+yoff, 276+xoff, 316+yoff);

//Face on left
noFill();
strokeWeight(7.0);
line(213+xoff, 325+yoff, 332+xoff, 320+yoff);

strokeWeight(10.0);
beginShape();
vertex(332+xoff, 322+yoff);
vertex(210+xoff, 505+yoff);
vertex(188+xoff, 345+yoff);
endShape();

beginShape();
vertex(210+xoff, 505+yoff);
vertex(135+xoff, 535+yoff);
vertex(141+xoff, 420+yoff);
vertex(183+xoff, 340+yoff);
endShape();

strokeWeight(1.0);
beginShape();
vertex(135+xoff, 424+yoff);
vertex(100+xoff, 475+yoff);
vertex(90+xoff, 585+yoff);
vertex(100+xoff, 610+yoff);
vertex(105+xoff, 638+yoff);
vertex(49+xoff,  707+yoff);
vertex(40+xoff, 758+yoff);
vertex(79+xoff, 805+yoff);
endShape();