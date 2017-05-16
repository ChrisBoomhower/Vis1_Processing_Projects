import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class HW1_Boomhower_Frye extends PApplet {
  public void setup() {
/* MSDS 6390 - Homework 1 - 5/12/17 *
 * Alex Frye, Chris Boomhower       *
 * Replication of ......            */

//Set variables
PImage grad;
int grey = 80;

//Load gradient background image created using http://angrytools.com/gradient/image.php
//and make background
//size(665,890); //Sized to match original art frame
//grad = loadImage("elsdjzob.png"); //gradient image 665x890 px to match

grad = loadImage("wrthjfim.png"); //gradient image 665x890 px to match
background(grad);
stroke(grey);
strokeWeight(5);

// create nose
fill(grey);
beginShape();
vertex(50, 603); // left
vertex(81, 653); // bottom
vertex(115, 603);// right
endShape(CLOSE);
noFill();

// add shapes to create wolf
strokeWeight(6.5f);
//fill(223, 223, 225);

// Nose Point Right
line(109, 607, 177, 573);
//line(160, 565, 185, 630);
//line(185, 630, 165, 660);
line(180, 689, 84, 672);
line(81, 653, 84, 672);

// Nose Point Left
line(84, 672, 75, 685);
line(75, 686, 42, 647);
line(42, 647, 48, 603);
line(42, 647, 51, 603);

// Nose Point Bottom
strokeWeight(8.5f);
line(76, 685, 117, 706);
//line(76, 684, 118, 704);
line(117, 706, 174, 705);


// Jawline
strokeWeight(6.0f);
line(174, 705, 177, 690);//, 296, 634, 294, 688);
strokeWeight(8.5f);
line(174, 705, 294, 688);
strokeJoin(ROUND);
quad(294, 635, 294, 688, 344, 682, 432, 594);

strokeWeight(7.0f);
beginShape();
vertex(177, 690); 
vertex(299, 627); 
vertex(200, 647);
endShape(CLOSE);
strokeWeight(5.5f);
line(177, 689, 299, 631);

// cheek and top of nose
strokeWeight(6.5f);
line(177, 573, 200, 647);//, 300, 626, 234, 500);
line(177, 573, 234, 500);
strokeWeight(4.5f);
line(234, 500, 298, 626);
line(237, 500, 298, 626);
strokeWeight(6.5f);
//line(235, 500, 186, 445);
line(180, 441, 135, 502);
//line(135, 500, 100, 545);
strokeWeight(8.5f);
line(97, 543, 49, 603);

// left cheek / eye
strokeWeight(6.5f);
line(97, 545, 96, 521);//, 108, 505, 135, 502);
strokeWeight(4.0f);
line(97, 521, 108, 504);
strokeWeight(6.0f);
line(97, 545, 135, 502);

strokeWeight(5.5f);
beginShape();
vertex(108, 505); 
vertex(133, 504); 
vertex(121, 477);
endShape(CLOSE);

//line(120, 475, 90, 500);
strokeWeight(6.0f);
line(90, 500, 95, 520);

strokeWeight(6.5f);
line(90, 500, 100, 415);
strokeWeight(4.0f);
line(90, 500, 120, 476);
strokeWeight(6.5f);

beginShape();
vertex(120, 474); 
vertex(100, 415);
vertex(130, 365);
endShape(CLOSE);
line(101, 412, 121, 375);

//beginShape();
//vertex(122, 370); 
//vertex(61, 180);
//vertex(165, 305);
//endShape(CLOSE);

strokeWeight(8.0f);
quad(120, 474, 130, 365, 165, 305, 180, 440);

strokeWeight(6.5f);
line(189, 286, 283, 280);
//line(281, 281, 185, 445);

// Left Ear
strokeJoin(MITER);
beginShape();
vertex(123, 372); 
vertex(61, 180);
vertex(165, 305);
endShape(CLOSE);


beginShape(); 
vertex(61, 180);
vertex(165, 305);
vertex(190, 285);
endShape(CLOSE);
strokeWeight(5.0f);
line(85, 210, 166, 300);

strokeWeight(6.5f);
beginShape(); 
vertex(61, 180);
vertex(190, 285);
vertex(245, 280);
endShape();
beginShape();
vertex(245, 280);
vertex(61, 174);
vertex(123, 370);
endShape();
//line(57, 170, 245, 280);


// Forehead
strokeWeight(9.0f);
//quad(281, 281, 185, 445, 250, 460, 330, 325);
line(181, 443, 281, 284);
strokeWeight(6.5f);

//triangle(185, 445, 250, 460, 235, 500);
line(185, 445, 235, 500);
strokeWeight(5.0f);
line(185, 445, 250, 460);
strokeWeight(5.5f);
triangle(250, 460, 235, 500, 270, 470);
strokeWeight(6.5f);

strokeJoin(ROUND);
triangle(282, 280, 330, 325, 347, 287);
strokeWeight(7.5f);
line(282, 280, 347, 287);
strokeWeight(6.5f);


// right eye & Cheek
quad(270, 470, 250, 460, 330, 325, 387, 401);

strokeWeight(8.0f);
line(270, 470, 387, 401);
line(387, 401, 335, 480);
strokeWeight(5.0f);
line(335, 480, 270, 470);
//triangle(270, 470, 387, 401, 335, 480);

line(335, 480, 306, 489);
line(306, 489, 291, 497);
line(291, 497, 233, 502);

//line(337, 479, 295, 635);
strokeWeight(6.0f);
line(306, 490, 295, 635);
line(291, 497, 295, 611);

triangle(337, 479, 295, 635, 417, 520);
strokeWeight(7.5f);
line(417, 520, 295, 635);

strokeWeight(9.0f);
line(417, 520, 425, 550);
line(425, 550, 430, 595);
strokeWeight(7.0f);
line(425, 550, 295, 635);

// Right Ear and Side of Head

triangle(425, 550, 430, 595, 540, 450);
triangle(417, 520, 425, 550, 540, 450);
triangle(417, 520, 510, 390, 540, 450);

quad(335, 480, 417, 520, 510, 390, 381, 405);

triangle(387, 401, 510, 387, 517, 287);
triangle(387, 401, 517, 287, 501, 143);

line(460, 165, 501, 143);

triangle(460, 165, 370, 250, 380, 273);
line(380, 273, 372, 382);
line(370, 250, 347, 287);
    noLoop();
  }

  public void settings() { 
size(570,759); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#FF0004", "HW1_Boomhower_Frye" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}