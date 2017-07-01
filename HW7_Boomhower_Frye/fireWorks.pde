class Particle {

  // fields
  PVector loc;
  PVector velocity;
  float scl;
  PImage p;
  float red;
  float green;
  float blue;

  // constructors
  Particle() {
  }

  Particle(PVector loc, PVector velocity, float scl, String particleSpriteURL) {
    this.loc = loc;
    this.scl = scl;
    this.velocity = velocity;
    p = loadImage(particleSpriteURL);
    this.red = random(0,255);
    this.green = random(0,255);
    this.blue = random(0,255);
  }

  void move() {
    loc.add(velocity);
  }

  void display() {
    pushMatrix();
    translate(loc.x, loc.y);
    scale(scl);
    if (p != null) {
      image(p, -p.width/2, -p.height/2);
    }
    else {
      noStroke();
      fill(red, green, blue);
      ellipse(0, 0, 1, 1);
    }
    popMatrix();
  }
}

class Emitter {

  // fields
  PVector loc;
  int particleCount;
  float particleBirthRate;
  PVector sprayVector;
  float sprayRadius;
  boolean isInfinite = false;
  Particle[] particles;
  float currentParticleCount = 0;
  String particleSpriteURL;
  float particleScale = 1;

  // constructors
  Emitter() {
  }

  Emitter(PVector loc, int particleCount, float particleBirthRate, PVector sprayVector, 
    float sprayRadius, boolean isInfinite) {
    this.loc = loc;
    this.particleCount = particleCount;
    this.particleBirthRate = particleBirthRate;
    this.sprayVector = sprayVector;
    this.sprayRadius = sprayRadius;
    this.isInfinite = isInfinite;

    particles = new Particle[particleCount];
    init();
  }

  Emitter(PVector loc, int particleCount, float particleBirthRate, PVector sprayVector, 
    float sprayRadius, boolean isInfinite, String particleSpriteURL, float particleScale) {
    this.loc = loc;
    this.particleCount = particleCount;
    this.particleBirthRate = particleBirthRate;
    this.sprayVector = sprayVector;
    this.sprayRadius = sprayRadius;
    this.isInfinite = isInfinite;
    this.particleSpriteURL = particleSpriteURL;
    this.particleScale = particleScale;

    particles = new Particle[particleCount];
    init();
  }
  
  void init() {
    for(int i=0; i<particles.length; i++) {
      float scl = random(1, particleScale);
      PVector vel = new PVector(sprayVector.x + random(-sprayRadius, sprayRadius),
        sprayVector.y + random(-sprayRadius, sprayRadius));
      particles[i] = new Particle(new PVector(loc.x, loc.y), vel, scl, particleSpriteURL);
    }
  }
  
  void run(float gravity, PVector turbulance, PVector wind) {
    for (int i=0; i<currentParticleCount; i++) {
      particles[i].velocity.y += gravity;
      particles[i].velocity.add(new PVector(random(-turbulance.x, turbulance.x), random(-turbulance.y, turbulance.y)));
      particles[i].velocity.add(wind);
      particles[i].move();
      particles[i].display();
      
      // reset particles
      if (isInfinite) {
        if (particles[i].loc.y>height || particles[i].loc.x>width || particles[i].loc.x<0) {
          particles[i].loc = new PVector(loc.x, loc.y);
          particles[i].velocity = new PVector(sprayVector.x + random(-sprayRadius, sprayRadius),
            sprayVector.y + random(-sprayRadius, sprayRadius));
        }
      }
    }
    if (currentParticleCount < particleCount - particleBirthRate) {
      currentParticleCount += particleBirthRate;
    }
  }
}

class Engine {
  
  // fields
  Emitter emitter;
  Emitter[] emitters;
  float gravity;
  PVector turbulance;
  PVector wind;
  
  Engine() {
  }
  
  Engine(Emitter emitter, float gravity, PVector turbulance, PVector wind) {
    this.emitter = emitter;
    this.gravity = gravity;
    this.turbulance = turbulance;
    this.wind = wind;
  }
  
  Engine(Emitter[] emitters) {
    this.emitters = emitters;
  }
  
  void start() {
    fill(0, 100);
    noStroke();
    rect(-1, -1, width+1, height+1);
    stroke(0, 255, 0);
    emitter.run(gravity, turbulance, wind);
  }
  
  void stop() {
  }
  
}

int particleCount = 100;

float[] x = new float[particleCount];
float[] y = new float[particleCount];
float[] fSpeedX = new float[particleCount];
float[] fSpeedY = new float[particleCount];
float[] gravity = new float[particleCount];

float[] x2 = new float[particleCount];
float[] y2 = new float[particleCount];
float[] fSpeedX2 = new float[particleCount];
float[] fSpeedY2 = new float[particleCount];
float[] gravity2 = new float[particleCount];

void fireworks() {
  //float[] burstX = new float[5];
  //float[] burstY = new float[5];
  fill(0, 20);
  noStroke();
  rect(-1, -1, width+1, height+1);
  stroke(0, 255, 0);

  if (frameCount % int(random(125, 175)) == 0) {
    float xRand = random(-200, 200);
    float yRand = random(-200, 200);
    for (int i = 0; i < particleCount; i++) {
      x[i] = width/2 + xRand;
      y[i] = height/3 + yRand;
      fSpeedX[i] = random(-1.2, 1.2);
      fSpeedY[i] = random(-4, -2);
      gravity[i] = 0.07;
    }
  }

  if (frameCount % int(random(125, 175)) == 0) {
    float xRand = random(-200, 200);
    float yRand = random(-200, 200);
    for (int i = 0; i < particleCount; i++) {
      x2[i] = width/2 + xRand;
      y2[i] = height/3 + yRand;
      fSpeedX2[i] = random(-1.2, 1.2);
      fSpeedY2[i] = random(-4, -2);
      gravity2[i] = 0.07;
    }
  }

  burst(x, y, fSpeedX, fSpeedY, gravity);
  burst(x2, y2, fSpeedX2, fSpeedY2, gravity2);

  if (frameCount % 60 == 0) showText = !showText;

  if (showText == true)fill(255);
  else fill(0);
  textFont(fontGaming);
  textAlign(CENTER, CENTER);
  text("You Win!", width/2, height/2);

  if (frameCount - fc > 3600) file.stop();
}
void burst(float[] x, float[] y, float[] fSpeedX, float[] fSpeedY, float[] gravity) {
  strokeWeight(1);
  for (int i = 0; i < particleCount; i++) {
    stroke(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
    rect(x[i], y[i], 1, 1);
    x[i] += fSpeedX[i];
    fSpeedY[i] += gravity[i];
    y[i] += fSpeedY[i];
  }
}