/* MSDS 6390 - Homework 1 - 5/12/17                                                          *
 * Alex Frye, Chris Boomhower                                                                *
 * Description: Replication of the geometric wolf art piece found at                         *
 * https://s-media-cache-ak0.pinimg.com/736x/61/dd/d2/61ddd235519b767f76abddc2bc0697dd.jpg   *
 * The gradient background image was created using the interactive tools available at        *
 * http://angrytools.com/gradient/image.php                                                  */

void setup(){
  //Set variables
  PImage grad;
  int grey = 80;
  
  //Load gradient background image and set as background
  size(570,759); //Sized to match original art frame
  grad = loadImage("wrthjfim.png"); //gradient image 570x759 px to match
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
  strokeWeight(6.5);
  
  // Nose Point Right
  line(109, 607, 177, 573);
  line(180, 689, 84, 672);
  line(81, 653, 84, 672);
  
  // Nose Point Left
  line(84, 672, 75, 685);
  line(75, 686, 42, 647);
  line(42, 647, 48, 603);
  line(42, 647, 51, 603);
  
  // Nose Point Bottom
  strokeWeight(8.5);
  line(76, 685, 117, 706);
  line(117, 706, 174, 705);
  
  
  // Jawline
  strokeWeight(6.0);
  line(174, 705, 177, 690);
  strokeWeight(8.5);
  line(174, 705, 294, 688);
  strokeJoin(ROUND);
  quad(294, 635, 294, 688, 344, 682, 432, 594);
  
  strokeWeight(7.0);
  beginShape();
  vertex(177, 690); 
  vertex(299, 627); 
  vertex(200, 647);
  endShape(CLOSE);
  strokeWeight(5.5);
  line(177, 689, 299, 631);
  
  // cheek and top of nose
  strokeWeight(6.5);
  line(177, 573, 200, 647);
  line(177, 573, 234, 500);
  strokeWeight(4.5);
  line(234, 500, 298, 626);
  line(237, 500, 298, 626);
  strokeWeight(6.5);
  line(180, 441, 135, 502);
  strokeWeight(8.5);
  line(97, 543, 49, 603);
  
  // left cheek / eye
  strokeWeight(6.5);
  line(97, 545, 96, 521);
  strokeWeight(4.0);
  line(97, 521, 108, 504);
  strokeWeight(6.0);
  line(97, 545, 135, 502);
  
  strokeWeight(5.5);
  beginShape();
  vertex(108, 505); 
  vertex(133, 504); 
  vertex(121, 477);
  endShape(CLOSE);
  
  strokeWeight(6.0);
  line(90, 500, 95, 520);
  
  strokeWeight(6.5);
  line(90, 500, 100, 415);
  strokeWeight(4.0);
  line(90, 500, 120, 476);
  strokeWeight(6.5);
  
  beginShape();
  vertex(120, 474); 
  vertex(100, 415);
  vertex(130, 365);
  endShape(CLOSE);
  line(101, 412, 121, 375);
  
  strokeWeight(8.0);
  quad(120, 474, 130, 365, 165, 305, 180, 440);
  
  strokeWeight(6.5);
  line(189, 286, 283, 280);
  
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
  strokeWeight(5.0);
  line(85, 210, 166, 300);
  
  strokeWeight(6.5);
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
  
  
  // Forehead
  strokeWeight(9.0);
  line(181, 443, 281, 284);
  strokeWeight(6.5);
  
  line(185, 445, 235, 500);
  strokeWeight(5.0);
  line(185, 445, 250, 460);
  strokeWeight(5.5);
  triangle(250, 460, 235, 500, 270, 470);
  strokeWeight(6.5);
  
  strokeJoin(ROUND);
  triangle(282, 280, 330, 325, 347, 287);
  strokeWeight(7.5);
  line(282, 280, 347, 287);
  strokeWeight(6.5);
  
  
  // right eye & Cheek
  quad(270, 470, 250, 460, 330, 325, 387, 401);
  
  strokeWeight(8.0);
  line(270, 470, 387, 401);
  line(387, 401, 335, 480);
  strokeWeight(5.0);
  line(335, 480, 270, 470);
  
  line(335, 480, 306, 489);
  line(306, 489, 291, 497);
  line(291, 497, 233, 502);
  
  strokeWeight(6.0);
  line(306, 490, 295, 635);
  line(291, 497, 295, 611);
  
  triangle(337, 479, 295, 635, 417, 520);
  strokeWeight(7.5);
  line(417, 520, 295, 635);
  
  strokeWeight(9.0);
  line(417, 520, 425, 550);
  line(425, 550, 430, 595);
  strokeWeight(7.0);
  line(425, 550, 295, 635);
  
  // Right Ear and Side of Head
  triangle(425, 550, 430, 595, 540, 450);
  triangle(417, 520, 425, 550, 540, 450);
  triangle(417, 520, 510, 390, 540, 450);
  
  quad(335, 480, 417, 520, 510, 390, 381, 405);
  
  triangle(387, 401, 510, 387, 517, 287);
  triangle(387, 401, 517, 287, 501, 143);
  
  line(460, 165, 501, 143);
  
  strokeWeight(5.5);
  line(460, 165, 380, 273);
  strokeWeight(4.5);
  line(380, 273, 370, 250);
  strokeWeight(6.5);
  line(461, 164, 370, 250);
  line(380, 273, 372, 382);
  line(370, 250, 347, 287);
}