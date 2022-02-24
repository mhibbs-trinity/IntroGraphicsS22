DragCircle p0 = new DragCircle(100,100,10);
DragCircle p1 = new DragCircle(300,300,10);
DragCircle p2 = new DragCircle(300,100,10);

void setup() {
  size(400,400);
}

void draw() {
  background(0);
  p0.display();
  p1.display();
  p2.display();
  
  stroke(255);
  strokeWeight(2);
  for(float t=0; t<=1; t+= 0.01) {
    //Line interpolation
    //point((1-t)*p0.x + t*p1.x, (1-t)*p0.y + t*p1.y);
    
    //Quadratic interpolation
    point(fx(t), fy(t));
    
    //C2 continuous interpolation
    //point(c2x(t), c2y(t));
  }
}

float fx(float t) {
  return p0.x + t*(-3*p0.x + 4*p1.x - p2.x) + t*t*(2*p0.x -4*p1.x + 2*p2.x);
}
float fy(float t) {
  return p0.y + t*(-3*p0.y + 4*p1.y - p2.y) + t*t*(2*p0.y -4*p1.y + 2*p2.y);
}

float c2x(float t) {
  return (p0.x - 0.5*p1.x + 0.125*p2.x) + t*(p1.x - 0.5*p2.x) + t*t*0.5*p2.x;
}
float c2y(float t) {
  return (p0.y - 0.5*p1.y + 0.125*p2.y) + t*(p1.y - 0.5*p2.y) + t*t*0.5*p2.y;
}
