class Particle {
  private PVector loc;
  private PVector vel;
  private PVector acc;
  
  public color fillCol = color(0);
  public float r = 5;

  public float mass = 1;

  Particle(PVector l, float rad) {
    this(l);
    r = rad;
  }
  Particle(PVector l) {
    acc = new PVector(0,0);
    vel = new PVector(random(-2,2),random(-2,2));
    loc = l.copy();
  }
  Particle() {
    this(new PVector(0,0));
  }

  void run(float t) {
    update(t);
    display();
  }
  void run() {
    run(1);
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);   
    acc.add(f);
  }

  void update() {
    update(1);
  }

  // Method to update location
  void update(float t) {
    //println(PVector.mult(vel,t));
    vel.add(PVector.mult(acc,t));
    loc.add(PVector.mult(vel,t));
    acc.mult(0);
    sideBounce();
  }
  
  void sideBounce() {
    if(loc.x < r || loc.x > width-r) {
      vel = new PVector(-vel.x,vel.y);
    }
    if(loc.y < r || loc.y > height-r) {
      vel = new PVector(vel.x,-vel.y);
    }
  }

  // Method to display
  void display() {
    noStroke();
    //fill(fillCol);
    ellipse(loc.x,loc.y,r*2,r*2);
  }

  boolean intersect(Particle other) {
    float delX = loc.x-other.loc.x;
    float delY = loc.y-other.loc.y;
    if(delX*delX + delY*delY < (r+other.r)*(r+other.r)) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(FixedWall wall) {
    float dpx = wall.end2.x - wall.end1.x;
    float dpy = wall.end2.y - wall.end1.y;
    float a = dpx*dpx + dpy*dpy;
    float b = 2*(dpx*(wall.end1.x - loc.x) + dpy*(wall.end1.y - loc.y));
    float c = (wall.end1.x - loc.x)*(wall.end1.x - loc.x) +
              (wall.end1.y - loc.y)*(wall.end1.y - loc.y) - r*r;
    float disc = b*b - 4*a*c;
    if(disc >= 0) return true;
    else return false;
  }
  
  float getCollisionTime(Particle other) {
    PVector CD = PVector.sub(loc,other.loc);
    PVector Vcd = PVector.sub(vel,other.vel);
    float a = PVector.dot(Vcd,Vcd);
    float b = 2*PVector.dot(Vcd,CD);
    float c = PVector.dot(CD,CD) - (r+other.r)*(r+other.r);
    float disc = b*b - 4*a*c;
    float t1 = -1f;
    float t2 = -1f;
    if(disc >= 0) {
      t1 = (-b + sqrt(disc)) / (2*a);
      t2 = (-b - sqrt(disc)) / (2*a);
    }
    float retval = -1;
    if(t1 >= 0 && t2 >= 0) retval = min(t1,t2);
    else if(t1 >= 0) retval = t1;
    else if(t2 >= 0) retval = t2;
    return retval;
  }
  
  float getCollisionTime(FixedWall w) {
     float dpx = w.end2.x - w.end1.x;
     float dpy = w.end2.y - w.end1.y;
     PVector N = new PVector(-dpy,dpx);
     N.normalize();
     float det = dpx*vel.y - dpy*vel.x;
     
     float t1 = -dpy*(w.end1.x - loc.x + r*N.x)
                +dpx*(w.end1.y - loc.y + r*N.y);
     t1 /= det;
     float s1 = -vel.y*(w.end1.x - loc.x + r*N.x)
                +vel.x*(w.end1.y - loc.y + r*N.y);
     s1 /= det;
     float t2 = -dpy*(w.end1.x - loc.x - r*N.x)
                +dpx*(w.end1.y - loc.y - r*N.y);
     t2 /= det;
     float s2 = -vel.y*(w.end1.x - loc.x - r*N.x)
                +vel.x*(w.end1.y - loc.y - r*N.y);
     s2 /= det;
     
     if(t1 < 0 && t2 < 0) return 10000;
     if(s1 >= 0 && s1 <= 1) {
       if(s2 >= 0 && s2 <= 1) {
         if(t1 >= 0 && t2 < 0) return t1;
         else if(t1 < 0 && t2 >= 0) return t2;
         else if(t1 < t2) return t1;
         else if(t2 < t1) return t2;
         else return 10000;
       } else {
         if(t1 >= 0) return t1;
         else return 10000;
       }
     } else {
       if(s2 >= 0 && s2 <= 1) {
         if(t2 >= 0) return t2;
         else return 10000;
       }
       else return 10000;
     } 
  }
  
  void performCollision(Particle other) {
    PVector k = PVector.sub(loc,other.loc).normalize();
    float z = PVector.mult(k,2).dot(PVector.sub(vel,other.vel));
    z = z / ((1/mass)+(1/other.mass));
    vel = PVector.sub(vel, PVector.mult(k, z/mass));
    other.vel = PVector.add(other.vel, PVector.mult(k, z/other.mass));
    
    loc.add(PVector.mult(vel,0.001));
    other.loc.add(PVector.mult(other.vel,0.001));
  }

  void performCollision(FixedWall wall) {
    PVector N = new PVector(-(wall.end2.y - wall.end1.y), wall.end2.x - wall.end1.x);
    N.normalize();
    
    //Need the clockwise angle between N and -vel
    float dot = -vel.x*N.x - vel.y*N.y;
    float det = -vel.x*N.y + vel.y*N.x;
    float theta = atan2(det,dot);
    
    float theta2 = theta*2;
    //println("Orig vel: " + vel + " around N: " + N + " angle of " + theta2);
    vel = new PVector(-vel.x*cos(theta2) + vel.y*sin(theta2),
                      -vel.x*sin(theta2) - vel.y*cos(theta2));
    //println("New velo: " + vel);
    loc.add(PVector.mult(vel,0.001));
  }

}
