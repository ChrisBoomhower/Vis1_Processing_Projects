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
      
      if (mouseButton == CENTER) {
        int locx = mouseX;
        int locy = mouseY;
        int locxy = locx + locy*pic.width;
        println(red(pic.pixels[locxy]) + ", " + green(pic.pixels[locxy]) + ", " + blue(pic.pixels[locxy]));
      }
      
      if (mouseButton == LEFT) {
        println("curveVertex(" + mouseX + ", " + mouseY + ");");
      }
    }
    
      // DRAWING CODE STARTS HERE!
      
      // Face
    stroke(255, 10, 10);
    strokeJoin(ROUND);
    fill(172.0, 141.0, 95.0);
    beginShape();
    curveVertex(330, 391);
    curveVertex(326, 401);
    curveVertex(322, 412);
    curveVertex(317, 428);
    curveVertex(314, 443);
    curveVertex(307, 455);
    curveVertex(297, 469);
    curveVertex(282, 483);
    curveVertex(254, 505);
    curveVertex(231, 520);
    curveVertex(211, 523);
    curveVertex(189, 520);
    curveVertex(176, 509);
    curveVertex(159, 498);
    curveVertex(137, 476);
    curveVertex(119, 456);
    curveVertex(106, 438);
    curveVertex(99, 421);
    curveVertex(96, 411);
    curveVertex(90, 408);
    curveVertex(86, 403);
    curveVertex(90, 396);
    curveVertex(86, 383);
    curveVertex(85, 371);
    curveVertex(80, 354);
    curveVertex(79, 317);
    curveVertex(81, 300);
    curveVertex(81, 282);
    curveVertex(85, 259);
    curveVertex(95, 229);
    curveVertex(104, 215);
    curveVertex(115, 204);
    curveVertex(135, 195);
    curveVertex(150, 190);
    curveVertex(170, 190);
    curveVertex(207, 191);
    curveVertex(229, 199);
    curveVertex(255, 209);
    curveVertex(270, 223);
    curveVertex(289, 243);
    curveVertex(301, 263);
    curveVertex(313, 279);
    curveVertex(324, 296);
    curveVertex(336, 305);
    curveVertex(345, 311);
    curveVertex(346, 319);
    curveVertex(355, 313);
    curveVertex(365, 311);
    curveVertex(373, 319);
    curveVertex(373, 333);
    curveVertex(371, 341);
    curveVertex(367, 350);
    curveVertex(361, 367);
    curveVertex(362, 379);
    curveVertex(361, 394);
    curveVertex(352, 402);
    curveVertex(341, 401);
    curveVertex(332, 396);
    curveVertex(330, 391);
    endShape(CLOSE);
    
      // Left eye
    fill(111.0, 123.0, 105.0);
    stroke(55.0, 52.0, 43.0);
    beginShape();
    curveVertex(160, 330);
    curveVertex(154, 328);
    curveVertex(134, 330);
    curveVertex(124, 329);
    curveVertex(112, 329);
    curveVertex(106, 331);
    curveVertex(120, 321);
    curveVertex(134, 318);
    curveVertex(150, 318);
    curveVertex(159, 322);
    curveVertex(164, 333);
    curveVertex(162, 335);
    endShape(CLOSE);

    fill(63.0, 68.0, 80.0);
    ellipse(141, 325, 26, 13);
    fill(125, 125, 125);
    ellipse(141, 325, 3, 3);
    noFill();
    
    
      // Right eye
    fill(111.0, 123.0, 105.0);
    //beginShape();
    //curveVertex(227, 328);
    //curveVertex(234, 320);
    //curveVertex(239, 318);
    //curveVertex(244, 315);
    //curveVertex(252, 316);
    //curveVertex(264, 319);
    //curveVertex(274, 321);
    //curveVertex(280, 326);
    //curveVertex(271, 325);
    //curveVertex(267, 324);
    //curveVertex(259, 325);
    //curveVertex(251, 326);
    //curveVertex(241, 325);
    //curveVertex(236, 326);
    //curveVertex(226, 328);
    //curveVertex(227, 328);
    //endShape(CLOSE);
    
    //noStroke();
    triangle(239, 317, 229, 328, 241, 327);
    //stroke(55.0, 52.0, 43.0);
    
    //noFill();
    fill(55.0, 52.0, 43.0);
    beginShape();
    curveVertex(254, 316);
    curveVertex(255, 316);
    curveVertex(269, 320);
    curveVertex(279, 325);
    curveVertex(283, 329);
    curveVertex(276, 328);
    curveVertex(271, 325);
    curveVertex(264, 324);
    curveVertex(261, 325);
    curveVertex(260, 326);

    endShape();
    
    fill(63.0, 68.0, 80.0);
    //fill(0, 0, 255);
    ellipse(249, 322, 26, 13);
    fill(0);
    ellipse(249, 322, 5, 5);
    fill(125, 125, 125);
    ellipse(250, 322, 3, 3);
    noFill();
    
      // Nose
    stroke(120.0, 84.0, 50.0);
    beginShape();
    curveVertex(166, 345);
    curveVertex(157, 366);
    curveVertex(156, 375);
    curveVertex(156, 383);
    curveVertex(165, 386);
    curveVertex(172, 384);
    curveVertex(179, 388);
    curveVertex(187, 391);
    curveVertex(195, 391);
    curveVertex(202, 385);
    curveVertex(207, 384);
    curveVertex(215, 388);
    curveVertex(225, 385);
    curveVertex(231, 378);
    curveVertex(226, 370);
    curveVertex(224, 366);
    curveVertex(220, 359);
    endShape();
    //noStroke();
    
    line(166, 386, 125, 558);
    line(182, 390, 142, 563);
      // Hair
    //fill(209.0, 203.0, 187.0);

    beginShape();
    //curveVertex(330, 391);
    //curveVertex(324, 410);
    //curveVertex(316, 430);
    //curveVertex(308, 449);
    //curveVertex(300, 464);
    //curveVertex(287, 480);
    //curveVertex(272, 490);
    //curveVertex(252, 506);
    //curveVertex(240, 514);
    //curveVertex(226, 520);
    //curveVertex(205, 524);
    //curveVertex(192, 523);
    //curveVertex(177, 513);
    //curveVertex(165, 503);
    //curveVertex(160, 496);
    //curveVertex(141, 479);
    //curveVertex(129, 466);
    //curveVertex(119, 458);
    //curveVertex(109, 443);
    //curveVertex(102, 431);
    //curveVertex(96, 416);
    //curveVertex(95, 412);
    //curveVertex(91, 409);
    //curveVertex(87, 404);
    //curveVertex(87, 399);
    //curveVertex(88, 394);
    //curveVertex(85, 380);
    //curveVertex(82, 365);
    //curveVertex(75, 350);
    //curveVertex(70, 330);
    //curveVertex(62, 315);
    //curveVertex(55, 296);
    //curveVertex(51, 282);
    //curveVertex(49, 270);
    //curveVertex(50, 251);
    //curveVertex(52, 236);
    //curveVertex(56, 223);
    //curveVertex(62, 202);
    //curveVertex(69, 189);
    //curveVertex(77, 171);
    //curveVertex(86, 159);
    //curveVertex(95, 146);
    //curveVertex(109, 130);
    //curveVertex(125, 120);
    //curveVertex(141, 109);
    //curveVertex(155, 103);
    //curveVertex(167, 99);
    //curveVertex(186, 95);
    //curveVertex(196, 91);
    //curveVertex(207, 93);
    //curveVertex(219, 90);
    //curveVertex(236, 87);
    //curveVertex(250, 89);
    //curveVertex(261, 91);
    //curveVertex(273, 94);
    //curveVertex(284, 102);
    //curveVertex(294, 109);
    //curveVertex(301, 115);
    //curveVertex(314, 124);
    //curveVertex(324, 134);
    //curveVertex(334, 142);
    //curveVertex(343, 151);
    //curveVertex(352, 161);
    //curveVertex(360, 174);
    //curveVertex(366, 183);
    //curveVertex(373, 202);
    //curveVertex(373, 219);
    //curveVertex(375, 236);
    //curveVertex(370, 251);
    //curveVertex(367, 264);
    //curveVertex(369, 274);
    //curveVertex(369, 286);
    //curveVertex(371, 296);
    //curveVertex(377, 304);
    //curveVertex(386, 311);
    //curveVertex(395, 310);
    //curveVertex(402, 299);
    //curveVertex(405, 287);
    //curveVertex(403, 279);
    //curveVertex(400, 273);
    //curveVertex(392, 270);
    //curveVertex(386, 271);
    //curveVertex(378, 271);
    //curveVertex(385, 269);
    //curveVertex(390, 268);
    //curveVertex(396, 269);
    //curveVertex(403, 271);
    //curveVertex(410, 279);
    //curveVertex(412, 284);
    //curveVertex(411, 295);
    //curveVertex(408, 304);
    //curveVertex(403, 316);
    //curveVertex(396, 317);
    //curveVertex(388, 319);
    //curveVertex(381, 316);
    //curveVertex(375, 314);
    //curveVertex(375, 320);
    //curveVertex(375, 325);
    //curveVertex(372, 335);
    //curveVertex(373, 341);
    //curveVertex(372, 352);
    //curveVertex(373, 361);
    //curveVertex(370, 364);
    //curveVertex(367, 360);
    //curveVertex(367, 353);
    //curveVertex(365, 360);
    //curveVertex(362, 370);
    //curveVertex(362, 381);
    //curveVertex(361, 390);
    //curveVertex(359, 399);
    //curveVertex(349, 404);
    //curveVertex(341, 404);
    //curveVertex(336, 400);
    //curveVertex(331, 395);
    //curveVertex(306, 389);

    endShape(CLOSE);

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