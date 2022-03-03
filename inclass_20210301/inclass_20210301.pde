void setup() {
  size(800,800);
}

void circ(float x, float y, float r) {
  ellipse(x,y, r*2,r*2);
  if(r > 1) {
    circ(x-r,y, r/2);
    circ(x+r,y, r/2);
    circ(x,y-r, r/2);
    //circ(x,y+r, r/2);
  }
}

void draw() {
  background(0);
  stroke(255,50);
  noFill();
  
  circ(width/2, height/2, width/4);
  
}
