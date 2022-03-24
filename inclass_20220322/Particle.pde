

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  color c;
  float r;
  
  Particle(PVector l) {
    acc = new PVector(0,0);
    vel = new PVector(random(-2,2), random(-2,0));
    loc = l.copy();
    lifespan = 255.0;
    c = color(random(0,200));
    r = random(5,15);
  }
  void display() {
    stroke(0,lifespan);
    strokeWeight(2);
    fill(c,lifespan);
    ellipse(loc.x,loc.y, r,r);
  }
  void update() {
    loc.add(vel);
    vel.add(acc);
    acc.mult(0);
    lifespan -= 2;
  }
  void applyForce(PVector force) {
    acc.add(force); 
  }
  
}
