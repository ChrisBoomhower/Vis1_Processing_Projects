

void wave(int run, float mag, float depth) {

  // Only oscillate if new occurrence
  if (run >= waveCount) {

    // Draw magnitude oscillation
    stroke(142, 68, 173);
    quiet = false;
    noFill();
    beginShape();
    for (float w = 20; w < width/3 + 20; w += 5) {
      float h = height/1.5;
      h += -abs(mag * 100 * sin(w + count * 0.07 + TWO_PI / 2) * pow(abs(sin(w * 0.001 + count * 0.02)), 5));
      curveVertex(w, h);
    }    
    endShape();

    // Draw depth oscillations
    stroke(30, 132, 73);
    beginShape();
    for (float w = 20; w < width/3 + 20; w += 5) {
      float h = height/1.5;
      h += abs(depth * 2 * sin(w * .005 + TWO_PI / 2) * pow((sin(w * 0.001 + count * 0.02)), 5));
      curveVertex(w, h);
    }    
    endShape();

    count++;

    // Used for count range definition only
    //if (abs(100 * sin(30 * .005 + TWO_PI / 2) * pow((sin(30 * 0.001 + count * 0.02)), 5)) < .000000001) { //Wait until h practically zero
    //  println ((frameCount - 0) + " h zeroed out");
    //}

    // Reset count after full cycle and increment wavecount
    if (count == 153) {
      count = 0;
      waveCount++;
      quiet = true;
    }
  }

  // If no new activity, draw straight line
  else if (quiet == true) {
    stroke(30, 132, 73);
    line(20, height/1.5, width/3 + 13, height/1.5);
  }
}