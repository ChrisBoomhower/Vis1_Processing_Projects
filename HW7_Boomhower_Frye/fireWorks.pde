/**********************************************************
 Particle, Emitter, and Engine classes for confetti
 generation on youWin endgame screen
 
 Direct Reference:
 Code adapted and modified from Ira Greenberg's MSDS 6390
 OOP Particle Engine Demo, Parts 1-3
***********************************************************/

class Particle {

  // fields
  PVector loc;
  PVector velocity;
  float scl;
  float red;
  float green;
  float blue;

  // constructors
  Particle() {
  }

  Particle(PVector loc, PVector velocity, float scl, boolean colRand) {
    this.loc = loc;
    this.scl = scl;
    this.velocity = velocity;
    if (colRand == true) {
      this.red = random(0, 255);
      this.green = random(0, 255);
      this.blue = random(0, 255);
    }
    else {
      this.red = 241;
      this.green = 196;
      this.blue = 15;
    }
  }

  void move() {
    loc.add(velocity);
  }

  void display() {
    pushMatrix();
    translate(loc.x, loc.y);
    scale(scl);
    noStroke();
    fill(red, green, blue);
    ellipse(0, 0, 1, 1);
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
  boolean colRand;

  // constructors
  Emitter() {
  }

  Emitter(PVector loc, int particleCount, float particleBirthRate, PVector sprayVector, 
    float sprayRadius, boolean isInfinite, boolean colRand) {
    this.loc = loc;
    this.particleCount = particleCount;
    this.particleBirthRate = particleBirthRate;
    this.sprayVector = sprayVector;
    this.sprayRadius = sprayRadius;
    this.isInfinite = isInfinite;
    this.colRand = colRand;

    particles = new Particle[particleCount];
    init();
  }

  Emitter(PVector loc, int particleCount, float particleBirthRate, PVector sprayVector, 
    float sprayRadius, boolean isInfinite, float particleScale, boolean colRand) {
    this.loc = loc;
    this.particleCount = particleCount;
    this.particleBirthRate = particleBirthRate;
    this.sprayVector = sprayVector;
    this.sprayRadius = sprayRadius;
    this.isInfinite = isInfinite;
    this.particleScale = particleScale;
    this.colRand = colRand;

    particles = new Particle[particleCount];
    init();
  }

  void init() {
    for (int i=0; i<particles.length; i++) {
      float scl = random(1, particleScale);
      PVector vel = new PVector(sprayVector.x + random(-sprayRadius, sprayRadius), 
        sprayVector.y + random(-sprayRadius, sprayRadius));
      particles[i] = new Particle(new PVector(loc.x, loc.y), vel, scl, colRand);
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
    emitter.run(gravity, turbulance, wind);
  }

  void stop() {
  }
}