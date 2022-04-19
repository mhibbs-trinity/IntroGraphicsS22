
int mode = 1;

PVector a;
PVector b;
PVector c;
PVector d;
PVector e;
PVector abcNorm;
PVector acdNorm;
PVector adeNorm;
PVector aebNorm;
PVector aNorm, bNorm, cNorm, dNorm, eNorm;

void setup() {
  size(600,600, P3D);
  
}

void draw() {
  background(0);
  translate(width/2, height/2, 0);
  
  pointLight(255,255,255, mouseX-width/2,mouseY-height/2,100);
  stroke(255);
  strokeWeight(10);
  point(mouseX-width/2,mouseY-height/2,100);
  
  noStroke();
  fill(255);
  if(mode == 0) {
    beginShape(TRIANGLES);
    nor(abcNorm);
    vert(a);
    vert(b);
    vert(c);
    
    nor(acdNorm);
    vert(a);
    vert(c);
    vert(d);
    
    nor(adeNorm);
    vert(a);
    vert(d);
    vert(e);
    
    nor(aebNorm);
    vert(a);
    vert(e);
    vert(b);
    endShape();
  }
  if(mode == 1) {
    beginShape(TRIANGLE_FAN);
    nor(aNorm);
    vert(a);
    nor(bNorm);
    vert(b);
    nor(cNorm);
    vert(c);
    nor(dNorm);
    vert(d);
    nor(eNorm);
    vert(e);
    nor(bNorm);
    vert(b);
    endShape();
  }
  
  
}
  
void vert(PVector p) {
  vertex(p.x, p.y, p.z);
}
void nor(PVector n) {
  normal(n.x, n.y, n.z);
}
