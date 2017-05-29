/******************************************************************************************
 Custom Shapes Repository
 - star
 - moon
 ******************************************************************************************/

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void sun() {
  pushMatrix();
  noStroke();
  fill(251, 219, 31);
  translate(-500, -400);
  rotate((PI / 6 * -.5) - SunPivot);
  star(0, 0, 30, 50, 6);
  popMatrix();

  pushMatrix();
  noStroke();
  fill(234, 142, 3);
  translate(-500, -400);
  rotate((PI / 6 * +.5) + SunPivot);
  star(0, 0, 30, 50, 6);
  popMatrix();
}

void moon() {
  pushMatrix();
  noStroke();
  translate(-500, -400);
  rotate(HALF_PI);

  idVertexStart = -floor(map(1000, 0, width*2, floor(nbSamples*0.5), 0));
  idVertexEnd = floor(map(1000, 0, width*2, floor(nbSamples*0.5), 0));

  //println(idVertexStart, idVertexEnd);
  deltaIndex = idVertexEnd-idVertexStart;
  idVertexStartInsideCrescent = -floor((nbSamples-deltaIndex)*0.5);
  idVertexEndInsideCrescent = floor((nbSamples-deltaIndex)*0.5);


  fill(220, 220, 220);
  beginShape();

  // Outside crescent
  for (int i=idVertexStart; i<idVertexEnd; i++) {
    if (i < 0) {
      vertex(ptsCircle[nbSamples+i][0], ptsCircle[nbSamples+i][1]);
    } else {
      vertex(ptsCircle[i][0], ptsCircle[i][1]);
    }
  }
  if (deltaIndex < nbSamples) {
    vertex(ptsCircle[idVertexEnd][0], ptsCircle[idVertexEnd][1]);
  }

  // to manage the translation of inside crescent
  if (deltaIndex > floor(nbSamples*0.5)) {
    int nbIndexDelta = deltaIndex-floor(nbSamples*0.5);
    for (int i = 0; i < nbIndexDelta; i++) {
      deltaX+= ptsCircle[(nbSamples+idVertexStart)+i][0];
    }
  }

  // Inside crescent
  for (int i=idVertexEndInsideCrescent; i>idVertexStartInsideCrescent; i--) {
    if (i < 0) {
      vertex(ptsCircle[nbSamples+i][0]+(deltaX*2), ptsCircle[nbSamples+i][1]);
    } else {
      vertex(ptsCircle[i][0]+(deltaX*2), ptsCircle[i][1]);
    }
  }
  endShape(CLOSE);

  deltaX = 0;
  popMatrix();
}