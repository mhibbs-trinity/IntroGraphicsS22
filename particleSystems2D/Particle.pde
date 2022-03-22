
class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  
  float mass = 1;

  Particle(PVector l) {
    acc = new PVector(0,0);
    vel = new PVector(random(-2,2),random(-2,2));
    loc = l.copy();
    lifespan = 255.0;
  }
  Particle() {
    this(new PVector(0,0));
  }

  void run() {
    update();
    display();
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acc.add(f);
  }

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(0,lifespan);
    strokeWeight(2);
    fill(127,lifespan);
    ellipse(loc.x,loc.y,12,12);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
