class MyTri {
  PVector a,b,c;
  PVector n;
  float epsilon = 0.05;
 
  MyTri(PVector _a, PVector _b, PVector _c) {
    a = _a;
    b = _b;
    c = _c;
    n = PVector.sub(b,a).cross(PVector.sub(c,a));
    n.normalize();
  }
  void display() {
    beginShape();
    vertex(a.x,a.y,a.z);
    vertex(b.x,b.y,b.z);
    vertex(c.x,c.y,c.z);
    endShape(CLOSE);
  }
  void displaySpecial() {
    strokeWeight(1);
    stroke(0);
    beginShape();
    fill(255,0,0);
    vertex(a.x,a.y,a.z);
    fill(0,255,0);
    vertex(b.x,b.y,b.z);
    fill(0,0,255);
    vertex(c.x,c.y,c.z);
    endShape(CLOSE);
    stroke(255,255,0);
    strokeWeight(3);
    line(a.x,a.y,a.z, a.x+n.x*10,a.y+n.y*10,a.z+n.z*10);
  }
  
  /* Determines if a point is in front of or behind 
   * this TheTriangle:
   * + = in front of; - = behind; 0 = co-planar */
  float getFrontBack(PVector p) {
    float dotProd = PVector.dot(n,PVector.sub(p,a));
    if(abs(dotProd) < epsilon) dotProd = 0;
    return dotProd;
  }
}
