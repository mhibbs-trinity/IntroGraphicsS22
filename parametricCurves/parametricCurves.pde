void setup() {
  size(500,500);
}

float stepSize;
float e = 2.71828; 

void draw() {
  background(0);
  //stepSize = float(mouseY)/height + 0.01;
  stepSize = PI/256;
  translate(width/2,height/2);
  //scale(200);
  scale(20);
  //scale(50);
  stroke(200);
  noFill();
  strokeWeight(1.0/20);
  float m = float(mouseX)/width * 10;
  float q = float(mouseY)/height * 10;
  beginShape();
  //for(float t=0; t<map(mouseX, 0,width, 1,50)*PI; t+=stepSize) {
  for(float t=0; t<6*PI; t+=stepSize) {
    //vertex(fx(t,m),fy(t,m));
    //vertex(lx(t,5.0*mouseX/width),ly(t,5.0*mouseY/height));
    //vertex(bx(t),by(t));
    vertex(hx(t,5,q,m), hy(t,5,q,m));
  }
  endShape();
  //endShape();
}

float fx(float t, float m) {
  return cos(t);
}
float fy(float t, float m) {
  return sin(t)*pow(sin(0.5*t),m);
}

float lx(float t, float k) {
  return cos(k*t);
}
float ly(float t, float k) {
  return sin(k*t);
}

float bx(float t) {
  return sin(t) * (pow(e,cos(t)) - 2*cos(4*t) + pow(sin(t/12),5));
}
float by(float t) {
  return cos(t) * (pow(e,cos(t)) - 2*cos(4*t) + pow(sin(t/12),5));
}

float hx(float t, float R, float r, float d) {
  return (R-r)*cos(t) + d*cos(t*(R-r)/r); 
}
float hy(float t, float R, float r, float d) {
  return (R-r)*sin(t) - d*sin(t*(R-r)/r);
}
