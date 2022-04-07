
enum Mode { BASISCHANGE, ROTCOMPOSITE };
Mode mode = Mode.BASISCHANGE;

float angle = 0f;
PVector rotAxis;

void setup() {
  size(500, 500, P3D);
  angle=0;
  rotAxis = new PVector(0, 400, 100);
}

void draw() {
  background(0);
  lights();
  translate(200, 200);
  
  if(mode == Mode.BASISCHANGE) {
    text("Basis Change", -100,-100,0);
    rotateAroundAxisBasisChange(rotAxis, angle);
  }
  if(mode == Mode.ROTCOMPOSITE) {
    text("Rotation Composite", -100,-100,0);
    rotateAroundAxisRotationComposition(rotAxis, angle);
  }
  
  strokeWeight(5);
  stroke(255);
  line(0, 0, 0, rotAxis.x, rotAxis.y, rotAxis.z);
  
  stroke(color(255, 0, 0));
  line(-width, 0, 0, width, 0, 0);
  stroke(color(0, 255, 0));
  line(0, -height, 0, 0, height, 0);
  stroke(color(0, 0, 255));
  line(0, 0, -height, 0, 0, height);

  noStroke();
  translate(50,50,50);
  box(50);
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    float diff = mouseX - pmouseX;
    angle += diff/width;
  } else if (mouseButton == RIGHT) {
    rotAxis = new PVector(rotAxis.x + mouseX-pmouseX, rotAxis.y + mouseY-pmouseY, rotAxis.z);
  }
}

void keyPressed() {
  if(key == 'r') {
    rotAxis = new PVector(0,-100,0);
    angle = 0;
  }
  if(key == 'b') mode = Mode.BASISCHANGE;
  if(key == 'c') mode = Mode.ROTCOMPOSITE;
}

void rotateAroundAxisBasisChange(PVector axis, float theta) {
  PVector w = axis.get();
  w.normalize();
  PVector t = w.get();
  if (abs(w.x) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.x = 1;
  } else if (abs(w.y) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.y = 1;
  } else if (abs(w.z) - min(abs(w.x), abs(w.y), abs(w.z)) < 0.001) {
    t.z = 1;
  }
  PVector u = w.cross(t);
  u.normalize();
  PVector v = w.cross(u);
  applyMatrix(u.x, v.x, w.x, 0, 
  u.y, v.y, w.y, 0, 
  u.z, v.z, w.z, 0, 
  0.0, 0.0, 0.0, 1);
  rotateZ(theta);
  applyMatrix(u.x, u.y, u.z, 0, 
  v.x, v.y, v.z, 0, 
  w.x, w.y, w.z, 0, 
  0.0, 0.0, 0.0, 1);
}

void rotateAroundAxisRotationComposition(PVector axis, float theta) {
  PVector n = axis.get();
  n.normalize();
  
  //If n.x & n.z are both zero, the rotation axis is Y
  //(and the math below will blow up...) so special case:
  if(n.x == 0 && n.z == 0) {
    if(n.y > 0) theta = -theta;
    rotateY(theta);
    return;
  }
  
  float phi = asin(n.x / sqrt(n.x*n.x + n.z*n.z));
  if(n.z < 0) phi = PI - phi;

  n = new PVector(n.x*cos(phi) - n.z*sin(phi), n.y, n.x*sin(phi) + n.z*cos(phi));

  float gamma = acos(n.dot(new PVector(0, 0, -1)));
  if (axis.y < 0) gamma = acos(n.dot(new PVector(0, 0, 1)));

  rotateY(phi);
  rotateX(gamma);
  if(n.y > 0) theta = -theta;
  rotateZ(theta);
  rotateX(-gamma);
  rotateY(-phi);
}
