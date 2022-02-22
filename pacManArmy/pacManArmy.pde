PacMan[] pac;

void setup() {
  size(600,600);
  frameRate(15);
  pac = new PacMan[12*12];
  for(int i=0; i<12*12; i++) {
    pac[i] = new PacMan(random(PI/8));
  }
}

void draw() {
  background(0);
  translate(25,25);
  for(int r=0; r<12; r++) {
    pushMatrix();
    for(int c=0; c<12; c++) {
      pac[r*12+c].display();
      translate(50,0);
    }
    popMatrix();
    translate(0,50);
  }
}
