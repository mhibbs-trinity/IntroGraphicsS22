enum Mode { SPHERES, SINGLEQUAD, QUADTRI, MULTIQUAD }
Mode mode = Mode.SPHERES;

boolean showStroke = false;

void setup() {
  size(800,800,P3D);
}

void draw() {
  background(0);
  lightSpecular(255,0,255);
  pointLight(255,255,255, mouseX,mouseY,200);
  stroke(255);
  strokeWeight(10);
  point(mouseX,mouseY,200);
  
  if(showStroke) {
    stroke(255);
    strokeWeight(1);
  } else {
    noStroke();
  }
  fill(128);
  
  if(mode == Mode.SPHERES) {
    sphereDetail(50);
    float shine=1;
    for(float x=200; x<=600; x+=200) {
      for(float y=200; y<=600; y+=200) {
        shininess(shine);
        
        
        pushMatrix();
        translate(x,y,0);
        sphere(75);
        translate(-100,100,0);
        shininess(0);
        text("Shine = " + shine, 0,0,0);
        popMatrix();
        
        shine *= 4;

      }
    }
  }
  
  if(mode == Mode.SINGLEQUAD) {
    beginShape(QUADS);
      vertex(100,100,0);
      vertex(700,100,0);
      vertex(700,700,0);
      vertex(100,700,0);
    endShape();
  }
  
  if(mode == Mode.MULTIQUAD) {
    beginShape(QUADS);
      for(float x=100; x<700; x+=10) {
        for(float y=100; y<700; y+=10) {
          vertex(x   ,y   ,0);
          vertex(x+10,y   ,0);
          vertex(x+10,y+10,0);
          vertex(x   ,y+10,0);
        }
      }
    endShape();
  }
  
}

void keyPressed() {
  if(key == 's') mode = Mode.SPHERES;
  if(key == 'q') mode = Mode.SINGLEQUAD;
  if(key == 't') mode = Mode.QUADTRI;
  if(key == 'm') mode = Mode.MULTIQUAD;
  if(key == ' ') showStroke ^= true;
}
