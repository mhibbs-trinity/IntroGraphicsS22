void setup() {
  size(800,800);
}

void draw() {
  background(0);
  stroke(200,0,0);
  strokeJoin(ROUND);
  noFill();
  
  translate(width/2, height/2);
  scale(18);
  
  beginShape();
  for(float t=0; t<TWO_PI; t+=PI/128) {
    vertex(16 * pow(sin(t), 3),
           -13 * cos(t) + 5 * cos(2*t) + 2 * cos(3*t) + cos(4*t));
  }
  endShape();
}
