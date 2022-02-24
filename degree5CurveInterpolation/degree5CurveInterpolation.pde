DragCircle p0 = new DragCircle(100,100,10);
DragCircle p1 = new DragCircle(150,100,10);
DragCircle p2 = new DragCircle(200,100,10);
DragCircle p3 = new DragCircle(250,100,10);
DragCircle p4 = new DragCircle(300,100,10);
DragCircle p5 = new DragCircle(350,100,10);

void setup() {
  size(500,500);
}

void draw() {
  background(0);
  p0.display();
  p1.display();
  p2.display();
  p3.display();
  p4.display();
  p5.display();
  
  stroke(255);
  strokeWeight(3);
  for(float t=0; t<=1; t+= 0.01) {
    stroke(lerpColor(color(255,193,73),color(77,207,255),t));
    point(fx(t), fy(t));
  }
}

float fx(float t) {
  float result = p0.x;
  result += t * (-11.42*p0.x +25*p1.x -25*p2.x +16.67*p3.x -6.25*p4.x +p5.x);
  result += pow(t,2) * (46.88*p0.x -160.42*p1.x +222.92*p2.x -162.5*p3.x +63.54*p4.x -10.42*p5.x);
  result += pow(t,3) * (-88.54*p0.x +369.79*p1.x -614.58*p2.x +510.42*p3.x -213.54*p4.x +36.46*p5.x);
  result += pow(t,4) * (78.13*p0.x -364.58*p1.x +677.08*p2.x -625*p3.x +286.46*p4.x -52.08*p5.x);
  result += pow(t,5) * (-26.04*p0.x +130.21*p1.x -260.42*p2.x +260.42*p3.x -130.21*p4.x +26.04*p5.x);
  return result;
}
float fy(float t) {
  float result = p0.y;
  result += t * (-11.42*p0.y +25*p1.y -25*p2.y +16.67*p3.y -6.25*p4.y +p5.y);
  result += pow(t,2) * (46.88*p0.y -160.42*p1.y +222.92*p2.y -162.5*p3.y +63.54*p4.y -10.42*p5.y);
  result += pow(t,3) * (-88.54*p0.y +369.79*p1.y -614.58*p2.y +510.42*p3.y -213.54*p4.y +36.46*p5.y);
  result += pow(t,4) * (78.13*p0.y -364.58*p1.y +677.08*p2.y -625*p3.y +286.46*p4.y -52.08*p5.y);
  result += pow(t,5) * (-26.04*p0.y +130.21*p1.y -260.42*p2.y +260.42*p3.y -130.21*p4.y +26.04*p5.y);
  return result;
}
