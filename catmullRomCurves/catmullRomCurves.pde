DragCircle[] p = new DragCircle[50];
int numP;

void setup() {
  size(400,400);
  smooth();
  textFont(createFont("Helvetica",10));
  numP=0;
}

void draw() {
  background(0);
  for(int i=0; i<numP; i++) {
    p[i].display();
  }
  
  stroke(255);
  strokeWeight(2);
  noFill();
  if(numP >= 4) {
    beginShape();
    for(int i=0; i<numP; i++) {
      curveVertex(p[i].x, p[i].y);
    }
    endShape();
  }
}

void mouseClicked() {
  if(mouseButton == RIGHT) {
    p[numP] = new DragCircle(mouseX, mouseY, 10);
    numP++;
  }
}
