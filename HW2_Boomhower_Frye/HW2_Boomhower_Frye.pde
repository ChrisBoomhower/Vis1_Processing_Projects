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
    //stroke(255, 10, 10);
    strokeJoin(ROUND);
    fill(192.0, 161.0, 115.0);
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
    curveVertex(75, 300);
    curveVertex(75, 282);
    curveVertex(75, 259);
    curveVertex(95, 229);
    curveVertex(104, 215);
    curveVertex(115, 204);
    curveVertex(135, 195);
    curveVertex(150, 190);
    curveVertex(170, 180);
    curveVertex(207, 191);
    curveVertex(229, 199);
    curveVertex(255, 188);
    curveVertex(280, 223);
    curveVertex(289, 243);
    curveVertex(301, 263);
    curveVertex(313, 279);
    curveVertex(324, 280);
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
    
    stroke(55.0, 52.0, 43.0);
    curve(160, 339, 160, 339, 148, 348, 119, 354);
    curve(160, 339, 148, 348, 119, 354, 119, 354);
    //noStroke();
    
      // Left eyebrow
    fill(126.0, 101.0, 73.0);
    beginShape();
    vertex(160, 312);
    vertex(135, 307);
    vertex(119, 307);
    vertex(90, 321);
    vertex(85, 312);
    vertex(106, 302);
    vertex(128, 294);
    vertex(156, 304);
    endShape(CLOSE);    
    
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
    
    stroke(55.0, 52.0, 43.0);
    curve(226, 337, 226, 337, 235, 344, 257, 348);
    curve(226, 337, 235, 344, 257, 348, 257, 348);
    //noStroke();
    
      // Right eyebrow
    fill(126.0, 101.0, 73.0);
    beginShape();
    vertex(300, 320);
    vertex(277, 306);
    vertex(253, 304);
    vertex(222, 314);
    vertex(222, 304);
    vertex(250, 293);
    vertex(272, 290);
    vertex(303, 312);
    endShape(CLOSE);
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
    
      // Crayon
    fill(41.0, 108.0, 117.0);
    stroke(0);
    strokeJoin(MITER);
    beginShape();
    vertex(165, 385);
    vertex(125, 552);
    vertex(126, 552);
    vertex(124, 558);
    vertex(127, 560);
    vertex(141, 563);
    vertex(143, 554);
    vertex(182, 392);
    vertex(177, 386);
    vertex(171, 384);
    vertex(166, 385);
    //vertex(164, 387);
    endShape(CLOSE);
    noFill();
    
      // Mouth
    fill(114.0, 79.0, 66.0);
    //stroke(120.0, 84.0, 50.0);
    //stroke(0);
    noStroke();
    beginShape();
    vertex(175, 422);
    vertex(186, 422);
    vertex(192, 423);
    vertex(204, 421);
    vertex(230, 424);
    vertex(252, 430);
    vertex(239, 452);
    vertex(221, 470);
    vertex(202, 476);
    vertex(182, 472);
    vertex(166, 460);
    vertex(169, 449);
    vertex(184, 459);
    vertex(203, 463);
    vertex(224, 455);
    vertex(236, 446);
    vertex(242, 429);
    vertex(225, 425);
    vertex(203, 424);
    vertex(192, 425);
    vertex(187, 425);
    vertex(175, 424);
    endShape();
    
    triangle(153, 439, 148, 433, 155, 429);
    
      // Teeth
    fill(255);
    noStroke();
    triangle(224, 425, 228, 429, 230, 426);
    quad(211, 424, 218, 425, 217, 426, 211, 426);
    triangle(207, 424, 204, 427, 200, 424);
    rect(183, 425, 7, 1);
    triangle(177, 424, 178, 424, 176, 425);
    beginShape();
    vertex(239, 438);
    vertex(236, 446);
    vertex(233, 448);
    vertex(234, 441);
    vertex(238, 437);
    endShape();
    beginShape();
    vertex(174, 429);
    vertex(179, 439);
    vertex(181, 447);
    vertex(179, 454);
    vertex(170, 448);
    //vertex(173, 428);
    endShape(CLOSE);
    noFill();
    
    stroke(55.0, 52.0, 43.0);
    beginShape();
    vertex(177, 481);
    vertex(185, 486);
    vertex(217, 485);
    vertex(225, 480);
    endShape();

    
      // Cheeks
    stroke(55.0, 52.0, 43.0);
    curve(239, 386, 239, 386, 260, 420, 261, 436);
    curve(239, 386, 260, 420, 261, 436, 261, 436);
    curve(147, 390, 147, 390, 140, 400, 135, 416);
    curve(147, 390, 140, 400, 135, 416, 135, 416);
    noStroke();
    
      // Right Ear
    stroke(55.0, 52.0, 43.0);
    beginShape();
    curveVertex(338, 374);
    curveVertex(338, 374);
    curveVertex(345, 373);
    curveVertex(351, 377);
    curveVertex(356, 368);
    curveVertex(360, 349);
    curveVertex(358, 329);
    curveVertex(353, 334);
    curveVertex(353, 334);
    endShape();
    
    curve(344, 331, 344, 331, 339, 355, 329, 388);
    curve(344, 331, 339, 355, 329, 388, 329, 388);
    noStroke();
    
      // Hair
    fill(255, 244, 166);
    beginShape();
    curveVertex(81, 297);
    curveVertex(78, 327);
    curveVertex(80, 368);
    curveVertex(80, 370);
    curveVertex(76, 350);
    curveVertex(69, 332);
    curveVertex(50, 291);
    curveVertex(47, 258);
    curveVertex(50, 233);
    curveVertex(65, 200);
    curveVertex(70, 195);
    curveVertex(58, 203);
    curveVertex(56, 201);
    curveVertex(75, 174);
    curveVertex(89, 152);
    curveVertex(115, 125);
    curveVertex(150, 105);
    curveVertex(183, 96);
    curveVertex(195, 90);
    curveVertex(210, 91);
    curveVertex(226, 90);
    curveVertex(238, 92);
    curveVertex(252, 92);
    curveVertex(276, 100);
    curveVertex(295, 110);
    curveVertex(314, 125);
    curveVertex(335, 143);
    curveVertex(354, 164);
    curveVertex(368, 190);
    curveVertex(374, 207);
    curveVertex(375, 227);
    curveVertex(368, 252);
    curveVertex(366, 272);
    curveVertex(368, 289);
    curveVertex(377, 306);
    curveVertex(387, 313);
    curveVertex(401, 298);
    curveVertex(405, 282);
    curveVertex(398, 274);
    curveVertex(380, 273);
    curveVertex(387, 269);
    curveVertex(398, 269);
    curveVertex(408, 280);
    curveVertex(409, 291);
    curveVertex(407, 302);
    curveVertex(400, 316);
    curveVertex(387, 322);
    curveVertex(376, 314);
    curveVertex(372, 330);
    curveVertex(371, 343);
    curveVertex(371, 357);
    curveVertex(368, 367);
    curveVertex(366, 359);
    curveVertex(367, 348);
    curveVertex(364, 333);
    curveVertex(362, 328);
    curveVertex(358, 328);
    curveVertex(357, 340);
    curveVertex(356, 352);
    curveVertex(356, 364);
    curveVertex(352, 371);
    curveVertex(350, 361);
    curveVertex(348, 358);
    curveVertex(345, 364);
    curveVertex(343, 366);
    curveVertex(343, 352);
    curveVertex(344, 333);
    curveVertex(339, 318);
    curveVertex(333, 301);
    curveVertex(324, 290);
    curveVertex(304, 269);
    curveVertex(295, 255);
    curveVertex(287, 239);
    curveVertex(268, 219);
    curveVertex(265, 200);
    curveVertex(258, 192);
    curveVertex(251, 192);
    curveVertex(247, 203);
    curveVertex(240, 202);
    curveVertex(237, 218);
    curveVertex(232, 223);
    curveVertex(228, 219);
    curveVertex(228, 206);
    curveVertex(219, 223);
    curveVertex(212, 207);
    curveVertex(208, 205);
    curveVertex(202, 223);
    curveVertex(198, 206);
    curveVertex(192, 201);
    curveVertex(182, 215);
    curveVertex(165, 237);
    curveVertex(146, 250);
    curveVertex(162, 231);
    curveVertex(173, 216);
    curveVertex(181, 200);
    curveVertex(182, 193);
    curveVertex(180, 183);
    curveVertex(166, 192);
    curveVertex(158, 188);
    curveVertex(153, 202);
    curveVertex(147, 217);
    curveVertex(140, 224);
    curveVertex(145, 209);
    curveVertex(145, 203);
    curveVertex(134, 210);
    curveVertex(116, 215);
    curveVertex(102, 223);
    curveVertex(92, 233);
    curveVertex(82, 250);
    curveVertex(81, 272);
    curveVertex(79, 286);
    endShape(CLOSE);
    
    fill(255, 255, 204);
    beginShape();
    curveVertex(76, 183);
    curveVertex(76, 183);
    curveVertex(86, 157);
    curveVertex(104, 134);
    curveVertex(137, 110);
    curveVertex(162, 100);
    curveVertex(197, 92);
    curveVertex(209, 94);
    curveVertex(224, 89);
    curveVertex(256, 95);
    curveVertex(295, 109);
    curveVertex(323, 133);
    curveVertex(350, 158);
    curveVertex(368, 188);
    curveVertex(375, 226);
    curveVertex(363, 245);
    curveVertex(346, 247);
    curveVertex(360, 224);
    curveVertex(344, 225);
    curveVertex(352, 209);
    curveVertex(335, 211);
    curveVertex(332, 190);
    curveVertex(312, 193);
    curveVertex(308, 165);
    curveVertex(294, 178);
    curveVertex(276, 152);
    curveVertex(266, 161);
    curveVertex(258, 147);
    curveVertex(252, 162);
    curveVertex(245, 142);
    curveVertex(238, 151);
    curveVertex(232, 146);
    curveVertex(229, 159);
    curveVertex(221, 144);
    curveVertex(218, 149);
    curveVertex(215, 136);
    curveVertex(211, 155);
    curveVertex(198, 145);
    curveVertex(201, 152);
    curveVertex(192, 143);
    curveVertex(214, 162);
    curveVertex(207, 162);
    curveVertex(190, 149);
    curveVertex(180, 145);
    curveVertex(179, 153);
    curveVertex(166, 141);
    curveVertex(161, 150);
    curveVertex(150, 143);
    curveVertex(139, 155);
    curveVertex(135, 146);
    curveVertex(128, 151);
    curveVertex(124, 143);
    curveVertex(117, 155);
    curveVertex(104, 155);
    curveVertex(93, 167);
    curveVertex(90, 166);
    curveVertex(81, 182);
    curveVertex(81, 182);
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