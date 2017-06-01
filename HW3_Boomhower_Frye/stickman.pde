// Code for a walking stickman
// by geotheory.co.uk (2013)
Stickman Stanley;
int gnd;
int manSpeed;
int stage = 0;
int ballRadius = 20;
int fcSkit = 0;
int fcMove = 0;
double time = 0;
boolean catcher = false;
int delay = 0;
int countFourPasses = 0;
int countThreePasses = 0;

//void setup() {
//  size(200, 200);
//  gnd = height-20;
//  frameRate(60);
//  smooth();
//  Stanley = new Stickman(30);
//}

//void draw() {
//  background (200);
//  translate (width/2, gnd);
//  line (-width, 0, width, 0);
//  fill(0);
  
//  Stanley.stickman();
//}

class Stickman {
  int start = int(random(360));
  float t, tk, tf0, tf1, tw;
  float unit = 20;
  Knee[] knees = new Knee[2];
  Foot[] feet = new Foot[2];
  Elbow[] elbows = new Elbow[2];
  Hand[] hands = new Hand[2];

  Stickman(float UNIT) {
    for (int i=0; i<2; i++) {
      knees[i] = new Knee(i);
      feet[i] = new Foot(i);
      elbows[i] = new Elbow(i);
      hands[i] = new Hand(i);
    }
    unit = UNIT;
  }

  void stickman() {
    strokeWeight(2);
    
    if(stage == 2 | stage == 3 | stage == 4 | stage == 5 | stage == 6 | stage == 7) t = tk = tf0 = tf1 = tw = 0;
    else{
      t = (frameCount + start)%360;
      tk = sin (radians(t * 8));
      tf0 = sin (radians((t+12) * 8));
      tf1 = sin (radians((t-12) * 8));
      tw = sin (radians((t+82) * 16));
    }
    pushMatrix();
    translate(0, tw*2);
    pushMatrix();
    translate (0, -unit * 4.5);
    ellipse (0, 0, unit, unit);
    translate (0, unit * 0.5);
    for (Elbow e:elbows) e.move();
    //if(stage == 3){
    //  translate (0, unit * 1.7);
    //  rotate(-PI/2);
    //  line (0, 0, 0, unit * 1.7);
    //  rotate(PI/2);
    //}
    //else{
      line (0, 0, 0, unit * 1.7);
      translate (0, unit * 1.7);
    //}
    for (Knee k:knees) k.move();
    popMatrix ();
    popMatrix ();
    strokeWeight(1);
  }

  class Knee {
    int id, dir;
    PVector p = new PVector();
    Knee(int i) {
      id = i;
      if (i==0) dir = 1;
      else dir = -1;
    }
    void move() {
      if(stage == 2 | stage == 3 | stage == 4 | stage == 5 | stage == 6 | stage == 7){
        pushMatrix();
        rotate(dir * radians(10));
        line(0, 0, 0, unit*1.15);
        translate (0, unit*1.15);
        feet[id].move();
        popMatrix();
      }
      else{
        float angle = dir * radians(30*tk);
        pushMatrix ();
        rotate(angle);
        line(0, 0, 0, unit*1.15);
        translate (0, unit*1.15);
        feet[id].move();
        popMatrix ();
      }
    }
  }

  class Foot {
    float angle;
    int dir;
    PVector p = new PVector();
    Foot(int i) {
      if (i==0) dir = 1;
      else dir = -1;
    }
    void move() {
      if(stage == 2 | stage == 3 | stage == 4 | stage == 5 | stage == 6 | stage == 7){
        pushMatrix();
        rotate(dir * radians(-5));
        line(0, 0, 0, unit*1.15);
        translate (0, unit*1.15);
        popMatrix();
      }
      else{
        if (dir==-1) angle = radians(30*tf0 + 25);
        else angle = radians(30*tf1 + 25);
        pushMatrix();
        rotate(angle);
        line(0, 0, 0, unit*1.15);
        popMatrix();
      }
    }
  }

  class Elbow {
    int id, dir;
    PVector p = new PVector();
    Elbow(int i) {
      id = i;
      if (i==0) dir = 1;
      else dir = -1;
    }
    void move() {
      if(stage == 2 | stage == 3 | stage == 4 | stage == 5 | stage == 6 | stage == 7){
        pushMatrix();
        rotate(dir * radians(10));
        line(0, 0, 0, unit*1.1);
        translate (0, unit*1.1);
        hands[id].move();
        popMatrix();
      }
      else{
        float angle = -dir * radians(30*tk);
        pushMatrix ();
        rotate(angle);
        line(0, 0, 0, unit*1.1);
        translate (0, unit*1.1);
        hands[id].move();
        popMatrix ();
      }
    }
  }

  class Hand {
    float angle;
    int dir;
    PVector p = new PVector();
    Hand(int i) {
      if (i==0) dir = 1;
      else dir = -1;
    }
    void move() {
      if(stage == 2 | stage == 3 | stage == 5 | stage == 6 | stage == 7){
        if(catcher == true & dir == -1 & gravity > 0){
          pushMatrix();
          rotate(-PI/2);
          line(0, 0, 0, unit*1.1);
          popMatrix();
        }
        else if(ballX < width/2){
          pushMatrix();
          rotate(PI/1.5);
          line(0, 0, 0, unit*1.1);
          popMatrix();
        }
        else{
          pushMatrix();
          rotate(radians(-10));
          line(0, 0, 0, unit*1.1);
          translate (0, unit*1.1);
          popMatrix();
        }
      }
      else if(stage == 4){
        if(dir == -1){
          pushMatrix();
          rotate(-PI/3);
          line(0, 0, 0, unit*1.1);
          popMatrix();
        }
        else{
          pushMatrix();
          rotate(radians(-10));
          line(0, 0, 0, unit*1.1);
          translate (0, unit*1.1);
          popMatrix();
        }
      }
      else{
        if (dir==-1) angle = -radians(30*tf0 + 25);
        else angle = -radians(30*tf1 + 25);
        pushMatrix();
        rotate(angle);
        line(0, 0, 0, unit*1.1);
        popMatrix();
      }
    }
  }
}

void skit(){
  stroke(0);
  fill(0);
  //if(frameCount < 120) stage = 0;
  //else if(frameCount > 120) stage = 1;
  //else if(manSpeed > width/2) stage = 2;
  switch(stage){
    case 0: // Opening door
      println(stage);
      openDoor();
      if(fcSkit > 120) stage = 1;
      stillBall();
      fcSkit++;
      break;
    case 1:
      println(manSpeed, width/2);
      pushMatrix();
      manSpeed = (fcMove-120)*3;
      translate (manSpeed, gnd);   
      Stanley.stickman();
      popMatrix();
      stillDoor();
      stillBall();
      if(manSpeed > width/2 + 20){
        stage = 2;
        time = frameCount;
      }
      break;
    case 2: // Walking to ball
      println(stage);
      pushMatrix();
      translate(width/2 + 20, gnd);
      Stanley.stickman();
      popMatrix();
      stillDoor();
      stillBall();
      if(frameCount - time > 120) stage = 3;
      break;
    case 3: // Picking up ball
      println(stage);
      pushMatrix();
      translate(width/2 + 20, gnd);
      Stanley.stickman();
      popMatrix();
      stillDoor();
      pickupBall();
      if(pubFlag) delay++;
      if(delay > 90 & countThreePasses == 0){
        delay = 0;
        pubFlag = false;
        stage = 4;
        countThreePasses = 1;
      }
      else if(delay > 90 & countThreePasses == 1){
        delay = 0;
        pubFlag = false;
        stage = 4;
        countThreePasses = 2;
      }
      break;
    case 4: // Winding up to throw ball
      println(stage);
      pushMatrix();
      translate(width/2 + 20, gnd);
      Stanley.stickman();
      popMatrix();
      stillDoor();
      throwBall1p1();
      if(delay > 30 & countFourPasses == 0){
        delay = 0;
        stage = 5;
        countFourPasses = 1;
      }
      else if(delay > 30 & countFourPasses == 1){
        delay = 0;
        stage = 6;
        countFourPasses = 2;
      }
      else if(delay > 30 & countFourPasses == 2){
        delay = 0;
        stage = 7;
        throwSpeedY = 7;
        throwSpeedX = 4;
        countFourPasses = 3;
      }
      break;
    case 5: // Throwing ball 1st time
      println(stage);
      pushMatrix();
      translate(width/2 + 20, gnd);
      Stanley.stickman();
      popMatrix();
      stillDoor();
      throwBall1p2();
      if(actionC == true) delay++;
      if(delay > 60){
        delay = 0;
        actionC = false;
        throwSpeedY = 5;
        stage = 4;
      }
      break;
    case 6: // Throwing ball 2nd time
      println(stage);
      pushMatrix();
      translate(width/2 + 20, gnd);
      Stanley.stickman();
      popMatrix();
      stillDoor();
      throwBall2p2();
      if(actionC == true) delay++;
      if(delay > 45){
        pickupSpeedX = 0.3;
        pickupSpeedY = 5;
        actionC = false;
        stage = 3;
      }
      break;
    case 7: // Throwing ball 3rd time
      println(ballX);
      pushMatrix();
      translate(width/2 + 20, gnd);
      Stanley.stickman();
      popMatrix();
      stillDoor();
      throwBall2p2();
      //if(actionC == true) delay++;
      //if(delay > 45){
      //  pickupSpeedX = 0.3;
      //  pickupSpeedY = 5;
      //  actionC = false;
      //  stage = 3;
      //}
      break;
    default:
      println("No action");
      break;
  }
}