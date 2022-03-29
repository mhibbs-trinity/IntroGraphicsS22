ParticleSystem fire, smoke;
PImage fireImg, smokeImg;
color fireStart, fireEnd;
color smokeStart, smokeEnd;

int mode = 1; //0 for smoke only, 1 for fire only, 2 for both

ParticleSystem ps;

void setup() {
  size(640,360);
  ps = new ParticleSystem(0, new PVector(width/2, height - 50));
  
  fireImg = loadImage("fire.png");
  smokeImg = loadImage("smoke.png");
  fireStart = color(255,0,0,255);
  fireEnd = color(255,255,0,0);
  smokeStart = color(255,128);
  smokeEnd = color(128,0);
  if(mode == 1 || mode == 2) {
    fire = new ParticleSystem(0,new PVector(width/2,height-60));
  }
  if(mode == 0 || mode == 2) {
    smoke = new ParticleSystem(0,new PVector(width/2,height-50));
  }
}

void draw() {
  background(0);

  // Calculate a "wind" force based on mouse horizontal position
  float dx = map(mouseX,0,width,-0.5,0.5);
  PVector wind = new PVector(dx,0);
  
  //ps.applyForce(wind);
  //ps.run();
  //ps.addParticle();
  
  if(mode == 1 || mode == 2) {
    fire.applyForce(wind);
    fire.run();
    fire.addParticle(new ImageParticle(fire.origin,fireImg,fireStart,fireEnd));
  }
  if(mode == 0 || mode == 2) {
    smoke.applyForce(wind);
    smoke.run();
    smoke.addParticle(new ImageParticle(smoke.origin,smokeImg,smokeStart,smokeEnd));
  }

  // Draw an arrow representing the wind force
  drawVector(wind, new PVector(width/2,50,0),500);

}

// Renders a vector object 'v' as an arrow and a location 'loc'
void drawVector(PVector v, PVector loc, float scayl) {
  pushMatrix();
  float arrowsize = 4;
  // Translate to location to render vector
  translate(loc.x,loc.y);
  stroke(255);
  // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
  rotate(v.heading());
  // Calculate length of vector & scale it to be bigger or smaller if necessary
  float len = v.mag()*scayl;
  // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
  line(0,0,len,0);
  line(len,0,len-arrowsize,+arrowsize/2);
  line(len,0,len-arrowsize,-arrowsize/2);
  popMatrix();
}
