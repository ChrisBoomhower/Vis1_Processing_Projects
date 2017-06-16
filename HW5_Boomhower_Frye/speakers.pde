void speaker(float xloc1, float yloc1, float xloc2, float yloc2, float xloc3, float yloc3, float xloc4, float yloc4, float scale1, float scale2, float scale3, float scale4){
  float volume;
  stroke(0);
  pushMatrix();
  translate(xloc1, yloc1);
  for ( PVector p : points1 ) {
        //ellipse(p.x, p.y, 4,4);
        point(p.x, p.y);
    }
  popMatrix();
  pushMatrix();
  translate(xloc2, yloc2);
  for ( PVector p : points2 ) {
        //ellipse(p.x, p.y, 4,4);
        point(p.x, p.y);
    }
  popMatrix();
  pushMatrix();
  translate(xloc3, yloc3);
  for ( PVector p : points3 ) {
        //ellipse(p.x, p.y, 4,4);
        point(p.x, p.y);
    }
  popMatrix();
  pushMatrix();
  translate(xloc4, yloc4);
  for ( PVector p : points4 ) {
        //ellipse(p.x, p.y, 4,4);
        point(p.x, p.y);
    }
  popMatrix();
  
  volume = amplitude * 100;
  explode(scale1, scale2, scale3, scale4, volume) ;
}

void explode(float scale1, float scale2, float scale3, float scale4, float volume) {
    for (PVector p : points1 ) {
        p.x = random(-volume*gain/scale1,volume*gain/scale1) ;
        p.y = random(-volume*gain/scale1,volume*gain/scale1) ;
    }
    for (PVector p : points2 ) {
        p.x = random(-volume*gain/scale2,volume*gain/scale2) ;
        p.y = random(-volume*gain/scale2,volume*gain/scale2) ;
    }
    for (PVector p : points3 ) {
        p.x = random(-volume*gain/scale3,volume*gain/scale3) ;
        p.y = random(-volume*gain/scale3,volume*gain/scale3) ;
    }
    for (PVector p : points4 ) {
        p.x = random(-volume*gain/scale4,volume*gain/scale4) ;
        p.y = random(-volume*gain/scale4,volume*gain/scale4) ;
    }
}