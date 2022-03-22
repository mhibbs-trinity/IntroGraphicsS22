class ImageParticle extends Particle {

  PImage img;
  float rotation;
  color startColor;
  color endColor;

  ImageParticle(PVector l,PImage img_,color start,color end) {
    //super(l);
    acc = new PVector(0,-0.1);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 3.0;
    vel = new PVector(vx,vy);
    loc = l.copy();
    lifespan = 1.0;
    img = img_;
    rotation = randomGaussian()*PI/8;
    startColor = start;
    endColor = end;
  }

  void run() {
    render();
    update();
  }
  
  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void applyForce(PVector f) {
    acc.add(f);
  }  

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= 0.025;
    acc.mult(0); // clear Acceleration
    rotation += randomGaussian()*PI/32;
  }

  // Method to display
  void render() {
    pushMatrix();
    translate(loc.x,loc.y);
    rotate(rotation);
    imageMode(CENTER);
    tint(lerpColor(endColor,startColor,lifespan));
    image(img,0,0);
    popMatrix();
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
